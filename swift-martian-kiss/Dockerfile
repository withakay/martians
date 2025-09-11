FROM swift:5.9-jammy
WORKDIR /app
COPY swift-martian-kiss/main.swift /app/main.swift
RUN swiftc -O -o /usr/local/bin/martian /app/main.swift
ENTRYPOINT ["/usr/local/bin/martian"]
