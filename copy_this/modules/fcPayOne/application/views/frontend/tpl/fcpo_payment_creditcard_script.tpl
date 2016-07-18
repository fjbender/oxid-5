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
            }[{if !$smarty.foreach.fcpoForeachSelectorFields.last}],[{/if}]
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