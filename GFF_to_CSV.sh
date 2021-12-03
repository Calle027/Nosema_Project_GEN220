#!/bin/bash -l

#SBATCH --nodes=1
#SBATCH --ntasks=1
##SBATCH --cpus-per-task=1 # must match the # of threads (-t #)
##SBATCH --mem-per-cpu=10G # * if threading, do not let this line run (use ##). Cannot ask for too much memory per cpu!
#SBATCH --mem=10G # < if you are threading, ask for whole memory and not memory per CPU
#SBATCH --time=5:00:00     # 5 hrs
#SBATCH --output=GFF_to_CSV.stdout
#SBATCH --mail-user=calle027@ucr.edu
#SBATCH --mail-type=ALL
#SBATCH --job-name="GFF_to_CSV"
#SBATCH -p batch

# Create folder to store all Nosema Results
if [[ ! -d ./Nosema_Project_GEN220 ]]; then
    mkdir Nosema_Project_GEN220
fi


for FILE in ./*.gff;
do
    gff=$(basename $FILE)
    gen=${gff%_clean*}
    echo "convert" $gff "to CSV"
    
    awk -F '\t' -v OFS=, '!/^#/ {$1=$1;print}' $gff > ./GFFs_to_CSVs/$gen.csv

done

