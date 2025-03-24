process multiqc {

    publishDir "${projectDir}/results/multiqc/", mode: 'copy'

    input:
    path "*"

    output:
    path "multiqc_report.html"

    script:
    """
    multiqc .
    """
}
