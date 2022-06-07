Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EEACCA47C
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 14:17:41 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web12.13089.1654611458822943738
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 07:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CKt2hYHs;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id a15so15863943wrh.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0Yj2Fzgr+IPkdpXXbXzfSW3oXM/mbk/wn1BlAHKi4o=;
        b=CKt2hYHsWUXtCDCDVxbQuvb4jqBdi+bAQYvfs5HaBWDqU/abUzCurki8iIX6IYigHR
         +9SlhGZkjOwjMX1bi9pMRC4JA2AgsP9NwLqFbUXAJmBprnh2N3BdP6fStIg4RN7U01gB
         0g27Ar1XdEmdgh9XChB0DwwRMBZJgaQ8iGcxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0Yj2Fzgr+IPkdpXXbXzfSW3oXM/mbk/wn1BlAHKi4o=;
        b=fYWQVs7akyx8PNWlc0Egr5IHsABVwdU89SBhdNJXY0CW7M87Ig7Le0SqUspRA2p/7G
         KdlWiqhBwHAOOYWEA5i3JUKqnXRzZKbn1X6dqRTFbzehO7raaFbvivx2CfsaE+to61N8
         3fRzW5s2nBugepPX1YrTsz/nYFPmZjqcKW3UdXkKbdG/1azXyenjr753jB6dvIm1p6an
         AjcXyJWpXr2/qOzZZv+O/zKGRcdwD2tzbitqyRO75hpb9cGCmQFd3JOCi6Z2shoIMClq
         t+q9d7zK3gmjxgVfF0EdY5a7Nrr9YFx43cibzuch2T08dfNRmwyxQceNXAPFy5sAPhUL
         ZSRA==
X-Gm-Message-State: AOAM530OsxvJf201B7kwt2jDX3e8jWv0iClgbN0AKBLKeI1UaVAPd+Lr
	tP8VETUrNrtCFk963M1UNI4RI9py4nVGPw==
X-Google-Smtp-Source: 
 ABdhPJzL8E7gEvipl4nhTtNxhbE+Fq3gjsUM3xiRVcFIrxH79q2k+51kcLYjLjo+T79WYbqr1bik3Q==
X-Received: by 2002:a05:6000:147:b0:214:7d6e:cb1d with SMTP id
 r7-20020a056000014700b002147d6ecb1dmr21238054wrx.650.1654611456747;
        Tue, 07 Jun 2022 07:17:36 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12])
        by smtp.gmail.com with ESMTPSA id
 bd9-20020a05600c1f0900b0039c47767e23sm10483182wmb.33.2022.06.07.07.17.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 07:17:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] fetch/wget: Move files into place atomically
Date: Tue,  7 Jun 2022 15:17:33 +0100
Message-Id: <20220607141735.341158-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jun 2022 14:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13736

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/wget.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index b3a3de571a..b2b542e1dc 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -106,10 +106,9 @@ class Wget(FetchMethod):
 
         fetchcmd = self.basecmd
 
-        if 'downloadfilename' in ud.parm:
-            localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile)
-            bb.utils.mkdirhier(os.path.dirname(localpath))
-            fetchcmd += " -O %s" % shlex.quote(localpath)
+        localpath = os.path.join(d.getVar("DL_DIR"), ud.localfile) + ".tmp"
+        bb.utils.mkdirhier(os.path.dirname(localpath))
+        fetchcmd += " -O %s" % shlex.quote(localpath)
 
         if ud.user and ud.pswd:
             fetchcmd += " --auth-no-challenge"
@@ -133,6 +132,10 @@ class Wget(FetchMethod):
 
         self._runwget(ud, d, fetchcmd, False)
 
+        # Remove the ".tmp" and move the file into position atomically
+        # Our lock prevents multiple writers but mirroring code may grab incomplete files
+        os.rename(localpath, localpath[:-4])
+
         # Sanity check since wget can pretend it succeed when it didn't
         # Also, this used to happen if sourceforge sent us to the mirror page
         if not os.path.exists(ud.localpath):
-- 
2.34.1


