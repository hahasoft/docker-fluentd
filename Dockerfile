FROM fluent/fluentd:v1.11.5-1.0
MAINTAINER hahaman

# Set timezone to Bangkok
ENV TZ=Asia/Bangkok

USER root

# Add timezone data
RUN apk add --update --no-cache tzdata ruby-dev build-base \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \

	# Install fluentd plugins --no-document		
	&& /usr/bin/fluent-gem install fluent-plugin-kafka -v 0.15.3 \	
	&& /usr/bin/fluent-gem install ruby-kafka -v 1.0.0 \
	&& /usr/bin/fluent-gem install fluent-plugin-elasticsearch -v 4.3.2  \
	&& /usr/bin/fluent-gem install fluent-plugin-rewrite-tag-filter -v 2.3.0  \
	&& /usr/bin/fluent-gem install fluent-plugin-concat -v 2.4.0      

USER fluent