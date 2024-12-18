process CELLALIGNDTW {
    conda '/usersoftware/chanj3/tslearn'
    publishDir "${params.outdir}/CellAlignDTW/", mode: 'copy'
    cache 'lenient'

    input:
    val cluster_ordering
    path path

    output:
    val cluster_ordering, emit: cluster_ordering
    path cluster_ordering, emit: output_path

    script:
    """
    export NUMBA_CACHE_DIR=\$PWD
    mkdir -p ${cluster_ordering}
    gene_list=${cluster_ordering}/limma.paired_${cluster_ordering}.filtered.txt 
    if [ "${params.limma}" != "true" ]; then
        gene_list=${cluster_ordering}/hvg_genes_${cluster_ordering}.txt 
    fi
    /usersoftware/chanj3/tslearn/bin/python ${baseDir}/bin/run_CellAlignDTW.py \
        --path ${path} \
        --outpath ${cluster_ordering} \
        --clusters ${cluster_ordering} \
        --gene_list \${gene_list} \
        --n_splines ${params.n_splines} \
        --lam ${params.lam}
    """
}
