(function () {
  var widget = null;

  // Binds a new Addressfinder widget to any textarea element with a class named 'addressfinder'
  function initialiseAddressfinder() {
    var elements = document.querySelectorAll('textarea.addressfinder')

    // IE compatibility enabled
    Array.prototype.forEach.call(elements, function (addressElement) {
      widget = new AddressFinder.Widget(
        addressElement,
        "PKWQ7XJH3GBUCLFMV49Y",
        'NZ',
        {
          address_params: {
            post_box: '0'
          }
        }
      );

      // When an address is selected, put each portion of the address on a new
      // line. This matches existing behaviour. 
      widget.on('result:select', function (fullAddress, metaData) {
        var addressLines = fullAddress.split(', ');

        addressElement.value = addressLines.join(', \n');
        addressElement.rows = addressLines.length;
      });

      // Make the number of rows in the textarea element just the right
      // size for the current address (if any).
      var initialLineCount = addressElement.value.split(',').length;
      addressElement.rows = initialLineCount;
    });
  }

  // Downloads the Addressfinder widget, and calls the initialisation
  // function when loaded. This avoids Addressfinder from blocking any
  // other actions or assets that may need to be loaded. 
  function downloadAddressfinderWidget(initialisationFunction) {
    var script = document.createElement('script');
    script.src = 'https://api.addressfinder.io/assets/v3/widget.js';
    script.async = true;
    script.onload = initialisationFunction;
    document.body.appendChild(script);
  };

  // Only activate Addressfinder if there are elements with an 'addressfinder'
  // class present. Otherwise, do nothing. 
  document.addEventListener('DOMContentLoaded', function () {
    var addressFields = document.getElementsByClassName('addressfinder');

    if (addressFields.length > 0) {
      downloadAddressfinderWidget(initialiseAddressfinder);
    }
  });
})();
