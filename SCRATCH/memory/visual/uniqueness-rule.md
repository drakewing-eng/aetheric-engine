# Object identity / uniqueness rule (user)

**Status:** Active project rule for Richmond House art.

## Rule

1. Each object needs a **specific design and identity**.
2. Do **not** stamp the same hero still-life everywhere (e.g. one cheese block design cloned five times).
3. Furniture should be **unique where possible** (different silhouettes, materials, clutter kits per instance).
4. **Mass items** may share base styles: books, bricks, floorboards — with a few standout uniques.
5. Avoid non-specific “Minecraft” blocks (anonymous brown cubes, green mystery patches).

## Implementation hints

- Prefer **per-instance prop params** (colors, scale, clutter seeds) over identical dict clones.
- Kitchen shelves ≠ library bookshelves (different makers or strong style forks).
- If `kind: "bookshelf"` is reused, branch by room or use distinct kinds: `plate_rack`, `tool_shelf`, `library_case`.
- When densifying, add **identity** not only **count**.

## Related open bug

Generic identical shelves — [open-bugs.md](open-bugs.md) §3.
