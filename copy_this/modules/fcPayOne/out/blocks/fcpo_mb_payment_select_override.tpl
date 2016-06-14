[{assign var="dynvalue" value=$oView->getDynValue()}]
[{assign var="aFcPoCCPaymentMetaData" value=$oView->fcpoGetCCPaymentMetaData()}]
[{assign var="aFcPoOnlinePaymentMetaData" value=$oView->fcpoGetOnlinePaymentMetaData()}]

[{if $sPaymentID == "fcpocreditcard" && $oView->fcpoGetCreditcardType() == "ajax"}]
	[{if $oView->hasPaymentMethodAvailableSubTypes('cc') }]
        <div id="paymentOption_[{$sPaymentID}]" class="payment-option [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]active-payment[{/if}]">
            <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
            <input type="hidden" name="fcpo_cc_type" value="ajax">
            <ul class="form" id="fcpoCreditcard" style="display:none;">
                <li>
                    <div class="dropdown">
                        [{* only to track selection within DOM *}]
                        <input type="hidden" id="sFcpoCreditCardSelected" name="dynvalue[fcpo_kktype]" value="V" [{if $oView->getMaestroUK() }]onchange="fcCheckType(this);return false;"[{/if}] />
                        <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                            <a id="dLabelFcpoCreditCardSelected" role="button" href="#">
                                <span id="fcpoCreditCardSelected">[{oxmultilang ident="FCPO_CREDITCARD"}]</span>
                                <i class="glyphicon-chevron-down"></i>
                            </a>
                        </div>
                        [{* TODO: <select [{if $oView->getMaestroUK() }]onchange="fcCheckType(this);return false;"[{/if}]> *}]
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoCreditCardSelected">
                            [{foreach from=$aFcPoPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                                <li class="dropdown-option"><a tabindex="-1" data-selection-id="[{$oFcPoCCPaymentMetaData->sPaymentTag}]">[{$oFcPoCCPaymentMetaData->sPaymentName}]</a></li>
                            [{/foreach}]
                        </ul>
                        [{if !empty($dynvalue.fcpo_kktype)}]
                            [{oxscript add="$('#sFcpoCreditCardSelected').val('"|cat:$dynvalue.fcpo_kktype|cat:"');"}]
                        [{/if}]
                    </div>
                    [{foreach from=$aFcPoPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                        <input type="hidden" name="[{$oFcPoCCPaymentMetaData->sHashName}]" value="[{$oFcPoCCPaymentMetaData->sHashValue}]">
                        <input type="hidden" name="[{$oFcPoCCPaymentMetaData->sOperationModeName}]" value="[{$oFcPoCCPaymentMetaData->sOperationModeValue}]">
                    [{/foreach}]
                </li>
                <li>
                    <input type="number" size="20" maxlength="64" name="dynvalue[fcpo_kknumber]" autocomplete="off" value="[{$dynvalue.fcpo_kknumber}]" placeholder="[{oxmultilang ident="FCPO_NUMBER"}]" />
                    <div id="fcpo_cc_number_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_CC_NUMBER_INVALID" }]
                        </p>
                    </div>
                </li>
                <li>
                    <input type="text" size="20" maxlength="64" name="dynvalue[kkname]" value="[{if $dynvalue.fcpo_kkname}][{$dynvalue.fcpo_kkname}][{else}][{$oxcmp_user->oxuser__oxfname->value}] [{$oxcmp_user->oxuser__oxlname->value}][{/if}]" placeholder="[{oxmultilang ident="FCPO_BANK_ACCOUNT_HOLDER_2"}]" />
                    <br>
                    <div class="note">[{ oxmultilang ident="FCPO_IF_DEFERENT_FROM_BILLING_ADDRESS" }]</div>
                </li>
                <li>
                    <label>[{oxmultilang ident="FCPO_VALID_UNTIL"}]</label>
                    <div class="cardValidDateWrapper">
                        <div class="card-valid-date-field card-valid-date-month">
                            <div class="dropdown">
                                <input type="hidden" id="sFcpoCardValidDateMonthSelected" name="dynvalue[fcpo_kkmonth]" value="01" />
                                <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                                    <a id="dLabelFcpoCardValidDateMonthSelected" role="button" href="#">
                                        <span id="fcpoCardValidDateMonthSelected">01</span>
                                        <i class="glyphicon-chevron-down"></i>
                                    </a>
                                </div>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoCardValidDateMonthSelected">
                                    [{section name="iMonth" start=1 loop=13}]
                                        [{assign var=sMonth value=$smarty.section.iMonth.index|string_format:"%02d"}]
                                        <li class="dropdown-option">
                                            <a tabindex="-1" data-selection-id="[{$sMonth}]">[{$sMonth}]</a>
                                        </li>
                                        [{if $dynvalue.fcpo_kkmonth == $sMonth}]
                                            [{oxscript add="$('#sFcpoCardValidDateMonthSelected').val('"|cat:$sMonth|cat:"');"}]
                                        [{/if}]
                                    [{/section}]
                                </ul>
                            </div>
                        </div>
                        <div class="card-valid-date-field card-valid-date-divider">/</div>
                        <div class="card-valid-date-field card-valid-date-year">
                            <div class="dropdown">
                                [{assign var=aYear value=$oView->getCreditYears()}]
                                <input type="hidden" id="sFcpoCardValidDateYearSelected" name="dynvalue[fcpo_kkyear]" value="[{$aYear[0]}]" />
                                <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                                    <a id="dLabelFcpoCardValidDateYearSelected" role="button" href="#">
                                        <span id="fcpoCardValidDateYearSelected"></span>
                                        <i class="glyphicon-chevron-down"></i>
                                    </a>
                                </div>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoCardValidDateYearSelected">
                                    [{foreach from=$aYear item=iYear}]
                                        <li class="dropdown-option">
                                            <a tabindex="-1" data-selection-id="[{$iYear}]">[{$iYear}]</a>
                                        </li>
                                        [{if $dynvalue.fcpo_kkyear == $iYear}]
                                            [{oxscript add="$('#sFcpoCardValidDateYearSelected').val('"|cat:$iYear|cat:"');"}]
                                        [{/if}]
                                    [{/foreach}]
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div id="fcpo_cc_date_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_CC_DATE_INVALID" }]
                        </p>
                    </div>
                </li>
                <li>
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_kkpruef]" autocomplete="off" value="[{$dynvalue.fcpo_kkpruef}]" placeholder="[{oxmultilang ident="FCPO_CARD_SECURITY_CODE"}]" />
                    <div id="fcpo_cc_cvc2_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_CC_CVC2_INVALID" }]
                        </p>
                    </div>
                    <div class="clear"></div>
                    <div class="note">[{oxmultilang ident="FCPO_CARD_SECURITY_CODE_DESCRIPTION"}]</div>
                </li>
                [{if $oView->getMaestroUK() }]
                    <li id="fcpo_kkcsn_row" style="display: none;">
                        <input type="number" class="js-oxValidate js-oxValidate_notEmpty" size="20" maxlength="64" name="dynvalue[fcpo_kkcsn]" autocomplete="off" value="[{ $dynvalue.fcpo_kkcsn }]" placeholder="[{oxmultilang ident="FCPO_CARDSEQUENCENUMBER"}]" />
                        <p class="validation-error">
                            <span class="js-oxError_notEmpty">[{oxmultilang ident="ERROR_MESSAGE_INPUT_NOTALLFIELDS"}]</span>
                        </p>
                    </li>
                [{/if}]
                [{block name="checkout_payment_longdesc"}]
                    [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                        <li>
                            <div class="payment-desc">
                                [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                            </div>
                        </li>
                    [{/if}]
                [{/block}]
            </ul>
        </div>
        [{oxscript add="$('#paymentOption_$sPaymentID').find('.dropdown').oxDropDown();"}]
	[{/if}]
[{elseif $sPaymentID == "fcpocreditcard" && $oView->fcpoGetCreditcardType() == "hosted"}]
	[{if $oView->hasPaymentMethodAvailableSubTypes('cc') }]
        <div id="paymentOption_[{$sPaymentID}]" class="payment-option [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]active-payment[{/if}]">
            <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
            <script type="text/javascript" src="https://secure.pay1.de/client-api/js/v1/payone_hosted_min.js"></script>
            <input type="hidden" name="dynvalue[fcpo_kknumber]" value="">
            <input type="hidden" name="fcpo_cc_type" value="hosted">
            <ul class="form" id="fcpoCreditcard" style="display:none;">
                <li>
                    <div class="dropdown">
                        [{* only to track selection within DOM *}]
                        <input type="hidden" id="sFcpoCreditCardSelected" name="dynvalue[fcpo_kktype]" value="V" [{if $oView->getMaestroUK() }]onchange="fcCheckType(this);return false;"[{/if}] />
                        <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                            <a id="dLabelFcpoCreditCardSelected" role="button" href="#">
                                <span id="fcpoCreditCardSelected">[{oxmultilang ident="FCPO_CREDITCARD"}]</span>
                                <i class="glyphicon-chevron-down"></i>
                            </a>
                        </div>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoCreditCardSelected">
                            [{foreach from=$aFcPoPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                                <li class="dropdown-option"><a tabindex="-1" data-selection-id="[{$oFcPoCCPaymentMetaData->sPaymentTag}]">[{$oFcPoCCPaymentMetaData->sPaymentName}]</a></li>
                            [{/foreach}]
                        </ul>
                        [{if !empty($dynvalue.fcpo_kktype)}]
                            [{oxscript add="$('#sFcpoCreditCardSelected').val('"|cat:$dynvalue.fcpo_kktype|cat:"');"}]
                        [{/if}]
                    </div>
                    [{foreach from=$aFcPoPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                        <input type="hidden" name="[{$oFcPoCCPaymentMetaData->sHashName}]" value="[{$oFcPoCCPaymentMetaData->sHashValue}]">
                        <input type="hidden" name="[{$oFcPoCCPaymentMetaData->sOperationModeName}]" value="[{$oFcPoCCPaymentMetaData->sOperationModeValue}]">
                    [{/foreach}]
                </li>
                <li>
                    <label for="cardpanInput">[{ oxmultilang ident="FCPO_NUMBER" }]</label>
                    <span class="inputIframe" id="cardpan"></span>
                </li>
                <li>
                    <label for="cvcInput">[{ oxmultilang ident="FCPO_CARD_SECURITY_CODE" }]</label>
                    <span id="cardcvc2" class="inputIframe"></span>
                </li>
                <li>
                    <label for="expireInput">[{ oxmultilang ident="FCPO_VALID_UNTIL" }]</label>
                    <span id="expireInput" class="inputIframe">
                        <span id="cardexpiremonth"></span>
                        <span id="cardexpireyear"></span>
                    </span>
                </li>
                <li>
                    <label for="firstname">[{ oxmultilang ident="FCPO_FIRSTNAME" }]</label>
                    <input autocomplete="off" id="firstname" type="text" name="firstname" value="">
                </li>
                <li>
                    <label for="lastname">[{ oxmultilang ident="FCPO_LASTNAME" }]</label>
                    <input autocomplete="off" id="lastname" type="text" name="lastname" value="">
                </li>
                <li>
                    <div id="errorOutput"></div>
                </li>
                [{block name="checkout_payment_longdesc"}]
                    [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                        <li>
                            <div class="payment-desc">
                                [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                            </div>
                        </li>
                    [{/if}]
                [{/block}]
            </ul>
            <script>
                var request, config;
                config = {
                    fields: {
                        [{foreach from=$oView->fcpoGetCCFields() item="sSelectorName" name="fcpoForeachSelectorFields"}]
                            [{$sSelectorName}]: {
                                selector: "[{$sSelectorName}]", // put name of your div-container here
                                type: "[{$oView->getConfigParam('sFCPOCCNumberType')}]", // text (default), password, tel
                                size: "[{$oView->getConfigParam('sFCPOCCNumberCount')}]",
                                maxlength: "[{$oView->getConfigParam('sFCPOCCNumberMax')}]",
                                [{if $oView->getConfigParam('sFCPOCCNumberStyle') == "custom"}]
                                    style: "[{$oView->getConfigParam('sFCPOCCNumberCSS')}]",
                                [{/if}]
                                [{if $oView->getConfigParam('sFCPOCCNumberIframe') == "custom"}]
                                    iframe: {
                                        width: "[{$oView->getConfigParam('sFCPOCCNumberWidth')}]",
                                        height: "[{$oView->getConfigParam('sFCPOCCNumberHeight')}]"
                                    }
                                [{/if}]
                            }[{if !$smarty.foreach.fcpoForeachSelectorFields.last}]],[{/if}]
                        [{/foreach}]
                    },
                    defaultStyle: {
                        input: "[{$oView->getConfigParam('sFCPOCCStandardInput')}]",
                        select: "[{$oView->getConfigParam('sFCPOCCStandardOutput')}]",
                        iframe: {
                            width: "[{$oView->getConfigParam('sFCPOCCIframeWidth')}]",
                            height: "[{$oView->getConfigParam('sFCPOCCIframeHeight')}]"
                        }
                    },
                    [{if $oView->getConfigParam('blFCPOCCErrorsActive')}]
                        error: "errorOutput", // area to display error-messages (optional)
                        [{if $oView->getConfigParam('sFCPOCCErrorsLang') == "de"}]
                            language: Payone.ClientApi.Language.de // Language to display error-messages
                        [{else}]
                            language: Payone.ClientApi.Language.en 
                        [{/if}]
                    [{/if}]
                };

                [{capture name="fcpoCCIframes"}]
                    var iframes = fcInitCCIframes();
                [{/capture}]
                [{oxscript add=$smarty.capture.fcpoCCIframes}]
            </script>
        </div>
        [{oxscript add="$('#paymentOption_$sPaymentID').find('.dropdown').oxDropDown();"}]
    [{/if}]
[{elseif $sPaymentID == "fcpodebitnote"}]
    <div id="paymentOption_[{$sPaymentID}]" class="payment-option [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]active-payment[{/if}]">
        <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
        <ul class="form">
            <li id="fcpo_elv_error">
                <div class="validation-error" style="display: block;padding: 0;">
                    [{ oxmultilang ident="FCPO_ERROR" }]<div id="fcpo_elv_error_content"></div>
                </div>
            </li>
            <li id="fcpo_elv_error_blocked">
                <div class="validation-error" style="display: block;padding: 0;">
                    [{ oxmultilang ident="FCPO_ERROR" }]
                    <div>[{ oxmultilang ident="FCPO_ERROR_BLOCKED" }]</div>
                </div>
            </li>
            <li>
                <div class="dropdown">
                    [{assign var="sFirstCountry" value=""}]
                    [{foreach from=$oView->fcpoGetDebitCountries() key=sCountryId item=sCountry}]
                        [{if $sFirstCountry == ""}]
                            [{assign var="sFirstCountry" value=$sCountryId}]
                        [{/if}]
                    [{/foreach}]
                    <input type="hidden" id="sFcpoDebitNoteCountrySelected" name="dynvalue[fcpo_elv_country]" value="[{$sFirstCountry}]" onchange="fcCheckDebitCountry(this);return false;" />
                    <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                        <a id="dLabelFcpoDebitNoteCountrySelected" role="button" href="#">
                            <span id="fcpoDebitNoteCountrySelected">[{oxmultilang ident="FCPO_BANK_COUNTRY"}]</span>
                            <i class="glyphicon-chevron-down"></i>
                        </a>
                    </div>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoDebitNoteCountrySelected">
                        [{foreach from=$oView->fcpoGetDebitCountries() key=sCountryId item=sCountry}]
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="[{$sCountryId}]">[{$sCountry}]</a></li>
                        [{/foreach}]
                    </ul>
                    [{if !empty($dynvalue.fcpo_elv_country)}]
                        [{oxscript add="$('#sFcpoDebitNoteCountrySelected').val('"|cat:$dynvalue.fcpo_elv_country|cat:"');"}]
                    [{/if}]
                </div>
            </li>
            <li>
                <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_iban]" autocomplete="off" value="[{$dynvalue.fcpo_elv_iban}]" onkeyup="fcHandleDebitInputs();return false;" placeholder="[{oxmultilang ident="FCPO_BANK_IBAN"}]" />
                <div id="fcpo_elv_iban_invalid" class="fcpo_check_error">
                    <p class="validation-error" style="display: block;">
                        [{ oxmultilang ident="FCPO_IBAN_INVALID" }]
                    </p>
                </div>
            </li>
            <li>
                <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_bic]" autocomplete="off" value="[{$dynvalue.fcpo_elv_bic}]" onkeyup="fcHandleDebitInputs();return false;" placeholder="[{oxmultilang ident="FCPO_BANK_BIC"}]" />
                <div id="fcpo_elv_bic_invalid" class="fcpo_check_error">
                    <p class="validation-error" style="display: block;">
                        [{ oxmultilang ident="FCPO_BIC_INVALID" }]
                    </p>
                </div>
            </li>
            [{if $oView->fcpoShowOldDebitFields()}]
                <li id="fcpo_elv_ktonr" style="display: none;">
                    <div style="margin-top: 20px;margin-bottom:10px;">[{oxmultilang ident="FCPO_BANK_GER_OLD"}]</div>
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_ktonr]" autocomplete="off" value="[{$dynvalue.fcpo_elv_ktonr}]" onkeyup="fcHandleDebitInputs();return false;" placeholder="[{oxmultilang ident="FCPO_BANK_ACCOUNT_NUMBER"}]" />
                    <div id="fcpo_elv_ktonr_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_KTONR_INVALID" }]
                        </p>
                    </div>
                </li>
                <li id="fcpo_elv_blz" style="display: none;">
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_blz]" autocomplete="off" value="[{$dynvalue.fcpo_elv_blz}]" onkeyup="fcHandleDebitInputs();return false;" placeholder="[{oxmultilang ident="FCPO_BANK_CODE"}]" />
                    <div id="fcpo_elv_blz_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_BLZ_INVALID" }]
                        </p>
                    </div>
                </li>
            [{/if}]
            <input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
            [{block name="checkout_payment_longdesc"}]
                [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                    <li>
                        <div class="payment-desc">
                            [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                        </div>
                    </li>
                [{/if}]
            [{/block}]
        </ul>
    </div>
    [{oxscript add="$('#paymentOption_$sPaymentID').find('.dropdown').oxDropDown();"}]
[{elseif $sPaymentID == "fcpoonlineueberweisung"}]
	[{if $oView->hasPaymentMethodAvailableSubTypes('sb')}]
        <div id="paymentOption_[{$sPaymentID}]" class="payment-option [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]active-payment[{/if}]">
            <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
            <ul class="form">
                <li id="fcpo_ou_error">
                    <div class="validation-error" style="display: block;padding: 0;">
                        [{ oxmultilang ident="FCPO_ERROR" }]<div id="fcpo_ou_error_content"></div>
                    </div>
                </li>
                <li>
                    <div class="dropdown">
                        <input type="hidden" id="sFcpoSoTypeSelected" name="dynvalue[fcpo_sotype]" value="[{$oView->getDefaultOnlineUeberweisung()}]" onchange="fcCheckOUType(this);return false;" />
                        <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                            <a id="dLabelFcpoSoTypeSelected" role="button" href="#">
                                <span id="fcpoSoTypeSelected">[{oxmultilang ident="FCPO_ONLINE_UEBERWEISUNG_TYPE"}]</span>
                                <i class="glyphicon-chevron-down"></i>
                            </a>
                        </div>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoSoTypeSelected">
                            [{foreach var=$aFcPoOnlinePaymentMetaData item="oPaymentMetaData"}]
                                <li class="dropdown-option"><a tabindex="-1" data-selection-id="[{$oPaymentMetaData->sShortcut}]">[{$oPaymentMetaData->sCaption}]</a></li>
                            [{/foreach}]
                        </ul>
                        [{if !empty($dynvalue.fcpo_sotype)}]
                            [{oxscript add="$('#sFcpoSoTypeSelected').val('"|cat:$dynvalue.fcpo_sotype|cat:"');"}]
                        [{/if}]
                    </div>
                </li>
                <li id="fcpo_ou_iban">
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_iban]" autocomplete="off" value="[{$dynvalue.fcpo_ou_iban}]" placeholder="[{oxmultilang ident="FCPO_BANK_IBAN"}]" />
                    <div id="fcpo_ou_iban_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_IBAN_INVALID" }]
                        </p>
                    </div>
                </li>
                <li id="fcpo_ou_bic">
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_bic]" autocomplete="off" value="[{$dynvalue.fcpo_ou_bic}]" placeholder="[{oxmultilang ident="FCPO_BANK_BIC"}]" />
                    <div id="fcpo_ou_bic_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_BIC_INVALID" }]
                        </p>
                    </div>
                </li>
                <li id="fcpo_ou_blz">
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_blz]" autocomplete="off" value="[{$dynvalue.fcpo_ou_blz}]" placeholder="[{oxmultilang ident="FCPO_BANK_CODE"}]" />
                    <div id="fcpo_ou_blz_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_BLZ_INVALID" }]
                        </p>
                    </div>
                </li>
                <li id="fcpo_ou_ktonr">
                    <input type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_ktonr]" autocomplete="off" value="[{$dynvalue.fcpo_ou_ktonr}]" placeholder="[{oxmultilang ident="FCPO_BANK_ACCOUNT_NUMBER"}]" />
                    <div id="fcpo_ou_ktonr_invalid" class="fcpo_check_error">
                        <p class="validation-error" style="display: block;">
                            [{ oxmultilang ident="FCPO_KTONR_INVALID" }]
                        </p>
                    </div>
                </li>
                <li id="fcpo_ou_eps" style="display: none;">
                    <div class="dropdown">
                        <input type="hidden" id="sFcpoSoBanktypeEpsSelected" name="dynvalue[fcpo_so_bankgrouptype_eps]" value="ARZ_OVB" />
                        <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                            <a id="dLabelFcpoSoBanktypeEpsSelected" role="button" href="#">
                                <span id="fcpoSoBanktypeEpsSelected">[{oxmultilang ident="FCPO_BANKGROUPTYPE"}]</span>
                                <i class="glyphicon-chevron-down"></i>
                            </a>
                        </div>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoSoBanktypeEpsSelected">
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_OVB">Volksbanken</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_BAF">Bank f&uuml;r &Auml;rzte und Freie Berufe</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_NLH">Nieder&ouml;sterreichische Landes-Hypo</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_VLH">Vorarlberger Landes-Hypo</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_BCS">Bankhaus Carl Sp&auml;ngler & Co. AG</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_HTB">Hypo Tirol</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_HAA">Hypo Alpe Adria</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_IKB">Investkreditbank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_OAB">&Ouml;sterreichische Apothekerbank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_IMB">Immobank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_GRB">G&auml;rtnerbank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ARZ_HIB">HYPO Investment</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="BA_AUS">Bank Austria</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="BAWAG_BWG">BAWAG</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="BAWAG_PSK">PSK Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="BAWAG_ESY">easybank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="BAWAG_SPD">Sparda Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="SPARDAT_EBS">Erste Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="SPARDAT_BBL">Bank Burgenland</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="RAC_RAC">Raiffeisen</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="HRAC_OOS">Hypo Ober&ouml;sterreich</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="HRAC_SLB">Hypo Salzburg</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="HRAC_STM">Hypo Steiermark</a></li>
                        </ul>
                        [{if !empty($dynvalue.fcpo_so_bankgrouptype_eps)}]
                            [{oxscript add="$('#sFcpoSoBanktypeEpsSelected').val('"|cat:$dynvalue.fcpo_so_bankgrouptype_eps|cat:"');"}]
                        [{/if}]
                    </div>
                </li>
                <li id="fcpo_ou_idl" style="display: none;">
                    <div class="dropdown">
                        <input type="hidden" id="sFcpoSoBanktypeIdlSelected" name="dynvalue[fcpo_so_bankgrouptype_idl]" value="ABN_AMRO_BANK" />
                        <div class="dropdown-toggle" data-toggle="dropdown" data-target="#">
                            <a id="dLabelFcpoSoBanktypeIdlSelected" role="button" href="#">
                                <span id="fcpoSoBanktypeIdlSelected">[{oxmultilang ident="FCPO_BANKGROUPTYPE"}]</span>
                                <i class="glyphicon-chevron-down"></i>
                            </a>
                        </div>
                        <ul class="dropdown-menu" role="menu" aria-labelledby="dLabelFcpoSoBanktypeIdlSelected">
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ABN_AMRO_BANK">ABN Amro</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="BUNQ_BANK">Bunq</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ING_BANK">ING Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="RABOBANK">Rabobank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="SNS_BANK">SNS Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="ASN_BANK">ASN Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="SNS_REGIO_BANK">Regio Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="TRIODOS_BANK">Triodos Bank</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="KNAB_BANK">Knab</a></li>
                            <li class="dropdown-option"><a tabindex="-1" data-selection-id="VAN_LANSCHOT_BANKIERS">van Lanschot</a></li>
                        </ul>
                        [{if !empty($dynvalue.fcpo_so_bankgrouptype_idl)}]
                            [{oxscript add="$('#sFcpoSoBanktypeIdlSelected').val('"|cat:$dynvalue.fcpo_so_bankgrouptype_idl|cat:"');"}]
                        [{/if}]
                    </div>
                </li>
                [{block name="checkout_payment_longdesc"}]
                    [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                        <li>
                            <div class="payment-desc">
                                [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                            </div>
                        </li>
                    [{/if}]
                [{/block}]
            </ul>
            <input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
        </div>
        [{oxscript add="$('#paymentOption_$sPaymentID').find('.dropdown').oxDropDown();"}]
	[{/if}]
[{elseif $sPaymentID == "fcpoklarna" || $sPaymentID == "fcpoklarna_installment"}]
    <div id="paymentOption_[{$sPaymentID}]" class="payment-option [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]active-payment[{/if}]">
        <input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked="checked"[{/if}] />
        <ul class="form">
            [{assign var="blDisplayCampaignMissing" value=false}]
            [{if $sPaymentID == "fcpoklarna_installment"}]
                [{assign var="aCampaigns" value=$paymentmethod->fcpoGetKlarnaCampaigns()}]
                [{if $aCampaigns|@count == 0}]
                    [{assign var="blDisplayCampaignMissing" value=true}]
                [{/if}]
            [{/if}]
            [{if $blDisplayCampaignMissing == false}]
                [{if $sPaymentID == "fcpoklarna_installment"}]
                    <li>
                        [{ oxmultilang ident="FCPO_KLS_CHOOSE_CAMPAIGN" }]
                        <table>
                            [{foreach from=$aCampaigns item=aCampaign key=sId}]
                                <tr>
                                    <td style="width:32px;"><input type="radio" name="fcpo_klarna_campaign" value="[{$aCampaign.code}]"></td>
                                    <td>[{$aCampaign.title}]</td>
                                </tr>
                            [{/foreach}]
                        </table>
                        <div id="fcpo_klarna_campaign_invalid" class="fcpo_check_error">
                            <p class="validation-error" style="display: block;padding-left:32px;">
                                [{ oxmultilang ident="FCPO_KLS_CAMPAIGN_INVALID" }]
                            </p>
                        </div>
                    </li>
                [{/if}]
                [{if $oView->fcpoKlarnaInfoNeeded()}]
                    <li>
                        [{ oxmultilang ident="FCPO_KLV_INFO_NEEDED" }]
                        <br>
                    </li>
                [{/if}]
                [{if $sPaymentID == "fcpoklarna"}]
                    [{assign var="blKlv" value=true}]
                [{else}]
                    [{assign var="blKlv" value=false}]
                [{/if}]
                [{if $oView->fcpoKlarnaIsTelephoneNumberNeeded()}]
                    <li>
                        <input type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_fon]" value="[{ $dynvalue.fcpo_klv_fon }]"[{else}]name="dynvalue[fcpo_kls_fon]" value="[{ $dynvalue.fcpo_kls_fon }]"[{/if}] autocomplete="off" placeholder="[{oxmultilang ident="FCPO_KLV_TELEPHONENUMBER"}]" />
                        <div [{if $blKlv}]id="fcpo_klv_fon_invalid"[{else}]id="fcpo_kls_fon_invalid"[{/if}] class="fcpo_check_error">
                            <p class="validation-error" style="display: block;">
                                [{ oxmultilang ident="FCPO_KLV_TELEPHONENUMBER_INVALID" }]
                            </p>
                        </div>
                    </li>
                [{/if}]
                [{if $oView->fcpoKlarnaIsBirthdayNeeded()}]
                    [{oxscript include="js/libs/modernizr.custom.min.js" priority=10}]
                    [{oxscript include="js/widgets/oxdatepicker.js" priority=10}]
                    [{oxscript add="$('#datePicker').oxDatePicker();"}]
                    [{if $blKlv}]
                        [{assign var="iBirthdayDay" value=$dynvalue.fcpo_klv_birthday.day }]
                        [{assign var="iBirthdayMonth" value=$dynvalue.fcpo_klv_birthday.month }]
                        [{assign var="iBirthdayYear" value=$dynvalue.fcpo_klv_birthday.year }]
                    [{else}]
                        [{assign var="iBirthdayDay" value=$dynvalue.fcpo_kls_birthday.day }]
                        [{assign var="iBirthdayMonth" value=$dynvalue.fcpo_kls_birthday.month }]
                        [{assign var="iBirthdayYear" value=$dynvalue.fcpo_kls_birthday.year }]
                    [{/if}]
                    
                    <li class="oxDate">
                    <label>[{oxmultilang ident="FCPO_KLV_BIRTHDAY"}]</label>
                        <div id="datePicker">
                            <ul class="nav nav-pills nav-justified datepicker-container">
                                <li id="month">
                                    <button class="btn" type="button">+</button>
                                    <input [{if $blKlv}]name="dynvalue[fcpo_klv_birthday][month]"[{else}]name="dynvalue[fcpo_kls_birthday][month]"[{/if}] type="hidden" value="[{if $iBirthdayMonth > 0 }][{$iBirthdayMonth }][{/if}]" />
                                    <input placeholder="[{oxmultilang ident="MONTH"}]" type="text" readonly/>
                                    <button class="btn" type="button">-</button>
                                </li>
                                <li id="day">
                                    <button class="btn" type="button">+</button>
                                    <input data-fieldsize="xsmall" id="oxDay" maxlength="2" [{if $blKlv}]name="dynvalue[fcpo_klv_birthday][day]"[{else}]name="dynvalue[fcpo_kls_birthday][day]"[{/if}] placeholder="[{oxmultilang ident="DAY"}]" type="number" value="[{if $iBirthdayDay > 0 }][{$iBirthdayDay }][{/if}]" />
                                    <button class="btn" type="button">-</button>
                                </li>
                                <li id="year">
                                    <button class="btn" type="button">+</button>
                                    <input data-fieldsize="small" id="oxYear" maxlength="4"  [{if $blKlv}]name="dynvalue[fcpo_klv_birthday][year]"[{else}]name="dynvalue[fcpo_kls_birthday][year]"[{/if}] placeholder="[{oxmultilang ident="YEAR"}]" type="number" value="[{if $iBirthdayYear }][{$iBirthdayYear }][{/if}]" />
                                    <button class="btn" type="button">-</button>
                                </li>
                                <li class="months">
                                    <select id="months">
                                        [{section name="month" start=1 loop=13 }]
                                            <option value="[{$smarty.section.month.index}]" [{if $iBirthdayMonth == $smarty.section.month.index}] selected="selected" [{/if}]>[{oxmultilang ident="MONTH_NAME_"|cat:$smarty.section.month.index}]</option>
                                        [{/section}]
                                    </select>
                                </li>
                            </ul>
                            <div [{if $blKlv}]id="fcpo_klv_birthday_invalid"[{else}]id="fcpo_kls_birthday_invalid"[{/if}] class="fcpo_check_error">
                                <p class="validation-error" style="display: block;">
                                    [{ oxmultilang ident="FCPO_KLV_BIRTHDAY_INVALID" }]
                                </p>
                            </div>
                        </div>
                        <input id="modernDate" type="date" value="[{if $iBirthdayDay > 0 }][{$iBirthdayYear }]-[{if $iBirthdayMonth < 10 }]0[{/if}][{$iBirthdayMonth }]-[{$iBirthdayDay }][{/if}]"/>
                    </li>
                [{/if}]
                [{if $oView->fcpoKlarnaIsAddressAdditionNeeded()}]
                    <li>
                        <input type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_addinfo]" value="[{ $dynvalue.fcpo_klv_addinfo }]"[{else}]name="dynvalue[fcpo_kls_addinfo]" value="[{ $dynvalue.fcpo_kls_addinfo }]"[{/if}] autocomplete="off" placeholder="[{oxmultilang ident="FCPO_KLV_ADDINFO"}]" />
                        <div [{if $blKlv}]id="fcpo_klv_addinfo_invalid"[{else}]id="fcpo_kls_addinfo_invalid"[{/if}] class="fcpo_check_error">
                            <p class="validation-error" style="display: block;">
                                [{ oxmultilang ident="FCPO_KLV_ADDINFO_INVALID" }]
                            </p>
                        </div>
                    </li>
                [{/if}]
                [{if $oView->fcpoKlarnaIsDelAddressAdditionNeeded()}]
                    <li>
                        <input type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_del_addinfo]" value="[{ $dynvalue.fcpo_klv_del_addinfo }]"[{else}]name="dynvalue[fcpo_kls_del_addinfo]" value="[{ $dynvalue.fcpo_kls_del_addinfo }]"[{/if}] autocomplete="off" placeholder="[{oxmultilang ident="FCPO_KLV_ADDINFO_DEL"}]" />
                        <div [{if $blKlv}]id="fcpo_klv_del_addinfo_invalid"[{else}]id="fcpo_kls_del_addinfo_invalid"[{/if}] class="fcpo_check_error">
                            <p class="validation-error" style="display: block;">
                                [{ oxmultilang ident="FCPO_KLV_ADDINFO_INVALID" }]
                            </p>
                        </div>
                    </li>
                [{/if}]
                [{if $oView->fcpoKlarnaIsGenderNeeded()}]
                    <li>
                        [{if $blKlv}]
                            [{include file="form/fieldset/salutation.tpl" name="dynvalue[fcpo_klv_sal]" value=$dynvalue.fcpo_klv_sal }]
                        [{else}]
                            [{include file="form/fieldset/salutation.tpl" name="dynvalue[fcpo_kls_sal]" value=$dynvalue.fcpo_kls_sal }]
                        [{/if}]
                    </li>
                [{/if}]
                [{if $oView->fcpoKlarnaIsPersonalIdNeeded()}]
                    <li>
                        <input type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_personalid]" value="[{ $dynvalue.fcpo_klv_personalid }]"[{else}]name="dynvalue[fcpo_kls_personalid]" value="[{ $dynvalue.fcpo_kls_personalid }]"[{/if}] autocomplete="off" placeholder="[{oxmultilang ident="FCPO_KLV_PERSONALID"}]" />
                        <div [{if $blKlv}]id="fcpo_klv_personalid_invalid"[{else}]id="fcpo_kls_personalid_invalid"[{/if}] class="fcpo_check_error">
                            <p class="validation-error" style="display: block;">
                                [{ oxmultilang ident="FCPO_KLV_PERSONALID_INVALID" }]
                            </p>
                        </div>
                    </li>
                [{/if}]
                <li>
                    <div style="float:left;width:5%;">
                        [{if $blKlv}]
                            <input type="hidden"   name="dynvalue[fcpo_klv_confirm]" value="false">
                            <input type="checkbox" name="dynvalue[fcpo_klv_confirm]" value="true" [{if $dynvalue.fcpo_klv_confirm}]checked[{/if}]>
                        [{else}]
                            <input type="hidden"   name="dynvalue[fcpo_kls_confirm]" value="false">
                            <input type="checkbox" name="dynvalue[fcpo_kls_confirm]" value="true" [{if $dynvalue.fcpo_kls_confirm}]checked[{/if}]>
                        [{/if}]
                    </div>
                    <div style="float:left;width:95%;">
                        [{$oView->fcpoGetConfirmationText()}]
                    </div>
                    <div style="clear:both;"></div>
                    <div [{if $blKlv}]id="fcpo_klv_confirmation_missing"[{else}]id="fcpo_kls_confirmation_missing"[{/if}] class="fcpo_check_error">
                        <p class="validation-error" style="display: block;padding-left:5%;">
                            [{ oxmultilang ident="FCPO_KLV_CONFIRMATION_MISSING" }]
                        </p>
                    </div>
                </li>
            [{else}]
                <li>[{oxmultilang ident="FCPO_KLS_NO_CAMPAIGN"}]</li>
                <input type="hidden" name="fcpo_klarna_no_campaign" value="true">
            [{/if}]
            [{block name="checkout_payment_longdesc"}]
                [{if $paymentmethod->oxpayments__oxlongdesc->value}]
                    <li>
                        <div class="payment-desc">
                            [{$paymentmethod->oxpayments__oxlongdesc->getRawValue()}]
                        </div>
                    </li>
                [{/if}]
            [{/block}]
        </ul>
        <input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
    </div>
    [{oxscript add="$('#paymentOption_$sPaymentID').find('.dropdown').oxDropDown();"}]
[{else}]
    [{$smarty.block.parent}]
[{/if}]