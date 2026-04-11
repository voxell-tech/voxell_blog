document.addEventListener('input', (e) => {
  if (e.target.id !== 'search-input') return;

  const q = e.target.value.toLowerCase();
  const list = document.getElementById('post-list');
  const empty = document.getElementById('search-empty');
  if (!list) return;

  let visible = 0;
  list.querySelectorAll('a[data-title]').forEach(card => {
    const match = !q
      || card.dataset.title.includes(q)
      || (card.dataset.tags || '').includes(q);
    card.style.display = match ? '' : 'none';
    if (match) visible++;
  });
  if (empty) empty.style.display = q && visible === 0 ? '' : 'none';
});
