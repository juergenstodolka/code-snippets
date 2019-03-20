# Fast lookup by name or by date - Array - Hash - Linked List # 

See article [Perl Maven](https://perlmaven.com/fast-lookup-by-name-or-by-date) 

We have a lot of data-structures that have a name, a date when each one was created and some payload. Once in a while we need to find and remove an element. Either by the name of the element or by picking the oldest one. How can we make this efficient given that we have a lot of these data-structures? (Some 10,000.) 

## The data structure ##
If we hold each data structure in a hash we have something like this: 
```Perl
    {
        name => "some name",
        date => time,
        payload => { },
    }
```

The payload itself has Perl objects in them and I think some of them are even open sockets.

We basically have two ways to hold all the elements: 

## In array acting as a queue ##
We can keep them in an array and *push* any new element to the end. Then the first one is the oldest,we can use *shift* to remove it and we don't even need to keep the "date" field. Finding the element by name has a complexity of O(n) as we have to go over all the elements using grep or better yet using first from `List::Util`. 

## In a hash based on name ##
We can keep them in hash based on the name: Accessing `$h{$name}` has a complexity of O(1), but then in order to find the oldest we need to keep a timestamp as well in every object and we have to go over all the elements to find the object. This is O(n). 

## Linked list ##
In a linked list every element is connected to the previous element and the next element as well and there is a link from the outside world to the first element. (There might be also a link to the last element for easier bookkeeping.) We can implement such a linked list inside a hash. That way we can access any individual element inside the data structure by looking up its name. As this is a hash operation it takes O(1). We can also easily get to the oldest (first) element as we have a direct link to it from the outside world. That too is O(1).

It seems this approach can be by far the fastest, but we have to take in account that

   - The code is a bit more complex and thus we need to invest extra effort in verifying it.
   - Each operation is now slower so depending on the actual pattern of access we might not have  
     any overall speed gain.
   - The data now takes up more space in memory as we need the have the links to the previous and 
     next element for each piece of data.

