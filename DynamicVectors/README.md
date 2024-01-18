# Usage

```mojo vector.mojo```

# Output
![alt text](https://github.com/taalhaataahir0102/Mojo/blob/main/vector.png)

The copy constructor is called thrice when the Example onject is appended inside the Dynamic vector. Inside the newfunc2, the dynamic vector  of objects is passed. The copy constructor of the Example onject is called thrice when:

1. The comparision operation is called: 
``` arg[1].sz == 4 ```

2. Update operation is called:
```arg[1].sz = 4```

3. And print function is called:
```print(arg[1].sz)```


This shows that in mojo everytime, an element of the dynamic vector is accessed, a copy of that element is created. 
