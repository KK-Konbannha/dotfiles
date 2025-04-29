use std::collections::HashMap;
use std::env;
use std::fmt;
use std::fs::File;
use std::io::Read;
use std::path::PathBuf;

const APP_LIST_FILE_NAME: &str = "app_list.toml";

#[derive(Hash, Eq, PartialEq, Debug)]
enum UiKind {
    Cui,
    Gui,
}

#[derive(Debug)]
struct Category {
    name: String,
    apps: Vec<String>,
}

impl Category {
    fn parser(text: String) -> Vec<Self> {
        text.split("]\n\n")
            .map(|category| {
                // name(hoge = [\nのhoge)を取り出す
                let name = if let Some(end_position) = category.find(" = [") {
                    category[..end_position].to_string()
                } else {
                    "".to_string()
                };

                let apps = category
                    .lines()
                    .filter(|line| line.find('"').is_some()) // "が含まれていない行を省く
                    .map(|line| {
                        // lineの左右から"を検索
                        let start_position = line.find('"').expect("Failed to convert.");
                        let end_position = line.rfind('"').expect("Failed to convert.");

                        line[start_position + 1..end_position].to_string()
                    })
                    .collect();

                Category { name, apps }
            })
            .collect()
    }

    fn apps_to_string(&self) -> String {
        self.apps.join(" ")
    }
}

impl fmt::Display for Category {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "{}: {:?}", self.name, self.apps)
    }
}

#[derive(Debug)]
struct MyTomlFormat(HashMap<UiKind, Vec<Category>>);

impl MyTomlFormat {
    fn parser(text: &str) -> Self {
        let cui_start_point = text.find("[CUI]").expect("CUI category is required.");
        let gui_start_point = text.find("[GUI]").expect("GUI category is required.");

        let contents = if cui_start_point < gui_start_point {
            [
                (
                    UiKind::Cui,
                    Category::parser(text[cui_start_point + 6..gui_start_point].to_string()),
                ),
                (
                    UiKind::Gui,
                    Category::parser(text[gui_start_point + 6..].to_string()),
                ),
            ]
        } else {
            [
                (
                    UiKind::Cui,
                    Category::parser(text[gui_start_point + 6..cui_start_point].to_string()),
                ),
                (
                    UiKind::Gui,
                    Category::parser(text[cui_start_point + 6..].to_string()),
                ),
            ]
        };
        Self(HashMap::from(contents))
    }

    fn categories_as_vec(&self, ui_kind: &UiKind) -> Vec<String> {
        self.0[ui_kind]
            .iter()
            .map(|category| category.name.clone())
            .collect::<Vec<String>>()
    }

    fn apps_to_string(&self, ui_kind: &UiKind, category_names: Vec<String>) -> String {
        category_names
            .iter()
            .map(|category_name| {
                self.0[ui_kind]
                    .iter()
                    .filter(|category| &category.name == category_name)
                    .map(|category| category.apps_to_string())
                    .collect::<Vec<String>>()
                    .join(" ")
                    .to_string()
            })
            .collect::<Vec<String>>()
            .join(" ")
            .to_string()
    }
}

impl fmt::Display for MyTomlFormat {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(
            f,
            "CUI: {:?}\nGUI: {:?}\n",
            self.0[&UiKind::Cui],
            self.0[&UiKind::Gui]
        )
    }
}

fn main() -> std::io::Result<()> {
    let args: Vec<String> = env::args().collect();

    if (args.len() == 2 && args[1] == "All")
        || (args.len() == 3 && (args[1] == "CUI" || args[1] == "GUI") && args[2] == "name")
        || (args.len() > 3 && (args[1] == "CUI" || args[1] == "GUI") && args[2] == "app")
    {
    } else {
        eprintln!("Usage: {} All", args[0]);
        eprintln!("       {} [CUI | GUI] name", args[0]);
        eprintln!("       {} [CUI | GUI] app All", args[0]);
        eprintln!("       {} [CUI | GUI] app [list of category name]", args[0]);

        return Ok(());
    }

    let home_dir = env::var("HOME").expect("環境変数$HOMEが見つかりません。");
    let app_list_file = PathBuf::from(home_dir)
        .join("dotfiles")
        .join("scripts")
        .join(APP_LIST_FILE_NAME);

    let mut file = File::open(app_list_file)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;

    let my_toml_format = MyTomlFormat::parser(&contents);

    if args[1] == "All" {
        println!(
            "{}",
            [UiKind::Cui, UiKind::Gui]
                .iter()
                .map(|ui_kind| {
                    my_toml_format
                        .apps_to_string(ui_kind, my_toml_format.categories_as_vec(ui_kind))
                })
                .collect::<Vec<String>>()
                .join(" ")
        );

        return Ok(());
    }

    let ui_kind = if args[1] == "CUI" {
        &UiKind::Cui
    } else {
        &UiKind::Gui
    };

    if args[2] == "name" {
        println!("{}", my_toml_format.categories_as_vec(ui_kind).join("\n"));

        return Ok(());
    }

    if args[2] == "app" {
        println!(
            "{}",
            my_toml_format.apps_to_string(
                ui_kind,
                if args[3] == "All" {
                    my_toml_format.categories_as_vec(ui_kind)
                } else {
                    args[3..].to_vec()
                }
            )
        );

        return Ok(());
    }

    Ok(())
}
