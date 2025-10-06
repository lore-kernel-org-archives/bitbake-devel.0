Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA44CCA470
	for <webhook@archiver.kernel.org>; Mon,  6 Oct 2025 18:20:20 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web11.2820.1759774815199970086
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Oct 2025 11:20:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aUCHVQbC;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: adam.blank.g@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-856222505eeso581899085a.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 11:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759774814; x=1760379614; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sJqtNz4Zf+VbVv8ipF/+vaTthwXDBFjG4lMZcyXsXM0=;
        b=aUCHVQbC2gepw9UQhDPhBbhN13guot89CdYoqzL0pJgohVl61eL8wKm0XoWJki3jBS
         Hda2rf11F0fiOw0idkEmmkN16rlBoXivD7CE2su75w3zSnt1JHStlxX4LHm2qQAryAIQ
         hKTsDtx0/5SQA4hR0EgXzisDaSktUOVRq6ImuTbxAoIZX40vCfamnFYWJiPRDVyYQbg+
         BOjNJGm51Xj6te0oOqUik5L3QqY0fiW7W/WJ9EoUYXrDoz4u4Apl9CWveXXGFFc00atg
         0dFvdFSrdIe5im7WHvv3tTocgoUXi4JFe9RxH0oIFH3s/s4UygyA8N0QSQaiBz61KVS2
         w62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759774814; x=1760379614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sJqtNz4Zf+VbVv8ipF/+vaTthwXDBFjG4lMZcyXsXM0=;
        b=hUchXyfosHegM6CqilmouzdKvFFRIDKCyVVu1192Ro7cid8RYR2VpHzn6E8dcOAiWD
         lXpTI6BtToikMsCEMvMATjkl2D3oywFxutX0G6uJo/xKg56M4lS3CVBAxoxeGn47ahzb
         QMUcX+Z0IfL7kBSC238UUCNQzbjS9gj2lodb8SisJtP4XJN6iwHrectTGwi52MTIvSYH
         n+bN9F8wTDQbQAEl2RJjMmd0vf1uzfGbhFR/NV7LtO6Iy7tXsauNaXo4daZ0xQil0O2W
         fu0awDdTzUxtem5lQAW/0WNGZiXdkREUqwTxJSUJ/vAyydNkTJsJJ6sbyz/tDv5PlKRp
         GW1A==
X-Gm-Message-State: AOJu0Yxn4rlDtNaxyL/a/wWGvQpHjDLAgU3UEk1aHa/6EGYiAj2Zjd7J
	meRu5ZvMJqz9l2anbdtQJ8QGoQzY5wlU3mwIUaeaUbwkcdfMy88imCaPnJNba7UM
X-Gm-Gg: ASbGncsVgJb1H8pap5lgIcMVNluM6s/AFg9F/voAtAvJrteXlIShSsWfW5AUXbcP8Ld
	+zt3NQdxgFVTWY5CpCEsK6uBllp3Thy5kZoSiqE/Dxi3TqxRKr6iWw+V4zfiNsqEWtga13Y3G1U
	mKUlBXolUJ3nT9TSwfCc1bUKLeC0TdnWO3+w8Nfxm1aQjhNZojkiFROGIZvvJUqgc4aPOjUix6q
	cnD7JmsLZiRvGVazaust/Tv0PsG40UOQGIscR6OpyiTJ/7TvZlCILE+LiRIBCiDpS6xzAf/fM+V
	2nyeOeJPYCcqfyluxv9cB232Z5R7/q0hl7rBlrrGWFFRKbPfF2CUFqijGdbmS/7OiO/q8jcoObW
	6u/dkmiZC3mdHDGWRVMZgIhagnmfPDOLhrn1XCKc6qa1iuRuqSCLOT+tyJk9gkBJldxc=
X-Google-Smtp-Source: AGHT+IE1rUD7gj0/vhPNio5maeNzqypIokUCmlnXJJpvZDSw75w+d5lc2MLR935cQ8dnnCxnitb0xg==
X-Received: by 2002:a05:620a:4542:b0:865:8869:33db with SMTP id af79cd13be357-87a3720da48mr1615339185a.25.1759774814031;
        Mon, 06 Oct 2025 11:20:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:e5a6:e2b0:92ec:ff52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777892eb58sm1345996685a.42.2025.10.06.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 11:20:13 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>,
	Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v3] doc/bitbake-user-manual-ref-variables: improve INHERIT
Date: Mon,  6 Oct 2025 20:19:51 +0200
Message-ID: <20251006181951.39364-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Oct 2025 18:20:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18140

Current wording makes it difficult to understand what
exactly is done with INHERIT-ed anonymous functions and
when.

Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Added reference to Parsing The Base Configuration Metadata
- Emphasised how disjoint the cases are
Changes in v3:
- Regenerate the patch previously corrupted by Emacs

---
 .../bitbake-user-manual-ref-variables.rst         | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f88689..06d48dd47 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1200,9 +1200,18 @@ overview of their function and contents.

    :term:`INHERIT`
       Causes the named class or classes to be inherited globally. Anonymous
-      functions in the class or classes are not executed for the base
-      configuration and in each individual recipe. The OpenEmbedded build
-      system ignores changes to :term:`INHERIT` in individual recipes.
+      functions in the class or classes are executed in two disjoint situations:
+
+      - When only the
+	:ref:`base configuration <bitbake-user-manual/bitbake-user-manual-execution:parsing the base configuration metadata>`
+	is parsed as a result of the following BitBake invocation::
+
+	  $ bitbake -e
+
+      - When recipes are parsed - then for each parsed recipe.
+
+      The OpenEmbedded build system ignores changes to :term:`INHERIT`
+      in individual recipes.

       For more information on :term:`INHERIT`, see the
       ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:\`\`inherit\`\` configuration directive`"

