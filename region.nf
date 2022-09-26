#!/usr/bin/env nextflow
nextflow.enable.dsl=2


process generateRegion {

  publishDir "$params.outputDir", mode: "copy"

  input:
    path 'makepositionarraycoding.pl'

  output:
    path 'region.txt'

  script:
    """
    /usr/bin/perl makepositionarraycoding.pl --test_file shifted.txt --sequence_id LV39cl5_chr1 --region_file region.txt
    """
}


workflow {
    generateRegion(params.makepositionarraycoding)
}
