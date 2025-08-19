INSERT INTO `Rakesh-Workspace`.`Upvest Demo`.`up_orders_more_than_10_quantities_v2`
SELECT * FROM
`Rakesh-Workspace`.`Upvest Demo`.`up_orders` /*+ OPTIONS(
    'scan.startup.mode' = 'specific-offsets',
    'scan.startup.specific-offsets' = 'partition:0,offset:20;partition:1,offset:24;partition:2,offset:24'
) */
WHERE quantity > 10;