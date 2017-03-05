package org.apache.spark.examples.streaming

import org.apache.spark.streaming.{Seconds, StreamingContext}
import org.apache.spark.SparkContext._
import org.apache.spark.streaming.twitter._
import org.apache.spark.SparkConf
import java.io._

object Main extends App {
  println(s"I got executed with ${args size} args, they are: ${args mkString ", "}")

  val N = args(0).toInt
  val T = args(1).toLong

  // Hard coding credentials for simplicity
  val consumerKey = "<consumerKey>"
  val consumerSecret = "<consumerSecret>"
  val accessToken = "<accessToken>"
  val accessTokenSecret = "<accessTokenSecret>"

  // Set the system properties so that Twitter4j library used by twitter stream
  // can use them to generat OAuth credentials
  System.setProperty("twitter4j.oauth.consumerKey", consumerKey)
  System.setProperty("twitter4j.oauth.consumerSecret", consumerSecret)
  System.setProperty("twitter4j.oauth.accessToken", accessToken)
  System.setProperty("twitter4j.oauth.accessTokenSecret", accessTokenSecret)

  // Set the initial values
  val sparkConf = new SparkConf().setAppName("twitter_popularity")
  val ssc = new StreamingContext(sparkConf, Seconds(T))
  val stream = TwitterUtils.createStream(ssc, None)

  // tweetData while create a tuple out of the status that has the hashtag,
  // the authors for that hashtag and the mentions for that hashtag
  val tweetData = stream.flatMap(status => {
    val authors: Set[String] = Set(status.getUser().getScreenName())

    val mentions: Set[String] = status.getUserMentionEntities().map(_.getScreenName()).toSet

    val hashTags: Set[String] = status.getText.split(" ").filter(_.startsWith("#")).toSet

    hashTags.map(hashTag => {
      (hashTag, authors, mentions)
    })
  })

  // Get the top counts both by window and on their own
  val topCountsW = tweetData.map(data => (data._1, (data._2, data._3, 1)))
                     .reduceByKeyAndWindow((x, y) => (x._1 ++ y._1, x._2 ++ y._2, x._3 + y._3), Seconds(60 * 30))
                     .map{case (tag, (authors, mentions, count)) => (count, (tag, authors, mentions))}
                     .transform(_.sortByKey(false))


  val topCounts = tweetData.map(data => (data._1, (data._2, data._3, 1)))
                     .reduceByKey((x, y) => (x._1 ++ y._1, x._2 ++ y._2, x._3 + y._3))
                     .map{case (tag, (authors, mentions, count)) => (count, (tag, authors, mentions))}
                     .transform(_.sortByKey(false))

  // We will output different sets of files for the window and windowless reduce
  var counter = 0
  var counterW = 0

  topCountsW.foreachRDD(rdd => {
    val topList = rdd.take(N)
    val writer = new PrintWriter(new File(s"output/window$counterW.txt"))
    writer.write("\nPopular topics in last %s seconds (%s total):".format(T, rdd.count()))
    topList.foreach{case (count, (tag, authors, mentions)) => writer.write("\n%s (%s tweets)\nAuthors: %s\nMentions: %s\n".format(tag, count, authors, mentions))}
    writer.close()
    counterW += 1
  })

  topCounts.foreachRDD(rdd => {
    val topList = rdd.take(N)
    val writer = new PrintWriter(new File(s"output/interval$counter.txt"))
    writer.write("\nPopular topics in last %s seconds (%s total):".format(T, rdd.count()))
    topList.foreach{case (count, (tag, authors, mentions)) => writer.write("\n%s (%s tweets)\nAuthors: %s\nMentions: %s\n".format(tag, count, authors, mentions))}
    writer.close()
    counter += 1
  })

  ssc.start()
  ssc.awaitTermination()
}
