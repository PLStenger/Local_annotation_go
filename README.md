# Local_annotation_go
Create your own GO (Gene Ontology) annotation from UniProt informations in your local terminal.

The original idea where found here: https://github.com/enormandeau/go_enrichment.
But after some bugs of which I must be the source (may be this code is only for Linux synthax, not Mac OSX ?), I keep the really good Eric's idea to "web-scrapping" UniProt, and I adapt it to my datas.

Very useful, fast and reproductible.

### First, install  Wget

Run this in your terminal to know if you have already `Wget`:

```
wget
```

For Mac OSX, run this to install `Wget`:
```
sudo port install wget
```

### Select the transcripts that needs to be "Go annotated"
 - Create a folder.
 - Put the selection of the transcripts that needs to be "Go annotated" and their UniProt code in a file named `transcipts_and_uniprot_list.txt` into this folder
 
 Ex:
 
 ```
evm.model.scaffold1000size145372.14 ABCB6_RAT
evm.model.scaffold1000size145372.14 ABCB6_MOUSE
evm.model.scaffold1000size145372.14 ABCB6_HUMAN
evm.model.scaffold1000size145372.14 ABCB6_XENTR
evm.model.scaffold1000size145372.14 AB25B_ARATH
evm.model.scaffold1000size145372.20 UNC50_MOUSE
evm.model.scaffold1000size145372.20 UNC50_BOVIN
evm.model.scaffold1000size145372.20 UNC50_RAT
evm.model.scaffold1000size145372.20 UNC50_HUMAN
evm.model.scaffold1000size145372.20 UNC50_DANRE
...
 ```

- Download the `01_run_me_first.sh` script file and put also it in the folder.

### Run

- In your terminal, locate you in the folder 
```
cd path_to_folder
```

- Lunch this:
```
bash 01_run_me_first.sh
```

- This will create two files:
```
02_run_me_second.sh
03_run_me_third.sh
```

- So run `bash 02_run_me_second.sh`. Wait for the end of the process.

- Then run `bash 03_run_me_third.sh`

- `annotation_GO.txt` file will appears with the results :
```
evm.model.scaffold1000size145372.12	GO:0005783 GO:0005794 GO:0016021 GO:0005741 GO:0005886 GO:0005774 GO:0005524 GO:0042626 
evm.model.scaffold1000size145372.14	GO:0009507 GO:0009941 GO:0016021 GO:0005743 GO:0005739 GO:0005524 GO:0042626 GO:0005215 GO:0006879 GO:0009658 GO:0051276 GO:0006811 GO:0006777 GO:0009555 GO:0050790 GO:0010380 GO:0046686 GO:0010288 GO:0048364 GO:0043190 GO:0005829 GO:0005783 GO:0005789 GO:0005768 GO:0010008 GO:0070062 GO:0005794 GO:0000139 GO:0031307 GO:0005740 GO:0005741 GO:0005654 GO:0005886 GO:0005774 GO:0015562 GO:0020037 GO:0015439 GO:0007420 GO:0015886 GO:0006779 GO:0043588 GO:0055085 
evm.model.scaffold1000size145372.19	
evm.model.scaffold1000size145372.20	GO:0030173 GO:0005637 GO:0003723 GO:0015031 GO:0005794 GO:0000139 GO:0007166 
evm.model.scaffold1000size145372.7	GO:0005737 GO:0004418 GO:0006783 GO:0018160 GO:0006782 GO:0005829 GO:0030424 GO:0005634 GO:0043176 GO:0031406 GO:0050662 GO:0004852 GO:0033014 GO:0015995 
...
```

Enjoy !

### How it's work ?

- First, for each transcript and each UniProt associated terms, informations are kept in a file. The whole webpage of UniPort results for the UniProt associated term (ex: ABCB6_RAT) if print in the same file. So, a same number of file is created than the number of line you have in your `transcipts_and_uniprot_list.txt` file.

EX:

```
evm.model.scaffold1000size145372.14
ID   ABCB6_RAT               Reviewed;         836 AA.
AC   O70595;
DT   12-DEC-2006, integrated into UniProtKB/Swiss-Prot.
DT   01-AUG-1998, sequence version 1.
DT   08-MAY-2019, entry version 138.
DE   RecName: Full=ATP-binding cassette sub-family B member 6, mitochondrial;
DE   AltName: Full=Ubiquitously-expressed mammalian ABC half transporter;
GN   Name=Abcb6; Synonyms=Umat;

...

DR   Proteomes; UP000002494; Chromosome 9.
DR   Bgee; ENSRNOG00000018697; Expressed in 9 organ(s), highest expression level in skeletal muscle tissue.
DR   ExpressionAtlas; O70595; baseline and differential.
DR   Genevisible; O70595; RN.
DR   GO; GO:0005829; C:cytosol; IEA:Ensembl.
DR   GO; GO:0005783; C:endoplasmic reticulum; IEA:UniProtKB-SubCell.
DR   GO; GO:0005768; C:endosome; ISS:UniProtKB.

...
```

- Then, the transcript name (ex: `evm.model.scaffold1000size145372.14`) is grepped with all the GO terms (`grep -E ^DR\s+GO`) and put in other file.

- All files are cleaned and concatenated. Then, we kept only unique transcripts names with `awk F[$1]++ {$1=OFS}1`. All GO terms for this all transcripts we the same name are concatenated. Then, we cleaned the Go terms with remove the duplicates.

And that's it ! :) 

## Update 2019/06/24 : You can now add the gene's name !

Same instructions than above, but run only the `01_run_me_first_for_gene_s_name.sh`.

This will give you a `annotation_gene_named.txt` file with:

```
evm.model.scaffold1000size145372.14	 RecName: Full=ABC transporter B family member 25, mitochondrial;Short=ABC transporter ABCB.25; Short=AtABCB25; AltName: Full=ABC transporter of the mitochondrion 3; Short=AtATM3;Short=Iron-sulfur clusters transporter ATM3; AltName: Full=Protein STARIK 1; Flags: Precursor; RecName: Full=ATP-binding cassette sub-family B member 6, mitochondrial; AltName: Full=Mitochondrial ABC transporter 3; Short=Mt-ABC transporter 3; AltName: Full=P-glycoprotein-related protein;
evm.model.scaffold1000size145372.20	 RecName: Full=Protein unc-50 homolog; AltName: Full=Periodontal ligament-specific protein 22; Short=PDLs22; AltName: Full=Protein GMH1 homolog; Short=hGMH1; AltName: Full=Uncoordinated-like protein;RecName: Full=Protein unc-50 homolog; AltName: Full=Periodontal ligament-specific protein 22;RecName: Full=Protein unc-50 homolog; AltName: Full=Uncoordinated-like protein;
```

## Update 2019/06/26 : You can now apply the annotation on cluster !

Create your directory in your `$SCRATCH`.
ex: `/home1/scratch/plstenge/annotation_GO`
Put your `transcipts_and_uniprot_list.txt` into this folder and the `cluster_annotation_go.sh` script.

Run `qsub -I -q ftp -l walltime=48:00:00` to enter in the node connected to internet (the web-srapping will work into it).

And then,
```
cd $SCRATCH//annotation_GO
bash cluster_annotation_go.sh
bash 02_run_me_second.sh
ls -1 | wc -l ## To know the number of files created
bash 03_run_me_third.sh
```



