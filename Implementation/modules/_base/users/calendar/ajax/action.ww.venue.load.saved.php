<?php
$objResponse = new xajaxResponse ( ) ;
$objResponse->addClear ( 'saved_worldwide_venue_body', 'innerHTML' ) ;

$objResponse->addScript ( "changevenueto('saved_worldwide')" ) ;

$aoVenuesList = new Warecorp_Venue_List();
$aoVenuesList->setOwnerId( $this->_page->_user->getId() );
$aoVenuesList->setType( 'worldwide' );
$aoVenuesList->setCategory($aParams['wc']);
$aoVenuesList->setLetter($aParams['wl']);
$aoVenuesList->setCurrentPage($aParams['wp']);
$aoVenuesList->setListSize(10);

$usedLetters = $aoVenuesList->getLettersList ( ) ;

for ( $i = 'A' ; $i != 'AA' ; $i ++ ) {
    $letters [ $i ] = array ( 'current' => $i == $aParams [ 'wl' ] ? true : false , 
                              'link'    => array_key_exists ( $i, $usedLetters ) ? true : false ) ;
}

$aoVenuesCategoriesList = new Warecorp_Venue_CategoryList();
$aoVenuesCategoriesList->returnAsAssoc();
$aoVenuesCategoriesList->setType( Warecorp_Venue_Enum_VenueType::WORLDWIDE );
$venue_categories = $aoVenuesCategoriesList->getList();
$venue_categories[0] = "[ CHOOSE CATEGORY ]";
ksort($venue_categories);

$this->view->categories               = $venue_categories;
$this->view->letters                  = $letters;
$this->view->countVenues              = $aoVenuesList->getCount();
$this->view->aSearches                = $aParams;
$this->view->event                    = array('venue_type' => 'worldwide');
$this->view->aoWorldwideVenuesList    = $aoVenuesList->getList();

$output = $this->view->getContents ( 'users/calendar/ww.venues.saved.index.tpl' ) ;
$objResponse->addAssign ( 'saved_worldwide_venue_body', 'innerHTML', $output ) ;


?>
