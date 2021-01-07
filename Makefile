.PHONY: all clean dev

OBJS=index.html resume.html \
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
	docker run -d $(DOCKERFLAGS) --name lajule-bs --network host lajulebox \
		browser-sync start \
			--server \
			--files "*.html,styles/*.processed.css,scripts/*.processed.js" \
			--no-open

%.html: %.pug
	docker run -it $(DOCKERFLAGS) lajulebox pug $<

%.processed.css: %.css
	docker run -it $(DOCKERFLAGS) lajulebox postcss -m -u autoprefixer -u cssnano -o $@ $<

%.processed.js: %.js
	docker run -it $(DOCKERFLAGS) lajulebox uglifyjs $< -o $@ -c -m
