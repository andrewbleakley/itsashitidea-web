# It’s a Shit Idea — project guide

This file is loaded into every Claude session for this project. It holds the product context and the
brand rules that every page, component, email and asset must follow. **When in doubt, stay on brand.
Ask Andrew before adding new colours, fonts or mascot styles.**

---

## 1. The product

**It’s a Shit Idea** lets people tell a friend, anonymously, that their idea is bad. The best example is
someone about to launch AI slop. The app delivers the honesty so the friendship doesn’t take the hit.

- Core promise: **anonymous, honest and funny**. We roast the *idea*, never the *person*.
- Hero lines (already in use):
  - “Friends don’t let friends launch AI slop.”
  - “Avoid the butt hurt — let us tell them anonymously.”
- Known features and artefacts so far:
  - **Certificate of Shit Idea**: an official-looking certificate for an idea (see §8).
  - **Shit Idea of the Week**: a weekly trophy post for the winning idea (see §8).
  - Social posts for Instagram (1080 × 1350) and TikTok (1080 × 1920).

### Anonymity is the product
Never reveal, hint at or leak who sent a message. That covers UI copy, notifications, emails, URLs,
page titles, metadata, analytics events and error messages. If a feature could weaken anonymity,
stop and flag it before building.

---

## 2. Stack and commands

<!-- Andrew: fill these in so Claude doesn't have to guess. -->
- Framework / language: _TODO_
- CSS approach: _TODO_ (if Tailwind, use the theme tokens in §4)
- JS approach: _TODO_
- Run locally: _TODO_
- Tests / lint: _TODO_
- Deploy: Hatchbox (not Kamal). Andrew deploys himself

General preferences: follow framework conventions, keep code clean and maintainable, and prefer small,
self-contained components and vanilla JS over adding dependencies.

---

## 3. Voice and tone

- **Cheeky, self-deprecating, kind underneath.** Tongue-in-cheek, never mean. Think of a friend
  who winces while saying it.
- **Short and punchy.** One idea per line. Headlines end with a full stop for deadpan effect
  (“AI slop.” “A Shit Idea.”).
- **Toilet humour is allowed but kept PG-13.** Puns like butt hurt, flush and “not to be used as toilet
  paper” are fine. No graphic bodily descriptions, slurs, punching down or jokes about real people.
- **Mock-official is a house style.** Bureaucratic pomp played straight: “The Bureau of It’s a
  Shit Idea”, “hereby officially and irrevocably declared”, fine print that confers “no rights,
  refunds or dignity”.
- **Australian English**: colour, organise, apologise, licence (noun), centre, favourite.
- **Swearing:** “shit” is part of the name and is never censored (no “sh*t”). Avoid other swearing
  unless Andrew asks for it.
- **The mascot is sorry.** The brand’s default emotion is apologetic, so copy can lean into “sorry, but…”.
- **Microcopy** stays playful but always clear. The joke never hides what a button does or what went wrong.

### Name usage
- Display: **It’s a Shit Idea**, with a curly apostrophe, a lowercase “a” and “Shit” and “Idea” capitalised.
- Code, URLs and slugs: `its-a-shit-idea`. Short code prefix: `ISI` (used in certificate numbers).
- Use typographic quotes and dashes in display copy: ’ “ ” — and ·

---

## 4. Colour

One brand background per surface, flat (no gradient washes). Ink does almost all the text.

| Token | Hex | Use |
|---|---|---|
| `butter` | `#FFDB6E` | **Primary background.** Default for everything |
| `bubblegum` | `#FFB8C6` | Alternate background |
| `mint` | `#9FE3CF` | Alternate background |
| `sky-brand` | `#A9D8FF` | Alternate background (named to avoid clashing with Tailwind’s `sky`) |
| `ink` | `#2A1810` | Text, tags, buttons, dark surfaces |
| `ink-soft` | `#5B3A24` | Secondary text on coloured backgrounds |
| `outline` | `#4A2C1A` | Illustration outlines only |
| `poo` | `#8B5A3C` | Mascot fill, accents, secondary text on paper only |
| `poo-light` | `#B07A52` | Mascot highlights |
| `blush` | `#F08A8A` | Mascot cheeks, tiny accents |

“Official” palette (certificates and awards only): gold `#B8862B`, paper `#FBF5E6`,
band `#F3E6C4`, stamp red `#B23A2E`, signature ink `#22304F`.

### Contrast (WCAG), checked
- `ink` on butter, bubblegum, mint or sky-brand: 10.4–12.6:1 ✅ (AAA)
- `ink-soft` on any of the four backgrounds: 6.2–7.5:1 ✅
- `butter` text on `ink` (the tag): 12.6:1 ✅
- ⚠️ `poo` `#8B5A3C` on butter is **4.3:1 and fails AA for body text.** On coloured backgrounds use
  `ink-soft` for secondary text. `poo` text is fine on paper (5.3:1).

### Tokens

```css
/* Plain CSS */
:root {
  --butter: #FFDB6E; --bubblegum: #FFB8C6; --mint: #9FE3CF; --sky-brand: #A9D8FF;
  --ink: #2A1810; --ink-soft: #5B3A24; --outline: #4A2C1A;
  --poo: #8B5A3C; --poo-light: #B07A52; --blush: #F08A8A;
  --font-brand: "Bricolage Grotesque", system-ui, sans-serif;
}
```

```css
/* Tailwind v4 */
@theme {
  --color-butter: #FFDB6E; --color-bubblegum: #FFB8C6; --color-mint: #9FE3CF; --color-sky-brand: #A9D8FF;
  --color-ink: #2A1810; --color-ink-soft: #5B3A24; --color-outline: #4A2C1A;
  --color-poo: #8B5A3C; --color-poo-light: #B07A52; --color-blush: #F08A8A;
  --font-brand: "Bricolage Grotesque", system-ui, sans-serif;
}
```

---

## 5. Typography

**Bricolage Grotesque** (Google Fonts, SIL OFL) is the only brand typeface for product and marketing.

| Role | Weight | Size guide | Notes |
|---|---|---|---|
| Display headline | 800 | 72–140px (marketing), 40–64px (app) | `line-height: .92–.98`, `letter-spacing: -0.03em` |
| Subheading / lead | 700 | 24–54px | `line-height: 1.1`, `letter-spacing: -0.01em` |
| Eyebrow / label | 800 | 12–24px | UPPERCASE, `letter-spacing: .18–.24em` |
| Body / UI | 400–500 | 16–18px | `line-height: 1.5`. Load these weights if the app needs body text |
| Wordmark | 800 | — | “It’s a Shit Idea”, `letter-spacing: .02em` |

Use `text-wrap: balance` on headlines and pull quotes.

**Official-document fonts** (certificates and awards only, never in the app UI):
UnifrakturMaguntia (blackletter titles), Cormorant Garamond 500/600/700 (body),
Pinyon Script (recipient names), Mrs Saint Delafield (signatures).

---

## 6. Signature device: the punchline tag

The brand’s most recognisable element is the punchline in a dark, slightly tilted tag. It’s used for
“AI slop.”, “of the Week” and “A Shit Idea.”

```css
.tag {
  display: inline-block;
  padding: .04em .23em .12em;     /* ≈ 4px 26px 14px at 112px */
  border-radius: .2em;
  background: var(--ink);
  color: var(--butter);            /* match the surface background colour */
  transform: rotate(-2deg);
}
```

Rules: **one tag per view**, reserved for the punchline, and the tag text colour always matches the
page background. Buttons can borrow the look (ink background with butter text, rounded), but they
stay straight. The tilt is only for the punchline.

---

## 7. Mascot and icons

The mascot is a cartoon poo with three tiers and a curled tip. It has a thick `outline` stroke, a
`poo` fill, soft `poo-light` highlights, big glossy eyes and `blush` cheeks.

- **Moods drawn so far:** apologetic (the default brand emotion, with worried brows, teary eyes and a
  sweat drop), thinking, lightbulb moment, delighted and proud (in the trophy).
- **Primary mark: the poo filament.** A glowing glass lightbulb with the grinning poo inside, used in
  the social posts and in the certificate seal.
- **App icon:** square, full-bleed, on a butter background, with **no text**. Let the platform round the
  corners (≈22.37% radius for previews). It stays legible down to 29px.
- **Trophy:** a gold cup on a wooden stand with the proud poo sitting in it. Used for Shit Idea of the Week.

Rules:
- Never use the 💩 emoji, or any emoji, in place of the mascot or as UI icons. Use inline SVG icons.
- Keep the illustration style: flat fills, `outline` strokes and simple highlights. Never add photoreal
  effects, 3D or other styles.
- The mascot is never gross. It doesn’t splatter, smear or interact with toilets.
- Add new moods by changing the face (brows, eyes, mouth) and props, not the body shape.
- Alt text describes the mood, e.g. `alt="The It’s a Shit Idea mascot, looking apologetic"`.
  Decorative copies get `alt="" aria-hidden="true"`.

### Brand assets
<!-- Andrew: update these paths to wherever the files live in this repo. -->
Expected in `brand/`: app icon (apologetic, thinking, lightbulb), poo bulb (merge A),
poo filament (merge B, primary), trophy, confetti, and the Bricolage Grotesque font files.
SVG is the master format. Export PNGs from it and never hand-edit exported PNGs.

---

## 8. Templates and recurring content

### Certificate of Shit Idea (single self-contained HTML file)
- A4 landscape, designed at 1123 × 794px. It prints to A4, and `?export` gives an exact render for PDFs
  or screenshots.
- Fills `data-field="name" | "idea" | "date" | "number"` through server render, `window.CERTIFICATE = {…}`,
  URL params (`?name=&idea=&date=&no=`) or `certify({...})`. **Always insert as text** (`textContent`).
  Never use `innerHTML` with user input.
- Date format is “13th November 2026”. Number format is `ISI-YYYY-NNNNN`, hashed from name, idea
  and date unless one is given.
- The certificate is issued by **The Bureau of It’s a Shit Idea** and signed by
  **Sir Reginald P. Flushington III, Chief Assessor of Questionable Ideas**. Keep this character
  consistent everywhere.
- Fine print: “This certificate confers no rights, refunds or dignity. Valid in all states of denial.
  Not to be used as toilet paper.”

### Shit Idea of the Week
- Instagram 1080 × 1350 layout, top to bottom:
  - “Week NN · YYYY” eyebrow.
  - “Shit Idea” headline with an “of the Week” tag.
  - Trophy.
  - “This week’s winner” label and the idea in curly quotes.
  - “Nominated anonymously by a concerned friend”.
  - The wordmark.
- Use ISO week numbers. Confetti stays at the edges, behind the text.

### Social formats
- Instagram feed: 1080 × 1350.
- TikTok / Reels / Stories: 1080 × 1920. Keep text and key art out of the bottom ~380px and the
  right ~120px, where the platform UI sits.
- Composition: centred, with a big headline on top, the mascot or mark in the middle, and the subline
  plus wordmark at the bottom.

---

## 9. Layout and UI principles

- Bold and simple: one flat brand colour, big type and lots of air. Centre the composition for
  marketing. Use normal, left-aligned layouts for app UI and forms.
- Radii: cards and panels ~20px, tags ~0.2em, pills fully rounded.
- Confetti and sparkles are for celebration moments only (awards, a sent message), not decoration
  everywhere.
- Motion: small and playful (a wobble or tilt on hover). Always respect `prefers-reduced-motion`.
- Accessibility: use real `<button>`, `<a>` and `<label>` elements. Touch targets are ≥ 44px. Use the
  contrast pairs in §4. Every mascot image gets meaningful alt text.
- Pages must work at phone width first. Most traffic will come from social.

---

## 10. Do and don’t

**Do:** use the tokens, put the punchline in the tag, stay apologetic and cheeky, write in Australian
English, protect anonymity and test on mobile.

**Don’t:** invent new colours or fonts, use emoji as icons, add gradient washes or generic “AI” styling
(purple gradients, glassmorphism), mock the person rather than the idea, censor the name, or show
the mascot doing anything gross.
