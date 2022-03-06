Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCF3C433FE
	for <webhook@archiver.kernel.org>; Sun,  6 Mar 2022 13:35:30 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.15131.1646573730296951510
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Mar 2022 05:35:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GirkKiUq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 bi14-20020a05600c3d8e00b00386f2897400so4063930wmb.5
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Mar 2022 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dM3kXZBvSDsI6x1JbJEUJgMIQPI6PmtWjpaDDlP/bVo=;
        b=GirkKiUqUoNYFlYK0REqwQ9S/6lo5KRniWrCRbyv9S3i/N4BOxAYqZDcYeN/ll+qpF
         ClctyGeX68cEPI30k5xdfm03sKsmyfEMMTAMdPuFtdz4py+LMBaP+vm4Z5K0KA7lZ785
         1r3A41QrOgvOo2N4atqSWCb3UROrk17DlnW+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dM3kXZBvSDsI6x1JbJEUJgMIQPI6PmtWjpaDDlP/bVo=;
        b=3bHvkwx3oTY0sOlpB27jf4IGELn2kqSHrqNBKT+kJJkoKKYMz8rsKbyDdckJ3t80/s
         oTqfgba0xyEBtWhMhfgZDbKI9879EmdmSX11TgaMUs5crY6cNLTSflRo9LYhJDipUwup
         zouxxiM+6E16tS0AE8EkrL+MsKxP0+ULcg+AlAj1kuouqRicC8yNjqh7CjJOzA1nwveE
         rUoEnIDAKvF1ysMG87uj3WPFJXYeK7TQt45TOBXa/vKJce72ix3RLPef0/uuk9JYMJ2H
         f9lD4fQiKboZqfIbZZcuSSKbRiFYFSumg1gF3UCpOd0HJdE4OmAvwRPrJWJLDPNQipr1
         rVRg==
X-Gm-Message-State: AOAM533StgJFCvOKAaazJwWPS5AFLY7WlyvE9tFAZYD5hqIXMcMJUcaG
	iRnCcAYrEMpq18Jmt//t9WNemTaGbCR69WDc
X-Google-Smtp-Source: 
 ABdhPJzRIayufCCov75Jo1bUl+OH9ac04DOd/O+6HY1NSwpBkfreZUZRMLzQMJlF8oKC9WB+7RaRSw==
X-Received: by 2002:a7b:c382:0:b0:388:2e76:49ed with SMTP id
 s2-20020a7bc382000000b003882e7649edmr5718488wmj.195.1646573728601;
        Sun, 06 Mar 2022 05:35:28 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:455b:9320:b5a2:495a])
        by smtp.gmail.com with ESMTPSA id
 i9-20020adffdc9000000b001f046861795sm8734890wrs.19.2022.03.06.05.35.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 05:35:28 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] knotty: Improve setscene task display
Date: Sun,  6 Mar 2022 13:35:26 +0000
Message-Id: <20220306133526.442843-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306133526.442843-1-richard.purdie@linuxfoundation.org>
References: <20220306133526.442843-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Mar 2022 13:35:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13417

There is general agreement the current display of the total setscene and
executed full tasks is confusing. Fixing it is tricky to be clear to new
users whilst not wasting screen real estate for experienced users and not
compromisng features like the progress bar.

As a compromise, move the setscene total to the previous line making
the status display a two line summary for interactive terminals. This
makes it clear what two of the numbers represent (setscene task) whilst
separating this out from the other items.

Also tweak the non-interactive output to use a comma as a separator,
the use of the forward slash was a poor choice.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 1bcdc0023a..b02e59c1fe 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -276,11 +276,11 @@ class TerminalFilter(object):
             print(content)
         else:
             if self.quiet:
-                content = "Running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Running tasks (%s of %s, %s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             elif not len(activetasks):
-                content = "No currently running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Setscene tasks: %s of %s\nNo currently running tasks (%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             else:
-                content = "Currently %2s running tasks (%s of %s/%s of %s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Setscene tasks: %s of %s\nCurrently %2s running tasks (%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
-- 
2.32.0


