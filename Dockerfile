FROM alpine:3 AS downloader

# .NET Core SDK
RUN wget https://download.visualstudio.microsoft.com/download/pr/4546f2c5-3ec8-4d0d-a47d-ba44b58a2a3f/4b5319fcb0ec675d3a05cdc4d6c65c80/dotnet-sdk-2.1.804-linux-musl-x64.tar.gz -O /tmp/dotnet.tar.gz
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
