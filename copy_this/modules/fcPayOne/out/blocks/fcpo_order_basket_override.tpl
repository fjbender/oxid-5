[{$smarty.block.parent}]
[{assign var="payment" value=$oView->getPayment()}]
[{assign var="sMandateText" value=$payment->fcpoGetMandateText()}]
[{if $payment && method_exists($payment, 'fcpoGetMandateText') && $payment->fcpoGetMandateText() }]
    [{oxscript include=$oViewConf->fcpoGetModuleJsPath('fcPayOne.js')}]
    <style type="text/css">
        #fcpoSEPAMandateBox {
            margin-bottom: 35px;
            color: #515353;
        }        
        .fcpoSEPAMandate {
            overflow: scroll;
            border: 1px solid #ccc;
            padding: 10px;
            height: 200px;
            margin: 10px 0 10px 0;
        }
        .fcpoSEPAMandate P {
            margin: 0 0 18px;
        }
        .fcpoSEPAMandate DL {
            margin-bottom: 20px;
        }
        .fcpoSEPAMandate DT {
            float: left;
            font-weight: normal;
            width: 250px;
        }
        .fcpoSEPAMandate DD {
            margin-left: 10px;
            display: block;
        }
        .fcpoSEPAMandate DD, .fcpoSEPAMandate DT {
            line-height: 20px;
        }
        .fcpoSEPAMandateCheckbox LABEL {
            float: left;
            padding-right: 10px;
            display: block;
            margin-bottom: 5px;
        }
        .fcpoSEPAMandateCheckbox {
            [{if method_exists($oViewConf, 'getActiveTheme') && $oViewConf->getActiveTheme() == 'mobile'}]
                margin-bottom: 50px;
            [{else}]]
                margin-bottom: 20px;
            [{/if}]]
        }
    </style>
    <div id="fcpoSEPAMandate">
        [{if method_exists($oViewConf, 'getActiveTheme') && $oViewConf->getActiveTheme() == 'mobile'}]
            <h3 class="heading section-heading">
                <span>SEPA-Lastschrift</span>
            </h3>
        [{else}]
            <h3 class="section">
                <strong>SEPA-Lastschrift</strong>
            </h3>
        [{/if}]
        [{oxmultilang ident="FCPO_ORDER_MANDATE_INFOTEXT"}]
        <div class="fcpoSEPAMandate">
            [{$sMandateText}]
        </div>
        
        <div class="fcpoSEPAMandateCheckbox">
            <label style="float:left; padding-right:10px;" for="mandate_status" class="control-label">[{oxmultilang ident="FCPO_ORDER_MANDATE_CHECKBOX"}]</label>
            <input type="checkbox" onclick="fcpoHandleMandateCheckbox(this);">
            <div class="clear"></div>
        </div>
    </div>
[{/if}]