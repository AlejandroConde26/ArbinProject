    function toggleSearch() {
        const bar = document.getElementById('searchBar');
        bar.style.display = bar.style.display === 'block' ? 'none' : 'block';
    }
    
    function toggleDropdown() {
        const dropdown = document.getElementById('dropdownMenu');
        dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
       
    }
    function toggleGridView() {
        const normal = document.getElementById('normalView');
        const grid = document.getElementById('gridView');
        
            const isGridVisible = grid.style.display === 'grid' || grid.style.display === 'block';
        
            if (isGridVisible) {
            grid.style.display = 'none';
            normal.style.display = 'block';
            } else {
            normal.style.display = 'none';
            grid.style.display = 'grid';
            }
        }
