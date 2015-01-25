/**
 * General page behavior
 *
 * @author Viacheslav Lotsmanov
 */

require! {
	prelude : _p
	jquery : $
	'../basics' : b
	'../preload'
	'../link-handler'
	'../has-el-by-hash'
}

require \jquery.transit

$w = $ window
$html = $ \html
$page = $ 'html,body'

$body = $html .find \body
$header = $body .find \header
$logo = $header .find '>.logo'
$logo-img = $logo .find \img

$cards = $ \.general-cards
$card1 = $cards .find \.card-1
$card1-bg = $card1 .find \.bg
$card1-next = $card1 .find \.next

speed = b.get-val \animation-speed

loading-animation = true

$card1-next .click link-handler

card1-parallax-init = !->
	card1-bg-parallax-bind-suffix = '.card-1-bg-parallax'

	$w.on \scroll + card1-bg-parallax-bind-suffix, !->
		st = $w.scrollTop!
		return if st > $card1.height!
		val = st / 2
		$card1-bg.css \background-position, "center #{val}px"

	$w.on \resize + card1-bg-parallax-bind-suffix, !->
		$w.trigger \scroll + card1-bg-parallax-bind-suffix

	$w.trigger \resize + card1-bg-parallax-bind-suffix

# rotate Wi logo before finish loading
loading-loop = !->
	if not loading-animation then return
	$logo-img.transition rotate: \360deg, (speed*4), \linear, !->
		if not loading-animation then return
		$logo-img.css rotate: \0deg
		loading-loop!

# callback after all images is preloaded (see icons.styl)
preload-cb = !->
	card1-parallax-init!
	loading-animation := false
	<-! $logo-img .stop! .transition rotate: \360deg, (speed*4), \linear
	<-! $card1-bg .stop! .transition opacity: 1, scale: 1, (speed*4), \in-out
	$logo .addClass \logo-move
	set-timeout (!->
		$body .addClass \loaded
		$page .scrollTop 0

		require './general/portfolio'

		go-to-anchor = $html.data \go-to-anchor
		go-to-anchor! if _p.is-type \Function go-to-anchor
	), (speed*4)

# preload logo first (for use this logo as loading spinner)

require! '../lib/load_img' : LoadImg # for get exceptions (need to refactoring this module in the future)
img-src = $logo-img.attr \src
b.load-img img-src, (err, img) !->
	if err
		if err instanceof LoadImg.exceptions.Timeout
			window.alert b.get-local-text \err, \preload-img-timeout, {
				\#IMAGE_SRC# : img-src
			}
			return
		window.alert b.get-local-text \err, \preload-img, {
			\#ERROR_CODE# : err.to-string!
			\#IMAGE_SRC# : img-src
		}
		return

	loading-loop!
	preload preload-cb
