with orders as (
    select
    * 
    from {{ source('thelook_ecommerce' , 'orders')}}
)

select
*
from orders