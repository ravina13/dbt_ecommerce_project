{{ config(materialized='table') }}

WITH
  merged AS (
  SELECT
    o.order_id,
    o.user_id,
    o.status,
    o.gender,
    o.created_at,
    o.returned_at,
    o.shipped_at,
    o.delivered_at,
    o.num_of_item,
    oi.product_id,
    oi.sale_price,
    p.cost,
    p.retail_price
  FROM
     {{ ref("stg_orders") }} o
  LEFT JOIN
    {{ ref("stg_order_items") }} oi
  ON
    o.order_id = oi.order_id
  LEFT JOIN
    {{ ref("stg_products") }} p
  ON
    oi.product_id = p.id
  )

  SELECT
  order_id,
  user_id,
  status,
  gender,
  created_at,
  returned_at,
  shipped_at,
  delivered_at,
  num_of_item,
  COUNT(product_id) AS num_products,
  SUM(sale_price) AS total_sale_price,
  SUM(cost) AS total_cost,
  SUM(retail_price) AS total_retail_price
FROM
  merged
GROUP BY
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9
