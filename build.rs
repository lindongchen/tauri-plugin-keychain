const COMMANDS: &[&str] = &["save_item","get_item","remove_item"];

fn main() {
  tauri_plugin::Builder::new(COMMANDS)
		.global_api_script_path("./api-iife.js")
    .android_path("android")
    .ios_path("ios")
    .build();
}