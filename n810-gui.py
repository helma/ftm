import os
import gtk
import hildon

def quit(o,w):
  os.system("echo 'quit' > /tmp/mplayer-input")
  gtk.main_quit()

def execute(o,call):
    os.system(call) 

def main():
  window = hildon.Window()
  #window.fullscreen()
  window.connect("delete_event", quit)
  table = gtk.Table(2, 4, True)
  buttons = [
    ["1", "/usr/bin/ruby1.8 /usr/local/bin/tag.rb 1"],
    ["2", "/usr/bin/ruby1.8 /usr/local/bin/tag.rb 2"],
    ["3", "/usr/bin/ruby1.8 /usr/local/bin/tag.rb 3"],
    ["4", "/usr/bin/ruby1.8 /usr/local/bin/tag.rb 4"],
    ["[]", "echo 'pause' > /tmp/mplayer-input"],
    ["<", "echo 'seek -10' > /tmp/mplayer-input"],
    [">", "echo 'seek 10' > /tmp/mplayer-input"],
    [">>", "echo 'pt_step 1' > /tmp/mplayer-input"]
  ]
  col = 0
  row = 0
  for args in buttons:
    button = gtk.Button(args[0])
    button.connect("clicked", execute, args[1])
    table.attach(button,col,col+1,row,row+1)
    button.show()
    col = col + 1
    if col > 3 and row == 0:
      col = 0
      row = 1

  window.add(table)
  table.show()
  window.show()
  gtk.main()

if __name__ == "__main__":
  main()
