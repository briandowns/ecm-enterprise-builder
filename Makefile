.PHONY: ent-k3s
ent-k3s:
	./k3s_build.sh

.PHONY: ent-rancher
ent-rancher:
	./rancher_build.sh

.PHONY: clean
clean:
	rm -rf ./k3s
	rm -rf ./rancher
