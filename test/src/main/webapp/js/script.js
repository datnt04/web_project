document.addEventListener('DOMContentLoaded', function () {
    const searchIcon = document.querySelector('.search-icon');
    const searchBar = document.querySelector('.search-bar');

    if (searchIcon && searchBar) {
        searchIcon.addEventListener('click', function () {
            searchBar.classList.toggle('active');
        });

        document.addEventListener('click', function (event) {
            if (!searchIcon.contains(event.target) && !searchBar.contains(event.target)) {
                searchBar.classList.remove('active');
            }
        });
    }

    if (typeof Swiper !== 'undefined') {
        try {
            new Swiper('.review-slider', {
                slidesPerView: 2,
                spaceBetween: 30,
                loop: true,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: false,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                breakpoints: {
                    768: {
                        slidesPerView: 2,
                    },
                    1024: {
                        slidesPerView: 2,
                    },
                },
            });
            console.log('Swiper initialized successfully.');
        } catch (error) {
            console.error('Error initializing Swiper:', error);
        }
    } else {
        console.error('Swiper not loaded. Please check the Swiper.js CDN or local file.');
    }
});

