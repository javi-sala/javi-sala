(: 1.Mostrar cada uno de los nombres de los bailes con la etiqueta "losbailes".

for $nombres in doc("bd2.xml")/bailes/baile
return <losbailes>{$nombres/nombre/text()}</losbailes>
:)

(: 2.Mostrar los nombres de los bailes seguidos con el número de plazas entre paréntesis, ambos dentro de la misma etiqueta"losbailes".

for $nombres in doc("bd2.xml")/bailes/baile
return <losbailes>{$nombres/nombre/text()}({$nombres/plazas/text()})</losbailes>
:)

(:3.Mostrar los nombres de los bailes cuyo precio sea mayor de 30.

for $nombres in doc("bd2.xml")/bailes/baile
where $nombres/precio > 30
return <losbailes>{$nombres/nombre/text()}</losbailes>
:)

(:4.Mostrar los nombres de los bailes cuyo precio sea mayor de 30 y la moneda "euro".

for $nombres in doc("bd2.xml")/bailes/baile
where $nombres/precio > 30 and $nombres/precio/@moneda = "euro"
return <losbailes>{$nombres/nombre/text()}</losbailes>
:)

(:5.Mostrar los nombres y la fecha de comienzo de los bailes que comiencen el mes de enero (utiliza para buscarlo la cadena de texto "/1/")

for $nombres in doc("bd2.xml")/bailes/baile
where contains($nombres/comienzo, "/1/") 
return <losbailes>{$nombres/nombre/text()}
{$nombres/comienzo/text()}</losbailes>
:)

(:6.Mostrar los nombres de los profesores y la sala en la que dan clase, ordénalos por sala.

for $prof_sala in doc("bd2.xml")/bailes/baile
order by $prof_sala/sala
return
<baile>
{$prof_sala/profesor}
{$prof_sala/sala}
</baile>
:)

(: 7.Mostrar los nombres de los profesores eliminando los repetidos y acompañar cada nombre con todas las salas en la que da clase, ordénalos por nombre.

for $profesor in distinct-values(doc("bd2.xml")/bailes/baile/profesor)
let $salas := doc("bd2.xml")/bailes/baile[profesor=$profesor]/sala
order by $profesor
return 
   <profesores>
     <nombre>{$profesor}</nombre>
     {$salas}
   </profesores>
:)

(: 8.Mostrar la media de los precios de todos los bailes.

let $media := avg(doc ("bd2.xml")/bailes/baile/precio)
return 
<Precio> {$media} </Precio>
:)

(: 9.Mostrar la suma de los precios de los bailes de la sala 1

let $suma := sum(doc("bd2.xml")/bailes/baile[sala=1]/precio) 
return 
<Precio>{$suma}</Precio>
:)

(: 10.Mostrar cuántas plazas en total oferta el profesor "Jesus Lozano".

let $plazas := sum(doc("bd2.xml")/bailes/baile[profesor="Jesus Lozano"]/plazas)
return
<plazas_totales>
{$plazas}
</plazas_totales>
:)

(: 11. Mostrar el dinero que ganaría la profesora "Laura Mendiola" si se completaran todas las plazas de su baile, sabiendo que sólo tiene un baile

let $suma := (doc("bd2.xml")/bailes/baile[profesor="Laura Mendiola"])
return 
<Ganancias>{$suma/plazas * $suma/precio}</Ganancias>
:)

(: 12.- Mostrar el dinero que ganaría el profesor "JesusLozano" si se completaran todas las plazas de su baile, pero mostrando el beneficio de cada baile por separado

for $dinero in doc("bd2.xml")/bailes/baile
where $dinero/profesor = "Jesus Lozano"
return
<Ganancias>{$dinero/nombre/text()}({$dinero/plazas * $dinero/precio}€)</Ganancias>
:)

(: 13.Mostrar el dinero que ganaría la profesora "Laura" (no conocemos su apellido) si se completaran todas las plazas de su baile


for $dinero in doc("bd2.xml")/bailes/baile
where starts-with($dinero/profesor, "Laura")
return <Ganancias>{$dinero/plazas * $dinero/precio}</Ganancias>
:)

(: 14.Mostrar el nombre del baile, su precio y el precio con un descuento del 15% para familias numerosas. Ordenar por el nombre del baile.

for $baile in doc("bd2.xml")/bailes/baile
order by $baile/nombre
return 
<nombre>{$baile/nombre/text()}(
{$baile/precio/text()}€) Descuento del 15%: {$baile/precio - ($baile/precio * 0.15)  }</nombre>
:)

(: 15.Mostrar todos los datos de cada baile excepto la fecha de comienzo y de fin.

for $baile in doc("bd2.xml")/bailes/baile
return <baile>{$baile/* except $baile/comienzo except $baile/fin}</baile>
:)

(: 16.Mostrar en una tabla de HTML los nombres de los bailes y su profesor, cada uno en una fila 
:)
<table> {
  for $baile in doc("bd2.xml") /bailes/baile
  return <tr><td>{$baile/nombre/text()}</td><td>{$baile/profesor/text()}</td></tr>
} </table>

