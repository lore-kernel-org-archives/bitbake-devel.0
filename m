Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5A1C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 20:22:55 +0000 (UTC)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
 [209.85.166.54])
 by mx.groups.io with SMTP id smtpd.web12.3475.1643314974564903866
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 12:22:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YSdz+sVD;
 spf=pass (domain: gmail.com, ip: 209.85.166.54, mailfrom: twoerner@gmail.com)
Received: by mail-io1-f54.google.com with SMTP id p63so4226747iod.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Jan 2022 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCpNdItw47HXj+H47PoNfVB/I0RdOVq7ZGi8WqhfHf4=;
        b=YSdz+sVD0UGFUlfxRKM5eTZJOqpwpk26VqVK3AU8ggW/aINoTBmsB8i+vZ6RD0RBMU
         2VwCr28dIGWGtFo53AB15mYO7UynE4eqKTCTdMIXHV40ozY4zrK5HS2eBvsecgglKwuy
         oewFr+uUkoavZ6rXsmwhLuarbi0W0+XMh+AdL7RmgXCUQQdmcwyVdoByZjgiITL7tdtG
         MTkkokINhy4It/aFR4c1pUjKkeISfzavL+12zP9A3ig/TsdeMr0TnczPIxPyb4UsBP49
         khVGBObhozYWv0cEplvrL2eOfQIulZU3Q/vJ49scy4wx/UgS3vCvJumLttQUSfVztmZ0
         yJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCpNdItw47HXj+H47PoNfVB/I0RdOVq7ZGi8WqhfHf4=;
        b=HB6SqKSW4klH9SbYXzGQj0lNYBujKSKFfGSXnfR6/HGIl2XHpZEC4R1DtlZ6134Aam
         vm0/bUcmTnvTGt3WhC7PTP1Aq0sDD0+e/Cv1WVbR68ywhPGb7SclLwOTdHOg6tSvbR0C
         IP/OgOagI7aeelDj3AVyA06eFQ5/uGVKnEKE3EJ/zrjnGnYor7NpYMvJEBhz5Xm4Sc0N
         xmeyKKetiOSEbvH/EfJMhL963G1SGvqTkjxO21+tNaf4WxhWI38+hxJq2dLGuynJg+vy
         GX9jW7xhU563CmAM+w0adGNcHkKTOxgmaPPxQD26wdmEHukVfUqk31vKv+2Xdd5nFdA8
         Cesw==
X-Gm-Message-State: AOAM533kwXm3ax9aCmVMC3q2Gfli73n7bpRQ3WX+pPCucJ/9FrQEXIEv
	KePdwz5FIELyTaOEdE2mKoLWnG0aG2Y=
X-Google-Smtp-Source: 
 ABdhPJwuj9TpYL7K5AwHHxUPP7iR3F2oDUDuCkxlVRZJC0nsmzRMjFGXKeMYIk760qpXmR0MJOfHjQ==
X-Received: by 2002:a05:6602:727:: with SMTP id
 g7mr3251945iox.90.1643314973549;
        Thu, 27 Jan 2022 12:22:53 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca.
 [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id
 q14sm6415003iow.1.2022.01.27.12.22.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:22:52 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] knotty: improve the UI information
Date: Thu, 27 Jan 2022 15:22:43 -0500
Message-Id: <20220127202243.26972-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Jan 2022 20:22:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13291

During a build you might end up with bitbake telling you:

	Currently 30 running tasks (2757 of 2757/3476 of 6390)

Which, to me, is really confusing. The forward slash separator and the two
numbers immediately on each side of which are likely to be interpreted as
being one unit (i.e. 2757/3476) but they're not. Also nothing is labeled,
leaving the user to wonder what these numbers are.

Add labels, spaces, etc. to help clarify the information bitbake is trying to
convey. The resulting line would appear as:

	30 running tasks (setscene:2757/2757 tasks:3476/6390)

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes since v1:
- improve the commit message
- remove the redundant word "Currently" in order to help keep the total
  line length manageable for users of 80-column terminals
---
 lib/bb/ui/knotty.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 484545a6..c2a7d06e 100644
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
+                content = "%2s running tasks (setscene:%s/%s  tasks:%s/%s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
-- 
2.34.1.75.gabe6bb3905


