<link type="text/css" rel="stylesheet" href="{$AppTheme->css}/yui-autocomplete.css" />
<script type="text/javascript" src="/js/yui/yahoo-dom-event/yahoo-dom-event.js"></script> 
<script type="text/javascript" src="/js/yui/connection/connection-min.js"></script> 
<script type="text/javascript" src="/js/yui/autocomplete/autocomplete-min.js"></script> 
{literal}
<style>
.yui-ac-bd {
	height: 150px; 
	overflow:auto;
}
#acCity .yui-ac-content .yui-ac-bd {
    background-color:#FFFFFF;
}
#acZip .yui-ac-content .yui-ac-bd {
    background-color:#FFFFFF;
}
</style> 
<script type="text/javascript">
	/**
	*
	*/
    var m_city_fCallBackToAutocomplete;
    var m_city_oParent;
    var m_city_sQuery;
	YAHOO.widget.DS_XAJAX_CITY = function() { this._init(); };
	YAHOO.widget.DS_XAJAX_CITY.prototype = new YAHOO.widget.DataSource();
	YAHOO.widget.DS_XAJAX_CITY.prototype.doQuery = function(oCallbackFn, sQuery, oParent) { doQueryXajaxCity(oCallbackFn, oParent, sQuery); return; }
    function doQueryXajaxCity(fCallBack, oParent, sQuery)
    {
        m_city_fCallBackToAutocomplete 	= fCallBack;
        m_city_oParent 					= oParent;
        m_city_sQuery 					= sQuery;
		var country = YAHOO.util.Dom.get('countryId');
		country = country.options[country.selectedIndex].value;
        xajax_autoCompleteCity(country, decodeURIComponent(sQuery), "autocompleteCallbackCity");
    }                           
    function autocompleteCallbackCity(sResponse)  {
        if (sResponse.constructor != Array) sResponse = new Array();
        m_city_fCallBackToAutocomplete(m_city_sQuery, sResponse, m_city_oParent);
    }
	var itemCitySelectHandler = function(sType, aArgs) {
		YAHOO.util.Dom.get('acCity').style.display = 'none';
	};
	var containerCityCollapseEvent = function(oSelf) {
		YAHOO.util.Dom.get('acCity').style.display = '';
	}
    var myDataSourceCity = new YAHOO.widget.DS_XAJAX_CITY();
	function initCityAutocomplete() {
		var cityAutoComp = new YAHOO.widget.AutoComplete("city", "acCity", myDataSourceCity);
		cityAutoComp.maxResultsDisplayed 	= 1000;
		cityAutoComp.minQueryLength 		= 1;
        cityAutoComp.animSpeed				= 0.01;        
		cityAutoComp.itemSelectEvent.subscribe(itemCitySelectHandler);
		cityAutoComp.containerCollapseEvent.subscribe(containerCityCollapseEvent);
	}
	/**
	*
	*/
    var m_zip_fCallBackToAutocomplete;
    var m_zip_oParent;
    var m_zip_sQuery;
	YAHOO.widget.DS_XAJAX_ZIP = function() { this._init(); };
	YAHOO.widget.DS_XAJAX_ZIP.prototype = new YAHOO.widget.DataSource();
	YAHOO.widget.DS_XAJAX_ZIP.prototype.doQuery = function(oCallbackFn, sQuery, oParent) { doQueryXajaxZip(oCallbackFn, oParent, sQuery); return; }
    function doQueryXajaxZip(fCallBack, oParent, sQuery)
    {
        m_zip_fCallBackToAutocomplete 	= fCallBack;
        m_zip_oParent 					= oParent;
        m_zip_sQuery 					= sQuery;
		var country = YAHOO.util.Dom.get('countryId');
		country = country.options[country.selectedIndex].value;
        xajax_autoCompleteZip(country, decodeURIComponent(sQuery), "autocompleteCallbackZip");
    }                           
    function autocompleteCallbackZip(sResponse)  {
        if (sResponse.constructor != Array) sResponse = new Array();
        m_zip_fCallBackToAutocomplete(m_zip_sQuery, sResponse, m_zip_oParent);
    }
	var itemZipSelectHandler = function(sType, aArgs) {
		YAHOO.util.Dom.get('acZip').style.display = 'none';
	};
	var containerZipCollapseEvent = function(oSelf) {
		YAHOO.util.Dom.get('acZip').style.display = '';
	}
    var myDataSourceZip = new YAHOO.widget.DS_XAJAX_ZIP();
	function initZipAutocomplete() {
		var zipAutoComp = new YAHOO.widget.AutoComplete("zipId", "acZip", myDataSourceZip);
		zipAutoComp.maxResultsDisplayed 	= 1000;
		zipAutoComp.minQueryLength 			= 3; 
        zipAutoComp.animSpeed				= 0.01;
		zipAutoComp.itemSelectEvent.subscribe(itemZipSelectHandler);
		zipAutoComp.containerCollapseEvent.subscribe(containerZipCollapseEvent);
	}

	YAHOO.util.Event.onDOMReady(initCityAutocomplete);
	YAHOO.util.Event.onDOMReady(initZipAutocomplete);
</script>
{/literal}


		<h2>{t}Group Members{/t}</h2>
		
		<!-- Toggled area start -->
			<div class="prDropBoxInner">
				
				<h2>{t}Step 1: Group Category and Location{/t}</h2>
				
				<div>
				 
					{form from=$form} 
					 
					<table class="prForm">
						<col width="40%" />
						<col width="40%" />
						<col width="20%" />					
						<thead>
							<tr><th colspan="3" class="prText5">{t}Fields marked with asterisk <span class="prMarkRequired">*</span> are required.{/t}</th></tr>
							<tr><th colspan="3" class="prNoPadding">{form_errors_summary}</th></tr>
						</thead>
						<tbody>
							<tr>
								<td class="prTRight"><span class="prMarkRequired">*</span> <label for="categoryId">{t}Group Category:{/t}</label></td>
								<td>{form_select name="categoryId" style="width:180px;" selected=$group.categoryId options=$categories}</td>
								<td>&#160;</td>
							</tr>                     
							<tr>
								<td class="prTRight"><span class="prMarkRequired">*</span>
									<label for="countryId">{t}Country:{/t}</label>
								</td>
								<td>
									{form_select id="countryId" name="countryId" style="width:180px;" selected=$group.countryId options=$countries onchange="xajax_detectCountry(this.options[this.selectedIndex].value);"}
								</td>
								<td>&#160;</td>
							</tr>                     
							{* CHANGES FOR LOCATIONS START *}
							<tr id="LocationTrZip" {if !$group.countryId || ($group.countryId != 1 && $group.countryId != 38)}style="display:none;"{/if}>
								<td class="prTRight"><span class="prMarkRequired">*</span>
									<label for="zipId">{t}Zip code:{/t}</label></td>
								<td>
									<div class=" yui-skin-sam">
										<div class="yui-ac">
											{form_text name="zipcode" id="zipId"  value=$group.zipcode|escape:"html" style="width: 174px;"}
											<div id="acZip"></div>
										</div>
									</div>
								</td>
								<td>&#160;</td>
							</tr>
							<tr id="LocationTrCity" {if !$group.countryId || $group.countryId == 1 || $group.countryId == 38}style="display:none;"{/if}>					
								<td class="prTRight"><span class="prMarkRequired">*</span> <label for="city">{t}City:{/t}</label></td>
								<td>
									<div class=" yui-skin-sam">
										<div class="yui-ac">
											{form_text name="city" id="city"  value=$group.city|escape:"html" style="width: 174px;"}
											<div id="acCity"></div>
										</div>
									</div>
								</td>
								<td>&#160;</td>
							</tr>
								{* CHANGES FOR LOCATIONS END *}
							<tr>
								<td>&nbsp;</td>  
								<td>&#160;</td>             
								<td class="prTRight">
										{t var="in_submit"}Continue{/t}
										{form_submit name="Continue" value=$in_submit}
								</td>
							</tr>
				   		</table>       
				   {/form} 
				</div>
			</div>		<!-- Toggled area end -->