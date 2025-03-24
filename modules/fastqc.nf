process fastqc {
    
    input:
    tuple val(sample), path(reads)

    output:
    path "${sample}_raw_fastqc", emit: trimmed_fastqc_ch

    script:
    """
    mkdir ${sample}_raw_fastqc
    fastqc -t ${task.cpus} -o ${sample}_raw_fastqc ${reads}
    """
}