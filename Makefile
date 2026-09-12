HOLYC_ROOT ?= ../holyc-linux
HOLYC := $(HOLYC_ROOT)/.holyc-build/bin/holyc
INCLUDES := -I include

.PHONY: all test clean

all: build/slide-demo

$(HOLYC):
	$(MAKE) -C $(HOLYC_ROOT) compiler

build/slide-demo: examples/SlideDemo.HC include/HolyGame.HC $(HOLYC)
	mkdir -p build
	$(HOLYC) $< $(INCLUDES) -o $@

build/engine-test: tests/EngineTest.HC include/HolyGame.HC $(HOLYC)
	mkdir -p build
	$(HOLYC) $< $(INCLUDES) -o $@

build/bible-test: tests/BibleTest.HC include/HolyBible.HC $(HOLYC)
	mkdir -p build
	$(HOLYC) $< $(INCLUDES) -o $@

test: build/engine-test build/bible-test build/slide-demo
	./build/engine-test
	./build/bible-test
	SDL_VIDEODRIVER=dummy ./build/slide-demo

clean:
	rm -rf build
