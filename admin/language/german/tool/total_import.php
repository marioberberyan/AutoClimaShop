<?php
#####################################################################################
#  Module Total Import PRO for Opencart 2.0.0 From HostJars opencart.hostjars.com 	#
#####################################################################################

// Step 5 Tables
$_['table_products'] 		= 'Products';
$_['table_categories'] 		= 'Kategorien';
$_['table_manufacturers'] 	= 'Hersteller';
$_['table_attributes'] 		= 'Eigenschaften';
$_['table_options'] 		= 'Optionen';
$_['table_downloads'] 		= 'Downloads';
$_['table_filters'] 		= 'Filter';

// Heading
$_['heading_title']    	= 'Total Import PRO';

// Tabs
$_['tab_fetch'] 		= 'Schritt 1: Fetch-Feed Datei';
$_['tab_global'] 		= 'Schritt 2: Globale Einstellungen';
$_['tab_adjust'] 		= 'Schritt 3: Stellen Sie Daten importieren';
$_['tab_mapping'] 		= 'Schritt 4: Feld zu ordnung';
$_['tab_import'] 		= 'Schritt 5: Importieren';
$_['tab_log'] 		    = 'Import Einloggen';

$_['button_fetch'] 		    = 'Fetch Feed';
$_['button_global'] 		= 'Globale Einstellungen';
$_['button_adjust'] 		= 'Stellen Sie Daten importieren';
$_['button_mapping'] 		= 'Field Mapping';
$_['button_import'] 		= 'Import';

$_['tooltip_fetch']         = 'Fetch Ihr Produkt Futtermittel';
$_['tooltip_global'] 		= 'Konfigurieren Sie die globalen Einstellungen für neue Produkte';
$_['tooltip_adjust'] 		= 'Stellen Sie Ihre Daten importieren';
$_['tooltip_mapping'] 		= 'Karte Felder aus Ihrer Produktzufuhr zu OpenCart Felder';
$_['tooltip_import'] 		= 'Führen Sie Ihre Import';

// Text
$_['text_load_profile'] 			= 'Einstellungen laden Profil:';
$_['text_profile_help']				= 'Verwenden Sie Profile importieren, um Ihre Importeinstellungen zu speichern';
$_['text_profile_default']			= 'Wählen Sie ein Profil zu laden';
$_['text_home_help']         		= 'Sie können die Schaltflächen unten, um auf die Schritte, die Sie benötigen zu überspringen. Sie müssen in der Regel laufen zumindest die Schritte 1 und 5. Wenn Sie dieses Modul zum ersten Mal, sollten Sie alle Schritte in der Reihenfolge von Schritt 1 ausgeführt';
$_['text_settings_loaded']          = 'Einstellungen erfolgreich geladen: ';
$_['text_deleted_profile']          = "Success: Gelöschte Profil '%s'";
$_['text_add']     					= 'Hinzufügen';
$_['text_reset']     				= 'Rücksetzen';
$_['text_update']     				= 'Hinzufügen / aktualisieren';
$_['text_adjust_help']     			= 'Wenn Sie alle Daten aus Ihren Feed vor dem Import anpassen müssen, können Sie die Operationen unten auf den Feldern in Ihrer Datenbank verwenden. Sie können auch verlassen Sie diesen Bildschirm öffnen und verwenden phpmyadmin direkt stellen Sie die Datenbanktabelle hj_import und dann hierher zurückkehren, um den Import abzuschließen.';
$_['text_operation']     			= 'Operation';
$_['text_operation_field_name'] 	= 'Field';
$_['text_operation_data'] 			= 'Daten';
$_['text_sample'] 					= 'Feed Sample';
$_['text_select_operation']			= '-- Operation wählen --';
$_['text_select']					= '-- Wählen Sie --';
$_['text_operation_type']			= 'Operation Typ';
$_['text_operation_desc']			= 'Beschreibung';
$_['text_most_popular']				= 'Bestseller';
$_['text_advanced']					= 'Erweitert';
$_['text_more']						= 'Mehr';

// Entry
$_['entry_basic_authentication'] 	= 'Verwenden Sie Standardauthentifizierung:';
$_['entry_import_file']     		= 'Import-Feed Datei:';
$_['entry_feed_source']				= 'Feed Source:';
$_['entry_file_upload']				= 'Datei-Upload';
$_['entry_file_system']				= 'Dateisystem';
$_['entry_feed_format']     		= 'Feed-Format:';
$_['entry_max_file_size']     		= 'Maximale Größe: %d mb';
$_['entry_import_url']    	 		= 'Import Feed URL:';
$_['entry_import_ftp'] 				= 'Import Feed FTP:';
$_['entry_ftp_server'] 				= 'FTP Server:';
$_['entry_ftp_user'] 				= 'Benutzername:';
$_['entry_auth_user'] 				= 'Benutzername:';
$_['entry_ftp_pass'] 				= 'Passwort:';
$_['entry_auth_pass'] 				= 'Passwort:';
$_['entry_ftp_path'] 				= 'absolute Pfad zur Datei:';
$_['entry_import_filepath']    		= 'Import-Feed lokalen Dateipfad:';
$_['entry_xml_product_tag']     	= 'XML Product Tag:';
$_['entry_delimiter']  				= 'CSV Feldtrennzeichen:';
$_['entry_data_feed']  				= 'CSV-Daten-Feed:';
$_['entry_out_of_stock']  			= 'Ausverkauft Statu:';
$_['entry_weight_class']  			= 'Gewichtsklasse:';
$_['entry_length_class']  			= 'Länge Klasse:';
$_['entry_customer_group']  		= 'Kundengruppe:';
$_['entry_tax_class']  				= 'Steuerklasse:';
$_['entry_subtract_stock']  		= 'Subtrahieren Lager:';
$_['entry_requires_shipping']  		= 'Benötigt Versand:';
$_['entry_minimum_quantity'] 	 	= 'Mindestbestellmenge:';
$_['entry_product_status']  		= 'Produkt Status:';
$_['entry_language']  				= 'Sprache:';
$_['entry_store']  	   				= 'Store:';
$_['entry_remote_images']  	   		= 'Download von Remote Images:';
$_['entry_remote_images_warning']  	= 'Warnung: Dies wird wahrscheinlich für Produkt Timeout-Feeds größer als rund 500 Produkte.';
$_['entry_image_subfolder']	   		= 'Bild Unterordner:';
$_['entry_ignore_fields'] 			= 'Überspringen Produkte Wo:';
$_['entry_field_mapping']			= 'Field Mapping:';
$_['entry_import_type']				= 'Import Type:';
$_['entry_price_multiplier']		= 'Preismultiplikator:';
$_['entry_image_remove']			= 'Bild entfernen Text:';
$_['entry_image_prepend']			= 'Bild Anfügen von Text:';
$_['entry_image_append']			= 'Bild anhängen Text:';
$_['entry_split_category']			= 'Kategorie Trennzeichen:';
$_['entry_split_related']			= 'Verwandte Produkte Trennzeichen:';
$_['entry_top_categories']			= 'Hinzufügen den Kategorien Top Bar';
$_['entry_bottom_category']			= 'Fügen Sie Produkte zu:';
$_['entry_new_items'] 				= 'Neuzugänge:';
$_['entry_existing_items'] 			= 'Vorhandene Elemente:';
$_['entry_delete_diff'] 			= 'Angebote im Shop, aber nicht in der Datei:';
$_['entry_reset'] 					= 'Wählen Sie die Tabellen zurück:';
$_['entry_file_encoding']     		= 'Dateikodierung:';
$_['entry_first_row_is_headings']	= 'Erste Zeile Rubriken:';
$_['entry_use_safe_headings']		= 'Use Safe Rubriken:';
$_['entry_use_safe_headings_help']	= 'ignorieren die Vorschub \' s Position';
$_['entry_unzip_feed']				= 'Entpacken Feed:';
$_['entry_file_encoding']			= 'Dateikodierung:';
$_['entry_file_encoding_help']		= 'Wenn Sie unsicher sind, verwenden Sie UTF-8:';
$_['entry_required']				= 'Erforderlich';
$_['entry_advanced']				= 'Advanced (optionale Einstellungen)';
$_['entry_yes']						= 'Ja';
$_['entry_no']						= 'Nein';
$_['entry_none_wide']				= '--- Keine ---';
$_['entry_all_categories']			= 'Alle Kategorien';
$_['entry_bottom_category_only']	= 'Bottom Kategorie Nur';
$_['entry_related_field']			= 'Verwandte Produkte Field:';
$_['entry_none'] 					= 'Keine';
$_['entry_add'] 					= 'Add';
$_['entry_skip'] 					= 'Überspringen';
$_['entry_update'] 					= 'Update';
$_['entry_ignore'] 					= 'Ignorieren';
$_['entry_delete'] 					= 'Löschen';
$_['entry_disable'] 				= 'Deaktivieren';
$_['entry_zero_quantity']			= 'Menge auf Null';
$_['entry_import_range'] 			= 'Elemente für Import:';
$_['entry_to'] 						= 'auf';
$_['entry_from'] 					= 'Von der Produkt';
$_['entry_import_range_help']		= 'Import nur einen Teil Ihrer Produktzufuhr zB: Von 1 bis 100 werden die ersten 100 Artikel im Datei importieren';
$_['entry_range'] 					= 'Range';
$_['entry_all'] 					= 'Alle';
$_['entry_simple'] 					= 'Einfache Lizenz aktualisieren';
$_['entry_simple_fields']			= 'Einfache Fields';
$_['entry_simple_matching']			= 'Passende Feld';
$_['entry_cron_fetch']				= 'Cron Fetch';
$_['entry_cron_fetch_help']			= 'Holt das erste Element in Ihren Feed, um die Einstellungen zu konfigurieren. Diese Option ist zu empfehlen für große Produkt-Feeds.';


// Fields
$_['text_field_oc_title']	 		= 'OpenCart Field';
$_['text_field_feed_title']	 		= 'Feed Field';
$_['text_field_name']     			= 'Name';
$_['text_field_price']     			= 'Preis';
$_['text_field_special_price']     	= 'Sonderpreis';
$_['text_field_discount_price']    	= 'Angebotspreis';
$_['text_field_id']					= 'PRODUKT ID';
$_['text_field_model']    	 		= 'MODEL';
$_['text_field_sku']     			= 'SKU';
$_['text_field_upc']     			= 'UPC';
$_['text_field_ean']     			= 'EAN';
$_['text_field_jan']     			= 'JAN';
$_['text_field_isbn']     			= 'ISBN';
$_['text_field_mpn']     			= 'MPN';
$_['text_field_points']     		= 'Punkte';
$_['text_field_manufacturer']     	= 'Hersteller';
$_['text_field_attribute']     		= 'Attribut';
$_['text_field_category']     		= 'Kategorie';
$_['text_field_filter']				= 'Filter';
$_['text_field_related']			= 'Verwandte Produkte';
$_['text_field_quantity']     		= 'Menge';
$_['text_field_image']     			= 'Bild';
$_['text_field_additional_image']   = 'Zusätzliches Bild';
$_['text_field_description']     	= 'Beschreibung';
$_['text_field_meta_title']     	= 'Meta Titel';
$_['text_field_meta_desc']     		= 'Meta Description';
$_['text_field_meta_keyw']     		= 'Meta Keywords';
$_['text_field_weight']     		= 'Gewicht';
$_['text_field_length']     		= 'Länge';
$_['text_field_height']     		= 'Höhe';
$_['text_field_width']     			= 'Breite';
$_['text_field_location']    	 	= 'Ort';
$_['text_field_keyword']     		= 'SEO Keyword';
$_['text_field_stock_status']       = 'Out Of Stock Status';
$_['text_field_tags']     			= 'Produktschlag';
$_['text_field_sort_order']			= 'Sortierung';
$_['text_field_option']				= 'Options';
$_['text_field_reward']				= 'Reward Points';
$_['text_field_related']	= 'Verwandte Produkte';
$_['text_field_subtract_stock']		= 'Subtrahieren Lizenz';
$_['text_field_requires_shipping']	= 'Benötigt Shipping';
$_['text_field_minimum_quantity']	= 'Mindestbestellmenge ist';
$_['text_field_product_status']		= 'Produktstatus';
$_['text_field_product_reward_group'] = 'Reward Gruppe';
$_['text_field_layout']				= 'Layout';
$_['text_field_download']			= 'Download';
$_['text_mapping_description']		= 'Das Feld Spalte OpenCart enthält den Namen des Feldes in OpenCart ist der Vorschub Feld, in dem Sie auf die Überschrift Name der Spalte, die Sie importieren, um jeden OpenCart Feld ein eingeben müssen. Sie können jedes Feld auf "None" gesetzt, wenn Sie nichts dort zu importieren. Keiner der Felder sind Pflichtfelder, aber je mehr Sie desto besser sind Ihre Import werden bieten..';
$_['text_feed_sample'] 				= 'Beispiel aus Ihrem Feed';
$_['text_save_profile'] 			= 'Geben Sie einen Namen, um ein neues Profil zu speichern Einstellungen: ';
$_['text_identify_existing'] 		= 'Identifizieren Bestehende Produkte Passende Feld: ';
$_['text_documentation'] 			= 'Dokumentation';

// Import
$_['button_import']	   			= 'Import';
$_['button_next']	   			= 'Speichern & amp; Weiter';
$_['button_skip']	   			= 'Direkt';
$_['button_save'] 	   			= 'Speichern';
$_['button_cancel']	   			= 'Abbrechen';
$_['button_add_operation']	   	= 'Operation hinzufügen';
$_['button_load']	 		  	= 'Laden';
$_['button_delete']	 		  	= 'Löschen';


// Success
$_['text_success_step1']   		= 'Erfolgs: Füttern abgerufen und analysiert. Bereit für den Import:% s;';
$_['text_success_step1_csv']    = 'Ungültige CSV Zeilen:% s';
$_['warning_invalid_rows'] 		= 'Ungültige CSV Reihen zeigen, dass die Anzahl der Spalten in dieser Zeile didn \' t die Ihrer Kopfzeile.';
$_['text_success_step2']     	= 'Der Erfolg:. Globale Einstellungen gespeichert.';
$_['text_success_step3']     	= 'Der Erfolg:. Operationen gespeichert.';
$_['text_success_step4']     	= 'Der Erfolg:. Zuordnungen gespeichert.';
$_['text_success_step5']     	= 'Der Erfolg: Hinzugefügt% s Produkte, aktualisiert% s Produkte';
$_['text_success']     			= 'Der Erfolg: Einstellungen gespeichert';

// Error
$_['error_permission'] 			= 'Achtung: Sie haben keine Berechtigung zur total Import ändern!';
$_['error_empty']      			= 'Achtung: Keine Datei, leere Datei, oder schlecht Authentifizierung!';
$_['error_mac_csv']      		= 'Achtung: CSV-Datei enthält nur eine Zeile: Wenn Sie Ihre CSV-Datei mit Mac zu erstellen, müssen Sie es als speichern "CSV (Windows)"!';
$_['error_wrong_delimiter']    	= 'Achtung: Der von Ihnen gewählte Trennzeichen scheint nicht richtig zu sein!';
$_['error_csv_heading'] 		= "Achtung: Ihre Überschriften für die direkte Verwendung geeignet überprüfen Sie bitte jede Spalte nicht hat einen% s Rubrik oder nutzen Sie sichere Überschriften!";
$_['error_xml_product_tag']		= 'Achtung: Sie müssen eine Größe und Tag für XML-Dateien angeben!!';
$_['error_xml_format']			= 'Achtung: XML-Format Fehler - bitte fixieren Sie Ihre XML-Datei!';
$_['error_no_db'] 				= 'Achtung: Schritt 1 korrekt, bevor Sie abgeschlossen werden!';
$_['error_file_source']         = 'Achtung: Der angegebene Dateipfad nicht vorhanden ist';
$_['error_ftp_source']          = 'Achtung: Überprüfen Sie Ihre FTP-Details werden eingestellt;';
$_['error_upload_exceeds_dir']		= 'Die hochgeladene Datei überschreitet upload_max_filesize in der php.ini zu sterben;';
$_['error_upload_exceeds_max'] 		= 'Die Datei überschreitet hochgeladene sterben MAX_FILE_SIZE richtlinie, sterben im HTML-Formular Informationen angegeben Wurde';
$_['error_upload_partial']			= 'Die Datei Würde Nur Teilweise Hochgeladen';
$_['error_upload_no_file'] 			= 'Es wurde keine Datei Hochgeladen';
$_['error_upload_missing'] 			= 'Fehlende EINEN Temporären Ordner';
$_['error_upload_failed_to_write'] 	= 'Könnte sterben Datei auf Festplatte zu schreiben sterben';
$_['error_upload_stopped'] 			= 'Datei-Upload DURCH Erweiterung gestoppt';
$_['error_timeout_reached']			= 'Ihre Import Würde Nicht Abgeschlossen, wie ihr Server \' s Maximale Ausführung% ss war ungenügend. <a alt="How do I fix this?" href="http://helpdesk.hostjars.com/entries/21903992-Fatal-error-Maximum-execution-time-of-30-seconds-exceeded">How Kann ich of this Problem beheben?</a>';
$_['error_invalid_operation']       = '"-- Choose --" is a ungültiges Feld, choose Bitte ein vorhandenes Feld aus Ihrem Feed';

// Log
$_['log_level_warning'] 			= 'ACHTUNG';
$_['log_level_info'] 				= 'INFO';

// Operations Text
$_['operation_multiply_price']			= 'Anpassen Preis (Multiply)';
$_['operation_multiply']				= 'Multiply';
$_['operation_by']						= 'durch';
$_['operation_add_price']				= 'Anpassen Preis (Hinzufügen)';
$_['operation_add']						= 'Add';
$_['operation_to']						= 'zu';
$_['operation_split_fields_category']	= 'Split Kategorie auf Trennzeichen';
$_['operation_split']					= 'Split';
$_['operation_on']						= 'auf';
$_['operation_append_image']			= 'Fügen Sie Text dem Bild';
$_['operation_append']					= 'Anhängen';
$_['operation_after']					= 'nach';
$_['operation_prepend_image']			= 'Voranstellen Text dem Bild';
$_['operation_prepend']					= 'Voranstellen';
$_['operation_append_text']				= 'Fügen Sie Text, um Willkürliches Feld';
$_['operation_prepend_text']			= 'Voranstellen Text auf ein beliebiges Feld';
$_['operation_multiply_field']			= 'Multiplizieren Sie alle Felder';
$_['operation_add_field']				= 'Zu jedem Feld hinzufügen';
$_['operation_split_fields']			= 'Split Willkürliches Feld';
$_['operation_replace_text']			= 'Text ersetzen';
$_['operation_replace']					= 'Ersetzen';
$_['operation_with']					= 'mit';
$_['operation_in']						= 'in';
$_['operation_remove_text']				= 'Entfernen Text';
$_['operation_remove']					= 'Entfernen';
$_['operation_delete_row_equals']		= 'Filter Products (gleich)';
$_['operation_delete_row_not_equal']	= 'Filter Products (nicht gleich)';
$_['operation_delete_row_containing']	= 'Filter Products (enthalten)';
$_['operation_delete_row_not_containing']	= 'Filter Products (nicht enthalten)';
$_['operation_exclude_products']		= 'Produkte, bei denen Ausschließen';
$_['operation_equals']					= 'gleich';
$_['operation_does_not_equal']			= 'entspricht nicht';
$_['operation_contains']				= 'enthält';
$_['operation_does_not_contain']		= 'enthält nicht';
$_['operation_duplicate_feed']			= 'Clone field';
$_['operation_duplicate']				= 'Duplizieren';
$_['operation_merge_columns']			= 'Anhängen Feld zu Feld';
$_['operation_separated_by']			= 'getrennt durch';
$_['operation_merge_rows']				= 'Merge mehrreihigen Produkte';
$_['operation_common_field']			= 'Gemeinsamer Bereich';
$_['operation_merge_the_following']		= 'Führen Sie die folgenden Felder aus';
$_['operation_replace_newlines']		= 'Convert Zeilenumbrüche in HTML';
$_['operation_custom_column']			= 'Erstellen von benutzerdefinierten Spalte';
$_['operation_column_name']				= 'New Spaltenname:';
$_['operation_column_value']			= 'Neue Spalte Wert:';


//Operations Labels
$_['operation_label_most_popular']	= 'Am beliebtesten';
$_['operation_label_advanced']	= 'Fortgeschritten';

?>