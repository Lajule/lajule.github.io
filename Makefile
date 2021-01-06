SOURCES := index.html \
	resume.html \
	styles/style.processed.css \
	scripts/main.processed.js

all: $(SOURCES)

clean:
	$(RM) *.html styles/*.processed.css styles/*.processed.css.map scripts/*.processed.js

dev:
	docker run -d --rm --name browser-sync --network host -v $$PWD:/src/app -w /src/app lajulebox browser-sync start --server --files "*.html,styles/*.processed.css,scripts/*.processed.js" --no-open

.PHONY: all clean dev

%.html: %.pug
	docker run -it --rm -v $$PWD:/src/app -w /src/app lajulebox pug $<

%.processed.css: %.css
	docker run -it --rm -v $$PWD:/src/app -w /src/app lajulebox postcss -m -u autoprefixer -u cssnano -o $@ $<

%.processed.js: %.js
	docker run -it --rm -v $$PWD:/src/app -w /src/app lajulebox uglifyjs $< -o $@ -c -m
