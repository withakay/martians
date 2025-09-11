FROM erlang:26-slim
WORKDIR /app
COPY langs/erlang-kiss/martian.escript /app/martian
RUN chmod +x /app/martian
ENTRYPOINT ["/app/martian"]
