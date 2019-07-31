FROM fluent/fluentd:v1.6-1
MAINTAINER hahaman

# Set timezone to Bangkok
ENV TZ=Asia/Bangkok

USER root

# Add timezone data
RUN apk add -U tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \

	# Install fluentd plugins
	&& /usr/bin/fluent-gem install fluent-plugin-kafka -v 0.11.0  \
	&& /usr/bin/fluent-gem install fluent-plugin-elasticsearch -v 3.5.3 \
	&& /usr/bin/fluent-gem install fluent-plugin-rewrite-tag-filter -v 2.2.0 \
	&& /usr/bin/fluent-gem install fluent-plugin-concat -v 2.4.0 \
	
    # Cleanup
    && rm -rf /var/cache/apk/* \
	&& rm -rf /usr/share/zoneinfo

USER fluent