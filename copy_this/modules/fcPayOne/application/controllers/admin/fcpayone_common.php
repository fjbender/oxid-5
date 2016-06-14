<?php

/** 
 * PAYONE OXID Connector is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * PAYONE OXID Connector is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with PAYONE OXID Connector.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      http://www.payone.de
 * @copyright (C) Payone GmbH
 * @version   OXID eShop CE
 */
 

class fcpayone_common extends fcpayone_adminview {
    
    /**
     * Current class template name.
     * 
     * @var string
     */
    protected $_sThisTemplate = 'fcpayone_common.tpl';

    
    /**
     * Template getter returns payone connector version
     * 
     * @param void
     * @return string
     */
    public function fcpoGetVersion() {
       return  $this->_oFcpoHelper->fcpoGetModuleVersion();
    }
    
    
    /**
     * Template getter for Merchant ID
     * 
     * @param void
     * @return string
     */
    public function fcpoGetMerchantId() {
        $oConfig = $this->_oFcpoHelper->fcpoGetConfig();
        return $oConfig->getConfigParam( 'sFCPOMerchantID' );
    }


    /**
     * Template getter for integrator ID
     * 
     * @param void
     * @return string
     */
    public function fcpoGetIntegratorId() {
        return $this->getIntegratorId();
    }
    

    /**
     * Loads shop version and formats it in a certain way
     *
     * @return string
     */
    protected function getIntegratorId() {
        $sReturn = '';
        $sEdition = $this->getShopEdition();
        
        if($sEdition == 'CE') {
            $sReturn = '2027000';
        } else if($sEdition == 'PE') {
            $sReturn = '2028000';
        } else if($sEdition == 'EE') {
            $sReturn = '2029000';
        }
        
        return $sReturn;
    }
    
    
    /**
     * Returns current view identifier
     *
     * @return string
     */
    public function getViewId() {
        return 'dyn_fcpayone';
    }

}