# This will generate dev environment variables
define app_generate_dev_env
flutter pub add environment_config
flutter pub run environment_config:generate --config-extension=dev
flutter pub remove environment_config
endef

# This will run project code generation
define app_codegen
flutter pub run build_runner build --delete-conflicting-outputs
endef

generate_dev_env:
	$(app_generate_dev_env)

codegen:
	$(app_codegen)