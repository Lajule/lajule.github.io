DOCKERFLAGS = --rm -u "$(shell id -u):$(shell id -g)" -v "$${PWD}:/src" -w /src

serve:
	docker run -d $(DOCKERFLAGS) -p 3000:3000 -p 3001:3001 lajulebox \
	  browser-sync start -s -f index.html style.css index.js --no-open

.PHONY: serve
