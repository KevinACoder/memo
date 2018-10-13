
#look up process info
ps -A #select all processes
pgrep bash  #get pid of process
cat /proc/$pid/environ | tr '\0' '\n' #get environment variables of the process, with '\0' translated to '\n'

//variables
var=vaule
echo $var  #create and print variable
export PATH="$PATH:/usr/lib" #set the export attribute for variables, add path

//use vim
#https://www.radford.edu/~mhtay/CPSC120/VIM_Editor_Commands.htm
a/A/i/I/o/O  #shift from cmd mode to insert mode
esc #shift from insert mode to cmd mode
:wq #save and exit
:set number #show line number
:q!  #
ctrl + alt + '+'/'-' #ctrl font size

//replace character in file
cat ./rcd.txt | tr '\|' ' ' > ./rcd.txt
