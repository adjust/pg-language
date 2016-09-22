EXTENSION = language
EXTVERSION = $(shell grep default_version $(EXTENSION).control | \
                sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")
DATA = $(wildcard sql/*--*.sql)

MODULE_big = language
OBJS = src/language.o
EXTRA_CLEAN = src/language_reverse.h src/language_forward.h

TESTS        = $(wildcard test/sql/*.sql)
REGRESS      = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test --load-extension=${EXTENSION}

all: concat

src/language.o: ${EXTRA_CLEAN}

src/language_reverse.h: languages src/lang_rev.awk
	sort $< | awk -f src/lang_rev.awk > $@

src/language_forward.h: languages src/lang_fwd.awk
	sort -k 3 -n $< | awk -f src/lang_fwd.awk > $@

concat:
	echo > sql/$(EXTENSION)--$(EXTVERSION).sql
	cat $(filter-out $(wildcard sql/*--*.sql),$(wildcard sql/*.sql)) >> sql/$(EXTENSION)--$(EXTVERSION).sql


PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)