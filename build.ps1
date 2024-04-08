# Kontrollera om "mybuilder" redan existerar
if (-not (docker buildx ls | Select-String -Pattern "mybuilder")) {
    # Skapa en ny builder instans
    docker buildx create --use --name mybuilder
}
# Bygg din image för både arm64 och x64
docker buildx build --platform "linux/amd64,linux/arm64" -t aelmen/xafblazoraspnet8 --push .