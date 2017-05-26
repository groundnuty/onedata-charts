#!/usr/bin/env bash

chart=$1
version=$(grep version:  $chart/Chart.yaml | tr -s ' ' | cut -d ' ' -f 2)
echo "Chart $chart-$version"
echo "Building and packaging ${chart}..."
make build-$chart

echo "Cloning helm registry..."
TMP_DIR=$(mktemp -d)
git clone -b gh-pages git@github.com:groundnuty/onedata-charts.git "$TMP_DIR"

echo "Copying package $chart-$version.tgz to helm registry..."
if [[ -f "$TMP_DIR/$chart-$version.tgz" ]]; then
  echo "Package exists in the registry. Aborting..."
  rm -rf "$TMP_DIR"
  exit 1
fi
cp "$chart-$version.tgz" "$TMP_DIR/"

current=$PWD
cd "$TMP_DIR/"
helm repo index .  --url https://groundnuty.github.io/onedata-charts/
cd $current

git -C "$TMP_DIR" status
echo "Adding all changes to commit..."
git -C "$TMP_DIR" add -A

git -C "$TMP_DIR" status
git -C "$TMP_DIR" commit -m "released chart $chart $version"
git -C "$TMP_DIR" push

rm -rf "$TMP_DIR"
rm "$chart-$version.tgz"
