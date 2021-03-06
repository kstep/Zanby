<?php

/**
 * Smarty form function for element <input type=text>
 *
 * @param array $params
 * @param object $smarty
 * @return string
 * @author Ivan Meleshko
 * @author Dmitry Kostikov
 */
function smarty_function_form_password($params, &$smarty)
{
	Warecorp::addTranslation('/plugins/function.form_password.php.xml');
    // form object verify
    if (!isset($smarty->_tpl_vars['wf_form_object'])) return Warecorp::t('Form object not found.');
    $form = $smarty->_tpl_vars['wf_form_object'];

    // element name verify
    if (!isset($params['name'])) return Warecorp::t('Name for field not found.');
	
	// set element id
	if (!isset($params['id'])) $params['id'] = $params['name'];
	
    // element default value
    if (isset($form->_defaults[$params['name']]))
        $params['value'] = $form->_defaults[$params['name']];
    
    $rules = $form->getRules();
    if (!empty($rules)){
        if (isset($rules[$params['name']])){
            foreach ($rules[$params['name']] as $k => $rule){
                if ($rule['error'] == 1) {
                    $params['class'] = 'prFormErrors';
                }
            }
        }
    }

    $content = '<input type="password"';
    foreach ($params as $k => &$v) $content .= ' '.$k.'="'.$v.'"';
    $content .= ' />';

    return $content;
}