process quast {

    publishDir "${projectDir}/results/", mode: 'copy'

    input:
    path renamed_assemblies

    output:
    path 'unicycler-quast'

    script:
    """
    quast -o unicycler-quast/ -m 200 --threads ${task.cpus} ${renamed_assemblies}
    """
}