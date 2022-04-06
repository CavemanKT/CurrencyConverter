extends Control

var rates = {}
var amount:float
var initial_amount:float
var FC:String = 'EUR'
var TC:String = 'USD'

var url:String = "http://data.fixer.io/api/latest?access_key=" + ApiKey.key


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request(url)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	rates = response.rates
	currency_add()
	default_selection()
	

func _on_FromCurrency_item_selected(index):
	FC = $FromCurrency.get_item_text(index)
	Convert(amount, FC, TC)
	pass

func _on_ToCurrency_item_selected(index):
	TC = $ToCurrency.get_item_text(index)
	Convert(amount, FC, TC)

func _on_Amount_text_changed(new_text):
	if int(new_text) <= 0:
		amount = 1
		$Amount.text = '1'
	elif float(new_text) > 0: 
		amount = float(new_text)
	else: 
		$Result.text = "Number only"
	Convert(amount, FC, TC)
		
func currency_add():
	for key in rates.keys():
		$FromCurrency.add_item(key)
		$ToCurrency.add_item(key)

func default_selection():
	$FromCurrency.select(46)
	FC = str(rates.keys()[46])
	$ToCurrency.select(149)
	TC = str(rates.keys()[149])

func Convert(amount, from_currency, to_currency):
	initial_amount = amount
	if from_currency != 'EUR':
		amount = amount / rates.get(from_currency)  # this line makes every currrency be EUR.
	if to_currency == 'EUR':
		$ResultNum.text = str(amount)
		$CRNum.text = str(rates.get(to_currency))
	else:
		$ResultNum.text = str(amount * rates.get(to_currency))
		$CRNum.text = str(amount * rates.get(to_currency) / initial_amount)
	pass
