with 

source as (

    select * from {{ source('thelook_ecommerce', 'distribution_centers') }}

),

renamed as (

    select
        id,
        name,
        latitude,
        longitude

    from source

)

select * from renamed
