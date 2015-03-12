## Parameters
AUTOBUILDS=#test #Kompiler self contained .f
BUILDS= assign1
MODULES= mprecision constants random generic specific
LIBS= lapack #slatec
LIBPATH=/usr/lib/


## Preferences
FC=gfortran
FFLAGS= -mcmodel=large -g
LDFLAGS=
RM=rm -f
GARBAGE=*.o *.mod
EXEC=*.out *.exe


## DEF
LIBARGS=-L$(LIBPATH) $(LIBS:%=-l%)

define LINK
$(FC) $(FFLAGS) $^ $(LDFLAGS) -o $@.out $(LIBARGS)
endef

define COMPILE
$(FC) $(FFLAGS) -c $<
endef


## General
all: builds

builds: $(BUILDS) $(AUTOBUILDS)

modules: $(MODULES)


## Dependencies
assign1: %:mprecision.o constants.o random.o generic.o specific.o %.o
	$(LINK)

## STNRD
$(AUTOBUILDS): %: %.o
	$(LINK)

%.o: %.f95
	$(COMPILE)


## UTILS
.INTERMEDIATE: $(BUILDS:%=%.o) $(AUTOBUILDS:%=%.o) $(MODULES:%=%.o)

.PHONY: all clean vclean builds modules

clean:
	$(RM) $(GARBAGE)

vclean: clean
	$(RM) $(EXEC)
