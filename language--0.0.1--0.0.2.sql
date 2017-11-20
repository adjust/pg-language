

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

