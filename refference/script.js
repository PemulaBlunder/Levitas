document.addEventListener('DOMContentLoaded', () => {
  const fabContainer = document.querySelector('.fab-container');
  const fabButton = document.querySelector('.fab');
  const fabMenu = document.querySelector('.fab-menu');
  const fabOverlay = document.querySelector('.fab-overlay');

  fabButton.addEventListener('click', (e) => {
    e.stopPropagation();
    fabContainer.classList.toggle('active');
    fabOverlay.style.display = fabContainer.classList.contains('active') ? 'block' : 'none';
  });

  fabMenu.addEventListener('click', (e) => e.stopPropagation());

  fabOverlay.addEventListener('click', () => {
    fabContainer.classList.remove('active');
    fabOverlay.style.display = 'none';
  });
});
