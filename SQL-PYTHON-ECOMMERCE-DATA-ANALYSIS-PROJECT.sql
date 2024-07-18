create database ecommerce;
show databases
Select products.product_category category , sum(payments.payment_value) sales from products join order_items
on products.product_id = order_items.product_id
join payments
on payments.order_id = order_items.order_id
group by category


cur.execute(query)

data = cur.fetchall()

df = pd.DataFrame(data, columns = ["Category", "sales"])
df
show databases
use ecommerce;
with count_per_order as
(Select orders.order_id, orders.customer_id, count(order_items.order_id) as oc
from orders join order_items
on orders.order_id = order_items.order_id
group by orders.order_id, orders.customer_id)

(select customers.customer_city, round(avg(count_per_order.oc),2) average_orders
from customers join count_per_order
on customers.customer_id = count_per_order.customer_id
group by customers.customer_city)

SELECT * FROM ecommerce.order_items;
select orders.order_id, orders.customer_id, count(order_items.order_id)
from orders join order_items
on orders.order_id = order_items.order_id
group by orders.order_id, orders.customer_id;

select customers.customercity, avg(count_per_order.oc)
from customers join count_per_order
on customers.customer_id = count_per_order.customer_id
group by customers.customer_city
;

use ecommerce;
select products.product_category,
count(order_items.product_id),
round(avg(order_items.price),2)
from products join order_items 
on products.product_id = order_items.product_id
group by products.product_category;
use ecommerce;
select customer_id, order_purchase_timestamp, payment,
avg(payment) over(partition by customer_id order by order_purchase_timestamp
rows between 2 preceding and current row) as mov_avg
from
(select orders.customer_id,orders.order_purchase_timestamp,
payments.payment_value as payment
from payments join orders
on payments.order_id = orders.order_id) as a;

select years, months, payment, sum(payment)
over(order by years, months) cumulative_sales from
(select year(orders.order_purchase_timestamp) as years,
month(orders.order_purchase_timestamp) as months,
round(sum(payments.payment_value),2) as payment from orders join payments
on orders.order_id = payments.order_id
group by years, months order by years, months) as a;

select products.product_category category ,
round((sum(payments.payment_value)/(select sum(payment_value) from payments))*100,2) sales_percent from products join order_items
on products.product_id = order_items.product_id
join payments
on payments.order_id = order_items.order_id
group by category order by sales_percent desc


