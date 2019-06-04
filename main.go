package main

import (
	"flag"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

var source = flag.String("in", "", "Absolute filepath of source file")
var destination = flag.String("out", "", "Absolute filepath of destination file")

func main() {
	flag.Parse()
	content, err := ioutil.ReadFile(*source)
	if err != nil {
		os.Exit(-1)
	}

	// if new path does not exist, read original file and create the resolved one
	if _, err := os.Stat(*destination); os.IsNotExist(err) {
		// for each line of the file replace {here} with the Dir of in file
		sourcedir := filepath.Dir(*source)
		data := strings.Replace(string(content), "{here}", sourcedir, -1)
		// does the folder already exist? if not, create it
		os.MkdirAll(filepath.Dir(*destination), 0777)
		// write file to destination
		ioutil.WriteFile(*destination, []byte(data), 0666)
	}
}
