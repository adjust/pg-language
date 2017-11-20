EXTENSION = language
EXTVERSION = $(shell grep default_version $(EXTENSION).control | \
                sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")
DATA = $(wildcard *--*.sql)
SQLSRC = $(wildcard sql/*.sql)

MODULE_big = language
OBJS = $(patsubst %.c,%.o,$(wildcard src/*.c))
EXTRA_CLEAN = src/language_reverse.h src/language_forward.h

TESTS        = $(wildcard test/sql/*.sql)
REGRESS      = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --inputdir=test --load-extension=${EXTENSION}

PG_CONFIG ?= pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

ifeq ($(shell test $(VERSION_NUM) -lt 90600; echo $$?),0)
REGRESS := $(filter-out parallel_test, $(REGRESS))
endif


all: $(EXTENSION)--$(EXTVERSION).sql $(EXTRA_CLEAN)

$(EXTENSION)--$(EXTVERSION).sql: $(SQLSRC)
	echo "-- complain if script is sourced in psql, rather than via CREATE EXTENSION" > $@
	echo "\echo Use \"CREATE EXTENSION ${EXTENSION}\" to load this file. \quit" >> $@
	echo "" >> $@
	cat $^ >> $@

src/language_reverse.h: languages src/lang_rev.awk build_lang.sh
	./build_lang.sh $@ $^

src/language_forward.h: languages src/lang_fwd.awk build_lang.sh
	./build_lang.sh $@ $^

src/$(MODULE_big).o: ${EXTRA_CLEAN}