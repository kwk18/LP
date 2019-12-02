IN = open("familytree.ged", "r")
OUT = open("out.txt", "w")

s = {}

for line in IN.readlines():
    m = line.split(" ")
    l = len(m)
    if l >= 3:
        first = m[1]
        
        if m[2][0] == "I":
            i = m[1]
            
        if first == "GIVN":
            name = m[2]
            
        if first == "SURN":
            surname = m[2]
            curr = (name[:-1], surname[:-1])
            upd = {i:curr}
            s.update(upd)
            
        if first == "HUSB":
            husband = m[2]
            sex = "m"
            for j, (a, b) in s.items():
                
                if j == husband[:-1]: father = a + " " + b
            r = "sex(%r, %r).\n" % (father, sex)
            OUT.write(r)
                    
                    
        if first == "WIFE":
            wife = m[2]
            sex = "f"
            for j, (a, b) in s.items():
                
                if j == wife[:-1]: mother = a + " " + b
            r = "sex(%r, %r).\n" % (mother, sex)
            OUT.write(r)
                    
        if first == "CHIL":
            children = m[2]
            
            for j, (a, b) in s.items():
                
                if j == children[:-1]: children = a + " " + b
            r = "parent(%r,%r).\n" % (mother, children)
            OUT.write(r) 
            r = "parent(%r,%r).\n" % (father, children)
            OUT.write(r)  
IN.close()
OUT.close()