FROM fluent/fluentd:v1.3
MAINTAINER hahaman

# Set timezone to Bangkok
ENV TZ=Asia/Bangkok

# Add timezone data
RUN apk add -U tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \

	# Install fluentd plugins
	&& /usr/bin/fluent-gem install fluent-plugin-kafka -v 0.7.9 \
	&& /usr/bin/fluent-gem install fluent-plugin-elasticsearch \
	&& /usr/bin/fluent-gem install fluent-plugin-rewrite-tag-filter \
	&& /usr/bin/fluent-gem install fluent-plugin-concat \
	
    # Cleanup
    && rm -rf /var/cache/apk/* \
	&& rm -rf /usr/share/zoneinfo
