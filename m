Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE87BC43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 17:08:15 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.48.1657127286158656400
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 10:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=KkgrY3sr;
 spf=pass (domain: gmail.com, ip: 209.85.218.52,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f52.google.com with SMTP id f23so3931456ejc.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ln0ipfUSR8k65g8/MDjSlVOX+A5Vg3kkZ0MSmhANCI=;
        b=KkgrY3srswkx9g/Y53a00wPJffcogcUjrK3HVlomdcow6zQ0bkJrmZmm8zXdmx+Uho
         qIcMP7ojUQVXq27U7HnDRGt5rXASR/A+vkkgU+X7so1LjGMXexcHon+I/M4POY3gM5oc
         aX4qORWpz+3IeJ18uoq7biQfM55jfpdeLYWwcByBpfLW80xzQju99q6jFut+pMJYYhoU
         co6KkceLL4qHCeTMKUh+bwYlckD+f8jzvnCypntDbR4s4vle6ED132J2944t6NjUzhXT
         K6D59+Plfp6Kg4F0AO+rPK8K0+ES0DTUgVqQ/hdEbvzPpnwmvE62MgNdVWlxJ6SGJcK6
         AuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ln0ipfUSR8k65g8/MDjSlVOX+A5Vg3kkZ0MSmhANCI=;
        b=7XyFgftWXK842homC/Gx9whIf+0sJxctdhNEMMfQ7ucXULJPZ4lu8nT56HT8bJOdUU
         uQADM+hEUx4/UX6R73PUhVbVIaU2i46gBjncugXz1sKXpVCP7t6IA9GtrQKWjwDwrX0p
         Zg9jRgTpzrBi0X5ytDKYMiaH8sYnoYfwtjkbMd/PhQEFRkL2adm6RvUyvC0EN/8qCrDd
         m9/Uy83s521UbmAd+NGyNByqZQ3/VxuslBdTQPZCxSqzB4tupS95AZetlnWERyKe7Hmb
         XqbuE2D6EluXZ4OVAvPLwyGAPFAfiXazJZEoMAMcMS7q3f0BFQ0IZ5i2offoqHvcHxr0
         4fOQ==
X-Gm-Message-State: AJIora/kf3OtTLYsg+rVe8ZbBORN0DKLbHtxIaifa+ITDIjbnp/oxq/B
	evC/rwk3g2agMkvvAJ7YvxSuwwo1cZ4=
X-Google-Smtp-Source: 
 AGRyM1s9LY7XieQLlete1I9wVA2rWVlGRfcsOjRa7FKz0dQua5rriVeGtI0Sfk+D/IXhw92xKaKdSA==
X-Received: by 2002:a17:907:763a:b0:72a:5128:b34f with SMTP id
 jy26-20020a170907763a00b0072a5128b34fmr35817519ejc.372.1657127284549;
        Wed, 06 Jul 2022 10:08:04 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id
 la21-20020a170907781500b0072aeda86ac3sm2266674ejc.149.2022.07.06.10.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:08:04 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Martin Jansa <Martin.Jansa@gmail.com>
Subject: [PATCH] fetch2/git: show SRCREV and git repo in error message about
 fixed SRCREV
Date: Wed,  6 Jul 2022 19:07:53 +0200
Message-Id: <20220706170753.4152159-1-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 17:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13805

* in recipe with 17 git repos in SRC_URI I've accidentally pasted one SRCREV to
  be one character shorter and because fetcher uses:
    if not ud.revisions[name] or len(ud.revisions[name]) != 40  or (False in [c in "abcdef0123456789" for c in ud.revisions[name]]):
  to decide which SRCREV values are fixed SRCREVs this one was
  considered as tag or branch name, because it was only 39 chars long

  The original error message wasn't very helpful as it doesn't show
  which repo or which SRCREV was considered missing:

  do_fetch: Bitbake Fetcher Error: FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).", None)

  with SRCPV included in PV as error recomments it's a bit better:

  bb.data_smart.ExpansionError: Failure expanding variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception FetchError: Fetcher failure: Unable to resolve '0a92994d729ff76a58f692d3028ca1b64b145d9' in upstream git repository in git ls-remote output for github.com/Maratyszcza/FP16
  The variable dependency chain for the failure is: SRCPV -> PV -> WORKDIR -> T

  with this change the first error will read:

  do_fetch: Bitbake Fetcher Error: FetchError("Recipe uses a floating tag/branch '0a92994d729ff76a58f692d3028ca1b64b145d9' for repo 'github.com/Maratyszcza/FP16' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).", None)

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 07b3d9a7..4534bd75 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -738,7 +738,7 @@ class Git(FetchMethod):
         Compute the HEAD revision for the url
         """
         if not d.getVar("__BBSEENSRCREV"):
-            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE).")
+            raise bb.fetch2.FetchError("Recipe uses a floating tag/branch '%s' for repo '%s' without a fixed SRCREV yet doesn't call bb.fetch2.get_srcrev() (use SRCPV in PV for OE)." % (ud.unresolvedrev[name], ud.host+ud.path))
 
         # Ensure we mark as not cached
         bb.fetch2.get_autorev(d)
-- 
2.35.1


