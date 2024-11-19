Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6EFD62071
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 10:34:59 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.17837.1732012490490366719
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Nov 2024 02:34:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=B0iHEcwz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43163667f0eso26373215e9.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Nov 2024 02:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732012488; x=1732617288; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KwSGtOwJwfpkRZwi0GvgAx95O7CaNhCBWTyGwc50e4c=;
        b=B0iHEcwzhh4IALMW4DpeVnEbTaEVInw5T7FAcblRA0VfMfS7iMRepo0wvfQb+k81yt
         1xTH70zDw15xYze80T7ln9KZ1KH1T7H5pWP/NajSTLtitgHvZNF2+J+rtSdF02/t9OP2
         zTjh4SknUrA04AJXeObyA3ESVZGbuCnr5TG0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732012488; x=1732617288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwSGtOwJwfpkRZwi0GvgAx95O7CaNhCBWTyGwc50e4c=;
        b=VU29mv2RhQCWKKjp01pxHQOmOtiEiGuhdVlGIMKI4AoRMsnDFFP9+HhAm6QSXnHYp4
         7+qvXOWn8puYRLzIXaW+ZYg888FpWQdEOv5KxQBNbM8geRSugUmBo5CjHrPxCsZGYWtO
         Bws5V2wZ0zagC8SKcNdsuzqEShzcuugVO0B+On1rSEZDngMJXkd6pOzN3H5cFmmAPyDJ
         1H25DCW7K3BGPRIcKMM+ohFbZa1DeQQScrzyI2R4MsUXbID8g5P2ipH2a8oxEglWdyru
         cSZRMoa/CMvfmmMUOllzkNXEuhf+JBUsOLAmphmcXEvlWsS8A1vSCeisOzeoW2jABPAo
         PZ/w==
X-Gm-Message-State: AOJu0YzGDJHY3HI500Xf24blOMeWauyRAXhdD8qqyj4965HMMmLG+I5K
	jsIwe88MP6Zvl4DujOOYW/bI9CR7g+kF+TrquiSmzQivsTUGkmJX/0h3XIIrB7Dc34jSFd7wFlE
	GcMw=
X-Google-Smtp-Source: AGHT+IGtzdSYJlxEx0inqeC4SZsQ2ERPJOfa+Fm7zgQfhZ0jyrjSWauKKaVFcO6aedKVdw+I+ZZ14A==
X-Received: by 2002:a05:600c:6987:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-432eafa1837mr91349995e9.16.1732012488226;
        Tue, 19 Nov 2024 02:34:48 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4474:2f77:9044:e4d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7220asm186693705e9.6.2024.11.19.02.34.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 02:34:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Drop support for BB_DANGLINGAPPENDS_WARNONLY
Date: Tue, 19 Nov 2024 10:34:46 +0000
Message-ID: <20241119103446.1983984-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Nov 2024 10:34:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16811

DANGLINGAPPENDS_WARNONLY is a very poorly designed interface and
is commonly abused. The challenge is that once it is set, by any
layer, it applies everywhere.

Some layers rely on this to get notification they need to update
bbappend files and having the behaviour change from inclusion of an
antisocial layer is not good.

In addition, showing warnings as an accepted thing on the console
devalues them and trains the user to ignore them. I want to steer us
away from this mindset.

We could extend the functionality and make it apply only to certain
layers, or only to certain appends but then we've basically re-invented
BBMASK.

Given all the above, we should drop support for BB_DANGLINGAPPENDS_WARNONLY
and direct anyone with issues to BBMASK instead.

https://lists.openembedded.org/g/openembedded-architecture/message/2029

[YOCTO #14870]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 .../bitbake-user-manual-ref-variables.rst            | 12 ------------
 lib/bb/cooker.py                                     |  8 +-------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index f23fb7f2a7..6c5bab4d4d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -127,18 +127,6 @@ overview of their function and contents.
       Contains the name of the currently running task. The name does not
       include the ``do_`` prefix.
 
-   :term:`BB_DANGLINGAPPENDS_WARNONLY`
-      Defines how BitBake handles situations where an append file
-      (``.bbappend``) has no corresponding recipe file (``.bb``). This
-      condition often occurs when layers get out of sync (e.g. ``oe-core``
-      bumps a recipe version and the old recipe no longer exists and the
-      other layer has not been updated to the new version of the recipe
-      yet).
-
-      The default fatal behavior is safest because it is the sane reaction
-      given something is out of sync. It is important to realize when your
-      changes are no longer being applied.
-
    :term:`BB_DEFAULT_TASK`
       The default task to use when none is specified (e.g. with the ``-c``
       command line option). The task name specified should not include the
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d58c0f575c..a8e0a81dc9 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -957,13 +957,7 @@ class BBCooker:
                                                                         '\n  '.join(appends_without_recipes[mc])))
 
         if msgs:
-            msg = "\n".join(msgs)
-            warn_only = self.databuilder.mcdata[mc].getVar("BB_DANGLINGAPPENDS_WARNONLY", \
-                False) or "no"
-            if warn_only.lower() in ("1", "yes", "true"):
-                bb.warn(msg)
-            else:
-                bb.fatal(msg)
+            bb.fatal("\n".join(msgs))
 
     def handlePrefProviders(self):
 

