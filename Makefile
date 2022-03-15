DOMAIN = artynnn.github.io
OUTPUT_DIR = ~/Sync/Projects/Artynnn.github.io/
HUGO_BASEURL = "https://$(DOMAIN)/"
HUGO_FLAGS += --gc --minify

.PHONY: hugo
hugo: clean
	hugo --gc --baseURL $(HUGO_BASEURL) $(HUGO_FLAGS) --destination $(OUTPUT_DIR)

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: view
view: hugo
	python3 -m http.server --directory $(OUTPUT_DIR)

.PHONY: publish
publish: hugo
	vercel --prod
