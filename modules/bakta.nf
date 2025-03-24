process bakta {
    
    publishDir "${projectDir}/results/bakta-annotations/", mode: 'copy'

    container 'quay.io/biocontainers/bakta:1.9.3--pyhdfd78af_0'
    containerOptions = "--volume ${params.bakta_db}:${params.bakta_db}"

    input:
    tuple val(sample), path(assembly_dir)

    output:
    tuple val(sample), path("${sample}_bakta"), emit: bakta_ch

    script:
    """
    bakta \
        --db ${params.bakta_db} \
        --min-contig-length 200 \
        --prefix ${sample} \
        --output ${sample}_bakta \
        --strain ${sample} \
        --compliant \
        --threads ${task.cpus} \
        ${assembly_dir}/assembly.fasta
    """
}
