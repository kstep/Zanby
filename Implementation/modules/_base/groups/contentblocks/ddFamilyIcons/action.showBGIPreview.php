<?php
Warecorp::addTranslation('/modules/groups/contentblocks/ddFamilyIcons/action.showBGIPreview.php.xml');

$objResponse = new xajaxResponse();

$objResponse->addAssign("a_image_preview","src", strip_tags($url));
$objResponse->addAssign("a_image_preview","name", strip_tags($id));
$objResponse->addAssign("a_image_preview_title","innerHTML", strip_tags($title));