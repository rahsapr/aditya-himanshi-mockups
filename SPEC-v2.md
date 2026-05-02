# Aditya & Himanshi — Wedding Mini-Invite · Build Spec v2

**Date**: 2026-05-02
**For**: Rahul Sapru (brother of groom)
**Goal**: 5 new mockup variants. Cinematic, wow-factor mini-invitations delivered via WhatsApp — not formal cards, but rich enough that guests don't think "why are they asking me to RSVP without an invite?"
**Decision maker**: Rahul's wife is the toughest reviewer. If she's impressed, we're in the right place. Rahul's parents are the final sign-off.

---

## 0. Context — read this first

This is a Kashmiri Pandit wedding. Audience is mixed — family elders (60-80), middle-aged aunts/uncles (50s-60s), younger cousins (20s-40s). Delhi + Jammu split across 9 days.

**What failed in v1 (five variants built earlier today):**
- Too minimal / editorial / text-heavy
- No wow factor, no hero imagery, no motion
- RSVP placed at bottom of page — people never reached it
- Fonts too thin for older eyes on phones
- First-round copy was too casual ("Let us know you're coming", "rough sense", "we'd love to talk to you properly") — felt disrespectful in Indian family context
- Confused positioning — looked fancy enough to *seem* like an invite but wasn't invite-y enough

**The pivot:**
This IS the mini-invitation. Not a heads-up. Not an RSVP form with wedding info. **A proper WhatsApp-native digital invitation that also collects travel plans.** A formal physical/elaborate card comes later from the family — but this must stand on its own as an emotionally resonant, impressive first communication.

**The bar:**
Guests open the link. First reaction should be: *"Wow. Aditya's wedding is going to be something."* They should feel pride, excitement, warmth — before they ever think about filling anything in.

---

## 1. Core Information

### Couple
**Aditya & Himanshi**

### Family
- Hosted by: **Anil & Renu Sapru** (groom's parents)
- Blessing line (at top of hero): **"With the blessings of Amma — Rani Sapru"** (groom's grandmother — do NOT use "Shrimati" or other formal prefixes; simple "Amma" is right)
- Family name: **The Sapru Family**

### Programme (9 days, 2 cities)

**Delhi**
- 20 November 2026 — Devgun Ceremony

**Jammu**
- 24 November 2026 — Arrival in Jammu
- 24 November 2026 — Mehndi Raat (Evening)
- 25 November 2026 — Barat (Morning)
- 26 November 2026 — Lunch
- 26 November 2026 — Departure for Delhi (Evening)

**Delhi**
- 29 November 2026 — Shishur (Lunch)

### Contact
- **Anil-ji**: +91 98101 36111
- **Renu-ji**: +91 98102 26037

### Family note copy (use verbatim — it's in Anil's voice)
> *"We are delighted to invite you to the wedding of Aditya and look forward to celebrating this joyous occasion together. We eagerly await your presence and blessings on this special occasion."*

### RSVP section copy (locked — Rahul approved "Option A")
**Eyebrow**: Your presence and blessings
**Heading**: Kindly share your plans
**Body**:
> *"To help us make suitable arrangements for your stay, we kindly request you to share your travel plans at your convenience. Your timely response will help us ensure a pleasant and comfortable experience for everyone. A phone call is most welcome — it would be our joy to speak with you."*

**Buttons (in order)**:
1. **Share travel plans** (primary — links to `#rsvp-form`, form to be built later)
2. **Call Anil-ji** (`tel:+919810136111`)
3. **Call Renu-ji** (`tel:+919810226037`)

---

## 2. Design Requirements (non-negotiable)

### 2.1 Wow factor (critical)

Each variant must have at least **THREE** of the following:
- Hero imagery — AI-generated (Bedrock Stable Diffusion SD 3.5 Large) or stock photography. Kashmiri/Delhi wedding themes. NO placeholder rectangles.
- Scroll-triggered animations (reveal on scroll, parallax, staggered entry)
- Hero load animation — names reveal letter-by-letter, shimmer on gold, soft bloom
- Ambient background motion — falling petals/leaves, subtle particle drift, cloud layer shifts
- Big dramatic typography — 80px+ couple names on phone, cinematic scale
- Atmospheric backgrounds — gradients, textures, depth (NOT flat)

### 2.2 RSVP placement (critical)

**Pick ONE of these patterns per variant:**
- **Sticky bottom bar** — persistent RSVP row visible while scrolling (form button + two call buttons, compact)
- **Early RSVP section** — right after hero, before programme, full RSVP block
- **Hero RSVP** — RSVP CTA in or directly below the hero itself

**Do NOT** place RSVP only at the bottom of the page. That was the v1 failure.

**Strong recommendation:** Sticky bottom bar on ALL variants + early RSVP section on most. Belt-and-braces.

### 2.3 Mobile-first, elder-friendly typography

- **Body text minimum 18px, prefer 20-22px**
- **No thin serif weights** at small sizes — they disappear on phones. Use regular/medium/semibold.
- **Headings** — dramatic serifs fine because they're big. At small sizes, use bolder weights.
- **Line height 1.65-1.75** for readability
- **High contrast** — dark text on light, or very-bright text on dark. No washed-out greys.
- **Touch targets 48px minimum** — buttons need to be tappable by shaky older fingers
- **Button text 14-16px, clear, no thin letterforms**

### 2.4 Fonts — choose from this palette

Each variant must pair a dramatic display font with a highly legible body font. Suggested pairings:

| Variant direction | Display (headings) | Body |
|---|---|---|
| Traditional-warm | Playfair Display (600-700) | Source Serif 4 / Source Sans 3 |
| Editorial-modern | Fraunces (500-600) | Inter (400-500) |
| Luxurious | Cormorant Garamond (500-600) | Montserrat (400-500) |
| Cinematic | Playfair Display SC (500-700) | Inter (400-500) |
| Heritage-classical | EB Garamond (500-600) | Lato (400-500) |

**Avoid**: Cinzel as body, Cormorant Light at any size below 20px, Marcellus for long paragraphs (it's a headline face), Fraunces 300 weight at any size.

### 2.5 Imagery

**Each variant should have 2-4 images.** Options (in order of preference):

**Option A — AI-generated (preferred if time permits):**
- Use Bedrock Stable Diffusion 3.5 Large via `aws bedrock` (account 623297416416, region us-east-1)
- Style prompts: "Kashmiri wedding watercolour illustration", "Dal Lake at dusk with shikara boats, soft watercolour", "Chinar leaves in autumn, elegant botanical illustration", "Himalayan mountains at sunset, painterly", "Delhi farmhouse wedding, golden hour, painterly"
- Generate 6-10 candidates, pick the best for each variant
- Reference: the LSCT booklet project at `~/Documents/Kiro-Working-Folder/lsct-booklet-v2/` — Rahul has done this before, it worked beautifully

**Option B — Stock photography:**
- Unsplash / Pexels — search "Kashmir landscape", "Indian wedding", "Dal Lake", "Himalayas", "mandap", "Indian wedding decor"
- Only use royalty-free, commercial-OK images
- Credit if required

**Option C — CSS-only fallback (only if A and B both fail):**
- Rich gradients, SVG patterns, geometric ornaments
- NEVER use plain solid-colour backgrounds as the hero

### 2.6 Tone (locked — do not change)

**Traditional Indian family — respectful, warm, formal without being stiff.**

**Banned phrases** (do NOT use):
- "Let us know you're coming"
- "Rough sense of who's coming"
- "Nothing needs to be final"
- "We'd love to hear from you"
- "We'd love to talk to you properly"
- "Share tentative plans" / "Share details"
- "From all of us" (as section eyebrow — too casual)
- "Parents of the groom" (as sign-off role label)
- "~ with love ~" / "~ with joy ~" (cute tildes)
- "Shrimati" (too museum-formal)

**Preferred phrasing:**
- "Kindly" everywhere — it's the magic word
- "Cordially invite"
- "We would be grateful"
- "At your convenience"
- "With warm regards"
- "It would be our joy to speak with you"
- "A phone call is most welcome"
- No contractions in the formal sections (we are, you are, we would)

---

## 3. The Five Variants — Distinct Directions

**Goal: no two variants should feel the same.** Each has a distinct aesthetic philosophy, not just a colour swap.

### Variant 1 — "Dal" · Cinematic Dark
- **Vibe**: Dal Lake at dusk. Deep indigo/midnight + luminous gold. Film-poster aesthetic.
- **Hero**: Full-screen dark atmospheric scene. AI image of Dal Lake or Himalayan night sky. Couple names in big luminous Playfair Display, gold with shimmer animation. Falling leaves / subtle star twinkle in background.
- **Scroll treatment**: Events appear with soft fade-up as you scroll
- **RSVP placement**: Sticky bottom bar + early section after hero
- **Palette**: `#0B1F2E` midnight, `#D4A24C` gold, `#F5E6C8` cream, `#152B3F` deep blue
- **Best for**: Cousins, visually bold crowd, the "wow that's cinematic" reaction

### Variant 2 — "Kesar" · Saffron Warmth
- **Vibe**: Golden hour. Luxurious saffron, warm cream, gold leaf. Feels like an opulent invitation.
- **Hero**: Warm cream background with AI watercolour of Delhi/Jammu scene. Saffron + gold accents. Couple names in Cormorant Garamond with gold foil effect (CSS gradient). Floating rose petals or marigold drift animation.
- **Scroll treatment**: Programme cards with gold-edge reveals on scroll
- **RSVP placement**: Hero-adjacent + sticky bar
- **Palette**: `#F5EBDC` cream, `#D4741C` saffron, `#8B2635` crimson accent, `#B8860B` gold
- **Best for**: Family elders, traditional readers, "this feels proper"

### Variant 3 — "Chinar" · Autumn Heritage
- **Vibe**: Chinar leaves falling, Kashmiri autumn. Warm orange-red + deep green, hand-painted feel.
- **Hero**: Cream background with animated chinar leaves drifting down. AI watercolour of chinar tree or Kashmiri landscape. Devanagari `॥ श्री गणेशाय नमः ॥` above names in a respectful eyebrow. Names in EB Garamond.
- **Scroll treatment**: Leaf motifs appear at section breaks, subtle wind effect
- **RSVP placement**: Sticky bar + section after family note
- **Palette**: `#F5EBDC` cream, `#C9753A` chinar orange, `#5C7B3E` deep green, `#8B2635` crimson accent
- **Best for**: The cultural heart of the audience — ties to Kashmiri identity

### Variant 4 — "Shaam" · Soft Editorial Modern
- **Vibe**: 2026 Pinterest quiet-luxury. Soft pastels (oyster beige, dusty rose, powder blue), emotional minimalism but ELEVATED with imagery and motion this time.
- **Hero**: Soft blush background with AI-generated ethereal watercolour (pale mountains, soft flowers, dreamy). Names in Fraunces with gentle reveal animation. Subtle floating particles.
- **Scroll treatment**: Full-bleed image sections alternating with programme cards
- **RSVP placement**: Hero CTA + sticky bar
- **Palette**: `#F4E6E0` blush, `#C9A9A3` dusty rose, `#9BA99B` sage, `#EDE4D6` oyster
- **Best for**: Modern cousins, Instagram-era aesthetic, but now with visual substance

### Variant 5 — "Mahal" · Opulent Palace / Art Deco
- **Vibe**: Delhi farmhouse wedding. Emerald green + gold + ivory. Geometric luxury, laser-cut ornament feel. Architectural.
- **Hero**: Ivory background framed with ornate geometric art-deco patterns + AI image of a regal mandap or Mughal-arch architectural scene. Monogram "AH" in a circular crest. Names in Marcellus / Cormorant.
- **Scroll treatment**: Each section framed with deco ornaments, side panels, gold-border reveals
- **RSVP placement**: Framed RSVP panel with sticky bar
- **Palette**: `#F8F3E8` ivory, `#0F4C3A` emerald, `#C9A85C` gold, `#1A2620` ink
- **Best for**: "Designed and polished" crowd, wedding-planner aesthetic

---

## 4. Technical Requirements

### 4.1 Tech stack
- **Pure HTML/CSS/JS** — no frameworks, no build step. Same as v1.
- Each variant = single self-contained `.html` file
- Inline CSS in `<style>` block
- Inline JS in `<script>` block (for animations, scroll triggers)
- Google Fonts loaded via `<link>` in head
- Images: either inline base64 (if small), or in an `/images/` folder relative to the HTML

### 4.2 Performance on phones
- **Total page weight under 2MB** per variant including images
- Images optimised — WebP preferred, JPG fallback
- Lazy-load images below the fold
- CSS animations preferred over JS where possible (GPU-accelerated)
- No libraries heavier than 10KB gzipped (if any library at all — prefer none)

### 4.3 Deployment
- **Repo**: `rahsapr/aditya-himanshi-mockups` (already exists, GitHub Pages enabled)
- Root directory serves the mockups (`index.html` = gallery, `01-*.html` etc = variants)
- Live URL: `https://rahsapr.github.io/aditya-himanshi-mockups/`
- **Replace the existing 5 mockups entirely** — they are obsolete
- Keep the gallery `index.html` as the entry point, update thumbnails to reflect new variants
- Working folder: `~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/`
- Commit with clear message, push to main, GitHub Pages auto-deploys in 1-2 min

### 4.4 Image generation (if using Bedrock)
- Region: `us-east-1`
- Model: Stable Image Core or SD 3.5 Large (check availability)
- Profile: `rahsapr-dev`
- Run `ada credentials update --account=623297416416 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --profile=rahsapr-dev --once` first if token expired
- Reference implementation: LSCT booklet v2, scripts at `~/Documents/Kiro-Working-Folder/lsct-booklet-v2/`
- Save generated images to `~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/images/` as WebP or JPG
- Budget: ~10-15 image generations total across all 5 variants

---

## 5. Build Order (suggested)

1. **Setup** (10 min)
   - Read this spec fully
   - Check working folder state at `~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/`
   - Verify GitHub repo state
   - If using Bedrock: refresh AWS creds

2. **Images first** (20-30 min)
   - Generate 6-10 AI images covering the 5 variant themes
   - Optimize + save to `images/`
   - Pick 2-4 best per variant

3. **Build 1 variant end-to-end** (30-40 min)
   - Start with Variant 1 "Dal" (cinematic dark) — highest-risk, best to validate first
   - Full hero + animations + programme + RSVP + sticky bar
   - Test on mobile viewport in browser dev tools (iPhone 12 Pro size)
   - Verify fonts readable, buttons tappable, animations smooth

4. **Check in with Rahul** — show Variant 1 before building the other 4. If the bar is wrong, better to catch it at 1 than at 5.

5. **Build remaining 4 variants** (20-30 min each)
   - Reuse structural patterns from Variant 1
   - Each gets its own distinctive hero + palette + motion

6. **Update gallery `index.html`**
   - New thumbnails
   - Updated descriptions matching the new variant DNA

7. **Deploy** — commit, push, verify live URL

---

## 6. Definition of Done

A variant is "done" when:

- [ ] Hero has a real image (AI-generated, stock, or truly impressive CSS art)
- [ ] Hero has a load animation (names reveal, fade, shimmer — some motion)
- [ ] At least one scroll-triggered animation exists (reveal on scroll, parallax, etc)
- [ ] RSVP is accessible WITHOUT reaching the bottom of the page (sticky bar or early section)
- [ ] Body text is 18px+ and readable on a phone
- [ ] All touch targets are 48px+
- [ ] The correct copy is used (no banned phrases, formal tone, Option A RSVP copy)
- [ ] All three buttons work (form anchor, both `tel:` links)
- [ ] Both parents' numbers are correct (Anil +919810136111, Renu +919810226037)
- [ ] Programme is complete and accurate (all 7 events, correct dates)
- [ ] Blessing line at top: "With the blessings of Amma — Rani Sapru"
- [ ] Family note uses Anil's full quoted text (both sentences)
- [ ] Tested in browser mobile viewport (looks good on iPhone 12 Pro / 390px width)
- [ ] Total weight under 2MB

---

## 7. Non-goals (do NOT do these)

- Do NOT build the RSVP form itself yet — that comes after family picks a variant
- Do NOT deploy to Firebase — GitHub Pages is fine for the preview round
- Do NOT add sound/music — too risky on mobile, can revisit later
- Do NOT spend time on desktop-specific designs — phones are 95% of the audience
- Do NOT add custom domain — `rahsapr.github.io/...` is fine for now
- Do NOT build per-guest unique links — one shared URL is fine for v1
- Do NOT add photo placeholders — use real AI/stock images or skip that section

---

## 8. Existing assets (state of the project)

### Working folder
`~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/`
- `CONTENT.md` — shared content file (reference, don't duplicate)
- `01-chinar.html` through `05-himalaya.html` — **OBSOLETE v1 files, replace or delete**
- `index.html` — gallery, **needs updating for new variants**

### GitHub repo
- **URL**: https://github.com/rahsapr/aditya-himanshi-mockups
- **Pages URL**: https://rahsapr.github.io/aditya-himanshi-mockups/
- **Status**: Pages enabled, main branch, root directory
- **State**: Has v1 files pushed — replace them

### Family context
- Rahul Sapru (son/brother of groom) — driver of this project, in UK
- Anil Sapru (father) — formal host, warm personality, native Indian English
- Renu Sapru (mother) — same
- Rani Sapru / "Amma" (grandmother) — blessing line, respect matters
- Rahul's wife (Preeti Kaul) — toughest critic, taste authority, her feedback is the bar

### Memory references (for continuity)
- Core rules: `~/.kiro/kiro-agent-memory/core-rules.md`
- Preferences: `~/.kiro/kiro-agent-memory/preferences.md`
- LSCT booklet for Bedrock image generation reference: [[lsct-booklet]]

---

## 9. If you get stuck

- **If Bedrock auth fails**: Run `ada credentials update --account=623297416416 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --profile=rahsapr-dev --once`. Do NOT ask Rahul for `mwinit`.
- **If GitHub push fails**: Auth via `gh auth status` — should be logged in as rahsapr
- **If you can't generate AI images**: Fall back to Unsplash/Pexels stock. Do NOT use plain CSS hero as the final solution — it's what failed in v1.
- **If the wow factor isn't landing**: Show Rahul one variant early for taste-check before building the other four.
- **If you're uncertain about tone**: Default to formal + respectful. "Kindly" is never wrong. Contractions are usually wrong in the formal sections.

---

## 10. Handoff note to new session

You are stepping into a project that has iterated 3 times already. The spec above is locked. Do NOT relitigate:
- The copy choices (approved by Rahul)
- The RSVP placement requirement (sticky bar + early section)
- The tone (traditional Indian family, no casual Western-startup voice)
- The audience (mixed ages, elder-friendly)

You CAN relitigate:
- Specific design execution (which fonts, which animations, which colour shades)
- Which 5 directions to pick (if you have a better pentad than Dal/Kesar/Chinar/Shaam/Mahal)
- Technical approach details (animation library vs CSS, image format, etc)

**Your first message should be a short plan** — what you'll do in what order. Then build. Don't ask Rahul for permission on every step. This is a production sprint.

The bar is: **Rahul's wife sees the result and is impressed.** If she's not, we've failed.

Good luck. 🪔
