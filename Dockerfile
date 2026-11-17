# `main` moves with every upstream merge. Use a release tag (e.g. `:0.2.0`) or pin a
# digest when this instance needs to sit on a known build.
FROM ghcr.io/dhis2/open-geo-service:main

# The image brings the service and its dependencies; pyproject.toml brings what the
# instance plugins add on top.
USER root
COPY pyproject.toml ./
RUN uv pip install --python /app/.venv/bin/python -r pyproject.toml
USER geoservice

# Also bind-mounted by compose, so both can be edited without a rebuild.
COPY geoservice.yaml /app/geoservice.yaml
COPY plugins/ /app/plugins/

ENV GEOSERVICE_CONFIG=/app/geoservice.yaml
ENV PORT=8003
