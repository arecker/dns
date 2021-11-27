PROJECTS = astuary blog
SECRETS = secrets/aws-access-key-id secrets/aws-secret-key secrets/cloudflare-email secrets/cloudflare-token
PROJECT_CONFIGS = $(addsuffix /config.tf, $(PROJECTS))

.PHONY: all
all: $(SECRETS) $(PROJECT_CONFIGS)

.PHONY: secrets
secrets: $(SECRETS)
secrets/%:
	pass dns/$* > $@

.PHONY: configs
configs: $(PROJECT_CONFIGS)
$(PROJECT_CONFIGS): $(SECRETS)
	@./scripts/generate-config.sh $(patsubst %/config.tf,%, $@) > $@

.PHONY: clean
clean:
	rm -rf $(SECRETS)
	rm -rf $(PROJECT_CONFIGS)
