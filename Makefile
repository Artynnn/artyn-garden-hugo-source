DOMAIN = https://artyns-garden.vercel.app/
OUTPUT_DIR = ~/Sync/Projects/artyns-garden.vercel.app/public/
HUGO_BASEURL = "https://$(DOMAIN)/"
HUGO_FLAGS += --gc --minify

.PHONY: hugo
hugo: clean
	hugo --gc $(HUGO_FLAGS) --destination $(OUTPUT_DIR)

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: view
view: hugo
	python3 -m http.server --directory $(OUTPUT_DIR)

.PHONY: publish
publish: hugo
	vercel --prod

.PHONY: search
search: hugo
	cp $(OUTPUT_DIR)index.toml content/index.toml
	cd content && stork build --input index.toml --output ../static/index.st

