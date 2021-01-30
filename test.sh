
IMAGENAME="kotet-atcoder-java"

if [ -z "$(sudo docker images -q $IMAGENAME)" ]; then
    docker build -t $IMAGENAME .
fi

DOCKER="sudo docker run -i --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp $IMAGENAME"
BUILD="$DOCKER javac -encoding UTF-8 Main.java"

if [ "$1" = "debug" ]; then
    RUN="$DOCKER timeout 5 java -Xss256M -enableassertions Main"
else
    RUN="$DOCKER timeout 5 java -Xss256M Main"
fi

echo "Building..."
echo $BUILD
$BUILD

if [ ! $? = 0 ]; then
    echo "Build failed."
    exit
fi

echo "Removing old output..."
mkdir -p output
rm output/*

for file in `ls input`; do
    echo -n "Testing $file..."
    timeout 5 $RUN < input/$file > output/$file 2>&1
    if diff -q output/$file answer/$file > /dev/null; then
        echo "passed."
    else
        echo "failed."
    fi
done

for file in `ls input`; do
    bat output/$file
done

rm -f Main.class
