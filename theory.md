## Theory - answers

1. Ruby has **single inheritance** so it impossible to derive from more than one class. Each Ruby class has only one parent (except for root class called BasicObject).
This isn't Ruby's downside. Multiple inheritance is often hated. As an alternative, implementing multiple interfaces can be used (practice in languages like Java/C#). Ruby **mixin modules** probably eliminate any need for multiple inheritance because _mixed-in_ modules behave like parent classes.

2. Iteration type **A** is more idiomatic. Preferred way of iterating over collection in Ruby is by `#each` method. Iteration type B uses `for e in elements` construct. In my opinion, it isn't elegant to have two keywords (_for_ and _in_) just to iterate over collection. To only execute chunk of code multiple times `10.times { # some code }` can be used instead of for loop. Also, for loop uses method `#each` internally so it brings another level of indirection unnecesesarily.
Another difference between A and B is that variable `number` in case B is accessible after iteration:
```
[1] pry(main)> [1, 2, 3].each { |number| p number * 10 }
10
20
30
=> [1, 2, 3]
[2] pry(main)> number
NameError: undefined local variable or method `number' for main:Object
from (pry):2:in `__pry__'
[3] pry(main)> for number in [1, 2, 3]
[3] pry(main)*   p number * 10  
[3] pry(main)* end  
10
20
30
=> [1, 2, 3]
[4] pry(main)> number
=> 3

```
In case A, method `#each` passes each element of the Array to the given block `p number * 10`. In case B, `for` uses `each` internally.

We can call method `#each` (and many others) on instance of any Ruby collection class (class that includes Enumerable and implements method each). In this case it is Array collection.

3. No, it is impossible to invoke `#qux` method outside `Foo` class. This behaviour is because of defining the `#qux` method after `private` access modifier. If we try to call method `#qux`, we will get `NoMethodError: private method 'qux'...`

4. There is no keyword used to declare a String in Ruby as well as there is no keywords for other data types. I think, in Ruby, we can't even declare a variable without defining/initializing it in the same line (if we strictly take the meaning of variable declaration).

To create a String in Ruby we just type between single or double quotation marks:
```
'sample'
=> "sample"
'sample'.class
=> String
```
String can also be created like this: 
```
s = String.new
=> ""
```

5. Enumerable is mixin module included in all Ruby collection classes. Enumerable provides those collections with bunch of useful methods to do things like searching, sorting and so on. It is important to implement method `#each` and operator `<=>` (used by methods `#min`, `#max` and `#sort`) in order to use all Enumerable module features.
 
6. Method `#bar` will send `My name is Foo.` to standard output. That's because `#bar` is class method, so `self` inside `#{}` block  will become name of class `Foo` in returning string.

7. Method `#map` returns the new Array object with same size. Internally, Array#map first creates new array and then iterates over `["a", "b", "c"]` array. Each element is yielded to method `#upcase` and return value is then pushed to newely created array.

Thanks to pry-doc :)
```
[16] pry(main)> show-source Array#map

From: array.c (C Method):
Owner: Array
Visibility: public
Number of lines: 13

static VALUE
rb_ary_collect(VALUE ary)
{
    long i;
    VALUE collect;

    RETURN_SIZED_ENUMERATOR(ary, 0, 0, ary_enum_length);
    collect = rb_ary_new2(RARRAY_LEN(ary));
    for (i = 0; i < RARRAY_LEN(ary); i++) {
	rb_ary_push(collect, rb_yield(RARRAY_AREF(ary, i)));
    }
    return collect;
}
```

When Ruby sees a `&` sign, parameter next to `&` must be `Proc` object or Ruby will call `#to_proc` method on given parameter.
`["a", "b", "c"].map(&:upcase)` without `&` is equivalent to `["a", "b", "c"].map{ |e| :upcase.to_proc.call(e) }`.