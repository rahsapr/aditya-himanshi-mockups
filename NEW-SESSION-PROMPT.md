# New Session Start Prompt — v4 shipped, awaiting family feedback
> Paste this into a fresh Kiro CLI session (or new Aria session) to resume.

---

My brother Aditya is getting married to Himanshi in November 2026. I've already built and shipped **6 mockup variants** of a digital mini-invitation (v4). All live at https://rahsapr.github.io/aditya-himanshi-mockups/ — gallery index at the root, and 6 individual variants:

- **01 Dal** — cinematic dark, Dal Lake video hero, gold shimmer
- **02 Kesar** — saffron warmth, marigold petals video hero
- **03 Chinar** — Kashmiri heritage, chinar leaves video, Devanagari eyebrow, real maple-leaf SVG particles
- **04 Shaam** — soft editorial modern, breathing hero image (deliberately quiet, no video)
- **05 Mahal** — opulent palace / art deco, mandap candlelight video, emerald + gold
- **06 Neelam** — royal celebration, sapphire + gold, larger type throughout (built for older eyes)

**What this session should do depends on what feedback I have:**

1. **If wife / family picked a winner** → polish that variant, tweak details, potentially ship to family WhatsApp group. Likely also wire the RSVP form to a Google Form backend (~2 min once they've picked).
2. **If wife / family want a NEW variant direction** → build variant 07 with the requested aesthetic.
3. **If wife / family want tweaks across multiple variants** → patch each and redeploy.
4. **If wife wants RSVP fields changed** → the form is currently name + attend-which (4 radio options with conditional event checkboxes) + free-text notes. Easy to adjust.

**Current state of the codebase** (all locked, don't relitigate unless asked):

- **Location**: `~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/`
- **GitHub**: https://github.com/rahsapr/aditya-himanshi-mockups
- **Live URL**: https://rahsapr.github.io/aditya-himanshi-mockups/
- **Copy** (locked, approved by Rahul in v4):
  - Devanagari `॥ श्री गणेशाय नमः ॥` on all 6 variants (Tiro Devanagari Hindi, bold)
  - 3-part formal blessing block: "With the eternal blessings of Late Shri Hari Krishan Sapru and Late Smt & Shri TN Handoo" → "Smt. Rani Sapru requests the pleasure of your company on the occasion of the Marriage of" → "Aditya & Himanshi"
  - Family note quote, signed "The Sapru Family · Anil & Renu Sapru"
  - RSVP copy: "Option A" — kindly share your plans at your convenience
  - Contact: Anil-ji +91 98101 36111, Renu-ji +91 98102 26037
- **Design decisions** (locked):
  - Every variant has hero video or rich image — no CSS placeholders
  - Sticky RSVP bar + early RSVP section (accessible without scrolling to bottom)
  - Body 19-20px, weights 500+ on body, 600-700 on display, 52-60px touch targets
  - Pop-up RSVP modal (not inline form) — tap "Share travel plans" or sticky RSVP pill → modal opens
  - Ambient audio: icon-only toggle top-right, 10s Kashmiri loop, starts muted
  - No programme images at the bottom (removed — too noisy)
- **Tech**:
  - AWS account 623297416416, profile `rahsapr-dev`
  - Images: SD 3.5 Large in us-west-2
  - Videos: Nova Reel v1:1 in us-east-1, compressed with ffmpeg (H.264 CRF 28)
  - S3 bucket: `rahsapr-media-gen-us-east-1`
  - Audio: 10s extract from `/Users/rahsapr/Downloads/vidoes for testing/kashmiri-audio.mp4`
  - GitHub Pages from `main` branch, root directory
- **Backend status**: RSVP form is **cosmetic only** — currently logs submissions to browser console. When family picks a winner, wire to Google Form (1 Python script + 2 min of user configuring the form).

**What's in the working folder:**
- `01-dal.html` through `06-neelam.html` — 6 variant pages
- `index.html` — gallery
- `images/` — 13 SD 3.5 Large AI images + `icons/maple-leaf.svg`
- `videos/` — 5 Nova Reel MP4s (compressed `-web.mp4` versions committed, raw source gitignored)
- `audio/kashmiri-loop.m4a` — 10s fade-in/out loop
- `scripts/` — generate-images.sh, generate-videos.sh, poll-videos.sh, generate-neelam-images.py, rsvp-modal.html (reusable snippet)
- `SPEC-v2.md` — the original v2 build spec (historical reference)
- `CONTENT.md` — content source of truth

**First things to do:**
1. Read this prompt fully
2. Ask me: what feedback did I get? From wife? From family? Which variant won (if any)?
3. Based on feedback, propose the 1-3 things to do in this session
4. Refresh AWS creds if we're going to regenerate any AI media: `ada credentials update --account=623297416416 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --profile=rahsapr-dev --once`

**If deploying:**
- Frontend: `git push origin main` (GitHub Pages auto-deploys in ~60s)
- Always verify live: `curl -s -o /dev/null -w "%{http_code}\n" https://rahsapr.github.io/aditya-himanshi-mockups/01-dal.html`

**Pre-deploy sanity check (new rule from v4 session):**
After any multi-file regex CSS patch, run a brace-balance check to catch orphan `}` that silently breaks downstream styles:
```python
for f in ['01-dal.html','02-kesar.html','03-chinar.html','04-shaam.html','05-mahal.html','06-neelam.html']:
    css = re.search(r'<style>(.*?)</style>', open(f).read(), re.DOTALL).group(1)
    assert css.count('{') == css.count('}'), f"brace imbalance in {f}"
```

The bar is still: **Rahul's wife sees the result and is impressed.** v4 landed "LOVE it" — now it's about incorporating whatever family feedback comes back.
