#ifndef LANGUGA_H
#define LANGUGA_H

#include "postgres.h"

#include "fmgr.h"

typedef uint8 language_code;

static const language_code LANG_MAX = 186;

#define PG_RETURN_UINT8(x) return UInt8GetDatum(x)
#define PG_GETARG_UINT8(x) DatumGetUInt8(PG_GETARG_DATUM(x))

#define PG_RETURN_LANGUAGE(x) PG_RETURN_UINT8(x)
#define PG_GETARG_LANGUAGE(c) PG_GETARG_UINT8(c)
#define LanguageGetDatum(x) (CharGetDatum(x))

Datum language_in(PG_FUNCTION_ARGS);
Datum language_out(PG_FUNCTION_ARGS);
Datum language_recv(PG_FUNCTION_ARGS);
Datum language_send(PG_FUNCTION_ARGS);
Datum supported_languages(PG_FUNCTION_ARGS);

#endif