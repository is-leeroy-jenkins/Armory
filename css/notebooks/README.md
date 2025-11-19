

# 🎨 CSS3 Tutorial

A structured, notebook-ready guide to CSS3, covering selectors, text styling, layout, Flexbox, Grid, media queries, animations, at-rules, and more.

---

## 🧱 1. CSS Basics & Root Styles

* CSS controls the visual presentation of HTML.
* Styles begin with a *selector* and a set of *declarations*.
* Common global selectors: `html`, `body`, `:root`, and `*`.
* CSS variables (`--name`) allow consistent theming.
* Global resets help maintain layout predictability.

```css
:root {
  --color-bg: #f5f7fa;
  --color-text: #222;
  --color-accent: #3a7afe;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

html, body {
  font-family: system-ui, sans-serif;
  background: var(--color-bg);
  color: var(--color-text);
}
```

---

## 🧩 2. Selectors

* Selectors target elements in the DOM.
* Types include universal, type, class, ID, group, and combinators.
* Powerful selection options via pseudo-classes and pseudo-elements.
* Useful for targeting siblings, parents, and conditionally styled states.

```css
/* ID, class, element selectors */
#header { padding: 1rem; }
.card { border-radius: 8px; }
p { line-height: 1.6; }

/* Combinators */
article p { color: gray; }
ul > li { list-style: square; }

/* Pseudo-classes */
a:hover { color: var(--color-accent); }
input:focus { outline: 2px solid blue; }

/* Pseudo-elements */
h1::before { content: "★ "; }
```

---

## ✏️ 3. Text-Level & Phrasing Styles

* Inline-level HTML elements include `<strong>`, `<em>`, `<mark>`, `<code>`, `<time>`.
* Typography controlled with font size, family, weight, spacing.
* Inline highlighting and code styling improves readability.

```css
strong { color: var(--color-accent); }
em { color: #c23b22; }
mark { background: #fffa91; padding: 0 3px; }
code { font-family: monospace; background: #eee; padding: 2px 4px; }
```

---

## 📄 4. Block & Grouping Elements

* Block-level containers shape layout and text flow.
* `<div>` is generic; `<blockquote>` and `<pre>` preserve structure.
* Use margins, padding, borders, and backgrounds for visual grouping.

```css
div.intro {
  background: #fafbff;
  padding: 1rem;
  border-radius: 6px;
}

blockquote {
  border-left: 5px solid var(--color-accent);
  background: #f0f4ff;
  padding: 1rem;
}

pre {
  background: #272822;
  color: #fff;
  padding: 1rem;
  border-radius: 8px;
}
```

---

## 🖼️ 5. Media & Embedded Content

* Use `max-width: 100%` for responsive images and videos.
* `<canvas>` and `<iframe>` often require borders and shadows.
* Use `object-fit: cover` for cropped thumbnails without distortion.

```css
img, video {
  max-width: 100%;
  height: auto;
  border-radius: 8px;
}

canvas {
  border: 2px dashed var(--color-accent);
  background: #fff;
}

iframe {
  border: none;
  border-radius: 6px;
}
```

---

## 🧮 6. Tables

* Tables structure data using rows and columns.
* Use `border-collapse` to merge borders.
* Highlight headers and alternate row backgrounds for readability.

```css
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  padding: 0.6rem;
  border: 1px solid #ccc;
}

thead {
  background: var(--color-accent);
  color: #fff;
}

tbody tr:nth-child(even) {
  background: #f9f9f9;
}
```

---

## 📝 7. Forms

* Style inputs, selects, and textareas uniformly.
* Use focus states for accessibility.
* Buttons should have clear visual hierarchy.

```css
input, select, textarea {
  padding: 0.5rem;
  border: 1px solid #ccc;
  border-radius: 4px;
}

input:focus {
  outline: 2px solid var(--color-accent);
}

button {
  padding: 0.6rem;
  background: var(--color-accent);
  color: white;
  border: none;
  border-radius: 4px;
}
```

---

## 🌐 8. Navigation & Links

* Navigation bars use Flexbox for spacing.
* Links should change color on hover.
* List-style removed for nav menus.

```css
nav ul {
  display: flex;
  gap: 1rem;
  list-style: none;
}

nav a {
  text-decoration: none;
  color: var(--color-accent);
}

nav a:hover {
  text-decoration: underline;
}
```

---

## 🧭 9. Semantic & Structural Styling

* Elements like `<main>`, `<figure>`, `<figcaption>`, `<address>` improve accessibility.
* Use centered layouts, subtle shadows, and balanced spacing.

```css
main {
  max-width: 800px;
  margin: auto;
  background: #fff;
  padding: 2rem;
  border-radius: 8px;
}

figure { text-align: center; }
figcaption { font-style: italic; color: #666; }

address { font-style: italic; }
```

---

## 🧰 10. Flexbox

* One-dimensional layout model.
* Align, justify, and distribute space along a row or column.
* Ideal for navbars, grids, card layouts.

```css
.container {
  display: flex;
  gap: 1rem;
}

.container.center {
  align-items: center;
  justify-content: center;
}

.item {
  flex: 1;
}
```

---

## 🏗️ 11. CSS Grid

* Two-dimensional layout model.
* Supports rows, columns, gaps, and named areas.
* Best for dashboards and page layouts.

```css
.grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1rem;
}

.grid-item {
  background: #fff;
  padding: 1rem;
}
```

---

## 🎞️ 12. Transitions & Animations

* Animations use `@keyframes`.
* Transitions animate property changes smoothly.
* Transformations allow scaling, rotating, and shifting.

```css
button {
  transition: background 0.3s ease;
}

button:hover {
  background: #2e63db;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.box {
  animation: fadeIn 1s ease-out;
}
```

---

# ⚖️ 13. CSS At-Rules

### 🖥️ `@media` — Responsive Queries

```css
@media (max-width: 600px) {
  .container { padding: 1rem; }
}
```

### ✒️ `@font-face` — Custom Fonts

```css
@font-face {
  font-family: "Inter";
  src: url("Inter.woff2") format("woff2");
}
```

### 🧪 `@supports` — Feature Detection

```css
@supports (display: grid) {
  .cards { display: grid; }
}
```

### 🎞️ `@keyframes` — Animations

```css
@keyframes pulse {
  50% { transform: scale(1.1); }
}
```

### 📄 `@import` — Import Stylesheets

```css
@import url("theme.css");
```

### 🖨️ `@page` — Print Rules

```css
@page { margin: 1in; }
```

### 🧩 `@layer` — Cascade Layers

```css
@layer base {
  h1 { font-size: 2rem; }
}
```

### 🎚️ `@property` — Custom Property Registration

```css
@property --rotation {
  syntax: "<angle>";
  initial-value: 0deg;
}
```

---

# 📘 License

This tutorial is free to use, modify, and include in educational or training material.

---

# 🙌 Contributing

Pull requests that expand examples, improve clarity, or add sections (e.g., CSS Variables, Filters, Mixing Modes) are welcome.


