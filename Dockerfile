FROM alpine:3 AS downloader

# .NET Core Runtime
RUN wget https://download.visualstudio.microsoft.com/download/pr/48c55817-a638-4efa-b01a-c6e109bebe6c/3ef6df9794ad3954340317e50edf0e0b/aspnetcore-runtime-2.1.16-linux-musl-x64.tar.gz -O /tmp/dotnet.tar.gz
RUN mkdir -p /opt/dotnet
RUN tar xvf /tmp/dotnet.tar.gz -C /opt/dotnet

# StyleCopAnalyzers.CLI
RUN wget https://github.com/rookxx/StyleCopAnalyzers.CLI/archive/272ae20cc129ed09b93010bd72bf5b7dbc5625e0.tar.gz -O /tmp/StyleCopAnalyzers.CLI.tar.gz
RUN mkdir -p /opt/StyleCopAnalyzers.CLI
RUN tar xvf /tmp/StyleCopAnalyzers.CLI.tar.gz -C /opt/StyleCopAnalyzers.CLI --strip-component=1

FROM alpine:3

RUN apk add --no-cache icu-libs libstdc++ libintl
COPY --from=downloader /opt /opt
ENTRYPOINT [ "/opt/dotnet/dotnet", "/opt/StyleCopAnalyzers.CLI/tools/bin/style/StyleCopAnalyzers.CLI.dll" ]
