// https://github.com/ghiculescu/jekyll-table-of-contents, modified by Erick (fantasticfears@gmail.com)
(function($){
  $.fn.toc = function(options) {
    var defaults = {
      noBackToTopLinks: true,
      title: 'Contents',
      minimumHeaders: 3,
      headers: 'h1, h2, h3, h4, h5, h6',
      listType: 'ul', // values: [ol|ul]
      showEffect: 'fadeIn', // values: [show|slideDown|fadeIn|none]
      showSpeed: 'slow' // set to 0 to deactivate effect
    },
    settings = $.extend(defaults, options);

    function fixedEncodeURIComponent (str) {
      return encodeURIComponent(str).replace(/[!'()*]/g, function(c) {
        return '%' + c.charCodeAt(0).toString(16);
      });
    }

    var headers = $(settings.headers).filter(function() {
      // get all headers with an ID
      var previousSiblingName = $(this).prev().attr( "name" );
      if (!this.id && previousSiblingName) {
        this.id = $(this).attr( "id", previousSiblingName.replace(/\./g, "-") );
      }
      return this.id;
    }), output = $(this);
    if (!headers.length || headers.length < settings.minimumHeaders || !output.length) {
      $(this).hide();
      return;
    }

    if (0 === settings.showSpeed) {
      settings.showEffect = 'none';
    }

    var render = {
      show: function() { output.hide().html(html).show(settings.showSpeed); },
      slideDown: function() { output.hide().html(html).slideDown(settings.showSpeed); },
      fadeIn: function() { output.hide().html(html).fadeIn(settings.showSpeed); },
      none: function() { output.html(html); }
    };

    var get_level = function(ele) { return parseInt(ele.nodeName.replace("H", ""), 10); }
    var highest_level = headers.map(function(_, ele) { return get_level(ele); }).get().sort()[0];
    var return_to_top = '<i class="fa fa-long-arrow-up back-to-top"></i>';

    var level = get_level(headers[0]),
      this_level,
      html = "<p class='toc-title'>" + settings.title + "</p><"+settings.listType+">",
      number_id = [0];
    headers.on('click', function() {
      if (!settings.noBackToTopLinks) {
        window.location.hash = this.id;
      }
    })
    .map(function(index, header) {
      this_level = get_level(header);
      if (!settings.noBackToTopLinks && this_level === highest_level) {
        $(header).addClass('top-level-header').after(return_to_top);
      }
      if (this_level === level) { // same level as before; same indenting
        number_id[number_id.length - 1]++;
        html += "<li><a href='#" + fixedEncodeURIComponent(header.id) + "'><span class='toc-number'>" + number_id.join('.') + "</span><span class='toc-text'>" + $(header).text() + "</span></a>";
      }
      else if (this_level <= level){ // higher level than before; end parent ol
        for(i = this_level; i < level; i++) {
          html += "</li></"+settings.listType+">";
          number_id.pop();
          number_id[number_id.length - 1]++;
        }
        html += "<li><a href='#" + fixedEncodeURIComponent(header.id) + "'><span class='toc-number'>" + number_id.join('.') + "</span><span class='toc-text'>" + $(header).text() + "</span></a>";
      }
      else if (this_level > level) { // lower level than before; expand the previous to contain a ol
        for(i = this_level; i > level; i--) {
          html += "<"+settings.listType+"><li>";
          number_id.push(1);
        }
        html += "<a href='#" + fixedEncodeURIComponent(header.id) + "'><span class='toc-number'>" + number_id.join('.') + "</span><span class='toc-text'>" + $(header).text() + "</span></a>";
      }
      level = this_level; // update for the next one
    });
    html += "</"+settings.listType+">";
    if (!settings.noBackToTopLinks) {
      headers.addClass('clickable-header');
      $(document).on('click', '.back-to-top', function() {
        $(window).scrollTop(0);
        window.location.hash = '';
      });
    }

    render[settings.showEffect]();
  };
})(jQuery);
