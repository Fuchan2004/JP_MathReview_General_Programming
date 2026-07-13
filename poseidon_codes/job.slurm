#!/bin/bash
#SBATCH --partition=compute	 # specify the partition
#SBATCH --job-name=matlab        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:10:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on job start, end and fault
#SBATCH --mail-user=<username>@whoi.edu # email for receiving job status
#SBATCH --output=<jobname_here>%j.log # creates a log file with the specified job name and number (%j)

module load matlab

matlab -nodisplay -nodesktop -nosplash -r hello_world
#matlab -nodisplay -nodesktop -nosplash -r Testplot_20260713
