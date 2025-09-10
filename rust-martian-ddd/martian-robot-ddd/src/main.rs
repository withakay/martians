use martian::application::mission::run;
use std::io::{self, BufRead, BufReader};

fn main() {
    let stdin = io::stdin();
    let mut reader = BufReader::new(stdin.lock());
    if let Err(e) = run(&mut reader, io::stdout()) {
        eprintln!("{}", e);
        std::process::exit(1);
    }
}
