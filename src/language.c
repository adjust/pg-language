/*
 * Code is heavily inspired from pg-currency
 *
 * -- ms
 */
#include "postgres.h"
#include "fmgr.h"
#include "access/hash.h"
#include "funcapi.h"
#include "libpq/pqformat.h"

PG_MODULE_MAGIC;


typedef uint8 language_code;

static const language_code LANG_MAX = 186;


#define PG_RETURN_LANGUAGE(code) PG_RETURN_CHAR(code)
#define PG_GETARG_LANGUAGE(idx)  PG_GETARG_CHAR(idx)
#define LanguageGetDatum(x)      (CharGetDatum(x))


PG_FUNCTION_INFO_V1(language_in);
PG_FUNCTION_INFO_V1(language_out);
PG_FUNCTION_INFO_V1(language_recv);
PG_FUNCTION_INFO_V1(language_send);
PG_FUNCTION_INFO_V1(language_lt);
PG_FUNCTION_INFO_V1(language_le);
PG_FUNCTION_INFO_V1(language_eq);
PG_FUNCTION_INFO_V1(language_neq);
PG_FUNCTION_INFO_V1(language_ge);
PG_FUNCTION_INFO_V1(language_gt);
PG_FUNCTION_INFO_V1(language_cmp);
PG_FUNCTION_INFO_V1(hash_language);
PG_FUNCTION_INFO_V1(supported_languages);


Datum
language_in(PG_FUNCTION_ARGS)
{
    char *str = PG_GETARG_CSTRING(0);
    language_code lang_code = 0;

    if (strlen(str) != 2)
        elog(ERROR, "invalid language input string %s", str);

    switch (str[0] << 8 | str[1])
    {
#include "language_reverse.h"
        // updates {lang_code}
        default: elog(ERROR, "unknown language type: %s", str);
    }

    PG_RETURN_LANGUAGE(lang_code);
}

Datum
language_out(PG_FUNCTION_ARGS)
{
    const char* lang_str = NULL;
    const language_code curr = PG_GETARG_CHAR(0);
    
    switch (curr)
    {
#include "language_forward.h"
        default:
            elog(ERROR, "internal language representation unknown: %u", curr);
    }

    PG_RETURN_CSTRING(pstrdup(lang_str));
}

Datum
language_recv(PG_FUNCTION_ARGS)
{
    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);
    language_code result = pq_getmsgbyte(buf);
    PG_RETURN_LANGUAGE(result);
}

Datum
language_send(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    StringInfoData buf;

    pq_begintypsend(&buf);
    pq_sendbyte(&buf, a);
    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

Datum
language_lt(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    const language_code b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_BOOL(a < b);
}

Datum
language_le(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    const language_code b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_BOOL(a <= b);
}

Datum
language_eq(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    const language_code b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_BOOL(a == b);
}

Datum
language_neq(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    const language_code b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_BOOL(a != b);
}

Datum
language_ge(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    const language_code b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_BOOL(a >= b);
}

Datum
language_gt(PG_FUNCTION_ARGS)
{
    const language_code a = PG_GETARG_LANGUAGE(0);
    const language_code b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_BOOL(a > b);
}

Datum
language_cmp(PG_FUNCTION_ARGS)
{
    const int32 a = PG_GETARG_LANGUAGE(0);
    const int32 b = PG_GETARG_LANGUAGE(1);
    PG_RETURN_INT32(a - b);
}

Datum
hash_language(PG_FUNCTION_ARGS)
{
    return hash_uint32((int32) PG_GETARG_LANGUAGE(0));
}

Datum
supported_languages(PG_FUNCTION_ARGS)
{
    FuncCallContext *funcctx;

    /* stuff done only on the first call of the function */
    if (SRF_IS_FIRSTCALL())
    {
        /* create a function context for cross-call persistence */
        funcctx = SRF_FIRSTCALL_INIT();
    }

    /* stuff done on every call of the function */
    funcctx = SRF_PERCALL_SETUP();

    if (funcctx->call_cntr + 1 < LANG_MAX)
    {
        Datum lang = LanguageGetDatum(funcctx->call_cntr + 1);

        /* do when there is more left to send */
        SRF_RETURN_NEXT(funcctx, lang);
    }
    else
    {
        /* do when there is no more left */
        SRF_RETURN_DONE(funcctx);
    }
}
