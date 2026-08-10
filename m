Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6DAC5AD55
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 16:16:03 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33427.1786378556613922574
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Aug 2026 09:15:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HWYeU6Sq;
 spf=pass (domain: gmail.com, ip: 209.85.161.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6ae6e407bfdso712973eaf.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2026 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786378556; x=1786983356; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTBCb+UUD+x8Mqu2gV9z7uqBGXCgfPn11EzsIZAFWz8=;
        b=HWYeU6SqMoVSPWL4jYq07LxUzHRzXLOXI37RkwQW1yIcSz1LRrdYFaE9LNIc3i8NDP
         5qHyx1XcmmBZUpMzvZWqj5WibbHIzOY22Gek14AvjEPdozpWV6qBrxryLoPEPfyfE0+k
         wFuZqzJJjfKD1uA9/LX/Ki5Lt+8dxqoRuJIb5UX/aEWqhCjXVq6PDwE0nJa7iPkOsfMc
         lXBxRJbre9zM3iQk1M4XjVP0O7cGFlx+AvOIH2gAFadXqK4dAQjpO2R+MBYuaYEawDJL
         azIixA8UqWrqCNzWLSMHb70foVZfe7d1lGUz7gMo+RHtQKGfCn3UUZn0/GhfwfV1LD+6
         HVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786378556; x=1786983356;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HTBCb+UUD+x8Mqu2gV9z7uqBGXCgfPn11EzsIZAFWz8=;
        b=dbvXGrB+mW1hwiY5J6x2LKc4AxU81HMfxPsxIryP133QZgFJwAM5STRHT3AWJQ532a
         /zfrgzYKzEawSVcK/FCgFwXVIH4tKKjhDUNxP9p1XjzmUEU7B4istM+2Pngk/yWFRGIh
         0LM56pLM8fBNVf06MFdtMLlg0UsOrp/EQZmW56ZvLQ1cbx6I+EjsSEfwiDPC1FsPqEg8
         IXwXYGfkdsVIj+UvgcFcypiyWIr8MpbeqThoW8rt7jaCKv29Z8DcnAaXVKshPqTBETxQ
         sZZQoMq01SIgLtPufWoYNvH/MaEpRJ3MIEs5iMcTM+tqLkh6bRxQRoq2GtyqR8c4lf+Q
         JWcA==
X-Gm-Message-State: AOJu0Yw6EKlX2NW+Suom3kij7BCrWprXOpkTI3+36zi8yyFpuUl8qr+e
	e91uA2lS2Ym/VCTyoxhC9HlApWxm8lYD7gcPlfrE3M3hVkWAmTNfTdXxRpmnWA==
X-Gm-Gg: AR+sD13wb1qdZ+oJpY4PgP/Fnhi+ahEbsmQK2qXovO+hCssYcjIhIZbNRk52oR5DPD8
	yOYj1iUnX57H2FOGwrrY+RngkB9vVuIJRkoEgG1f/chudCNuDnMKRpDbT252+0CUDvQcNjeleCl
	a7g6urY7FLAmFrx/oxVQNWAXAbHwYdUOG1z0ago+bRyJ5Oqj5fnN3T/ys5Ec3Y1znePUApTBLsh
	pV3dZIhhyKrF7awmE7V/L+iz9DdVybwpYH7rx7b0WrR1OZ5b6f9kGRj1FIOwcLOyB8cewrTT3qA
	HJN0OGpc7wLfARurYmF+LC96VeqnFaSt1AC8iIKI07WR9kAys7RucEVIUuZSVSq9Yaf3JNlUBW7
	G5hvOOZvebxJYmdjst2VQC2zPTWHr1mg9ex6NwExrc1Vg4m111sAV+namKbAMmRCxTCvQZVAOpR
	EVA95XMk+o0HK5SsDk7Yn6kJQybGd0QvoT5m4xEGxRwwjdthmkjC4Ru52RRQ==
X-Received: by 2002:a05:6820:1508:b0:6ae:4913:7d11 with SMTP id 006d021491bc7-6b04213ea4dmr10750916eaf.22.1786378555573;
        Mon, 10 Aug 2026 09:15:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::abb5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc2631esm10009511eaf.4.2026.08.10.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:15:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] AGENTS.md: Add file
Date: Mon, 10 Aug 2026 10:15:50 -0600
Message-ID: <20260810161551.632465-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Aug 2026 16:16:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19911

Adds an AGENTS.md file to direct agents about better commit practices.
This is specifically *not* attempting to improve or direct agents about
the code that they generate. It has been noted that when AI is used to
write code and commit code, the commit messages that it generates can be
long and draw out (e.g. a "wall of text") which affects maintainer
ability to review the patches. Therefore, this AGENTS.md text file is
only focused on instructing the agents to produce commits that are more
suitable for our review process.

This file is intended to help agents comply with the existing project
document (and specifically, the AI Policy[1]), and does not constitute a
new policy. Any subsequent changes to this file should derive and comply
with the project documentation and policies.

It what can only be described as the most bizarre interaction with a
computer I've ever experienced, the best way to get an AGENTS.md file
that AI agents actually respect as intended is to instruct one to write
it for you (as opposed to writing one by hand). Future edits to this
file will likely be most effective if written by an Agent.

[1]: https://docs.yoctoproject.org/contributor-guide/submit-changes.html#acceptance-of-ai-generated-code
AI-Generated: Uses Claude Sonnet 5

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 AGENTS.md | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 AGENTS.md

diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 000000000..9fb4560b0
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,55 @@
+# AGENTS.md — BitBake
+
+Guidance for AI agents working in the `bitbake` repository.
+
+## Making changes
+
+- No web PR workflow. Both projects use **patches on mailing lists**
+  (bitbake-devel@lists.openembedded.org), tracked via patchwork. Don't assume
+  GitHub PR conventions apply.
+- One Git commit per logical change (e.g., one commit per recipe added/upgraded).
+- Commit message format:
+  - Summary line prefixed with the recipe name or short file path,
+    e.g. `openssl: upgrade to 3.2.1` or `classes/rootfs-postcommands: fix typo`.
+    Check `git log --oneline <path>` for the prefix convention already in use.
+  - Body explains what/why/how, and how it was tested.
+  - Prefer explaining *why* a change was made over restating what's
+    already visible in the diff, unless the diff is long/hard to follow
+    or the reason for the change isn't known — in those cases, summarize
+    what changed instead.
+  - Be succinct: use as few sentences and lines as possible while still
+    covering what/why/how. Cut restatements, filler, and any detail a
+    reviewer wouldn't need (e.g. exact test-run counts, step-by-step
+    narration). One short paragraph is usually enough; only add a second
+    if a distinct point (e.g. testing) needs it.
+  - The most relevant information about the change should be presented first.
+  - Reference bugs as `Fixes [YOCTO #1234]` when applicable.
+  - Use `Reported-by`, `Suggested-by`, `Tested-by`, `Reviewed-by`, `Cc` tags
+    where relevant.
+
+### AI-generated code
+
+- **Mandatory**: any AI-generated code/commit must add an `AI-Generated:`
+  tag line in the commit message, placed *before* `Signed-off-by` (if present),
+  naming the tool used, e.g.:
+
+  ```
+  component: Add the ability to ...
+
+  AI-Generated: Uses GitHub Copilot
+  ```
+
+- Also add a code comment or other in-patch indication that the code is
+  AI-generated (recommended, not just the commit tag).
+- **Mandatory** Do not automatically add a `Signed-off-by`. This tag must
+  always be written by the human contributor, never by the AI tool — the
+  DCO/Developer's Statement of Origin still applies in full.
+- Contributor is responsible for confirming the AI tool's terms don't
+  conflict with the project's open source license/IP policy, and that
+  any third-party copyrighted material in the AI output is properly
+  licensed before contributing it. See the Linux Foundation generative AI
+  guidance: https://www.linuxfoundation.org/legal/generative-ai.
+- `Co-authored-by` should be omitted in favor of the `AI-generated` tag.
+
+When in doubt about a convention, grep `git log --oneline <path>` in the
+target repo for precedent before inventing a new style.
-- 
2.54.0


