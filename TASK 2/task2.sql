with revenue as (
	select
		o.order_date,
		quantity,
		od.price,
		p."name",
		p.brand_id 
	from order_details od 
	left join products p on od.product_id = p.product_id 
	left join orders o ON od.order_id = o.order_id 
)

select 
	date(order_date) as "order_date",
	r."name" as "product_name",
	b.name as "brand_name",
	sum(r.quantity) as "qty_sold",
	sum(r.quantity*r.price) as "revenue"
from revenue r
left join brands b on b.brand_id = r.brand_id
group by 1,2,3;