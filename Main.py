text = input()

text = sorted(text)

b = text[0] == text[1] and text[2] == text[3] and text[1] != text[2]
if b:
    print("Yes")
else:
    print("No")
