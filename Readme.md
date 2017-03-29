# PAYONE FinanceGate
![license LGPL](https://img.shields.io/badge/license-LGPL-blue.svg)
[![GitHub issues](https://img.shields.io/github/issues/PAYONE-GmbH/oxid-5.svg)](https://github.com/PAYONE-GmbH/oxid-5/issues)

# PAYMENT FOR YOUR OXID-SHOP 
The Payone-FinanceGate-Module is already certified by OXID to guarantee faultless code quality and correct operation, but we are willing to do an even better job. The community here on Github is a great help for that and we are happy about your participation. Take a look at our released version and send us commits or other feedback to take care for the best possible solution.

## Important functions for OXID
*	Seamless integration in the checkout processes
*	Centralised administration within Oxid
*	The offered portfolio of payment options can be controlled depending on the consumer's credit rating
*	The payment extension is compatible with all OXID eShop editions of version 4: Community, Professional and Enterprise edition
*	Supports simplified PCI DSS conformity in accordance with SAQ A
*	Find all currently supported payment methods on www.payone.de/oxid

## More information
More information about OXID on https://www.payone.de/oxid or https://shop.fatchip.de/OXID-PAYONE-FinanceGate-Connector.html 

Videoguide: Installation and configuration (German): https://www.youtube.com/playlist?list=PLlzKa20PSzulrW3Yg7XmP3rkvDywe-DMe 

## Requirements
Installed OXID eShop > v4.7.0

## Installation
1.	Extract the module-package.
2.	Copy the content of the folder "copy_this" into your shop root-folder (where config.inc.php lies).
3.	Go to Extensions->Modules, select the "PAYONE FinanceGate" extension and press the "Activate" Button in the "Overview" tab.
4.	Next you need to deposit a transaction url in the PAYONE-Webinterface at Konfiguration -> Zahlungsportale -> YOUR_PORTAL -> Erweitert -> TransactionStatus URL. The URL has to look like this: http://->YOUR_SHOP<-/modules/fcPayOne/status.php
5.	Empty "tmp" folder.
6. 	There is a new menu item in the OXID-Interface named PAYONE. Here you can set your merchant connect data.

## Update
If you are updating from Version 1.52 or lower:
1.	Deactivate the "Payone FinanceGate"
2.	Delete the following files/folder from your server:
3.	SHOPROOT/application/controllers/admin/inc
4.	SHOPROOT/application/controllers/admin/fcpayone_admin.php
5.	SHOPROOT/application/controllers/admin/fcpayone_apilog.php
6.	SHOPROOT/application/controllers/admin/fcpayone_apilog_list.php
7.	SHOPROOT/application/controllers/admin/fcpayone_apilog_main.php
8.	SHOPROOT/application/controllers/admin/fcpayone_boni.php
9.	SHOPROOT/application/controllers/admin/fcpayone_boni_list.php
10.	SHOPROOT/application/controllers/admin/fcpayone_boni_main.php
11.	SHOPROOT/application/controllers/admin/fcpayone_common.php
12.	SHOPROOT/application/controllers/admin/fcpayone_list.php
13.	SHOPROOT/application/controllers/admin/fcpayone_log.php
14.	SHOPROOT/application/controllers/admin/fcpayone_log_list.php
15.	SHOPROOT/application/controllers/admin/fcpayone_main.php
16.	SHOPROOT/application/controllers/admin/fcpayone_order.php
17.	SHOPROOT/application/controllers/admin/fcpayone_protocol.php
18.	SHOPROOT/application/controllers/admin/fcpayone_status_forwarding.php
19.	SHOPROOT/application/controllers/admin/fcpayone_status_mapping.php
20.	SHOPROOT/application/controllers/admin/fcpayone_support.php
21.	SHOPROOT/application/controllers/admin/fcpayone_support_list.php
22.	SHOPROOT/application/controllers/admin/fcpayone_support_main.php
23.	SHOPROOT/modules/fcPayOne
24.	SHOPROOT/out/admin/img/certified_extension_100px.png
25.	SHOPROOT/out/admin/img/logoclaim.gif
26.	Copy the content of "copy this" into your shop root-folder (where config.inc.php lies).
27.	Activate the "Payone FinanceGate"

If you updating from version 2.x or higher:
1.	Deactivate the "Payone FinanceGate"
2.	Copy the content of "copy this" into your shop root-folder (where config.inc.php lies).
3.	Activate the "Payone FinanceGate"

## Notice
When you are using the creditcard iframe payment-method there is no transaction-id ( txid ) in the moment where the order is created. The transaction-id will be filled in seconds later, when the first "TransactionStatus" from Payone comes in. So when using pixi or another ERP where the transaction-id is needed, make sure to export the order only when the transaction-id is already there.

## About PAYONE
PAYONE provides business solutions for comprehensive automated processing of all payments in e-commerce. The payment service provider is part of the Sparkassen-Finanzgruppe and authorised as a credit institution by the German Federal Financial Supervisory Authority. PAYONE's service portfolio includes acceptance and processing for national and international payment methods, plus all payment services. Standardised interfaces and extensions allow simple integration into existing e-commerce and IT-systems whilst maintaining strict security standards.

PAYONE ranks amongst the 50 fastest-growing technology companies in Germany and serves over 4.00 e-commerce clients from a variety of sectors and countries, including well-known companies such as Immonet, Globetrotter Ausrüstung, HD PLUS, Fujitsu, Zalando, Hawesko, Sony Music and Hallhuber. PAYONE employs a workforce of over 150.
