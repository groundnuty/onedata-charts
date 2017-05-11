#!/usr/bin/env bash

usage() {
cat << EOF
Alias support for requirements.yaml

Available Commands:
  generate populates charts/ directory with aliassed charts

Aliases:
  generate, gen
EOF
}

generate_usage() {
cat << EOF
Generate aliassed charts into charts/ directory.

Example:
    $ helm generate <chart directory>
EOF
}

is_help() {
  case "$1" in
  "-h")
    return 0
    ;;
  "--help")
    return 0
    ;;
  "help")
    return 0
    ;;
  *)
    return 1
    ;;
esac
}

generate() {
  if is_help "$1" ; then
    push_usage
    return
  fi

  chart="$1"
  charts="$1/charts"

  rm -rf "$charts"/*

  helm dep update "$chart"
  helm dep build "$chart"

  #rm -rf "$charts"/*
  ls -l "${charts:?}/"
  for (( i=0; ; i++ ))
  do
    req="$(shyaml get-value dependencies.$i 2>/dev/null <"$chart/requirements.yaml")"
    if (( $? )) ; then
      exit
    fi
    req_alias=$(echo "$req" | sed -nr 's/\s*alias:\s+(\w+)/\1/p')
    req_name=$(echo "$req" | sed -nr 's/\s*name:\s+(\w+)/\1/p')
    req_version=$(echo "$req" | sed -nr 's/\s*version:\s+(\w+)/\1/p')
    #req_repository=$(echo "$req" | sed -nr 's/\s*repository:\s+(\w+)/\1/p')
    #repo_alias=$(helm repo list | sed -nr "s@(\S+)\s+($req_repository).*@\1@p")

    echo alias=$req_alias
    echo name=$req_name
    echo version=$req_version
    #echo repository=$req_repository
    #echo repository_alias=$repo_alias

    if [[ "$req_alias" == "" ]] ; then
      continue
    fi

    req_tar_name="$req_name-$req_version"

    tar -C "$charts" -xvzf "$charts/${req_tar_name}.tgz"

    mv "$charts/$req_name" "$charts/$req_alias"

    sed -r -i "s@(^name:\s+)($req_name)\S*@\1$req_alias@g" "$charts/$req_alias/Chart.yaml"
    tar -C "$charts" -czf "$charts/$req_alias-$req_version.tgz" "$req_alias"

    echo "Created $charts/$req_tar_name.tgz"

    rm -rf "${charts:?}/${req_alias}"
  done

  }

if (( $# < 1 )); then
  usage
  exit 1
fi

if ! type "shyaml" > /dev/null; then
  echo "Command 'shyaml' must be installed"
  exit 1
fi

case "${1:-"help"}" in
  help|--help|-h)
    usage
    ;;
  generate|gen):
    if [[ $# -lt 2 ]]; then
      generate_usage
      echo "Error: Chart package required."
      exit 1
    fi
    generate "$2"
    ;;
  *)
    usage
    exit 1
    ;;
esac

exit 0