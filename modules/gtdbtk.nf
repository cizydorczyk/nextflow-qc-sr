process gtdbtk {

    publishDir "${projectDir}/results/", mode: 'copy'

    conda '/home/user/miniconda3/envs/gtdbtk-2.3.2/'

    input:
    path assemblies

    output:
    path "gtdbtk"

    script:
    """
    mkdir -p assembly-copies-temp/
    cp ${assemblies} assembly-copies-temp/
    
    gtdbtk classify_wf --cpus ${task.cpus} --pplacer_cpus ${task.cpus} -x fasta --genome_dir assembly-copies-temp/ --out_dir gtdbtk/ --skip_ani_screen
    """
}