SOURCES := index.html \
	resume.html \
	styles/style.processed.css \
	scripts/main.processed.js

all: $(SOURCES)

clean:
	$(RM) *.html styles/*.processed.css styles/*.processed.css.map scripts/*.processed.js

dev:
	docker run -d --rm --name browser-sync --network host -v $$PWD:/src/app -w /src/app toolbox browser-sync start --server --files "*.html,styles/*.processed.css,scripts/*.processed.js" --no-open

.PHONY: all clean dev

ID := $(shell id -u):$(shell id -g)

%.html: %.pug
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox pug $<

%.processed.css: %.css
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox postcss -m -u autoprefixer -u cssnano -o $@ $<

%.processed.js: %.js
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox uglifyjs $< -o $@ -c -m
