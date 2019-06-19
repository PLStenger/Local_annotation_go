# Local_annotation_go
Create your own GO (Gene Ontology) annotation from UniProt informations in your local terminal.

## First, install  Wget

Run this for test if you have already `Wget`:

```
wget
```

For Mac OSX, run this to install `Wget`:
```
sudo port install wget
```

### Select the transcripts that needs to be "Go annotated"
 - Create a folder.
 - Put the selection of the transcripts that needs to be "Go annotated" and their UniProt code in a file named `transcipts_and_uniprot_list.txt`
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
 ```
