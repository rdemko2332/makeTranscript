1. I start with a combined genomic fasta file. Retrieve the strain names from this.

2. I send each strain into the following processes one at a time.

3. I query the database for the respective locations and indels, calculate and store current shift totals at those locations, and make an object to hold them. Query the database for the respective coding sequence positions and if they are reverse, and make an object to hold them. The object is created as a 2d array. Each internal array holds locations of the cds_start and cds_end and if reverse or not. 

4. I created a finalshifted object that contains the information from a new process that will move through both objects linearly and apply the respective shifts to each position in the coding sequence object, while maintaining the objects structure to preserve the reverse value for each coding region.

5. I then created a process that will take this final shifted object and write to a file like so

  <strain-name>:<cds_start_shifted>-<cds_end_shifted>	<0 for forward 1 for rev>

  <strain-name>:<cds_start_shifted>-<cds_end_shifted>   <0 for forward 1 for rev>

  <strain-name>:<cds_start_shifted>-<cds_end_shifted>   <0 for forward 1 for rev>

  This file is almost in the correct format for samtools faidx (to save time later), but also contains the indicator for forward or reverse. I will refer to this file as region.txt

6. I created a nextflow process (which is able to run within a samtools docker container) which takes the indexed consensus fasta, and the region.txt file. For every line in the region.txt file (this is necessary, as the samtools call is different depending on forward or reverse), it will see if the the lines contains a 0 or 1. This indicates forward or reverse. If reverse, then there is an additional -i flag in the samtools faidx command. I capture the output from the samtools faidx command and write it to a file. I do this for every line in the file, and append the output to the file. This actually runs very fast.

7. This output file now contains a transcript of all of the shifted coding regions from the consensus genome fasta. I clean up the output file slightly and prepend the strain name.

8. Finally, the strain specific files will be concatted together to create a merged transcript index fasta file!
Currently, these pieces are not woven into one workflow, mainly for testing. I can run the script that queries the database. This produces region.txt. I take this and the consensus fasta from the dnaseqanalysis workflow and send it to them to the transcript generation nextflow processes. These can take these two files and generate the transcript fasta file. 
