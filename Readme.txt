/*
 * @package PAYONE FinanceGate
 * @author FATCHIP GmbH
 * @copyright (C) 2014, FATCHIP GmbH
 * 
 * This Software is the property of FATCHIP GmbH
 * and is protected by copyright law - it is NOT Freeware.
 *
 * Any unauthorized use of this software without a valid license
 * is a violation of the license agreement and will be
 * prosecuted by civil and criminal law.
 */

==Title==
PAYONE FinanceGate

==Author==
FATCHIP GmbH
www.fatchip.de

==Prefix==
fc

==Version==
2.0.5_5_5613
June 20 2016

==Link==
http://www.payone.de
http://shop.fatchip.de/OXID-PAYONE-FinanceGate-Connector.html

==Mail==
<a href="mailto:support@fatchip.de">support@fatchip.de</a>

==Requirements==
/

==Description==
The PAYONE-FinanceGate-Module offers more than 20 payment methods for your OXID-Shopsystem. Beside commonly used payment methods as 
Paypal, Sofortueberweisung.de or eight Creditcards there is also the possibility to offer secure paying via bill or debit.

==Extend==
void

==Installation==
Notice: 
1. Extract the module-package.
2. Copy the content of the folder "copy_this" into your shop root-folder (where config.inc.php lies).
3. Go to Extensions->Modules, select the "PAYONE FinanceGate" extension and press the "Activate" Button in the "Overview" tab.
4. Next you need to deposit a transaction url in the PAYONE-Webinterface at Konfiguration -> Zahlungsportale -> YOUR_PORTAL -> Erweitert -> TransactionStatus URL  .
The URL has to look like this:
http://->YOUR_SHOP<-/modules/fcPayOne/status.php
8. Empty "tmp" folder.
9. There is a new menu item in the OXID-Interface named PAYONE. Here you can set your merchant connect data.

==Update==

If you are updating from Version 1.52 or lower:

1. Deactivate the "Payone FinanceGate"
2. Delete the following files/folder from your server:
- SHOPROOT/application/controllers/admin/inc
- SHOPROOT/application/controllers/admin/fcpayone_admin.php
- SHOPROOT/application/controllers/admin/fcpayone_apilog.php
- SHOPROOT/application/controllers/admin/fcpayone_apilog_list.php
- SHOPROOT/application/controllers/admin/fcpayone_apilog_main.php
- SHOPROOT/application/controllers/admin/fcpayone_boni.php
- SHOPROOT/application/controllers/admin/fcpayone_boni_list.php
- SHOPROOT/application/controllers/admin/fcpayone_boni_main.php
- SHOPROOT/application/controllers/admin/fcpayone_common.php
- SHOPROOT/application/controllers/admin/fcpayone_list.php
- SHOPROOT/application/controllers/admin/fcpayone_log.php
- SHOPROOT/application/controllers/admin/fcpayone_log_list.php
- SHOPROOT/application/controllers/admin/fcpayone_main.php
- SHOPROOT/application/controllers/admin/fcpayone_order.php
- SHOPROOT/application/controllers/admin/fcpayone_protocol.php
- SHOPROOT/application/controllers/admin/fcpayone_status_forwarding.php
- SHOPROOT/application/controllers/admin/fcpayone_status_mapping.php
- SHOPROOT/application/controllers/admin/fcpayone_support.php
- SHOPROOT/application/controllers/admin/fcpayone_support_list.php
- SHOPROOT/application/controllers/admin/fcpayone_support_main.php

- SHOPROOT/modules/fcPayOne

- SHOPROOT/out/admin/img/certified_extension_100px.png
- SHOPROOT/out/admin/img/logoclaim.gif

3. Copy the content of "copy this" into your shop root-folder (where config.inc.php lies).
4. Activate the "Payone FinanceGate"


If you updating from version 2.x or higher:

1. Deactivate the "Payone FinanceGate"
2. Copy the content of "copy this" into your shop root-folder (where config.inc.php lies).
3. Activate the "Payone FinanceGate"


==Notice==
When you are using the creditcard iframe payment-method there is no transaction-id ( txid ) in the moment where the order is created.
The transaction-id will be filled in seconds later, when the first "TransactionStatus" from Payone comes in.
So when using pixi or another ERP where the transaction-id is needed, make sure to export the order only when the transaction-id is already there.