# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version = 2.5.7
* node = v10.12.0
* yarn updated

## how to run it
$ rails server

this will be run our server 


## How to use it

this is an api that simulates a vending machine
Basically there are some endpoints to work with it

# 1
curl -X POST  http://localhost:3000/create_chine -d app='name,code,cost?nombre,c1,2' -d row_sep='?'
allow us to create a vending machine, we can create multiples vending machines
## parameters
# app
string as a CSV adding a custom row_sep, (name,code,cost) are a required fields.
# row_sep
it's the customn row_sep

# 2
curl -X POST  http://localhost:3000/add_money -d amount=2 -d app_id=1 -d type=dollar
with this we can add money to the vending machine.
## parameters
# 'type'
|dollar, cent|
# app_id
the id of the vending machine created showed in create_machine's response
# amount
the amount to add to the vending machine

# 3
curl -X POST  http://localhost:3000/buy_item -d app_id=1 -d code_item=c1
with this endpoint we will buy some of the products available in the vending machine
## parameters
# app_id
the id of the vending machine created showed in create_machine's response
# code_item
the code of the item in the vending machine

url -X POST  http://localhost:3000/show_machine -d app_id=1
this will show us the current state of the vending machine
## parameters
# app_id
the id of the vending machine created showed in create_machine's response



### it needs unit tests






