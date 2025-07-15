document.addEventListener('DOMContentLoaded', function() {
        const sidebarToggleBtn = document.getElementById('sidebarToggleBtn');
        const leftSidebar = document.querySelector('.left-sidebar');
        const mainContentWrapper = document.getElementById('mainContentWrapper');
        const mainWrapper = document.getElementById('main-wrapper');

        // Check initial state from local storage or set default
        const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
        if (isCollapsed) {
            leftSidebar.classList.add('collapsed');
            mainContentWrapper.classList.add('expanded');
            mainWrapper.setAttribute('data-sidebartype', 'mini-sidebar'); // For Modernize CSS integration
        }

        sidebarToggleBtn.addEventListener('click', function() {
            leftSidebar.classList.toggle('collapsed');
            mainContentWrapper.classList.toggle('expanded');

            // Update data-sidebartype attribute for Modernize CSS
            if (leftSidebar.classList.contains('collapsed')) {
                mainWrapper.setAttribute('data-sidebartype', 'mini-sidebar');
                localStorage.setItem('sidebarCollapsed', 'true');
            } else {
                mainWrapper.setAttribute('data-sidebartype', 'full');
                localStorage.setItem('sidebarCollapsed', 'false');
            }

            // Trigger window resize event to make charts and other responsive elements readjust
            window.dispatchEvent(new Event('resize'));
        });
    });