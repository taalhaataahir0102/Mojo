
# Creating a simple structure
struct Example(CollectionElement):
    var sz: Int

    fn __init__(inout self, sz: Int):
        self.sz = sz

    fn __copyinit__(inout self, existing: Self):
        print("CopyInit called")
        self.sz = existing.sz

    fn __moveinit__(inout self, owned existing: Self):
        self.sz = existing.sz

# Function which invokes copy constructor of the object when any object inside
# dynamic vector is accessed 
fn newfunc2(inout arg: DynamicVector[Example]) -> Int:
    if arg[1].sz == 4:
        print("yes")
    arg[1].sz = 4
    print(arg[1].sz)
    return 0

fn main() raises:

    let a = Example(0)
    var c = DynamicVector[Example] ()
    print("appending")
    c.append(a)
    c.append(a)
    c.append(a)
    print("before newfunc2")
    let d:Int = newfunc2(c)