# nextflow-qc-sr
Nextflow QC pipeline for short reads!

Runs:
    Trimmomatic
    FastQC
    Quast
    MultiQC
    Unicycler
    Bakta
    GTDBtk

See Nextflow-qc-lr for long read equivalent.

NB: Needs the i18 snp pipeline env to run. Bakta runs from a biocontainer. Conda and docker need to be enabled.
