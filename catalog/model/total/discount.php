<?php
/**
 * Discount on Order Total module for Opencart by Anand S
 *
 * Copyright © 2015 anandrmedia@gmail.com. All Rights Reserved.
 * This file may not be redistributed in whole or significant part.
 * This copyright notice MUST APPEAR in all copies of the script!
 *
 * @author 		Anand S <anandrmedia@gmail.com>
 * @copyright	Copyright (c) 2015, Anand S <anandrmedia@gmail.com>
 * @package 	Discount on Order Total
 */
 
class ModelTotalDiscount extends Model {
	public function getTotal(&$total_data, &$total, &$taxes) {
		$this->load->language('total/discount');

		$sub_total = $this->cart->getSubTotal();
		$discount = 0;
		
		/*
		if (isset($this->session->data['vouchers']) && $this->session->data['vouchers']) {
			foreach ($this->session->data['vouchers'] as $voucher) {
				$sub_total += $voucher['amount'];
			}
		}
		*/
		
		
		if($sub_total > $this->config->get('discount_above_total')){
			//echo $this->config->get('discount_type') ;
	
			if($this->config->get('discount_type') == 'percentage'){
				$discount = $sub_total*$this->config->get('discount_value')/100;
			}else{
				$discount = $this->config->get('discount_value');
			}
		}
		
		
		$total_data[] = array(
			'code'       => 'discount',
			'title'      => $this->language->get('text_discount'),
			'value'      => $discount,
			'sort_order' => $this->config->get('discount_sort_order')
		);

		$total -= $discount;
	}
}