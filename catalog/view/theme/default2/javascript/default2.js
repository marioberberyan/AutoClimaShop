/**
 * @package     default2 Theme
 * @author      EchoThemes, http://www.echothemes.com
 * @copyright   Copyright (c) 2015, EchoThemes
 * @license     GPLv3 or later, http://www.gnu.org/licenses/gpl-3.0.html
 */

$(document).ready(function()
{
  //=== OpenCart
  // Main Menu
  adjustMegamenu();

  /* Portable Search */
  $('.js-button-search').on('click', function() {
    url = $('base').attr('href') + 'index.php?route=product/search';

    var value = $(this).closest('.js-portable-search').find('.js-input-search').val();
    if (value) {
      url += '&search=' + encodeURIComponent(value);
    }

    location = url;
  });
  $('.js-input-search').on('keydown', function(e) {
    if (e.keyCode == 13) {
      $(this).closest('.js-portable-search').find('.js-button-search').trigger('click');
    }
  });

  // Overide language switcher
  $('#language a').unbind( "click" );
  $('#language .language-select').on('click', function(e) {
    e.preventDefault();

    $('#language input[name=\'code\']').attr('value', $(this).attr('href'));

    $('#language').submit();
  });

  // All script here will be triggered when browser resized
  $(window).resize(debouncer(function(e) {
    adjustMegamenu();
    $.fn.matchHeight._update();
  }));
});

// Function
function adjustMegamenu() {
  $('#nav-main .dropdown-megamenu').each(function() {
    var menuBarOffset   = $('#nav-main').offset(),
        menuBarWidth    = $('#nav-main').outerWidth(),
        menuOffset      = $(this).parent().offset(),
        menuWidth       = $(this).parent().outerWidth(),
        megaMenuWidth   = $(this).outerWidth();

    var menuBarTotalWidth   = menuBarOffset.left + menuBarWidth,  // menuBar right offset
        megaMenuTotalWidth  = menuOffset.left + megaMenuWidth,    // menuBar right offset
        menuCenter          = menuOffset.left + (menuWidth / 2),  // menu center offset
        megaMenuCenter      = (megaMenuWidth - menuWidth) / 2,
        mmcOffsetLeft       = menuCenter - megaMenuCenter,        // megamenu offset left
        mmcOffsetRight      = menuCenter + (megaMenuWidth / 2);   // megamenu offset right

    if (mmcOffsetLeft < menuBarOffset.left) { // Align left
      $(this).css('margin-left', '-' + (menuOffset.left - menuBarOffset.left) + 'px');
    } else if (mmcOffsetRight > menuBarTotalWidth) { // Align Right
      $(this).css('margin-left', '-' + (megaMenuTotalWidth - menuBarTotalWidth) + 'px');
      return false;
    } else if (megaMenuTotalWidth > menuBarTotalWidth) { // Center
      $(this).css('margin-left', '-' + megaMenuCenter + 'px');
    } else {
      $(this).css('margin-left', '0px'); // Original state
    }
  });
}

function debouncer(func, timeout) {
    var timeoutID, timeout = timeout || 500;
    return function () {
        var scope = this , args = arguments;
        clearTimeout(timeoutID);
        timeoutID = setTimeout(function() {
            func.apply(scope, Array.prototype.slice.call(args));
        }, timeout );
    };
}