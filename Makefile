DOCKER := docker

%.html: %.pug
	$(DOCKER) run -it --rm -u $$(id -u):$$(id -g) -v $$PWD:/src/app -w /src/app leandrosouza/pug pug --client --no-debug $<

index.html: index.pug

resume.html: resume.pug

all: index.html resume.html

clean:
	$(RM) index.html resume.html

.PHONY: all clean
