/**
 * General page "contacts" section behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	jquery: $
	prelude: {Obj, is-type, Num}
	\../../basics : {dynamic-api, get-val, get-local-text}
}

get-api-url = module.exports.get-yandex-maps-api-url = ->
	api-lang = get-val \yandex-maps-api-lang |> (."#{get-val \lang}")
	"http://api-maps.yandex.ru/2.1/?lang=#api-lang"

<-! (!-> module.exports.init = it)

(i) <-! $ \.contacts .each
$s = $ @

$map = $s.find \.map
$marker = $map.find \img.marker
$address = $map.find \address

bind-suffix = \.check

(err, ymaps) <-! dynamic-api get-api-url!, \ymaps
return if err?
<-! ymaps.ready

data =
	mark-x: $map.attr \data-mark-x |> parse-float
	mark-y: $map.attr \data-mark-y |> parse-float
	pos-x: $map.attr \data-pos-x |> parse-float
	pos-y: $map.attr \data-pos-y |> parse-float
	zoom: $map.attr \data-zoom |> parse-int _, 10

try
	data |> Obj.map ->
		if (it |> is-type \Number |> (not)) or (it |> Num.is-it-NaN)
			throw new Error!
catch
	return window.alert get-local-text \err, \yandex-map-not-enough-data

map-id = "yandex_map_#i"
$map.attr \id, map-id

marker-path = $marker.attr \src
$img = $ \<img/>
<-! (!-> $img.on \load, it; $img.attr \src, marker-path)
img = @

map = new ymaps.Map map-id, do
	center: [data.pos-y, data.pos-x]
	zoom: data.zoom
	controls: []

map.behaviors.disable \scrollZoom

map.controls.add \zoomControl, do
	float: 'none'
	position: left: 10, top: 10

marker = new ymaps.Placemark [data.mark-y, data.mark-x], do
	hint-content: $address.text!
	icon-content: \sheeeit
, do
	icon-layout: \default#image
	icon-image-href: marker-path
	icon-image-size: [img.width, img.height]
	icon-image-offset: [-(img.width/2), -img.height]

map.geo-objects.add marker

<-! (!-> $map.on \resize-map it .trigger \resize-map)
map.container.fit-to-viewport!