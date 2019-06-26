#!/usr/bin/env bash
#PBS -q mpi
#PBS -l walltime=48:00:00
#PBS -l select=1:ncpus=28:mem=115g

cd /home1/scratch/plstenge/annotation_GO

rm 02_run_me_second.sh

echo "#!/usr/bin/env bash" >> 02_run_me_second.sh
echo "#PBS -q mpi" >> 02_run_me_second.sh
echo "#PBS -l walltime=48:00:00" >> 02_run_me_second.sh
echo "#PBS -l select=1:ncpus=28:mem=115g" >> 02_run_me_second.sh

echo "cd /home1/scratch/plstenge/annotation_GO" >> 02_run_me_second.sh


cat transcipts_and_uniprot_list.txt | while read line 
do 
echo -e "$line" 
awk '{print "echo XXXX"$1"XXXX >> "$1$2"_uniprot_file.txtYYYYwget -q -O - http://www.uniprot.org/uniprot/"$2".txt >> "$1$2"_uniprot_file.txt"}' | sed $'s/XXXX/\'/g' | sed 's/YYYY/\'$'\n/g' >> 02_run_me_second.sh
done

rm 03_run_me_third_prep.sh

echo "#!/usr/bin/env bash" >> 03_run_me_third_prep.sh
echo "#PBS -q mpi" >> 03_run_me_third_prep.sh
echo "#PBS -l walltime=48:00:00" >> 03_run_me_third_prep.sh
echo "#PBS -l select=1:ncpus=28:mem=115g" >> 03_run_me_third_prep.sh
echo "cd /home1/scratch/plstenge/annotation_GO" >> 03_run_me_third_prep.sh
echo 'rm *_2.txt' >> 03_run_me_third_prep.sh
echo 'rm *_3.txt' >> 03_run_me_third_prep.sh
echo 'rm ALL*' >> 03_run_me_third_prep.sh
echo 'for FILE in $(ls *_uniprot_file.txt)' >> 03_run_me_third_prep.sh
echo 'do' >> 03_run_me_third_prep.sh
echo 'grep -E XXXXevm.model.scaffoldXXXX ${FILE##*/}  >> ${FILE##*/}_2.txt' >> 03_run_me_third_prep.sh
echo 'grep -E XXXX^DR\s+GOXXXX ${FILE##*/} | awk XXXX{print $3}XXXX | perl -pe XXXXs/\n//XXXX >> ${FILE##*/}_2.txt' >> 03_run_me_third_prep.sh
echo 'tr "\n" "\t" < ${FILE##*/}_2.txt > ${FILE##*/}_3.txt' >> 03_run_me_third_prep.sh
echo 'done' >> 03_run_me_third_prep.sh
echo 'cat *_3.txt > ALL.txt' >> 03_run_me_third_prep.sh
echo 'sed XXXXs/evm.model.scaffold/\XXXX$XXXX\nevm.model.scaffold/gXXXX ALL.txt > ALL_2.txt' >> 03_run_me_third_prep.sh
echo 'awk XXXXF[$1]++ {$1=OFS}1XXXX ALL_2.txt > ALL_3.txt' >> 03_run_me_third_prep.sh
echo 'sed XXXXs/  //gXXXX ALL_3.txt > ALL_4.txt' >> 03_run_me_third_prep.sh
echo 'tr -d XXXX\nXXXX < ALL_4.txt > ALL_5.txt' >> 03_run_me_third_prep.sh
echo 'sed XXXXs/evm.model.scaffold/\XXXX$XXXX\nevm.model.scaffold/gXXXX ALL_5.txt > ALL_6.txt' >> 03_run_me_third_prep.sh
echo 'awk XXXX{print $2}XXXX ALL_6.txt > ALL_7.txt' >> 03_run_me_third_prep.sh
echo 'sed XXXXs/;/ /gXXXX ALL_7.txt > ALL_8.txt' >> 03_run_me_third_prep.sh
echo 'awk XXXX{ while(++i<=NF) printf (!a[$i]++) ? $i FS : ""; i=split("",a); print ""}XXXX ALL_8.txt > ALL_9.txt' >> 03_run_me_third_prep.sh
echo 'awk XXXX{print $1}XXXX ALL_6.txt > ALL_10.txt' >> 03_run_me_third_prep.sh
echo 'paste ALL_10.txt ALL_9.txt > annotation_GO.txt' >> 03_run_me_third_prep.sh
echo 'rm ALL*' >> 03_run_me_third_prep.sh
echo 'rm *_2.txt' >> 03_run_me_third_prep.sh
echo 'rm *_3.txt' >> 03_run_me_third_prep.sh
echo 'rm *_uniprot_file.txt' >> 03_run_me_third_prep.sh

sed $'s/XXXX/\'/g' 03_run_me_third_prep.sh > 03_run_me_third.sh

rm 03_run_me_third_prep.sh
