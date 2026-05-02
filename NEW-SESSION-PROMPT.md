# New Session Start Prompt
> Paste this into a fresh Kiro CLI session (or new Aria session) to resume this project cleanly.

---

My brother Aditya is getting married to Himanshi in November 2026. I need to build **5 mockup variants** of a digital "mini-invitation" for WhatsApp that doubles as an RSVP collector. This is a fresh session — I built a first round earlier today with you and my wife's feedback was it needed way more wow factor.

**Full spec is at**: `~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/SPEC-v2.md`

**Read that file completely before doing anything else.** It has:
- All the content (couple names, programme, family copy, RSVP copy — locked)
- Tone requirements (traditional Indian family, list of banned phrases)
- Design requirements (wow factor, imagery, animations, mobile-first, elder-friendly)
- The 5 variant directions (Dal · Kesar · Chinar · Shaam · Mahal)
- Technical setup (GitHub repo, Bedrock for AI images, deploy instructions)
- Existing project state

**Critical context:**
- My wife is the toughest reviewer. She rejected v1 for being flat/boring/no wow factor. If she's impressed, we're in the right place.
- This IS the invitation (not a "heads up" — that was an earlier wrong framing). A formal card comes later; this one has to be rich enough to stand on its own.
- RSVP must be accessible WITHOUT scrolling to the bottom. v1 failed on this.
- Mixed audience: 60-80yo elders, 40-50yo aunts/uncles, 20s-40s cousins. Mobile is 95%. Fonts must be readable on phones by older eyes.

**First 3 things you should do (in order):**
1. Read the full spec — don't skim
2. Read my memory: `~/.kiro/kiro-agent-memory/core-rules.md`, `preferences.md`, `active-projects.md` (the wedding project is listed there)
3. Propose a short plan (5-8 bullets): what you'll build in what order, which variant first, how you'll use images (Bedrock-generated vs stock), how long you estimate

Then start building. Don't ask me for permission on every step — the spec has what you need. The one checkpoint: after you build Variant 1 end-to-end, show me before building the other 4, so we can taste-check the bar.

**Refresh AWS creds first** if you're going to use Bedrock for images:
```
ada credentials update --account=623297416416 --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --profile=rahsapr-dev --once
```

**Working folder**: `~/Documents/Kiro-Working-Folder/aditya-himanshi-wedding/`
**GitHub repo** (already deployed with obsolete v1 files): https://github.com/rahsapr/aditya-himanshi-mockups
**Live URL**: https://rahsapr.github.io/aditya-himanshi-mockups/

The bar: my wife sees the result and says "wow". Anything less is a fail.

Go.
