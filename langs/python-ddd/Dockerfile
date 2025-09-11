FROM python:3.12-slim
WORKDIR /app
COPY langs/python-ddd/src ./src
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app/src
ENTRYPOINT ["python","-m","martian_ddd.cli"]

