gen:
	flutter pub run build_runner build --delete-conflicting-outputs

hello:
	echo "Hello, user"; \
	echo "uraaa, makefile working"; \
	echo "^_^"

icon:
	flutter pub run flutter_launcher_icons:main

init_res:
	dart pub global activate flutter_asset_generator

format:
	dart format . --line-length 100

res:
	dart pub global activate fgen
	fgen --output lib/components/resources.g.dart --no-watch --no-preview; \
	make format

loc:
	flutter gen-l10n; \
	make format

