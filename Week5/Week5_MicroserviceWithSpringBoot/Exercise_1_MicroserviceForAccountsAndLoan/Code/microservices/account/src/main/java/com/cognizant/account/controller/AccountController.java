package com.cognizant.account.controller;

import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
@RequestMapping("/accounts")
public class AccountController {

    @GetMapping("/{accNo}")
    public Map<String, Object> fetchAccountDetails(@PathVariable("accNo") String accountNo) {
        Map<String, Object> accountDetails = new LinkedHashMap<>();
        accountDetails.put("Account_id", accountNo);
        accountDetails.put("Accountholder_name", "Avilash Dey");
        accountDetails.put("current_balance", 9999.00);
        accountDetails.put("account_type", "SAVINGS");
        accountDetails.put("currency_type", "INR");
        return accountDetails;
    }
}
