
qsub -cwd -V -N swHet -l time=23:00:00,h_data=4G -M ckyriazi -m a -t 3-3 -o /u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/slidingWindowHet -e /u/home/c/ckyriazi/kirk-bigdata/caracals/output/analysis/slidingWindowHet run_SWhet.sh




 
