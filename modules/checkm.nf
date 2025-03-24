process checkm {

    publishDir "${projectDir}/results/checkm/", mode: 'copy'

    conda '/home/user/miniconda3/envs/checkm-1.2.2/'

    input:
    path assemblies

    output:
    path "checkm-output.txt"

    script:
    """
    mkdir -p assembly-copies-temp-checkm/
    cp ${assemblies} assembly-copies-temp-checkm/
    checkm lineage_wf -x fasta -t ${task.cpus} --pplacer_threads ${task.cpus} --file checkm-output.txt assembly-copies-temp-checkm/ checkm/
    """
}