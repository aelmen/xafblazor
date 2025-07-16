# Modern base image for .NET 9 development and DevExpress XAF Blazor
FROM mcr.microsoft.com/dotnet/sdk:9.0

# Update package list and upgrade all installed packages
RUN apt-get update && apt-get upgrade -y

# Install required dependencies for DevExpress XAF Blazor and reporting
# Includes broad font support for Swedish, Finnish, Thai, and Windows compatibility
RUN apt-get install -y \
    software-properties-common \
    libc6 \
    libicu-dev \
    libfontconfig1 \
    tzdata \
    libgdiplus \
    fonts-dejavu-core \
    fonts-dejavu-extra \
    fonts-thai-tlwg \
    fonts-freefont-ttf \
    fonts-noto-cjk \
    fonts-liberation \
    fonts-crosextra-carlito \
    fonts-crosextra-caladea \
    fonts-noto-mono

# Install locales package to enable locale settings
RUN apt-get install -y locales

# Set environment variables for locale and timezone
ENV LOCALE=sv_SE.UTF-8
ENV TZ=Europe/Stockholm

# Generate the specified locale and set timezone
RUN locale-gen $LOCALE && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# NOTE: For runtime images, use the aspnet base image and repeat the relevant font and libgdiplus installation.
