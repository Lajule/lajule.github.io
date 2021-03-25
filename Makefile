OBJS=index.html \
  resume.html \
  styles/style.processed.css \
  scripts/main.processed.js

DOCKERFLAGS=--rm \
  -u $(shell id -u):$(shell id -g) \
  -v $$PWD:/usr/src/app \
  -w /usr/src/app

all: $(OBJS)

clean:
	$(RM) *.html \
	  styles/*.processed.css styles/*.processed.css.map \
	  scripts/*.processed.js

dev:
	docker run -d $(DOCKERFLAGS) -p 3000:3000 -p 3001:3001 lajulebox \
	  browser-sync start \
	    -s -f '*.html' '**/*.processed.css' '**/*.processed.js' --no-open

%.html: %.pug
	docker run -it $(DOCKERFLAGS) lajulebox pug $<

%.processed.css: %.css
	docker run -it $(DOCKERFLAGS) lajulebox \
	  postcss -m -u autoprefixer -u cssnano -o $@ $<

%.processed.js: %.js
	docker run -it $(DOCKERFLAGS) lajulebox uglifyjs $< -o $@ -c -m

.PHONY: all clean dev
