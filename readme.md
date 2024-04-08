# XAF Blazor Base Image

This Docker image serves as a base image for building and running XAF Blazor applications. It includes all necessary dependencies for running Skia.

## Usage

To use this image in your own Dockerfile, start with the following line:

```dockerfile
FROM aelmen/xafblazoraspnet8
```

You can also use this image with Docker Compose. Here's an example `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  myapp:
    build: 
      context: .
      dockerfile: Dockerfile
      environment:
        LOCALE: es_ES.UTF-8
        TZ: Europe/Madrid
    image: your_image_name
    ports:
      - "8080:80"
```

## Setting the Locale and Timezone

The `LOCALE` and `TZ` environment variables are used to set the locale and timezone inside the Docker container, respectively.

For `LOCALE`, you can find a list of available locales in Debian by running `locale -a` in a Debian-based Docker container. The format is typically `language_REGION.charset`, for example `es_ES.UTF-8` for Spanish.

For `TZ`, you can find a list of available timezones in the `/usr/share/zoneinfo` directory in a Debian-based Docker container. The format is `Region/City`, for example `Europe/Madrid` for Madrid, Spain.

To set these variables, include them in the `environment` section of your `docker-compose.yml` file or use the `-e` option with `docker run`. For example:

```yaml
environment:
    LOCALE: sv_SE.UTF-8
    TZ: Europe/Stockholm
```

or as a build argument:

```powershell
docker run -e LOCALE=sv_SE.UTF-8 -e TZ=Europe/Stockholm your_image_name
```

## Contents

This image is based on `mcr.microsoft.com/dotnet/sdk:8.0` and includes the following additional dependencies:

- `software-properties-common`
- `libc6`
- `libicu-dev`
- `libfontconfig1`
- `tzdata`
- `locales`

It also sets the locale to `sv_SE.UTF-8` and the timezone to `Europe/Stockholm`. You can change these settings by providing your own values for the `LOCALE` and `TZ` environment variables when building your Docker image:

```powershell
docker build --build-arg --env LOCALE=your_locale --env TZ=your_timezone -t your_image_name .
```

Replace `your_locale` with your desired locale and `your_timezone` with your desired timezone.
