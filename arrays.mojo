struct Array2Dnew(CollectionElement):
    var data: Pointer[SIMD[DType.float32, 8]]
    var dim: Int

    fn __init__(inout self, dim: Int):
        self.dim = dim
        self.data = Pointer[SIMD[DType.float32, 8]].alloc(dim)
    
    fn __copyinit__(inout self, other: Array2Dnew):
        self.dim = other.dim
        self.data = Pointer[SIMD[DType.float32, 8]].alloc(self.dim)
        for i in range(self.dim):
            self.data.store(i, other.data.load(i))
    
    fn __moveinit__(inout self, owned existing: Array2Dnew):
        self.dim = existing.dim
        self.data = existing.data

    fn __getitem__(borrowed self, i: Int) -> SIMD[DType.float32, 8]:
        return self.data.load(i)

    fn __setitem__(inout self, i: Int, value: SIMD[DType.float32, 8]):
        self.data.store(i, value)
    
    fn __setitem2__(inout self, i: Int, j: Int, value: Float32):
        var simd_vector = self.data.load(i)
        simd_vector[j] = value
        self.data.store(i, simd_vector)

    fn __del__(owned self):
        self.data.free()
    
    fn print_array(borrowed self):
        for i in range(self.dim):
            print(self.__getitem__(i))

struct Array3D(CollectionElement):
    var data: Pointer[UInt8]
    var dim0: Int
    var dim1: Int
    var dim2: Int

    fn __init__(inout self, dim0: Int, dim1: Int, dim2: Int):
        self.dim0 = dim0
        self.dim1 = dim1
        self.dim2 = dim2
        self.data = Pointer[UInt8].alloc(dim0 * dim1 * dim2)
    
    fn __copyinit__(inout self, other: Array3D):
        self.dim0 = other.dim0
        self.dim1 = other.dim1
        self.dim2 = other.dim2
        self.data = Pointer[UInt8].alloc(self.dim0 * self.dim1 * self.dim2)
        for i in range(self.dim0 * self.dim1 * self.dim2):
            self.data.store(i, other.data.load(i))
    
    fn __moveinit__(inout self, owned existing: Array3D):
        self.dim0 = existing.dim0
        self.dim1 = existing.dim1
        self.dim2 = existing.dim2
        self.data = existing.data

    fn __getitem__(borrowed self, i: Int, j: Int, k: Int) -> UInt8:
        return self.data.load(i * self.dim1 * self.dim2 + j * self.dim2 + k)

    fn __setitem__(inout self, i: SIMD[DType.uint8, 1], j: Int, k: Int, value: SIMD[DType.uint8, 1]):
        self.data.store(i * self.dim1 * self.dim2 + j * self.dim2 + k, value)

    fn __del__(owned self):
        self.data.free()


fn main() raises:
    var mat = Array2Dnew(2)
    mat.__setitem__(0,SIMD[DType.float32, 8] (0.7071, 1,  2,  3,  4,  6,  8.65,  8.2))
    mat.__setitem__(1,SIMD[DType.float32, 8] (0.7071, 1,  2,  3,  4,  6,  8.65,  8.2))

    let mat2 = mat

    for i in range(2):
        print(mat2.__getitem__(i))