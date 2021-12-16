package com.cognixia.jump.controller;

import com.cognixia.jump.model.Account;
import com.cognixia.jump.model.Amount;
import com.cognixia.jump.model.Login;
import com.cognixia.jump.model.Transaction;
import com.cognixia.jump.model.TransferRequest;
import com.cognixia.jump.service.AccountService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class AccountController {

    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @GetMapping("/login")
    public String viewLogin(Model model) {
        Login login = new Login();
        model.addAttribute("login", login);
        return "view-login";
    }

    @PostMapping("/login")
    public String postLogin(@ModelAttribute("login") Login login, Model model) {
        String email = login.getEmail();
        String password = login.getPassword();
        if(accountService.login(email, password)) {
            return "redirect:/account";
        }
        // the login was incorrect. Ask again.
        login = new Login();
        model.addAttribute("login", login);
        model.addAttribute("loginFailure", true);
        return "view-login";
    }

    @GetMapping("/logout")
    public String logout(Model model) {
        accountService.logout();
        model.addAttribute("logout", true);
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String viewRegister(Model model) {
        Account account = new Account();
        model.addAttribute("account", account);
        return "view-register";
    }

    @PostMapping("/register")
    public String postLogin(@ModelAttribute("account") Account newAccount, Model model) {
        String name = newAccount.getName();
        String email = newAccount.getEmail();
        String address = newAccount.getAddress();
        String password = newAccount.getPassword();
        double balance = newAccount.getBalance();

        Account account = accountService.addAccount(name, email, address, password, balance);
        // if account is null, the email is already in use
        if(account != null) {
            // account creation succeeded
            return "redirect:/login";
        }
        // the email was incorrect. Have them try again.
        account = new Account();
        model.addAttribute("account", account);
        model.addAttribute("registerFailure", true);
        return "view-register";
    }






    @GetMapping("/account")
    public String viewAccount(Model model) {
        model.addAttribute("account", accountService.getCurrentAccount());
        model.addAttribute("transactions", accountService.lastFiveTransactions());
        return "view-account";
    }

    @GetMapping("/deposit")
    public String viewDeposit(Model model) {
        Amount amount = new Amount();
        model.addAttribute("amount", amount);
        model.addAttribute("account", accountService.getCurrentAccount());
        return "view-deposit";
    }

    @PostMapping("/deposit")
    public String postDeposit(@ModelAttribute("amount") Amount amount, Model model) {
        double deposit = amount.getValue();
        Transaction transaction = accountService.deposit(deposit);
        // if the transaction is null, the deposit failed
        if(transaction == null) {
            model.addAttribute("amount", new Amount());
            model.addAttribute("account", accountService.getCurrentAccount());
            model.addAttribute("depositFailure", true);
            return "view-deposit";
        }
        // if it reaches this, the deposit succeeded. Return to the account screen.
        return "redirect:/account";
    }
    
    @GetMapping("/withdrawl")
    public String viewWithdrawl(Model model) {
        Amount amount = new Amount();
        model.addAttribute("account", accountService.getCurrentAccount());
        model.addAttribute("amount", amount);
        return "view-withdrawl";
    }

    @PostMapping("/withdrawl")
    public String postWithdrawl(@ModelAttribute("amount") Amount amount, Model model) {
        double withdrawl = amount.getValue();
        Transaction transaction = accountService.withdrawl(withdrawl);
        // if the transaction is null, the withdrawl failed
        if(transaction == null) {
            model.addAttribute("amount", new Amount());
            model.addAttribute("account", accountService.getCurrentAccount());
            model.addAttribute("withdrawlFailure", true);
            return "view-withdrawl";
        }
        // if it reaches this, the withdrawl succeeded. Return to the account screen.
        return "redirect:/account";
    }

    @GetMapping("/transfer")
    public String viewTransfer(Model model) {
        model.addAttribute("accounts", accountService.getAllAccounts());
        model.addAttribute("account", accountService.getCurrentAccount());
        TransferRequest transfer = new TransferRequest();
        model.addAttribute("transfer", transfer);
        return "view-transfer";
    }

    @PostMapping("/transfer")
    public String postTransfer(@ModelAttribute("transfer") TransferRequest transfer, Model model) {
        int targetId = transfer.getTargetId();
        double amount = transfer.getAmount();
        // if no ID is selected, targetId will be -1
        // ask for a selection again
        if(targetId == -1) {
            model.addAttribute("account", accountService.getCurrentAccount());
            model.addAttribute("accounts", accountService.getAllAccounts());
            model.addAttribute("transfer", new TransferRequest());
            model.addAttribute("noTarget", true);
            return "view-transfer";
        }
        // if the amount is negative or zero, ask for another input
        if(amount <= 0.0) {
            model.addAttribute("account", accountService.getCurrentAccount());
            model.addAttribute("accounts", accountService.getAllAccounts());
            model.addAttribute("transfer", new TransferRequest());
            model.addAttribute("amountNegative", true);
            return "view-transfer";
        }
        Transaction trans = accountService.transfer(targetId, amount);
        // if this returns null, there was an overdraft
        if(trans == null) {
            model.addAttribute("account", accountService.getCurrentAccount());
            model.addAttribute("accounts", accountService.getAllAccounts());
            model.addAttribute("transfer", new TransferRequest());
            model.addAttribute("overdraft", true);
            return "view-transfer";
        }
        // if it reaches this, the transaction was a success
        // return to the main account page
        return "redirect:/account";
    }
}
