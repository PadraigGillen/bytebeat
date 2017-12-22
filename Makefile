PROG=bb
SRC=$(PROG).c
ASM=$(PROG).s

CFLAGS=
ASM_FLAGS=-S -fverbose-asm

AUDIO_FILE=$(PROG).wav
AUDIO_RATE=22000
AUDIO_PLAYER=aplay
AUDIO_RECORDER=arecord
AUD_FLAGS=-r $(AUDIO_RATE)

HEX_VIEW=xxd -c 50

all: play
it: stop

prog: $(PROG)
asm: $(ASM)

$(PROG): $(SRC)
	gcc $(CFLAGS) $(SRC) -o $(PROG)

$(ASM): $(SRC)
	gcc $(ASM_FLAGS) $(SRC)

play: $(PROG) stop
	./$(PROG) | aplay $(AUD_FLAGS) &>/dev/null &

stop:
	-killall $(AUDIO_PLAYER) espeak -q

wav: prog
	./$(PROG) | head -c 4M > $(PROG).raw
	sox -r $(AUDIO_RATE) -c 1 -t u8 $(PROG).raw $(PROG).wav
	rm -f $(PROG).raw

ogg: wav
	oggenc $(PROG).wav

hex: prog
	./$(PROG) | $(HEX_VIEW)

readable_hex: prog
	./$(PROG) | $(HEX_VIEW) | less

clean:
	rm -f $(PROG).wav $(PROG).ogg $(PROG) $(ASM)
