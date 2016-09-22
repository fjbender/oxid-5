<div id="paymentOption_[{$sPaymentID}]" class="payment-option [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]active-payment[{/if}]">
    <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
    <input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
    <ul class="form">
        [{if $oView->fcpoShowB2B()}]
            <li>
                <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_payolution_ustid]" autocomplete="off" value="[{$oView->fcpoGetUserValue('oxustid')}]" placeholder="[{oxmultilang ident="FCPO_PAYOLUTION_USTID"}]" />
            </li>
        [{elseif $oView->fcpoShowB2C()}]
            <li>
                <input placceholder="[{oxmultilang ident="FCPO_PAYOLUTION_YEAR"}]" type="text" size="5" maxlength="4" name="dynvalue[fcpo_payolution_birthdate_year]" value="[{$oView->fcpoGetBirthdayField('year')}]">&nbsp;
                <input placceholder="[{oxmultilang ident="FCPO_PAYOLUTION_MONTH"}]" type="text" size="3" maxlength="2" name="dynvalue[fcpo_payolution_birthdate_month]" value="[{$oView->fcpoGetBirthdayField('month')}]">&nbsp;
                <input placceholder="[{oxmultilang ident="FCPO_PAYOLUTION_DAY"}]" type="text" size="3" maxlength="2" name="dynvalue[fcpo_payolution_birthdate_day]" value="[{$oView->fcpoGetBirthdayField('day')}]">
            </li>
        [{/if}]
    </ul>
</div>