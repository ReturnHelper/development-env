FROM ubuntu:22.04

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

RUN mkdir -p /root/.config/NuGet && mkdir -p /root/.nuget/NuGet

COPY NuGet.Config /root/.nuget/NuGet/NuGet.Config

RUN apt-get update -y

RUN apt-get install -y wget vim

RUN echo 'Install .net SDK'

RUN wget https://dot.net/v1/dotnet-install.sh \
    && chmod a+x dotnet-install.sh \
    && ./dotnet-install.sh --version 6.0.302 \
    && rm dotnet-install.sh

RUN ln -sf /root/.dotnet/dotnet /usr/bin/dotnet \
    && dotnet help

RUN dotnet tool install Nuke.GlobalTool --global

ENV PATH="$PATH:/root/.dotnet/tools"

