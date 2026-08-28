import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

/**
 * Bai 11: Dem tong so dong code trong mot thu muc chua nhieu file ma nguon.
 * Map phat ra ("total_lines", 1) cho moi dong; Reduce cong don lai.
 * Bo qua cac dong trong (chi chua khoang trang).
 */
public class LineCount {

    public static class LineMapper
            extends Mapper<LongWritable, Text, Text, LongWritable> {

        private final static LongWritable one = new LongWritable(1);
        private final static Text keyWord = new Text("total_lines");

        public void map(LongWritable key, Text value, Context context)
                throws IOException, InterruptedException {
            // Chi dem dong khong rong (bo dong chi co khoang trang)
            if (value.toString().trim().length() > 0) {
                context.write(keyWord, one);
            }
        }
    }

    public static class SumReducer
            extends Reducer<Text, LongWritable, Text, LongWritable> {

        private LongWritable result = new LongWritable();

        public void reduce(Text key, Iterable<LongWritable> values, Context context)
                throws IOException, InterruptedException {
            long sum = 0;
            for (LongWritable val : values) {
                sum += val.get();
            }
            result.set(sum);
            context.write(key, result);
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "line count");
        job.setJarByClass(LineCount.class);
        job.setMapperClass(LineMapper.class);
        job.setCombinerClass(SumReducer.class);
        job.setReducerClass(SumReducer.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(LongWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
