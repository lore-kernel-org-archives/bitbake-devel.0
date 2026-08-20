Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BDC5DF87
	for <webhook@archiver.kernel.org>; Thu, 20 Aug 2026 10:44:57 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4287.1787222696567929909
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Aug 2026 03:44:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Yy8wMTgR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1183756f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Aug 2026 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787222695; x=1787827495; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WRtXjs+kMG/kZCzvG59WoPrxabriR0xAxrQI9ncjh3k=;
        b=Yy8wMTgRUK5c78q5Nh0DwPyjPlGqAK6VlwvvQbBNSuEwB1lCZYAC3/2sovmRE3M9oR
         4as2MzOydRXpF6R4GU33q+Gm68uMWEX9Lph2LaoOxJ62JRKSOAbVg/Z7wp2ja6Hcanh3
         R84bB/LF9Ke4oaAcVDAM67cKaqw/KGiVifkeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787222695; x=1787827495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WRtXjs+kMG/kZCzvG59WoPrxabriR0xAxrQI9ncjh3k=;
        b=UmXpBirnzCe+gK2oWTVdHYct0HHePaU0trISvOUxWr1/Wbv40sYzRog4V1It7Ibybx
         W1d12RQtz7MMmyWmGppXF8LMjIixJli7dTb9NYo9f53Y8GjTiDXGOFILRMgOkvVcNrpZ
         DcS7z3beSxmyKhvFYdRmnz/CEE3zVOqve5/LRnlv2o71l4Ai8j+P6ilazL0bUxTNkUYI
         HlegeJFqpk2p4+9+3FZu9lVjX0WoI4PUWVgvVkpA1pO1I01Igzj5spsFFbr+acCQcDkn
         GLjZuJWnYj7PfOKb15mGSNXGgeBTBvLSC9IwGTGCRLHaK6dUzKAoQMIYuAVeD/EVkjQi
         lTEg==
X-Gm-Message-State: AFuF++kjxlkjuC/DYWF+dYYS2WjJpbx4bgB4p1ZwXzK1y/GwFg74IxWa
	VdFXDAXsuPMARnemBXMItV30PD8x2zsz2phYtmCwGElk0uqzpCFo7yBosl3XKdjUbnJV/6jRmQM
	xI1rBM60=
X-Gm-Gg: AR+sD13S4XqJjJ/FmoNhS8o1KrwvvgDF1Aim3wcBElQnipjgTrxT5P6J+GXMmpgS1WV
	oWTu+DeWaFoXYz/dT5S2F4H0lCzmTpboaUunITuUpWyTPJhucVRztCg5kqwSpmWPJLGRwTcsvtB
	wecVBnd164ld3EjtteMS/xkq/kftznDdgHYtTttMq2ZWEirIjTSmrlHVkteoib8eCGkim74P+h+
	GPuBALcfJZFNyF/pAtAlyD+jRs5oXgy0m/OUD7tSNved9BEBm6/33Dt+3kS1CSSOSwwp2vSOtSx
	BJodGI9uLLBSGxaaFkmQu6a7wwMppk+a1XMCOXEI9Gz04Nnfx0bdvS35lzV4TQWU6SHtgnuj+cG
	N/pbM0o4R/1l5COOztLHgG2asjiWaMVZzt0bNXZTV9+ZX7FfhbPSOpSrVv1xM14DaNVhpsHph1L
	o7UfPfX4nX6H6r6B9HRgqco6exKMCyGSxcIYn2aI8LY5mf72fkiv/B5P5V9lR5RtcdvLrd7ULRc
	S3uVQAf+V9KGJ/qTg==
X-Received: by 2002:a05:6000:41c7:b0:481:5167:abda with SMTP id ffacd0b85a97d-482b1e9e2a8mr21132610f8f.9.1787222694497;
        Thu, 20 Aug 2026 03:44:54 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9334:47ad:4624:539c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14d059bsm10678563f8f.36.2026.08.20.03.44.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:44:53 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] utils: Fix lockfile_to_exclusive to avoid deadlock
Date: Thu, 20 Aug 2026 11:44:52 +0100
Message-ID: <20260820104452.2680721-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Aug 2026 10:44:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20007

We need to drop the existing lock when trying to get the exclusive lock
else we'd deadlock with another process trying to do the same thing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/utils.py           | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4a3119ad09d..9cb268be503 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1907,7 +1907,7 @@ class Fetch(object):
                 if m.verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
                     done = True
                 if not done:
-                    bb.utils.lockfile_to_exclusive(lf)
+                    lf = bb.utils.lockfile_to_exclusive(lf)
                     if m.try_premirror(ud, self.d):
                         done = m.try_mirrors(self, ud, self.d, 'PREMIRRORS')
 
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index b635f68a153..37edd435350 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -587,12 +587,13 @@ def lockfile(name, shared=False, retry=True, block=False):
         if not retry:
             return None
 
+# We have to drop the existing lock to avoid deadlocks
 def lockfile_to_exclusive(lf):
     if not lf:
         return
-    fileno = lf.fileno()
-    fcntl.flock(fileno, fcntl.LOCK_EX)
-    return
+    name = lf.name
+    unlockfile(lf)
+    return lockfile(name)
 
 def unlockfile(lf):
     """

