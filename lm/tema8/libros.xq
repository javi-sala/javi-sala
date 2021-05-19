(:Consulta1
for $x in doc("bd1.xml")/bookstore/book
where $x/price <= 30
order by $x/title
return $x:)

(:Mostrar los libros cuyo precio sea menor o igual a 30. Primero incluyendo la condición en la cláusula "where" y luego en laruta del XPath.

for $x in doc("bd1.xml")/bookstore/book
where $x/price <= 30
return $x

for $libro in doc("bd1.xml")/bookstore/book[price<=30]
return $libro:)

(: Mostrar sólo el título de los libros cuyo precio sea menor o igual a 30.

for $t in doc("bd1.xml")/bookstore/book
where $t/price <= 30
return $t/title
:)

(:Mostrar sólo el título sin atributos de los libros cuyo precio sea menor o igual a 30.

for $t in  doc("bd1.xml")/bookstore/book[price<=30]
return <title>{$t/title/text()}</title>:)


(: Mostrar el título y el autor de los libros del año 2005, y etiquetar cada uno de ellos con "lib2005".
for $x in doc ("bd1.xml")/bookstore/book
where $x/year=2005
return <lib2005>{data($x/author/text())}-{data($x/year/text())}</lib2005>
:)
(:Mostrar los años de publicación, primero con "for" y luego con "let" para comprobar la diferencia entre ellos. Etiquetar la salida con "publicacion".

for $y in doc("bd1.xml")/bookstore/book
return <publicacion>{$y/title}{$y/year}</publicacion>

let $y := doc("bd1.xml")/bookstore/book/year
return <publicacion>{$y}</publicacion>
:)

(:
Mostrar los libros ordenados primero por "category" y luego por "title" en una sola consulta.

for $o in doc("bd1.xml")/bookstore/book
order by $o/@category,$o/title
return $o
:)

(:
Mostrar cuántos libros hay, y etiquetarlo con "total".

let $num_libro := count(doc("bd1.xml")/bookstore/book)
return <total>{$num_libro}</total>
:)

(:
let $total := count(doc("bd1.xml")/bookstore/book),
    $titulos := (
      for $libro in doc("bd1.xml")/bookstore/book/title 
      return <titulo>{$libro/text()}</titulo>) 
return 
      <resultado>
        {$titulos}
        <total_libros>{$total}</total_libros>
      </resultado>:)

(:
for $x in doc("bd1.xml")/bookstore/book
order by $x/price
return <libros>
        {$x/title}
        {$x/price}
        <precioiva>{$x/price*1.21}</precioiva>
       </libros>
:)

(:
Mostrar el título y el número de autores que tiene cada título en etiquetas diferentes.

for $titulo in doc("bd1.xml")/bookstore/book
return 
  <libro>
    {$titulo/title}
    <autores>{count($titulo/author)}</autores>
  </libro>
:)

(:Mostrar en la misma etiqueta el título y entre paréntesis el número de autores que tiene ese título.

for $libro in doc("bd1.xml")/bookstore/book
return 
  <libro>
    {$libro/title/text()} ({count($libro/author)})
  </libro>
:)

(:Mostrar los libros escritos en años que terminen en "3".

for $libro in doc("bd1.xml")/bookstore/book
where ends-with($libro/year, "3")
return $libro
:)

(:Mostrar los libros cuya categoría empiece por "C".

for $libro in doc("bd1.xml")/bookstore/book
where starts-with($libro/@category, "C")
return $libro
:)

(:Mostrar los libros que tengan una "X" mayúscula o minúsculaen el título ordenados de manera descendente.

for $libro in doc("bd1.xml")/bookstore/book
where contains(lower-case($libro/title), "x")
order by $libro/title descending
return $libro
:)

(:Mostrar el título y el número de caracteres que tiene cada título, cada uno con su propia etiqueta.

for $libro in doc("bd1.xml")/bookstore/book
return
   <libro> 
    <titulo> {$libro/title/text()}</titulo>
    <caracteres>{string-length($libro/title/text())}</caracteres>
   </libro>
:)

(:Mostrar todos los años en los que se ha publicado un libro eliminando los repetidos. Etiquétalos con "año".

for $libro in distinct-values(doc("bd1.xml")/bookstore/book/year)
return <año>{$libro}</año>
:)

(:Mostrar todos los autores eliminando los que se repiten y ordenados por el número de caracteres que tiene cada autor. 

for $autor in distinct-values(doc("bd1.xml")/bookstore/book/author)
order by string-length($autor)
return <año>{$autor}</año>
:)

(:Mostrar los títulos en una tabla de HTML.
:)
<table>
{
  for $libro in doc("bd1.xml")/bookstore/book
  return 
    <tr>
      <td>{$libro/title/text()}</td>
    </tr>
}
</table>

