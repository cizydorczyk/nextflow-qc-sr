process renameAssembly {
    input:
    tuple val(sample), path(assembly_dir)

    output:
    tuple val(sample), path("${sample}_assembly.fasta")

    script:
    """
    cp ${assembly_dir}/assembly.fasta ${sample}_assembly.fasta
    """
}