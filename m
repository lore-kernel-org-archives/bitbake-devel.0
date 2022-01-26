Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0958AC3525A
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 01:17:19 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web08.6620.1643159837882103119
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 17:17:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Wm06fBdd;
 spf=pass (domain: gmail.com, ip: 209.85.222.173,
 mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f173.google.com with SMTP id s12so26719391qkg.6
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNw5xeglqBd6iG2FLvY+qtRdml8RDiyLVmPCs2oibMU=;
        b=Wm06fBdd/rFAt42OXwO0ppIPKfdt12e8ybO6Tqu/CRgk68nWxhV+99jTFH6XFWpNCb
         soCIAd3VJEU5Q72VMtwliHDPbUOVBScIfRihFp34FbpVxpen/1nvcaHfoCDbIZNx63X9
         MX4GyIUkHjhyFPwGIIlKqfduy9iOPByOsc4cX6BQXn+UxyUurU7y7T1PtwqLOfwRgYcK
         1pupzBuQQXac4slXnWnGjIYPbJQhlrDfm11jUw5UZhVeMEqPZiBHHoFrAB7mF9nQagby
         C2cMpUselnbEfdW9Sk9axaya/QfhPyeMSUOSmNSHl6afWNDKwRblxZl54gDlT71h8WzV
         Dkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XNw5xeglqBd6iG2FLvY+qtRdml8RDiyLVmPCs2oibMU=;
        b=UV66S3T4ZrEiek+Lu7+AJzNNjGmLTZmy5+XB6QmQsgddAVl7/DMOuRRNSC5yg+Zk1W
         fIiJsubF82LmnEsm4MvJK2/l2xIOt/bsh5ucxvPT2wssVa4o+62RO06EOl0YCv4PutGP
         sC/EbKO2pCrvZhpNvLZdBRtZ99afBRJ9mm0r+Ec5TBf6ogVTQrVzYzPQ9uQb6DuVIGX6
         ylg5fnwkhNVWMTow24c+MBvxSL5cKz2TIewCAQhfIJiigcTVH1ITPBPHSMXcoIOwfvyJ
         uXr2b27NGkJDfhOro20xJ1Ft2anVpoMQhPD4yoHVBn1vMIjGKpHCVjlt0rVKoAzhoJKS
         yaOw==
X-Gm-Message-State: AOAM531nXKkRJ8N5x4VTLaKP2zyOA+i1XeVQQWwyOCSnkumRAXsd/cg9
	uSbux0M4jVnKdl+5EZzFXVbinEFAFtnpxw==
X-Google-Smtp-Source: 
 ABdhPJxIxUO0hn9Cz8Uo57YhOGrvVCVZAU8kdAoXqlKi5VGzvC7pDCngs0Mv23z9pGB0lBkUJv6WHQ==
X-Received: by 2002:a05:620a:1a14:: with SMTP id
 bk20mr675947qkb.479.1643159836649;
        Tue, 25 Jan 2022 17:17:16 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id
 v73sm4531951qkb.51.2022.01.25.17.17.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 17:17:16 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] knotty: improve the UI information
Date: Tue, 25 Jan 2022 20:17:08 -0500
Message-Id: <20220126011708.24391-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Jan 2022 01:17:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13283

During a build you might end up with bitbake telling you:

	Currently 30 running tasks (2757 of 2757/3476 of 6390)

Which, to me, is really confusing. For one the forward slash separator
and the two numbers immediately on each side of which are likely to be
interpreted as being one unit (i.e. 2757/3476) but they're not.

Add labels, spaces, etc. to help clarify the information bitbake is trying to
convey.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 lib/bb/ui/knotty.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 484545a6..1150a6ab 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -276,11 +276,11 @@ class TerminalFilter(object):
             print(content)
         else:
             if self.quiet:
-                content = "Running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Running tasks (setscene:%s/%s tasks:%s/%s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             elif not len(activetasks):
-                content = "No currently running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "No currently running tasks (setscene:%s/%s tasks:%s/%s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             else:
-                content = "Currently %2s running tasks (%s of %s/%s of %s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Currently %2s running tasks (setscene:%s/%s  tasks:%s/%s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
-- 
2.34.1.75.gabe6bb3905


