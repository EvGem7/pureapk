#!/usr/bin/env bash

set -e

BUILD_DIR=build
APK_NAME=pure.apk

KEYSTORE=$BUILD_DIR/key.jks
KEY_ALIAS=mykey
STORE_PASS=123123

mkdir -p $BUILD_DIR

if [ ! -f $KEYSTORE ]; then
    echo "> Keystore doesn't exist, creating one"
    keytool -genkeypair \
        -alias $KEY_ALIAS \
        -keystore $KEYSTORE \
        -storepass $STORE_PASS \
        -keypass $STORE_PASS \
        -keyalg RSA \
        -dname "CN="
fi

echo "> Compiling AndroidManifest.xml"
aapt2 link -o $BUILD_DIR/$APK_NAME --manifest AndroidManifest.xml -I android.jar

echo "> Compiling MainActivity.java"
javac -cp android.jar -d $BUILD_DIR MainActivity.java

echo "> Compiling MainActivity.class to classes.dex"
java -cp r8.jar com.android.tools.r8.D8 --output $BUILD_DIR $(find $BUILD_DIR -name "*.class")

echo "> Packing classes.dex to $APK_NAME"
pushd $BUILD_DIR
zip $APK_NAME classes.dex
popd

echo "> Signing apk with $KEYSTORE"
jarsigner $BUILD_DIR/$APK_NAME -keystore $KEYSTORE $KEY_ALIAS -storepass $STORE_PASS -keypass $STORE_PASS

