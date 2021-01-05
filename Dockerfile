FROM node
MAINTAINER Julien ROUZIERES <julien.rouzieres@mac.com>

RUN npm install pug-cli html-minifier uglify-js postcss postcss-cli cssnano autoprefixer -g
