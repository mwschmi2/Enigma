from string import ascii_lowercase
i = 0
key = "BDFHJLCPRTXVZNYEIWGAKMUSQO"

#for c in ascii_lowercase:
#	print("/*"+ c + "*/ assign out[" + str(i) + "] = " + str(ascii_lowercase.index(key[i].lower())) + ";");
#	i += 1

for c in ascii_lowercase:
	print("/*"+ c + "*/ assign reverse[" + str(ascii_lowercase.index(key[i].lower())) + "] = " + str(i) + ";");
	i += 1
	


