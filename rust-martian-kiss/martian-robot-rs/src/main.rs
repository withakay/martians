// src/main.rs
use std::io::{self, Read};

fn main() {
    let mut s = String::new();
    io::stdin().read_to_string(&mut s).unwrap();
    let case: martian::Scenario = s.parse().expect("invalid input");
    for line in martian::run_scenario(&case) {
        println!("{line}");
    }
    println!();
}
