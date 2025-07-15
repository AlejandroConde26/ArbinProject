 const btn = document.getElementById('toggleBtnRead');
    const desc = document.getElementById('desc');

    btn.addEventListener('click', () => {
      desc.classList.toggle('expanded');
      btn.textContent = desc.classList.contains('expanded') ? 'Leer menos' : 'Leer más';
    });
     const toggleBtn = document.getElementById('toggleBtn');
    const moreServices = document.getElementById('moreServices');

    toggleBtn.addEventListener('click', () => {
      moreServices.classList.toggle('show');
      toggleBtn.textContent = moreServices.classList.contains('show') ? 'Mostrar menos servicios' : 'Mostrar los 36 servicios';
    });