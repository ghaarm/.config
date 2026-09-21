# =============================================================================
# Hilfsdateien
# =============================================================================

push @generated_exts, "bbl";
push @generated_exts, "cb";
push @generated_exts, "cb2";
push @generated_exts, "spl";
push @generated_exts, "nav";
push @generated_exts, "snm";
push @generated_exts, "tdo";
push @generated_exts, "nmo";
push @generated_exts, "brf";
push @generated_exts, "nlg";
push @generated_exts, "nlo";
push @generated_exts, "nls";
push @generated_exts, "synctex.gz";
push @generated_exts, "run.xml";

# Hilfsdateien in Unterverzeichnis
$aux_dir = "auxiliary_files";

# Intervall bei kontinuierlicher Kompilierung
$sleep_time = 2;


# =============================================================================
# XeLaTeX / xdvipdfmx
#
# Standard:
#   schneller Arbeitsmodus ohne PDF-Kompression
#
# Final:
#   LATEXMK_FINAL=1 latexmk ...
# =============================================================================

if ($ENV{'LATEXMK_FINAL'}) {
    # Finaler Build: PDF komprimieren
    $xdvipdfmx = 'xdvipdfmx -E %O -o %D %S';
}
else {
    # Arbeitsbuild: keine PDF-Kompression
    $xdvipdfmx = 'xdvipdfmx -E -z 0 %O -o %D %S';
}
