// highlights the current page in the navbar
function navHighlight(elem, active) {
    // querying items
    var url = location.href.split('/'),
        loc = url[url.length -1],
        link = document.querySelectorAll(elem);
    // loop over links and paths
    for (var i = 0; i < link.length; i++) {
        var path = link[i].href.split('/'),
            page = path[path.length -1];
        if (page == loc && loc == '') {
            link[i].parentNode.className += ' ' + active;
            document.body.className += ' ' + page.substr(0, page.lastIndexOf('.'));
        }
    }
}


// animates the burger slide and link fades
function navExpand() {
    const hamburger = document.querySelector(".hamburger");
    const navLinks = document.querySelector(".my-nav-links");
    const links = document.querySelectorAll(".my-nav-links li");

    hamburger.addEventListener("click", () => {
        // toggle nav
        navLinks.classList.toggle('my-nav-active');
        // burger animation
        hamburger.classList.toggle('toggle');
        // link animation
        navLinks.classList.toggle("open");
        links.forEach(link => {
            link.classList.toggle("fade");
        });
    });
}


// for typewriter effect
var txtRotate = function(el, toRotate, period) {
    this.toRotate = toRotate;
    this.el = el;
    this.loopNum = 0;
    this.period = parseInt(period, 10) || 2000;
    this.txt = '';
    this.tick();
    this.isDeleting = false;
};


txtRotate.prototype.tick = function() {
    var i = this.loopNum % this.toRotate.length;
    var fullTxt = this.toRotate[i];

    if (this.isDeleting) {
        this.txt = fullTxt.substring(0, this.txt.length - 1);
    } else {
        this.txt = fullTxt.substring(0, this.txt.length + 1);
    }

    this.el.innerHTML = '<span class="wrap">'+this.txt+'</span>';

    var that = this;
    var delta = 150;

    if (this.isDeleting) { delta /= 2; }

    if (!this.isDeleting && this.txt === fullTxt) {
        delta = this.period;
        this.isDeleting = true;
    } else if (this.isDeleting && this.txt === '') {
        this.isDeleting = false;
        this.loopNum++;
        delta = 500;
    }

    setTimeout(function() {
        that.tick();
    }, delta);
};

window.onload = function() {
    var elements = document.getElementsByClassName('txt-rotate');

    for (var i=0; i<elements.length; i++) {
        var toRotate = elements[i].getAttribute('data-rotate');
        var period = elements[i].getAttribute('data-period');
        if (toRotate) {
            new txtRotate(elements[i], JSON.parse(toRotate), period);
        }
    }

    // inject CSS
    var css = document.createElement("style");
    css.type = "text/css";
    css.innerHTML = ".txt-rotate > .wrap { border-right: 0.1em solid white; }";
    document.body.appendChild(css);
};


// for flip card function
function flipCard() {
    const card = document.querySelectorAll('.flip-card-inner');
    // looping through cards to see if something was clicked
    for (let i = 0; i < card.length; i++) {
        card[i].addEventListener('click', function() {
            card[i].classList.toggle('flip-active');
        });
    }
}

function toTop() {
    var btn = $('#btt-button');

    $(window).scroll(function() {
        if ($(window).scrollTop() > 300) {
            btn.addClass('show');
        } else {
            btn.removeClass('show');
        }
    });

    btn.on('click', function(e) {
        e.preventDefault();
        $('html, body').animate({ scrollTop: 0 }, 'medium');
    });
}


// MAIN FUNCTION
const app = ()=> {
    AOS.init();
    navHighlight('nav .my-nav-links .fade-in a', 'current');
    navExpand();
    flipCard();
    toTop();
    // for bootstrap tooltip
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
}

app();
