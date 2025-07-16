# XAF Blazor .NET 9 Base Image

This Docker image is a modern, feature-rich base for building and running DevExpress XAF Blazor applications on .NET 9. It includes all essential dependencies, broad Unicode and Windows-like font support, and is ready for use as a development or production base image.

## Features

- Based on `mcr.microsoft.com/dotnet/sdk:9.0` (for build and dev; use `aspnet` for runtime)
- Preinstalled dependencies for DevExpress XAF Blazor and reporting (including `libgdiplus`)
- Extensive font support for Swedish, Finnish, Thai, and Windows compatibility (Arial, Times, Courier, Calibri, Cambria, etc.)
- Locale and timezone configuration via environment variables
- Ready for multi-language, multi-region, and reporting scenarios


## Usage

### As a Base Image in Your Dockerfile

```dockerfile
FROM aelmen/xafblazoraspnet9
# ...your build and app steps...
```

### With Docker Compose

You can use a `.env` file to manage environment variables for locale, timezone, and secrets like your DevExpress NuGet API key:

See [.env.example](./.env.example) for a template:

```env
LOCALE=fi_FI.UTF-8
TZ=Europe/Helsinki
DEVEXPRESS_NUGET_API_KEY=your_devexpress_api_key_here
```

Example [docker-compose.example.yml](./docker-compose.example.yml):

```yaml
version: '3.8'
services:
  xafblazor:
    image: aelmen/xafblazoraspnet9
    env_file:
      - .env
    ports:
      - "8080:80"
    environment:
      # Optionally override or add more environment variables here
      # DEVEXPRESS_NUGET_API_KEY: ${DEVEXPRESS_NUGET_API_KEY}
```

### With Docker Run

```sh
docker run -e LOCALE=th_TH.UTF-8 -e TZ=Asia/Bangkok -e DEVEXPRESS_NUGET_API_KEY=your_key your_image_name
```

## Building Your Own Runtime Image

You can build a runtime image for your XAF Blazor app using this base. See [Dockerfile.runtime.example](./Dockerfile.runtime.example) and [Dockerfile.runtime.full.example](./Dockerfile.runtime.full.example) for templates.

Example snippet for DevExpress NuGet authentication:

```dockerfile
ARG DEVEXPRESS_NUGET_API_KEY
RUN dotnet nuget add source https://nuget.devexpress.com/api -n devexpress-nuget --username=your_email --password=$DEVEXPRESS_NUGET_API_KEY --store-password-in-clear-text
```

You can pass the API key via .env, build args, or CI/CD secrets.

## Changing Locale, Timezone, and Connection Strings

The image uses the `LOCALE` and `TZ` environment variables to set the system locale and timezone. You can override these at build or runtime. Examples:

- `LOCALE=sv_SE.UTF-8` (Swedish)
- `LOCALE=fi_FI.UTF-8` (Finnish)
- `LOCALE=th_TH.UTF-8` (Thai)
- `TZ=Europe/Stockholm`
- `TZ=Europe/Helsinki`
- `TZ=Asia/Bangkok`

To see available locales, run `locale -a` inside a running container. For timezones, check `/usr/share/zoneinfo`.

For connection strings and other secrets, use environment variables in your .env or compose file:

```env
ConnectionStrings__DefaultConnection=Server=host.docker.internal;Database=MyDb;User Id=sa;Password=your_password;
```

## Extending the Image

You can build your own image on top of this base, adding your application and any extra dependencies you need:

```dockerfile
FROM aelmen/xafblazoraspnet9
COPY . /app
WORKDIR /app
RUN dotnet publish YourApp.csproj -c Release -o /app/publish
CMD ["dotnet", "/app/publish/YourApp.dll"]
```

Or use the full multi-stage example in [Dockerfile.runtime.full.example](./Dockerfile.runtime.full.example) for advanced scenarios.

## Included Packages

This image includes:

- `software-properties-common`, `libc6`, `libicu-dev`, `libfontconfig1`, `tzdata`, `libgdiplus`, `locales`
- Fonts: `fonts-dejavu-core`, `fonts-dejavu-extra`, `fonts-thai-tlwg`, `fonts-freefont-ttf`, `fonts-noto-cjk`, `fonts-liberation`, `fonts-crosextra-carlito`, `fonts-crosextra-caladea`, `fonts-noto-mono`

## Best Practices

- Use a `.env` file for environment variables in development and CI/CD
- For production, use the `aspnet` runtime image and repeat the font and `libgdiplus` installation steps
- Always specify the correct `LOCALE` and `TZ` for your application's users
- Never commit secrets (like your DevExpress API key) to version control

## Community & Contributions

This project is open for issues, pull requests, and suggestions! If you build something cool on top of this image, let us know or submit an example.

---

_Maintained by aelmen. Contributions and suggestions welcome!_

## Changing Locale and Timezone

The image uses the `LOCALE` and `TZ` environment variables to set the system locale and timezone. You can override these at build or runtime. Examples:

- `LOCALE=sv_SE.UTF-8` (Swedish)
- `LOCALE=fi_FI.UTF-8` (Finnish)
- `LOCALE=th_TH.UTF-8` (Thai)
- `TZ=Europe/Stockholm`
- `TZ=Europe/Helsinki`
- `TZ=Asia/Bangkok`

To see available locales, run `locale -a` inside a running container. For timezones, check `/usr/share/zoneinfo`.

## Extending the Image

You can build your own image on top of this base, adding your application and any extra dependencies you need:

```dockerfile
FROM aelmen/xafblazoraspnet9
COPY . /app
WORKDIR /app
RUN dotnet publish YourApp.csproj -c Release -o /app/publish
CMD ["dotnet", "/app/publish/YourApp.dll"]
```

## Included Packages

This image includes:

- `software-properties-common`, `libc6`, `libicu-dev`, `libfontconfig1`, `tzdata`, `libgdiplus`, `locales`
- Fonts: `fonts-dejavu-core`, `fonts-dejavu-extra`, `fonts-thai-tlwg`, `fonts-freefont-ttf`, `fonts-noto-cjk`, `fonts-liberation`, `fonts-crosextra-carlito`, `fonts-crosextra-caladea`, `fonts-noto-mono`

## Best Practices

- Use a `.env` file for environment variables in development and CI/CD
- For production, use the `aspnet` runtime image and repeat the font and `libgdiplus` installation steps
- Always specify the correct `LOCALE` and `TZ` for your application's users

---

_Maintained by aelmen. Contributions and suggestions welcome!_
