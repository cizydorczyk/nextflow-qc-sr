process unicycler {

    publishDir "${projectDir}/results/unicycler-assemblies/", mode: 'copy'

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("${sample}_assembly"), emit: unicycler_ch

    script:
    """
    unicycler -1 ${reads[0]} -2 ${reads[1]} -o ${sample}_assembly -t ${task.cpus} --depth_filter 0.25 --min_fasta_len 200 --mode normal
    """
}
