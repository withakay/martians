FROM haskell:9.6
WORKDIR /app
COPY langs/haskell-kiss/Main.hs /app/Main.hs
RUN ghc -O2 -o /usr/local/bin/martian /app/Main.hs && rm -f /app/Main.hi /app/Main.o
ENTRYPOINT ["/usr/local/bin/martian"]
