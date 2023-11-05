--1
ALTER TABLE rental 
ADD CONSTRAINT fk_customer 
FOREIGN KEY (customer_id) 
REFERENCES customer(customer_id)
ON DELETE Restrict;


--2
CREATE INDEX idx_payment_multicolumn 
ON payment (customer_id,payment_date,amount);
