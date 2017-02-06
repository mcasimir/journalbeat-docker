docker build -t mcasimir/journalbeat .
versionString=$(docker run mcasimir/journalbeat /bin/journalbeat-debian --version)
version=$(echo $versionString) | awk '{print $3}'

echo version

# docker tag mcasimir/journalbeat mcasimir/journalbeat:latest
# docker tag mcasimir/journalbeat mcasimir/journalbeat:"$version"
