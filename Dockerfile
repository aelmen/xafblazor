# Use mcr.microsoft.com/dotnet/sdk:8.0 as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Update the package list
RUN apt-get update

# Upgrade all installed packages
RUN apt-get upgrade -y

# Install dependencies
# software-properties-common: provides common software properties from Debian
# libc6: the GNU C Library, a key component of most systems
# libicu-dev: the International Components for Unicode library
# libfontconfig1: provides a configuration interface for font files
# tzdata: contains data files with rules for various timezones around the world
RUN apt-get install -y software-properties-common libc6 libicu-dev libfontconfig1 tzdata

# Install locales package, which allows you to set the system's locale
RUN apt-get install -y locales

# Add ENV for locale and timezone
# LOCALE: represents the Swedish locale
# TZ: represents the Stockholm timezone
ENV LOCALE=sv_SE.UTF-8
ENV TZ=Europe/Stockholm

# Generate a specific locale (replace sv_SE.UTF-8 with the locale you need)
RUN locale-gen $LOCALE

# Set the timezone to Europe/Stockholm
# The command reconfigures the tzdata package in a non-interactive mode, which is necessary when running the command in a Dockerfile
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f noninteractive tzdata