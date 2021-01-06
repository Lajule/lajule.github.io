FROM node
MAINTAINER Julien ROUZIERES <julien.rouzieres@mac.com>

RUN npm install -g \
	pug-cli \
	postcss postcss-cli cssnano autoprefixer \
	uglify-js \
	browser-sync

USER 1000:1000
