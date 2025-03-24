process trimmomatic {
    
    publishDir "${projectDir}/results/trimmed-fastq/", mode: 'copy'

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("${sample}_t_1.fastq.gz"), path("${sample}_t_2.fastq.gz"), emit: trimmomatic_raw_ch


    script:
    """
    trimmomatic PE \\
        -threads ${task.cpus} \\
        ${reads[0]} ${reads[1]} \\
        ${sample}_t_1.fastq.gz ${sample}_u_1.fastq.gz \\
        ${sample}_t_2.fastq.gz ${sample}_u_2.fastq.gz \\
        CROP:150 ILLUMINACLIP:${params.trimmomatic_adapters}:2:30:10:8:TRUE SLIDINGWINDOW:4:5 MINLEN:31
    """

}
