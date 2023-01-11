#!/usr/bin/env python3
# Watches a file for changes. Every time the file changes, send its contents
# to the clipboard.
#
# Requires watchdog (pip3 install watchdog)
# Requires clipboard (pip install clipboard)


import clipboard
import sys
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

def file_changed(path):
  print("FILE CHANGED: "+path)
  f = open(path, "r")
  contents = f.read()
  f.close()
  clipboard.copy(contents)

class FileChangedHandler(FileSystemEventHandler):
  def on_modified(self, event):
    file_changed(event.src_path) 

def main(path):
  event_handler = FileChangedHandler()
  observer = Observer()
  observer.schedule(event_handler, path=path, recursive=False)
  observer.start()

  try:
      while True:
          time.sleep(1)
  except KeyboardInterrupt:
      observer.stop()
  observer.join()

main(sys.argv[1])


