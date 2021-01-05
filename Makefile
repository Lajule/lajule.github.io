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
	docker run -it --rm -u $(ID) -v $$PWD:/src/app -w /src/app toolbox uglifyjs scripts/main.js -o scripts/main.processed.js -c -m --source-map
