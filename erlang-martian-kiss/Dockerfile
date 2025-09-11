FROM erlang:26-slim
WORKDIR /app
COPY erlang-martian-kiss/martian.escript /app/martian
RUN chmod +x /app/martian
ENTRYPOINT ["/app/martian"]
