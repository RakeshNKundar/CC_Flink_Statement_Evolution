INSERT INTO `Rakesh-Workspace`.`Upvest Demo`.`up_orders_more_than_10_quantities`
SELECT * FROM
`Rakesh-Workspace`.`Upvest Demo`.`up_orders`
WHERE quantity > 10;