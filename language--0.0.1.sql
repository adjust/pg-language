-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION istore" to load this file. \quit

CREATE TYPE language;

CREATE FUNCTION supported_languages()
    RETURNS SETOF language
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_in(cstring)
    RETURNS language
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_out(language)
    RETURNS cstring
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_recv(internal)
    RETURNS language
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_send(language)
    RETURNS bytea
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE language (
    internallength = 1,
    input = language_in,
    output = language_out,
    send = language_send,
    receive = language_recv,
    alignment = char,
    PASSEDBYVALUE
);

COMMENT ON TYPE language
  IS '1-byte adjust-specific Language Code';

CREATE FUNCTION language_lt(language, language)
    RETURNS BOOL
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_lt(language, language) IS 'implementation of < operator';

CREATE FUNCTION language_le(language, language)
    RETURNS BOOL
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_le(language, language) IS 'implementation of <= operator';

CREATE FUNCTION language_eq(language, language)
    RETURNS BOOL
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_eq(language, language) IS 'implementation of = operator';

CREATE FUNCTION language_neq(language, language)
    RETURNS BOOL
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_neq(language, language) IS 'implementation of <> operator';

CREATE FUNCTION language_ge(language, language)
    RETURNS BOOL
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_ge(language, language) IS 'implementation of >= operator';

CREATE FUNCTION language_gt(language, language)
    RETURNS BOOL
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_gt(language, language) IS 'implementation of > operator';

CREATE FUNCTION hash_language(language)
    RETURNS integer
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION hash_language(language) IS 'hash';

CREATE OPERATOR < (
    leftarg = language,
    rightarg = language,
    procedure = language_lt,
    commutator = >,
    negator   = >=,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

COMMENT ON OPERATOR <(language, language) IS 'less than';

CREATE OPERATOR <= (
    leftarg = language,
    rightarg = language,
    procedure = language_le,
    commutator = >=,
    negator   = >,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

COMMENT ON OPERATOR <=(language, language) IS 'less than or equal';

CREATE OPERATOR = (
    leftarg = language,
    rightarg = language,
    procedure = language_eq,
    commutator = =,
    negator   = <>,
    restrict = eqsel,
    join = eqjoinsel,
    HASHES, MERGES
);

COMMENT ON OPERATOR =(language, language) IS 'equal';

CREATE OPERATOR >= (
    leftarg = language,
    rightarg = language,
    procedure = language_ge,
    commutator = <=,
    negator   = <,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

COMMENT ON OPERATOR >=(language, language) IS 'greater than or equal';

CREATE OPERATOR > (
    leftarg = language,
    rightarg = language,
    procedure = language_gt,
    commutator = <,
    negator   = <=,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

COMMENT ON OPERATOR >(language, language) IS 'greater than';

CREATE OPERATOR <> (
    leftarg = language,
    rightarg = language,
    procedure = language_neq,
    commutator = <>,
    negator = =,
    restrict = neqsel,
    join = neqjoinsel
);

COMMENT ON OPERATOR <>(language, language) IS 'not equal';

CREATE FUNCTION language_cmp(language, language)
    RETURNS int4
    AS 'MODULE_PATHNAME'
    LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR CLASS language_ops
    DEFAULT FOR TYPE language USING btree AS
        OPERATOR        1       < ,
        OPERATOR        2       <= ,
        OPERATOR        3       = ,
        OPERATOR        4       >= ,
        OPERATOR        5       > ,
        FUNCTION        1       language_cmp(language, language);

CREATE OPERATOR CLASS language_ops
    DEFAULT FOR TYPE language USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_language(language);
