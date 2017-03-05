# Description
The content here is all inspired from assignments completed for the [Data Science W251 Scaling Up! Really Big Data](https://www.ischool.berkeley.edu/courses/datasci/251) class in the UC Berkeley MIDS program.

# Files
One of the assignments for this class involved [building a Twitter popular topic and user reporting system using Spark streaming](https://github.com/MIDS-scaling-up/coursework/tree/master/week9/hw). The file in this directory is my [solution in Scala](https://github.com/hdanish/Data-Science/blob/master/Streaming%20Tweet%20Processing/twitter_popularity.scala).

To execute the program, the following commands would be run on a Spark cluster:

cd $SPARK_HOME/twitter_popularity
sbt clean assembly && $SPARK_HOME/bin/spark-submit --master srk://spark1:7077 $(find target -iname "*assembly*.jar") 10 10

In the above command, the first argument represents the topN hashtags to find and the second argument represents the time (in seconds) to be used for the streaming context.

The program outputs two sets of files in the $SPARK_HOME/twitter_popularity/output directory. These files are based on different operations that are run in the scala script. I am doing one set of operations with a reduceByKey function (files are called intervalX.txt) and one set of operations with a reduceByKeyAndWindow function (files are called windowX.txt).

I set the time for the window to be 30 mins in order to accumulate results over an entire window so the windowX files are cumulative while the intervalX files are iterative. The output of the files is formatted such that the popular hashtag is written on a line (with a total count of tweets) and then the set of authors is printed on another line and the set of mentions on another line. The overall number of tweets is also maintained as an rdd count. This is the main difference between using the window or not.
