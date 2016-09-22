{
    printf "case ('%s' << 8 | '%s'): lang_code = %d; break;\n",  substr($1, 1, 1),  substr($1, 2, 1), $3;
}
