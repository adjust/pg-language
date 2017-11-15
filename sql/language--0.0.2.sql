


DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
	EXECUTE $E$ ALTER FUNCTION language_in(cstring) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_out(language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_recv(internal) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_send(language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_eq(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_neq(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_lt(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_le(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_gt(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_ge(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION language_cmp(language, language) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION hash_language(language) PARALLEL SAFE $E$;
  END IF;
END;
$$;

CREATE TYPE language;

CREATE FUNCTION supported_languages()
    RETURNS SETOF language
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_in(cstring)
    RETURNS language
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_out(language)
    RETURNS cstring
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_recv(internal)
    RETURNS language
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION language_send(language)
    RETURNS bytea
    AS '$libdir/language.so'
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
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_lt(language, language) IS 'implementation of < operator';

CREATE FUNCTION language_le(language, language)
    RETURNS BOOL
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_le(language, language) IS 'implementation of <= operator';

CREATE FUNCTION language_eq(language, language)
    RETURNS BOOL
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_eq(language, language) IS 'implementation of = operator';

CREATE FUNCTION language_neq(language, language)
    RETURNS BOOL
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_neq(language, language) IS 'implementation of <> operator';

CREATE FUNCTION language_ge(language, language)
    RETURNS BOOL
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_ge(language, language) IS 'implementation of >= operator';

CREATE FUNCTION language_gt(language, language)
    RETURNS BOOL
    AS '$libdir/language.so'
    LANGUAGE C IMMUTABLE STRICT;

COMMENT ON FUNCTION language_gt(language, language) IS 'implementation of > operator';

CREATE FUNCTION hash_language(language)
    RETURNS integer
    AS '$libdir/language.so'
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
    AS '$libdir/language.so'
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
