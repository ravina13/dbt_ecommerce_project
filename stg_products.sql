{{ config(materialized='table') }}

select * from {{ source("thelook_ecommerce", "products") }}