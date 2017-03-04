FROM ruby:2.2.6
MAINTAINER Adrian Perez <adrian@adrianperez.org>

EXPOSE 4567

RUN apt-get update \
	&& apt-get install -y git nodejs \
    	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lord/slate /app \
	&& cd /app \
	&& git checkout v1.5

WORKDIR /app
RUN bundle install

VOLUME /app/build
VOLUME /app/source

CMD ["bundle", "exec", "middleman", "server", "--watcher-force-polling"]
