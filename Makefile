.PHONY: ent-k3s
ent-k3s:
	cd ${GOPATH}/src/github.com/briandowns/k3s
	PROG=lke IMAGE_NAME=lke SKIP_VALIDATE=true make

.PHONY: clean
clean:
	rm -rf ./k3s

# rename files
# - k3s.service
# k3s-rootless.service
#
# Does kubectl get nodes output matter if it has k3s in it.
#
# lke binary dist/artifacts/lke size 67350528 exceeds max acceptable size of 67108864 bytes (64 MiB) - 241664 diff
#
