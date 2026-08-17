Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93ECC5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 20:05:18 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3879.1786997116110145243
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 13:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=H5jGUY8+;
 spf=pass (domain: gmail.com, ip: 209.85.167.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b21f71613fso2198812b6e.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 13:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786997115; x=1787601915; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ev8LL3IX0++0uM58dlqVANvy+zbHItT7hME58S8aBc8=;
        b=H5jGUY8+0UX7Eog24TvNXQJMUsQ+AwumCKfa/xfLRjJFQLfIpn8zUUnM34bf26DMSS
         maADF300bHNpErxqQM3gOTElzYyYCxQxqt6AJ9FnuEkt3q5RYYHQ/XEq41C7voMncRsO
         dQYG6zGR9VZyO/xkRTFDLEAPL9Cd5OOdj4RdFbhFMpJXjl02Tb5WggROSlJQmVJarvYd
         pgLvvo8YS4nX/EQdVF5oi8b60Cy5unCf1BbKGi+vk4EH4bNKmvX/mYcZHKHVbKoqONBS
         iUbojTPeeWJTHH3DgWFZCtaZ0+uPrAobdT7IJbWnTOAsgf67jUUepgjEtPHm5XoyEUUm
         ViTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786997115; x=1787601915;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ev8LL3IX0++0uM58dlqVANvy+zbHItT7hME58S8aBc8=;
        b=HAzf5hU1dUQ/7oJQEdmnVXt6iIeUvKyuCgaL4XX1EX9nfDuJ6q/E+t8FR9vVdKokUs
         dxnmFNA17sBH0O1Jj4lfGQwVQfJogd0mV6wnzTxzLRXiHPvPysA0jOpnVQfpAjrHSFhu
         B19qnl+K4siwlhJvXoPcEXbewog4ZVEopJknxKQdS1dAaaZPV6WPlTiJXrzLSoa/R6k/
         qNeYAhC1wn1KtQ0H6dAYp5aQp1w5AnSpOjzYyqlBA+b8VInG3zSPZI4ybd1KfYjCri2P
         vXPi5ZAvBC5TIB96/GQNuPvRizg7ogCw7COcQPDHzv4t+JHR50xA9T5HF3uEP4Sgdrs8
         99/Q==
X-Gm-Message-State: AOJu0Ywt4vWp52NzrcabyF9f9h/kiVGiK/Wk7Lb/nIMoIsC0czFK3v2V
	sVhM1A+xZ8Bmwz3a86yuu6u/RWccKf6HlhWPvAzzClQW7EF6Kc6R/vC+UufbRQ==
X-Gm-Gg: AR+sD11GhcvXBmcy4qKZn40tgMgGX6LmSGzXS6AySivOEkYzeP5LGa6yMy+w41fKLyJ
	qRN/uLC4ZjNni/gQJmcsA7Xs0CsqDT/G2zEC7fQuk7GuMx5E1yib7K4gdX7Gmll3mwXv+DzUTtP
	7nc17/oDhUeEdyUsoSFdgE9Ln50qA/elroHpeTd/CbLWWXRFUmcimwQQ1CRjYw/UkVbnTPquPQ1
	ZXdL4sDXIzDFJq0BkdTqzge7x5HRZyO4aWTRNP0DiwE/cEmv4sBZ6Zb7P53j6aMuVDnWFDNgW5s
	AWkDzKCIiGZOHVPurupFUQtG1h9u3NkYUAOEfnIrx04QvxbJfgzlrf+Lq05MdWUE9DybAEkS4XH
	qoGATS0oc0ZzyKXcULcka290dUF/qsMdVqhSuGEgNWvQCMCprZr1EjMpWwF+us1L6K0m3Q37mBY
	JEg6X5sgN+XNVgn852jaEbiQiP8Y0UIOSHj8nPHIbWRFgoz5qvePKMI/u+1Q==
X-Received: by 2002:a05:6808:640e:b0:497:c1f1:1511 with SMTP id 5614622812f47-4b29776347amr3878866b6e.16.1786997115169;
        Mon, 17 Aug 2026 13:05:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::44ae])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b290a46307sm2001225b6e.3.2026.08.17.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 13:05:14 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] AGENTS.md: Add file
Date: Mon, 17 Aug 2026 14:05:10 -0600
Message-ID: <20260817200512.2738020-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810161551.632465-1-JPEWhacker@gmail.com>
References: <20260810161551.632465-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 20:05:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19978

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
index 000000000..833eca7f6
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,55 @@
+# AGENTS.md — BitBake
+
+Guidance for AI agents working in the `bitbake` repository.
+
+## Making changes
+
+- No web PR workflow. The project uses **patches on mailing lists**
+  (bitbake-devel@lists.openembedded.org), tracked via patchwork. Don't assume
+  GitHub PR conventions apply.
+- One Git commit per logical change (e.g., one commit per recipe added/upgraded).
+- Commit message format:
+  - Summary line prefixed with the recipe name or short file path,
+    e.g. `openssl: upgrade 3.2.0 -> 3.2.1` or `classes/rootfs-postcommands: fix typo`.
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
+  - Reference bugs as `[YOCTO #1234]` when applicable.
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
2.55.0


