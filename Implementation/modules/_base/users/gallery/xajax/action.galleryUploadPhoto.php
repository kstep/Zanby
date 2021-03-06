<?php
Warecorp::addTranslation("/modules/users/gallery/xajax/action.galleryUploadPhoto.php.xml");

$objResponse = new xajaxResponse () ;
$gallery = Warecorp_Photo_Gallery_Factory::loadById($galleryId);

if ( $gallery->getId() !== null && 
     Warecorp_Photo_AccessManager_Factory::create()->canEditGallery($gallery, $this->currentUser, $this->_page->_user) ) {
    
    $form = new Warecorp_Form('uploadPhotosForm', 'post', $this->currentUser->getUserPath('galleryUploadPhotoDo'));
    $this->view->uploadPhotosForm = $form;
    $this->view->gallery = $gallery;    
    $content = $this->view->getContents('users/gallery/xajax.upload.photos.tpl');
    
    
    
    $popup_window = Warecorp_View_PopupWindow::getInstance();        
    $popup_window->content($content);
    $popup_window->title(Warecorp::t('Add photos to Gallery'));
    $popup_window->width(450)->height(350)->open($objResponse);
    
    $objResponse->addScript('turnOnSWFUpload();');
    
}
