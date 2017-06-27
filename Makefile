.PHONY: $(shell find * -type d -depth 0)

PREFIX = onedata-makefile-test-release

cross-support-job-1p: onedata-1p
cross-support-job-1p: build-cross-support-job-1p

cross-support-job-3p: onedata-3p
cross-support-job-3p: build-cross-support-job-3p

onedata-1p: onedata-chart-utils oneprovider onezone onedata-cli oneclient
onedata-1p: build-onedata-1p

onedata-3p: onedata-chart-utils oneprovider onezone onedata-cli oneclient
onedata-3p: build-onedata-3p

onedata: onedata-chart-utils oneprovider onezone onedata-cli oneclient
onedata: build-onedata

onedata-cli: onedata-chart-utils
onedata-cli: build-onedata-cli

onezone: onedata-chart-utils
onezone: build-onezone

oneprovider: onedata-chart-utils volumes
oneprovider: build-oneprovider

oneclient: onedata-chart-utils
oneclient: build-oneclient

test: test-onedata-chart-utils test-volume-s3 test-volume-ceph test-volume-nfs test-oneclient test-oneprovider test-onezone test-onedata-cli test-onedata test-onedata-3p test-cross-support-job-3p

#volumes
volumes: volume-s3 volume-nfs volume-ceph
volume-s3: onedata-chart-utils build-volume-s3
volume-nfs: onedata-chart-utils build-volume-nfs
volume-ceph: onedata-chart-utils build-volume-ceph

onedata-chart-utils: build-onedata-chart-utils

volumes-test: test-volume-s3 test-volume-ceph test-volume-nfs
helm-test-volumes: helm-test-volume-s3 helm-test-volume-ceph helm-test-volume-nfs

build-%:
	if [ -f $*/requirements.yaml ]; then helm dependency update $*; fi
	helm package $*

install-%:
	if [ -f $*/requirements.yaml ]; then helm dependency update $*; fi
	helm install $*

test-%: build-onedata-chart-utils
	helm dependency update $*
	helm lint --strict --debug $*
	helm install --dry-run  --debug $*

helm-test-%:
	if [ ! -f $*/templates/test.yaml ]; then helm install $* --name $(PREFIX)-$* ; fi
	if [ ! -f $*/templates/test.yaml ]; then helm test --cleanup $(PREFIX)-$* ; fi
	if [ ! -f $*/templates/test.yaml ]; then helm delete --purge $(PREFIX)-$* ; fi

clean-%:
	helm delete --purge `helm ls --all -q | grep $(PREFIX)`

clean:
	if [ "`helm ls --all -q | grep $(PREFIX)`" != "" ]; then helm delete --purge `helm ls --all -q | grep $(PREFIX)`; fi
	find . -name "*.tgz" -exec rm '{}' +