<dl>
    <dt>
        <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
        <label for="payment_[{$sPaymentID}]"><b>[{$paymentmethod->oxpayments__oxdesc->value}] [{if $paymentmethod->fAddPaymentSum != 0}]([{$paymentmethod->fAddPaymentSum}] [{$currency->sign}])[{/if}]</b></label>
    </dt>
    <dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
        <input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
        <ul class="form">
            <li id="fcpo_elv_error">
                <div class="oxValidateError" style="display: block;padding: 0;">
                    [{oxmultilang ident="FCPO_ERROR"}]<div id="fcpo_elv_error_content"></div>
                </div>
            </li>
            <li>
                <label>[{oxmultilang ident="FCPO_PAYOLUTION_ACCOUNTHOLDER"}]</label>
                <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_payolution_accountholder]" value="[{$dynvalue.fcpo_payolution_accountholder}]" onkeyup="fcHandleDebitInputs();return false;">
            </li>
            <li>
                <label>[{oxmultilang ident="FCPO_BANK_IBAN"}]</label>
                <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_payolution_iban]" value="[{$dynvalue.fcpo_payolution_iban}]" onkeyup="fcHandleDebitInputs();return false;">
                <div id="fcpo_payolution_iban_invalid" class="fcpo_check_error">
                    <p class="oxValidateError" style="display: block;">
                        [{oxmultilang ident="FCPO_IBAN_INVALID"}]
                    </p>
                </div>
            </li>
            <li>
                <label>[{oxmultilang ident="FCPO_BANK_BIC"}]</label>
                <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_payolution_bic]" value="[{$dynvalue.fcpo_payolution_bic}]" onkeyup="fcHandleDebitInputs();return false;">
                <div id="fcpo_payolution_bic_invalid" class="fcpo_check_error">
                    <p class="oxValidateError" style="display: block;">
                        [{oxmultilang ident="FCPO_BIC_INVALID"}]
                    </p>
                </div>
            </li>
        </ul>
        [{block name="checkout_payment_longdesc"}]
            [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                <div class="desc">
                    [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                </div>
            [{/if}]
        [{/block}]
    </dd>
</dl>