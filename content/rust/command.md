---
title: "String Builder"
date: 2021-12-26T18:54:07+09:00
draft: true
---





```
use std::process::{Command, Stdio};

fn main() {
    let output = Command::new("echo "안녕" | iconv -f utf8 -t euckr")
        // Tell the OS to record the command's output
        .stdout(Stdio::piped())
        // execute the command, wait for it to complete, then capture the output
        .output()
        // Blow up if the OS was unable to start the program
        .unwrap();

    // extract the raw bytes that we captured and interpret them as a string
    let stdout = String::from_utf8(output.stdout).unwrap();

    println!("{}", stdout);
}
```

