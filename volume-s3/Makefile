CHART_NAME +=`basename ${PWD}`
RELEASE_NAME = test-release-$(CHART_NAME)

all: test install

install:
	helm dependency update .
	helm install .

test:
	helm dependency update .
	helm lint --strict .
	helm install --dry-run .
	helm install . --name $(RELEASE_NAME)
	helm test --cleanup $(RELEASE_NAME) 
	helm delete --purge $(RELEASE_NAME)