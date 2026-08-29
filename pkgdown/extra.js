// Create decorative network overlay for navbar
function createNetworkOverlay() {
  const navbar = document.querySelector('nav.navbar');
  if (!navbar) return;

  // Create container for network
  const overlay = document.createElement('div');
  overlay.id = 'network-overlay';
  overlay.style.cssText = `
    position: absolute;
    top: 0;
    right: 0;
    width: 350px;
    height: 100%;
    pointer-events: none;
    overflow: hidden;
    z-index: 0;
  `;

  navbar.style.position = 'relative';
  navbar.insertBefore(overlay, navbar.firstChild);

  // Create canvas for lines
  const canvas = document.createElement('canvas');
  canvas.style.cssText = `
    position: absolute;
    top: 0;
    right: 0;
    pointer-events: none;
  `;
  overlay.appendChild(canvas);

  const ctx = canvas.getContext('2d');
  const overlayWidth = overlay.offsetWidth;
  const overlayHeight = overlay.offsetHeight;

  canvas.width = overlayWidth;
  canvas.height = overlayHeight;

  // Generate network nodes
  const nodes = [];
  const nodeCount = 8;
  const connectionDistance = 120; // Max distance to draw lines

  for (let i = 0; i < nodeCount; i++) {
    const size = Math.random() * 12 + 6; // 6-18px
    const opacity = 0.5;

    nodes.push({
      x: Math.random() * (overlayWidth - size) + size / 2,
      y: Math.random() * (overlayHeight - size) + size / 2,
      baseX: 0, // Will be set below
      baseY: 0, // Will be set below
      size: size,
      opacity: opacity,
      vx: 0, // Velocity from mouse interaction
      vy: 0,
      element: null
    });
  }

  // Store base positions
  nodes.forEach(node => {
    node.baseX = node.x;
    node.baseY = node.y;
  });

  // Create circle elements
  nodes.forEach(node => {
    const circle = document.createElement('div');
    circle.style.cssText = `
      position: absolute;
      width: ${node.size}px;
      height: ${node.size}px;
      border-radius: 50%;
      background: var(--bs-body-color);
      opacity: ${node.opacity};
      transform: translate(-50%, -50%);
      left: ${node.x}px;
      top: ${node.y}px;
    `;
    overlay.appendChild(circle);
    node.element = circle;
  });

  // Ensure all navbar children are above the overlay
  Array.from(navbar.children).forEach(child => {
    if (child !== overlay) {
      child.style.position = 'relative';
      child.style.zIndex = '2';
    }
  });

  // Track pointer position
  let pointerX = 0;
  let pointerY = 0;
  let isHovering = false;

  navbar.addEventListener('mouseenter', () => {
    isHovering = true;
  });

  navbar.addEventListener('mouseleave', () => {
    isHovering = false;
  });

  navbar.addEventListener('mousemove', (e) => {
    const rect = overlay.getBoundingClientRect();
    pointerX = e.clientX - rect.left;
    pointerY = e.clientY - rect.top;
  });

  // Animation loop
  function animate() {
    nodes.forEach(node => {
      let targetX = node.baseX;
      let targetY = node.baseY;

      // Mouse interaction: push node away
      if (isHovering) {
        const dx = node.x - pointerX;
        const dy = node.y - pointerY;
        const distance = Math.sqrt(dx * dx + dy * dy);

        const repelRadius = 25;

        if (distance < repelRadius && distance > 0) {
          const angle = Math.atan2(dy, dx);
          const force = (1 - distance / repelRadius) * 8;

          node.vx += Math.cos(angle) * force;
          node.vy += Math.sin(angle) * force;
        }
      }

      // Apply velocity and damp it
      node.x += node.vx;
      node.y += node.vy;

      node.vx *= 0.5; // Quick damping
      node.vy *= 0.5;

      // Gently return to base position
      const returnForce = 0.05;
      node.vx += (node.baseX - node.x) * returnForce;
      node.vy += (node.baseY - node.y) * returnForce;

      // Constrain within bounds
      const margin = node.size / 2;
      node.x = Math.max(margin, Math.min(overlayWidth - margin, node.x));
      node.y = Math.max(margin, Math.min(overlayHeight - margin, node.y));

      // Update element position
      node.element.style.left = node.x + 'px';
      node.element.style.top = node.y + 'px';
    });

    // Draw connections
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.strokeStyle = 'rgba(100, 150, 255, 0.3)';
    ctx.lineWidth = 1.5;

    for (let i = 0; i < nodes.length; i++) {
      for (let j = i + 1; j < nodes.length; j++) {
        const dx = nodes[j].x - nodes[i].x;
        const dy = nodes[j].y - nodes[i].y;
        const distance = Math.sqrt(dx * dx + dy * dy);

        if (distance < connectionDistance) {
          ctx.beginPath();
          ctx.moveTo(nodes[i].x, nodes[i].y);
          ctx.lineTo(nodes[j].x, nodes[j].y);
          ctx.stroke();
        }
      }
    }

    requestAnimationFrame(animate);
  }

  animate();
}

// Run when DOM is ready
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', createNetworkOverlay);
} else {
  createNetworkOverlay();
}
