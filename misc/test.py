#!/usr/bin/python3
print("Content-type: text/html\n\n")
import os
print("<HTML><BODY>\n")

print("<pre>")
print("---> ID that this cgi is running as")
myCmd = os.popen('id').read()
print(myCmd)

print("---> The shell this cgi is running in")
myCmd = os.popen('echo $SHELL').read()
print(myCmd)

print("<br>")

print("---> Environmental Varriables")
myCmd = os.popen('env').read()
print(myCmd)
print("<br>")


print("---> ls -la ~/")
myCmd = os.popen('ls -la ~/').read()
print(myCmd)

print("---> cd ~/;pwd;cat .test")
myCmd = os.popen('cd ~/;pwd;cat .test').read()
print(myCmd)

D = {}
D['a'] = 1
D['b'] = 2
D['c'] = 3

for k in D.keys():
	print(D[k])

##print(D['2'])


print("</pre>")
print("</BODY>\n")
print("</HTML>\n")

