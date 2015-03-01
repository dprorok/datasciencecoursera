## The following functions exploit the <<- operator to allow repeated 
## computationally expensive matrix inversion calculations to be done 
## efficiently. cacheSolve() accomplishes this by performing the calculation
## only once and cacheing the result. In subsequent calls, the cacheSolve()
## function returns the cached value rather than undergoing another
## needlessly expensive matrix inversion calculation.

## makeCacheMatrix() creates a special vector list of functions to
##  1. set the values of the matrix to be inverted
##  2. get the values of the matrix to be inverted
##  3. set the values of the inverted matrix
##  4. get the values of the inverted matrix

makeCacheMatrix <- function(x = matrix()) {
        invertedmatrix <- NULL
        set <- function(y) {
                x <<- y
                invertedmatrix <<- NULL
        }
        get <- function() x
        setinversion <- function(inversion) invertedmatrix <<- inversion
        getinversion <- function() invertedmatrix
        list(set = set, get = get,
             setinversion = setinversion,
             getinversion = getinversion)
}


## cacheSolve() uses solve() to invert the matrix in the vector created by
## makeCacheMatrix(). If the inversion has not been previously calculated,
## cacheSolve() will invoke solve() to compute the inversion and then
## caches the result in the vector of functions. If the inversion has
## already been calculated, cacheSolve() simply returns the previously
## calculated inverted matrix.

cacheSolve <- function(x, ...) {
        invertedmatrix <- x$getinversion()
        if(!is.null(invertedmatrix)) {
                message("getting cached data")
                return(invertedmatrix)
        }
        data <- x$get()
        invertedmatrix <- solve(data, ...)
        x$setinversion(invertedmatrix)
        invertedmatrix
}
