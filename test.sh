# DOCKER="sudo docker run -i --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp java:openjdk-8-alpine"
# BUILD="$DOCKER javac Main.java"
RUN="python3 -B ./Main.py"

# echo "Building..."
# echo $BUILD
# $BUILD

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

rm -f main.py
