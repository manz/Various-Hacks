OBJS = build_wram_data.o65 gogo.o65 build_set_data.o65
AS = ./snescom
LNK = ./sneslink

all: build/gogo.ips

build/gogo.ips: build/gogo_precomp.s
	$(AS) -I -Wall -o build/gogo.ips build/gogo_precomp.s 
	
build/gogo_precomp.s: gogo.s build_set_data.s build_wram_data.s
	gcc -E gogo.s > build/gogo_precomp.s
	
#gogo.ips: $(OBJS)
#	$(LNK) -fips -o $@ $^

# Generic rule to create .o65 out from .a65
#%.o65: %.s
#	$(AS) -J -Wall -o $@ $<

# Generic rule to create .ips out from .a65
#%.ips: %.a65
#	snescom -I -J -Wall -o $@ $<

clean:
	rm -f *.o65 *~ build/*
