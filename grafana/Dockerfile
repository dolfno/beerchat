FROM grafana/grafana-enterprise:9.5.6

USER root

COPY entrypoint.sh ./
RUN chmod +x ./entrypoint.sh

ENV GF_PATHS_PLUGINS="/var/lib/grafana-plugins"
ENV GF_PLUGIN_RENDERING_CHROME_BIN="/usr/bin/chrome"

RUN apk update && \
    apk upgrade && \
    apk add udev ttf-opensans chromium curl

RUN curl -L -o aws-env.tar.gz https://github.com/telia-oss/aws-env/releases/download/v1.3.0/aws-env-1.3.0-linux-amd64.tar.gz && \
    tar -xvzf aws-env.tar.gz aws-env -C /usr/local/bin && \
    rm aws-env.tar.gz

RUN ln -s /usr/bin/chromium-browser "$GF_PLUGIN_RENDERING_CHROME_BIN"

RUN chmod +x /usr/local/bin/aws-env

RUN mkdir /certs/
RUN chown -R grafana:root /certs

# Set proper permissions for Grafana user
RUN chown -R grafana:root /var/lib/grafana
RUN chown -R grafana:root /etc/grafana
RUN chown -R grafana:root /usr/share/grafana
RUN chown -R grafana:root /var/lib/grafana

# Create grafana-plugins dir
RUN mkdir $GF_PATHS_PLUGINS
RUN chown -R grafana:root $GF_PATHS_PLUGINS
RUN chmod -R 755 $GF_PATHS_PLUGINS

# Add custom plugins
COPY --chown=grafana:root ./plugins/singlestat-math/dist $GF_PATHS_PLUGINS/blackmirror1-singlestat-math-panel

ARG SHIFT_SELECTOR_VERSION="2.2.0"
ADD ./plugins/grafana-shift-selector-$SHIFT_SELECTOR_VERSION.tar.gz $GF_PATHS_PLUGINS/grafana-shift-selector
RUN mv $GF_PATHS_PLUGINS/grafana-shift-selector/grafana-shift-selector-$SHIFT_SELECTOR_VERSION/dist $GF_PATHS_PLUGINS/grafana-shift-selector && \
    rm -rf $GF_PATHS_PLUGINS/grafana-shift-selector/grafana-shift-selector-$SHIFT_SELECTOR_VERSION && \
    chown -R grafana:root $GF_PATHS_PLUGINS/grafana-shift-selector

# Switch to Grafana user
USER grafana

# Install plugins
ENV GF_RENDERER_PLUGIN_CHROME_BIN="/usr/bin/chromium-browser"

RUN grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install agenty-flowcharting-panel && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install grafana-clock-panel  && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install simpod-json-datasource && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install natel-discrete-panel && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install isaozler-paretochart-panel && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install ae3e-plotly-panel && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install isaozler-shiftselector-panel && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install marcusolsson-csv-datasource && \
    grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" --pluginUrl "https://github.com/grafana/grafana-image-renderer/releases/latest/download/plugin-linux-x64-glibc-no-chromium.zip" plugins install grafana-image-renderer

# Install Enterprise plugins
RUN grafana-cli --pluginsDir "$GF_PATHS_PLUGINS" plugins install grafana-datadog-datasource

# Add default configuration
COPY --chown=grafana:root ./grafana.ini /etc/grafana/grafana.ini

COPY --chown=grafana:root logo.svg /usr/share/grafana/public/img/grafana_icon.svg
COPY --chown=grafana:root favicon.png /usr/share/grafana/public/img/fav32.png

# Add AWS RDS certificates
RUN wget https://truststore.pki.rds.amazonaws.com/eu-central-1/eu-central-1-bundle.pem
RUN wget https://truststore.pki.rds.amazonaws.com/eu-west-1/eu-west-1-bundle.pem
RUN wget https://truststore.pki.rds.amazonaws.com/us-west-2/us-west-2-bundle.pem
RUN wget https://truststore.pki.rds.amazonaws.com/ap-southeast-1/ap-southeast-1-bundle.pem
RUN mv *.pem /certs/

# Set volumes
VOLUME /certs
VOLUME /var/lib/grafana
VOLUME /var/lib/grafana-plugins
VOLUME /etc/grafana
VOLUME /usr/share/grafana
VOLUME /var/log/grafana
VOLUME /tmp

ENTRYPOINT ["./entrypoint.sh"]
