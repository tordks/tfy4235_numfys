## Parameters
AUTOBUILDS=#test #Kompiler self contained .f
BUILDS= Assign1
MODULES= generic specific
LIBS= slatec lapack
LIBPATH=/usr/lib/


## Preferences
FC=gfortran
FFLAGS=-g
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
Assign1: %: generic.o specific.o %.o
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
