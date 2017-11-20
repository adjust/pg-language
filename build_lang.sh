#!/bin/bash

if [ $3 == src/lang_rev.awk ]; then
cat > $1 <<-EOF
/*
 * code automatically generated with make and build_lang.sh
 */

#ifndef LANG_REV_H
#define LANG_REV_H
#include "language.h"
static inline language_code
lang_from_str(const char *str)
{
    switch (str[0] << 8 | str[1])
    {
EOF
    sort $2 | awk -f $3 >> $1
    cat >> $1 <<-EOF
    default: elog(ERROR, "unknown language type: %s", str);
    }
};
#endif
EOF

elif [ $3 == src/lang_fwd.awk ]; then
    cat > $1 <<-EOF
/*
 * code automatically generated with make and build_lang.sh
 */

#ifndef LANG_FWD_H
#define LANG_FWD_H

#include "language.h"

static inline char *
create_string(const char *chars)
{
    char *str = (char *) palloc(3 * sizeof(char));
    memcpy(str, chars, 2 * sizeof(char));
    str[3] = '\0';
    return str;
}

static inline char *
language_to_str(language_code c)
{
    switch (c)
    {
EOF
    sort -k 3 -n $2 | awk -f $3 >> $1
    cat >> $1 <<-EOF
    default: elog(ERROR, "internal language representation unknown: %u", c);
    }
}
#endif
EOF
else
    echo "unknown awk command"
    exit 1
fi