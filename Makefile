ID := $(shell id -u):$(shell id -g)

index.html:
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox pug index.pug

resume.html:
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox pug resume.pug

styles/animation.processed.css:
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox postcss -m -u autoprefixer -u cssnano -o styles/animation.processed.css styles/animation.css

styles/style.processed.css:
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox postcss -m -u autoprefixer -u cssnano -o styles/style.processed.css styles/style.css

scripts/main.processed.js:
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox uglifyjs scripts/main.js -o scripts/main.processed.js -c -m

.PHONY: all clean serve

all: index.html resume.html styles/animation.processed.css styles/style.processed.css scripts/main.processed.js

clean:
	$(RM) *.html styles/*.processed.css styles/*.processed.css.map scripts/*.processed.js

serve:
	docker run -it --rm -p 3000:3000 -p 3001:3001 -v $$PWD:/src/app -w /src/app toolbox browser-sync start --server --files "*.html,styles/*.processed.css,scripts/*.processed.js" --no-open
