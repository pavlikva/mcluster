OPTIMIZATION=-O3
FFLAGS=$(HEADERS:%=-I%) -fbounds-check -mcmodel=medium -fopenmp -fPIC
LIBS=-lm -lgsl -lgslcblas -lc -lstdc++ -lgfortran
FC=gfortran $(OPTIMIZATION)
CC = gcc $(OPTIMIZATION)

FHEAD = common.h const_bse.h zdata.h

.f.o:
	$(FC) -c $<

FSOURCE = \
	comenv.f corerd.f deltat.f dgcore.f evolv1.f evolv2.f \
	gntage.f hrdiag.f input.f instar.f kick.f mix.f mlwind.f \
	mrenv.f ran3.f rl.f star.f zcnsts.f zfuncs.f

FOBJ = $(FSOURCE:.f=.o)


CSOURCE = \
	inipar/dictionary.c inipar/iniparser.c inipar/iniparser_interface.c \
	main.c

default: all

all: clean mcluster

mcluster: $(FOBJ) $(FHEAD)
	$(CC) $(FOBJ) $(CSOURCE) $(LIBS) $(FFLAGS) -o mcluster

clean:
	rm --f mcluster *.o
