{
    printf "        case ('%s' << 8 | '%s'): return %d;\n",  substr($1, 1, 1),  substr($1, 2, 1), $3;
}
