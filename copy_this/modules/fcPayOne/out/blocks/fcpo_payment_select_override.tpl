[{assign var="aFcPoCCPaymentMetaData" value=$oView->fcpoGetCCPaymentMetaData()}]
[{assign var="aFcPoOnlinePaymentMetaData" value=$oView->fcpoGetOnlinePaymentMetaData()}]

[{if $sPaymentID == "fcpocreditcard" && $oView->fcpoGetCreditcardType() == "ajax"}]
	[{if $oView->hasPaymentMethodAvailableSubTypes('cc') }]
		[{ assign var="dynvalue" value=$oView->getDynValue()}]
		<dl id="fcpoCreditcard" style="display:none;">
			<dt>
				<input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
				<label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}] [{ if $paymentmethod->fAddPaymentSum != 0 }]([{ $paymentmethod->fAddPaymentSum }] [{ $currency->sign}])[{/if}]</b></label>
			</dt>
			<dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
                <input type="hidden" name="fcpo_cc_type" value="ajax">
				<ul class="form">
					<li id="fcpo_cc_error">
						<div class="oxValidateError" style="display: block;padding: 0;">
							[{ oxmultilang ident="FCPO_ERROR" }]<div id="fcpo_cc_error_content"></div>
						</div>
					</li>
					<li>
						<label>[{ oxmultilang ident="FCPO_CREDITCARD" }]</label>
						<select name="dynvalue[fcpo_kktype]" [{if $oView->getMaestroUK() }]onchange="fcCheckType(this);return false;"[{/if}]>
                            [{foreach from=$aFcPoCCPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                                <option value="[{$oFcPoCCPaymentMetaData->sPaymentTag}]" [{ if $oFcPoCCPaymentMetaData->blSelected}]selected[{/if}]>[{$oFcPoCCPaymentMetaData->sPaymentName}]</option>
                            [{/foreach}]
						</select>
                        [{foreach from=$aFcPoCCPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                            <input type="hidden" name="[{$oFcPoCCPaymentMetaData->sHashName}]" value="[{$oFcPoCCPaymentMetaData->sHashValue}]">
                            <input type="hidden" name="[{$oFcPoCCPaymentMetaData->sOperationModeName}]" value="[{$oFcPoCCPaymentMetaData->sOperationModeValue}]">
                        [{/foreach}]
					</li>
					<li>
						<label>[{ oxmultilang ident="FCPO_NUMBER" }]</label>
						<input autocomplete="off" type="text" class="payment_text" size="20" maxlength="64" name="dynvalue[fcpo_kknumber]" value="[{ $dynvalue.fcpo_kknumber }]">
						<div id="fcpo_cc_number_invalid" class="fcpo_check_error">
							<p class="oxValidateError" style="display: block;">
								[{ oxmultilang ident="FCPO_CC_NUMBER_INVALID" }]
							</p>
						</div>
					</li>
					<li>
						<label>[{ oxmultilang ident="FCPO_BANK_ACCOUNT_HOLDER_2" }]</label>
						<input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_kkname]" value="[{ if $dynvalue.fcpo_kkname }][{ $dynvalue.fcpo_kkname }][{else}][{$oxcmp_user->oxuser__oxfname->value}] [{$oxcmp_user->oxuser__oxlname->value}][{/if}]">
						<br>
						<div class="note">[{ oxmultilang ident="FCPO_IF_DEFERENT_FROM_BILLING_ADDRESS" }]</div>
					</li>
					<li>
						<label>[{ oxmultilang ident="FCPO_VALID_UNTIL" }]</label>
						<select name="dynvalue[fcpo_kkmonth]">
							<option [{ if $dynvalue.fcpo_kkmonth == "01"}]selected[{/if}]>01</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "02"}]selected[{/if}]>02</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "03"}]selected[{/if}]>03</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "04"}]selected[{/if}]>04</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "05"}]selected[{/if}]>05</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "06"}]selected[{/if}]>06</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "07"}]selected[{/if}]>07</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "08"}]selected[{/if}]>08</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "09"}]selected[{/if}]>09</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "10"}]selected[{/if}]>10</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "11"}]selected[{/if}]>11</option>
							<option [{ if $dynvalue.fcpo_kkmonth == "12"}]selected[{/if}]>12</option>
						</select>&nbsp;/&nbsp;

						<select name="dynvalue[fcpo_kkyear]">
							[{foreach from=$oView->getCreditYears() item=year}]
								<option [{ if $dynvalue.fcpo_kkyear == $year}]selected[{/if}]>[{$year}]</option>
							[{/foreach}]
						</select>
						<div id="fcpo_cc_date_invalid" class="fcpo_check_error">
							<p class="oxValidateError" style="display: block;">
								[{ oxmultilang ident="FCPO_CC_DATE_INVALID" }]
							</p>
						</div>
					</li>
					<li>
						<label>[{ oxmultilang ident="FCPO_CARD_SECURITY_CODE" }]</label>
						<input autocomplete="off" type="text" class="payment_text" size="20" maxlength="64" name="dynvalue[fcpo_kkpruef]" value="[{ $dynvalue.fcpo_kkpruef }]">
						<div id="fcpo_cc_cvc2_invalid" class="fcpo_check_error">
							<p class="oxValidateError" style="display: block;">
								[{ oxmultilang ident="FCPO_CC_CVC2_INVALID" }]
							</p>
						</div>
						<div class="clear"></div>
						<div class="note">[{ oxmultilang ident="FCPO_CARD_SECURITY_CODE_DESCRIPTION" }]</div>
					</li>
					[{if $oView->getMaestroUK() }]
						<li id="fcpo_kkcsn_row" style="display: none;">
							<label>[{ oxmultilang ident="FCPO_CARDSEQUENCENUMBER" }]</label>
							<input autocomplete="off" type="text" class="payment_text" size="20" maxlength="64" name="dynvalue[fcpo_kkcsn]" value="[{ $dynvalue.fcpo_kkcsn }]">
						</li>
					[{/if}]
				</ul>
				[{if $paymentmethod->oxpayments__oxlongdesc->value}]
					<div class="desc">
						[{ $paymentmethod->oxpayments__oxlongdesc->rawValue}]
					</div>
				[{/if}]
			</dd>
		</dl>
		<input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
	[{/if}]
[{elseif $sPaymentID == "fcpocreditcard" && $oView->fcpoGetCreditcardType() == "hosted"}]
	[{if $oView->hasPaymentMethodAvailableSubTypes('cc') }]
		[{ assign var="dynvalue" value=$oView->getDynValue()}]
		<dl id="fcpoCreditcard" style="display:none;">
			<dt>
				<input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
				<label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}] [{ if $paymentmethod->fAddPaymentSum != 0 }]([{ $paymentmethod->fAddPaymentSum }] [{ $currency->sign}])[{/if}]</b></label>
			</dt>
			<dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
                <script type="text/javascript" src="https://secure.pay1.de/client-api/js/v1/payone_hosted_min.js"></script>
                <input type="hidden" name="dynvalue[fcpo_kknumber]" value="">
                <input type="hidden" name="fcpo_cc_type" value="hosted">
				<ul class="form">
					<li>
                        <label for="cardtypeInput">[{ oxmultilang ident="FCPO_CREDITCARD" }]</label>
                        <select id="cardtype" name="dynvalue[fcpo_kktype]">
                            [{foreach from=$aFcPoCCPaymentMetaData item="oFcPoCCPaymentMetaData"}]
                                <option value="[{$oFcPoCCPaymentMetaData->sPaymentTag}]" [{ if $oFcPoCCPaymentMetaData->blSelected}]selected[{/if}]>[{$oFcPoCCPaymentMetaData->sPaymentName}]</option>
                            [{/foreach}]
                        </select>
                        [{foreach from=$aFcPoCCPaymentMetaData item="oFcPoCCPaymentMetaData"}]
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
				[{if $paymentmethod->oxpayments__oxlongdesc->value}]
					<div class="desc">
						[{ $paymentmethod->oxpayments__oxlongdesc->rawValue}]
					</div>
				[{/if}]
			</dd>
		</dl>
		<input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
    [{/if}]
[{elseif $sPaymentID == "fcpodebitnote"}]
	[{ assign var="dynvalue" value=$oView->getDynValue()}]
	<dl>
		<dt>
			<input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
			<label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}] [{ if $paymentmethod->fAddPaymentSum != 0 }]([{ $paymentmethod->fAddPaymentSum }] [{ $currency->sign}])[{/if}]</b></label>
		</dt>
		<dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
			<ul class="form">
				<li id="fcpo_elv_error">
					<div class="oxValidateError" style="display: block;padding: 0;">
						[{ oxmultilang ident="FCPO_ERROR" }]<div id="fcpo_elv_error_content"></div>
					</div>
				</li>
				<li id="fcpo_elv_error_blocked">
					<div class="oxValidateError" style="display: block;padding: 0;">
						[{ oxmultilang ident="FCPO_ERROR" }]
                        <div>[{ oxmultilang ident="FCPO_ERROR_BLOCKED" }]</div>
					</div>
				</li>
                
                <li>
                    <label>[{ oxmultilang ident="FCPO_BANK_COUNTRY" }]</label>
                    <select name="dynvalue[fcpo_elv_country]" onchange="fcCheckDebitCountry(this);return false;">
                        [{foreach from=$oView->fcpoGetDebitCountries() key=sCountryId item=sCountry}]
                            <option value="[{$sCountryId}]" [{ if $dynvalue.fcpo_elv_country == $sCountryId}]selected[{/if}]>[{$sCountry}]</option>
                        [{/foreach}]
                    </select>
                </li>
				<li>
					<label>[{ oxmultilang ident="FCPO_BANK_IBAN" }]</label>
                    <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_iban]" value="[{ $dynvalue.fcpo_elv_iban }]" onkeyup="fcHandleDebitInputs();return false;">
					<div id="fcpo_elv_iban_invalid" class="fcpo_check_error">
						<p class="oxValidateError" style="display: block;">
							[{ oxmultilang ident="FCPO_IBAN_INVALID" }]
						</p>
					</div>
				</li>
				<li>
					<label>[{ oxmultilang ident="FCPO_BANK_BIC" }]</label>
					<input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_bic]" value="[{ $dynvalue.fcpo_elv_bic }]" onkeyup="fcHandleDebitInputs();return false;">
					<div id="fcpo_elv_bic_invalid" class="fcpo_check_error">
						<p class="oxValidateError" style="display: block;">
							[{ oxmultilang ident="FCPO_BIC_INVALID" }]
						</p>
					</div>
				</li>
                [{if $oView->fcpoShowOldDebitFields()}]
                    <li id="fcpo_elv_ktonr" style="display: none;">
                        <div style="margin-top: 20px;margin-bottom:10px;">[{oxmultilang ident="FCPO_BANK_GER_OLD"}]</div>
                        <label>[{ oxmultilang ident="FCPO_BANK_ACCOUNT_NUMBER" }]</label>
                        <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_ktonr]" value="[{ $dynvalue.fcpo_elv_ktonr }]" onkeyup="fcHandleDebitInputs();return false;">
                        <div id="fcpo_elv_ktonr_invalid" class="fcpo_check_error">
                            <p class="oxValidateError" style="display: block;">
                                [{ oxmultilang ident="FCPO_KTONR_INVALID" }]
                            </p>
                        </div>
                    </li>
                    <li id="fcpo_elv_blz" style="display: none;">
                        <label>[{ oxmultilang ident="FCPO_BANK_CODE" }]</label>
                        <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_elv_blz]" value="[{ $dynvalue.fcpo_elv_blz }]" onkeyup="fcHandleDebitInputs();return false;">
                        <div id="fcpo_elv_blz_invalid" class="fcpo_check_error">
                            <p class="oxValidateError" style="display: block;">
                                [{ oxmultilang ident="FCPO_BLZ_INVALID" }]
                            </p>
                        </div>
                    </li>
                [{/if}]
			</ul>
			<input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
			[{if $paymentmethod->oxpayments__oxlongdesc->value}]
				<div class="desc">
					[{ $paymentmethod->oxpayments__oxlongdesc->rawValue}]
				</div>
			[{/if}]
		</dd>
	</dl>
[{elseif $sPaymentID == "fcpoonlineueberweisung"}]
	[{if $oView->hasPaymentMethodAvailableSubTypes('sb')}]
		[{ assign var="dynvalue" value=$oView->getDynValue()}]
		<dl>
			<dt>
				<input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
				<label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}] [{ if $paymentmethod->fAddPaymentSum != 0 }]([{ $paymentmethod->fAddPaymentSum }] [{ $currency->sign}])[{/if}]</b></label>
			</dt>
			<dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
				<ul class="form" style="width:400px;">
					<li id="fcpo_ou_error">
						<div class="oxValidateError" style="display: block;padding: 0;">
							[{ oxmultilang ident="FCPO_ERROR" }]<div id="fcpo_ou_error_content"></div>
						</div>
					</li>
					<li>
						<label>[{ oxmultilang ident="FCPO_ONLINE_UEBERWEISUNG_TYPE" }]</label>
						<select name="dynvalue[fcpo_sotype]" onchange="fcCheckOUType(this);return false;">
                            [{foreach from=$aFcPoOnlinePaymentMetaData item="oPaymentMetaData"}]
                                <option value="[{$oPaymentMetaData->sShortcut}]" [{ if $oPaymentMetaData->blSelected}]selected[{/if}]>[{$oPaymentMetaData->sCaption}]</option>
                            [{/foreach}]
						</select>
					</li>
                    <li id="fcpo_ou_iban">
                        <label>[{ oxmultilang ident="FCPO_BANK_IBAN" }]</label>
                        <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_iban]" value="[{ $dynvalue.fcpo_ou_iban }]">
                        <div id="fcpo_ou_iban_invalid" class="fcpo_check_error">
                            <p class="oxValidateError" style="display: block;">
                                [{ oxmultilang ident="FCPO_IBAN_INVALID" }]
                            </p>
                        </div>
                    </li>
                    <li id="fcpo_ou_bic">
                        <label>[{ oxmultilang ident="FCPO_BANK_BIC" }]</label>
                        <input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_bic]" value="[{ $dynvalue.fcpo_ou_bic }]">
                        <div id="fcpo_ou_bic_invalid" class="fcpo_check_error">
                            <p class="oxValidateError" style="display: block;">
                                [{ oxmultilang ident="FCPO_BIC_INVALID" }]
                            </p>
                        </div>
                    </li>
					<li id="fcpo_ou_blz">
						<label>[{ oxmultilang ident="FCPO_BANK_CODE" }]</label>
						<input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_blz]" value="[{ $dynvalue.fcpo_ou_blz }]">
						<div id="fcpo_ou_blz_invalid" class="fcpo_check_error">
							<p class="oxValidateError" style="display: block;">
								[{ oxmultilang ident="FCPO_BLZ_INVALID" }]
							</p>
						</div>
					</li>
					<li id="fcpo_ou_ktonr">
						<label>[{ oxmultilang ident="FCPO_BANK_ACCOUNT_NUMBER" }]</label>
						<input autocomplete="off" type="text" size="20" maxlength="64" name="dynvalue[fcpo_ou_ktonr]" value="[{ $dynvalue.fcpo_ou_ktonr }]">
						<div id="fcpo_ou_ktonr_invalid" class="fcpo_check_error">
							<p class="oxValidateError" style="display: block;">
								[{ oxmultilang ident="FCPO_KTONR_INVALID" }]
							</p>
						</div>
					</li>
					<li id="fcpo_ou_eps" style="display: none;width: 400px;">
						<label>[{ oxmultilang ident="FCPO_BANKGROUPTYPE" }]</label>
						<select name="dynvalue[fcpo_so_bankgrouptype_eps]">
							<option value="ARZ_OVB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_OVB"}]selected[{/if}]>Volksbanken</option>
							<option value="ARZ_BAF" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_BAF"}]selected[{/if}]>Bank f&uuml;r &Auml;rzte und Freie Berufe</option>
							<option value="ARZ_NLH" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_NLH"}]selected[{/if}]>Nieder&ouml;sterreichische Landes-Hypo</option>
							<option value="ARZ_VLH" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_VLH"}]selected[{/if}]>Vorarlberger Landes-Hypo</option>
							<option value="ARZ_BCS" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_BCS"}]selected[{/if}]>Bankhaus Carl Sp&auml;ngler & Co. AG</option>
							<option value="ARZ_HTB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_HTB"}]selected[{/if}]>Hypo Tirol</option>
							<option value="ARZ_HAA" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_HAA"}]selected[{/if}]>Hypo Alpe Adria</option>
							<option value="ARZ_IKB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_IKB"}]selected[{/if}]>Investkreditbank</option>
							<option value="ARZ_OAB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_OAB"}]selected[{/if}]>&Ouml;sterreichische Apothekerbank</option>
							<option value="ARZ_IMB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_IMB"}]selected[{/if}]>Immobank</option>
							<option value="ARZ_GRB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_GRB"}]selected[{/if}]>G&auml;rtnerbank</option>
							<option value="ARZ_HIB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "ARZ_HIB"}]selected[{/if}]>HYPO Investment</option>
							<option value="BA_AUS" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "BA_AUS"}]selected[{/if}]>Bank Austria</option>
							<option value="BAWAG_BWG" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "BAWAG_BWG"}]selected[{/if}]>BAWAG</option>
							<option value="BAWAG_PSK" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "BAWAG_PSK"}]selected[{/if}]>PSK Bank</option>
							<option value="BAWAG_ESY" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "BAWAG_ESY"}]selected[{/if}]>easybank</option>
							<option value="BAWAG_SPD" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "BAWAG_SPD"}]selected[{/if}]>Sparda Bank</option>
							<option value="SPARDAT_EBS" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "SPARDAT_EBS"}]selected[{/if}]>Erste Bank</option>
							<option value="SPARDAT_BBL" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "SPARDAT_BBL"}]selected[{/if}]>Bank Burgenland</option>
							<option value="RAC_RAC" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "RAC_RAC"}]selected[{/if}]>Raiffeisen</option>
							<option value="HRAC_OOS" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "HRAC_OOS"}]selected[{/if}]>Hypo Ober&ouml;sterreich</option>
							<option value="HRAC_SLB" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "HRAC_SLB"}]selected[{/if}]>Hypo Salzburg</option>
							<option value="HRAC_STM" [{ if $dynvalue.fcpo_so_bankgrouptype_eps == "HRAC_STM"}]selected[{/if}]>Hypo Steiermark</option>
						</select>
					</li>
					<li id="fcpo_ou_idl" style="display: none;">
						<label>[{ oxmultilang ident="FCPO_BANKGROUPTYPE" }]</label>
                        <select name="dynvalue[fcpo_so_bankgrouptype_idl]">
                            <option value="ABN_AMRO_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "ABN_AMRO_BANK"}]selected[{/if}]>ABN Amro</option>
                            <option value="BUNQ_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "BUNQ_BANK"}]selected[{/if}]>Bunq</option>
                            <option value="ING_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "ING_BANK"}]selected[{/if}]>ING Bank</option>
                            <option value="RABOBANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "RABOBANK"}]selected[{/if}]>Rabobank</option>
                            <option value="SNS_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "SNS_BANK"}]selected[{/if}]>SNS Bank</option>
                            <option value="ASN_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "ASN_BANK"}]selected[{/if}]>ASN Bank</option>
                            <option value="SNS_REGIO_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "SNS_REGIO_BANK"}]selected[{/if}]>Regio Bank</option>
                            <option value="TRIODOS_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "TRIODOS_BANK"}]selected[{/if}]>Triodos Bank</option>
                            <option value="KNAB_BANK" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "KNAB_BANK"}]selected[{/if}]>Knab</option>
                            <option value="VAN_LANSCHOT_BANKIERS" [{ if $dynvalue.fcpo_so_bankgrouptype_idl == "VAN_LANSCHOT_BANKIERS"}]selected[{/if}]>van Lanschot</option>
                        </select>
					</li>
				</ul>
				<input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
				[{if $paymentmethod->oxpayments__oxlongdesc->value}]
					<div class="desc">
						[{ $paymentmethod->oxpayments__oxlongdesc->rawValue}]
					</div>
				[{/if}]
			</dd>
		</dl>
	[{/if}]
[{elseif $sPaymentID == "fcpoklarna" || $sPaymentID == "fcpoklarna_installment"}]
	[{ assign var="dynvalue" value=$oView->getDynValue()}]
	<dl>
		<dt>
			<input id="payment_[{$sPaymentID}]" type="radio" name="paymentid" value="[{$sPaymentID}]" [{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]checked[{/if}]>
			<label for="payment_[{$sPaymentID}]"><b>[{ $paymentmethod->oxpayments__oxdesc->value}] [{ if $paymentmethod->fAddPaymentSum != 0 }]([{ $paymentmethod->fAddPaymentSum }] [{ $currency->sign}])[{/if}]</b></label>
		</dt>
		<dd class="[{if $oView->getCheckedPaymentId() == $paymentmethod->oxpayments__oxid->value}]activePayment[{/if}]">
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
                        <li style="width: 850px;">
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
                                <p class="oxValidateError" style="display: block;padding-left:32px;">
                                    [{ oxmultilang ident="FCPO_KLS_CAMPAIGN_INVALID" }]
                                </p>
                            </div>
                        </li>
                    [{/if}]
                    [{if $oView->fcpoKlarnaInfoNeeded()}]
                        <li style="width: 850px;">
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
                            <label>[{ oxmultilang ident="FCPO_KLV_TELEPHONENUMBER" }]</label>
                            <input autocomplete="off" type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_fon]" value="[{ $dynvalue.fcpo_klv_fon }]"[{else}]name="dynvalue[fcpo_kls_fon]" value="[{ $dynvalue.fcpo_kls_fon }]"[{/if}]>
                            <div [{if $blKlv}]id="fcpo_klv_fon_invalid"[{else}]id="fcpo_kls_fon_invalid"[{/if}] class="fcpo_check_error">
                                <p class="oxValidateError" style="display: block;">
                                    [{ oxmultilang ident="FCPO_KLV_TELEPHONENUMBER_INVALID" }]
                                </p>
                            </div>
                        </li>
                    [{/if}]
                    [{if $oView->fcpoKlarnaIsBirthdayNeeded()}]
                        <li style="width: 850px;">
                            <label>[{ oxmultilang ident="FCPO_KLV_BIRTHDAY" }]</label>
                            <input autocomplete="off" type="text" size="3" maxlength="2" style="width:auto;margin-right:10px;" [{if $blKlv}]name="dynvalue[fcpo_klv_birthday][day]" value="[{ $dynvalue.fcpo_klv_birthday.day }]"[{else}]name="dynvalue[fcpo_kls_birthday][day]" value="[{ $dynvalue.fcpo_kls_birthday.day }]"[{/if}] >
                            <input autocomplete="off" type="text" size="3" maxlength="2" style="width:auto;margin-right:10px;" [{if $blKlv}]name="dynvalue[fcpo_klv_birthday][month]" value="[{ $dynvalue.fcpo_klv_birthday.month }]"[{else}]name="dynvalue[fcpo_kls_birthday][month]" value="[{ $dynvalue.fcpo_kls_birthday.month }]"[{/if}]>
                            <input autocomplete="off" type="text" size="8" maxlength="4" style="width:auto;margin-right:10px;" [{if $blKlv}]name="dynvalue[fcpo_klv_birthday][year]" value="[{ $dynvalue.fcpo_klv_birthday.year }]"[{else}]name="dynvalue[fcpo_kls_birthday][year]" value="[{ $dynvalue.fcpo_kls_birthday.year }]"[{/if}]> (DD.MM.YYYY)
                            <div [{if $blKlv}]id="fcpo_klv_birthday_invalid"[{else}]id="fcpo_kls_birthday_invalid"[{/if}] class="fcpo_check_error">
                                <p class="oxValidateError" style="display: block;">
                                    [{ oxmultilang ident="FCPO_KLV_BIRTHDAY_INVALID" }]
                                </p>
                            </div>
                        </li>
                    [{/if}]
                    [{if $oView->fcpoKlarnaIsAddressAdditionNeeded()}]
                        <li>
                            <label>[{ oxmultilang ident="FCPO_KLV_ADDINFO" }]</label>
                            <input autocomplete="off" type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_addinfo]" value="[{ $dynvalue.fcpo_klv_addinfo }]"[{else}]name="dynvalue[fcpo_kls_addinfo]" value="[{ $dynvalue.fcpo_kls_addinfo }]"[{/if}]>
                            <div [{if $blKlv}]id="fcpo_klv_addinfo_invalid"[{else}]id="fcpo_kls_addinfo_invalid"[{/if}] class="fcpo_check_error">
                                <p class="oxValidateError" style="display: block;">
                                    [{ oxmultilang ident="FCPO_KLV_ADDINFO_INVALID" }]
                                </p>
                            </div>
                        </li>
                    [{/if}]
                    [{if $oView->fcpoKlarnaIsDelAddressAdditionNeeded()}]
                        <li>
                            <label>[{ oxmultilang ident="FCPO_KLV_ADDINFO_DEL" }]</label>
                            <input autocomplete="off" type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_del_addinfo]" value="[{ $dynvalue.fcpo_klv_del_addinfo }]"[{else}]name="dynvalue[fcpo_kls_del_addinfo]" value="[{ $dynvalue.fcpo_kls_del_addinfo }]"[{/if}]>
                            <div [{if $blKlv}]id="fcpo_klv_del_addinfo_invalid"[{else}]id="fcpo_kls_del_addinfo_invalid"[{/if}] class="fcpo_check_error">
                                <p class="oxValidateError" style="display: block;">
                                    [{ oxmultilang ident="FCPO_KLV_ADDINFO_INVALID" }]
                                </p>
                            </div>
                        </li>
                    [{/if}]
                    [{if $oView->fcpoKlarnaIsGenderNeeded()}]
                        <li>
                            <label>[{ oxmultilang ident="FCPO_KLV_SAL" }]</label>
                            [{if $blKlv}]
                                [{include file="form/fieldset/salutation.tpl" name="dynvalue[fcpo_klv_sal]" value=$dynvalue.fcpo_klv_sal }]
                            [{else}]
                                [{include file="form/fieldset/salutation.tpl" name="dynvalue[fcpo_kls_sal]" value=$dynvalue.fcpo_kls_sal }]
                            [{/if}]
                        </li>
                    [{/if}]
                    [{if $oView->fcpoKlarnaIsPersonalIdNeeded()}]
                        <li>
                            <label>[{ oxmultilang ident="FCPO_KLV_PERSONALID" }]</label>
                            <input autocomplete="off" type="text" size="20" maxlength="64" [{if $blKlv}]name="dynvalue[fcpo_klv_personalid]" value="[{ $dynvalue.fcpo_klv_personalid }]"[{else}]name="dynvalue[fcpo_kls_personalid]" value="[{ $dynvalue.fcpo_kls_personalid }]"[{/if}]>
                            <div [{if $blKlv}]id="fcpo_klv_personalid_invalid"[{else}]id="fcpo_kls_personalid_invalid"[{/if}] class="fcpo_check_error">
                                <p class="oxValidateError" style="display: block;">
                                    [{ oxmultilang ident="FCPO_KLV_PERSONALID_INVALID" }]
                                </p>
                            </div>
                        </li>
                    [{/if}]
                    <li style="width: 850px;">
                        [{if $oView->fcpoKlarnaInfoNeeded()}]
                            <br>
                        [{/if}]
                        <div style="float:left;width: 32px;">
                            [{if $blKlv}]
                                <input type="hidden"   name="dynvalue[fcpo_klv_confirm]" value="false">
                                <input type="checkbox" name="dynvalue[fcpo_klv_confirm]" value="true" [{if $dynvalue.fcpo_klv_confirm}]checked[{/if}]>
                            [{else}]
                                <input type="hidden"   name="dynvalue[fcpo_kls_confirm]" value="false">
                                <input type="checkbox" name="dynvalue[fcpo_kls_confirm]" value="true" [{if $dynvalue.fcpo_kls_confirm}]checked[{/if}]>
                            [{/if}]
                        </div>
                        <div style="float:left;width: 800px;">
                            [{$oView->fcpoGetConfirmationText()}]
                        </div>
                        <div style="clear:both;"></div>
                        <div [{if $blKlv}]id="fcpo_klv_confirmation_missing"[{else}]id="fcpo_kls_confirmation_missing"[{/if}] class="fcpo_check_error">
                            <p class="oxValidateError" style="display: block;padding-left:32px;">
                                [{ oxmultilang ident="FCPO_KLV_CONFIRMATION_MISSING" }]
                            </p>
                        </div>
                    </li>
                [{else}]
                    <li>[{oxmultilang ident="FCPO_KLS_NO_CAMPAIGN"}]</li>
                    <input type="hidden" name="fcpo_klarna_no_campaign" value="true">
                [{/if}]
			</ul>
			<input type="hidden" name="fcpo_mode_[{$sPaymentID}]" value="[{$paymentmethod->fcpoGetOperationMode()}]">
			[{if $paymentmethod->oxpayments__oxlongdesc->value}]
				<div class="desc">
					[{ $paymentmethod->oxpayments__oxlongdesc->rawValue}]
				</div>
			[{/if}]
		</dd>
	</dl>
[{else}]
    [{$smarty.block.parent}]
[{/if}]