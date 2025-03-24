#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { trimmomatic } from './modules/trimmomatic.nf'
include { fastqc } from './modules/fastqc.nf'
include { multiqc } from './modules/multiqc.nf'
include { unicycler } from './modules/unicycler.nf'
include { bakta } from './modules/bakta.nf'
include { renameAssembly } from './modules/renameAssembly.nf'
include { quast }  from './modules/quast.nf'
include { gtdbtk } from './modules/gtdbtk.nf'
// include  { checkm } from './modules/checkm.nf' // does not work rn; db issue?

/*
 * Pipeline parameters
 */


samples_ch = Channel.fromFilePairs(params.raw_fastq)


workflow {

    trimmomatic(samples_ch)
    trimmomatic.out.map { sample, reads1, reads2 -> [sample, [reads1, reads2]] }.set { trimmomatic_ch }

    fastqc(trimmomatic_ch)

    multiqc(fastqc.out.collect())
    
    unicycler(trimmomatic_ch)
    
    bakta(unicycler.out.unicycler_ch)

    renameAssembly(unicycler.out.unicycler_ch)

    renameAssembly.out.map { it -> it[1] }.collect().set { quast_input_ch }
    quast(quast_input_ch)

    // renameAssembly.out.collect(flat: false).view()

    gtdbtk(renameAssembly.out.map{it -> it[1]}.collect(flat: false))
    
    // checkm(renameAssembly.out.map{it -> it[1]}.collect())
    // checkm.out.view()

}