Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5488BC4708E
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 12:49:21 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.14339.1670417356535512828
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 04:49:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Bv01bRST;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id m19so13502703wms.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 04:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxjuikBaHS83G95JcnL7sxXMfbjeoWz6szFJN2rxJvc=;
        b=Bv01bRSTb1rGP/Wi6WpFaNwZvQHi4su0G3KtFnNY0Nn5GmnofYkrgUy6bnEUPQasxd
         MpvERdf/wS1R+TAw55Mqkcq3uRYU2zk3c84Acduz6Y20KjrMZfaDh7gRrHG+fBWUR9ll
         eqdZXfdX8MbgE2O8R2ictcGVy82LgceHl0Uvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxjuikBaHS83G95JcnL7sxXMfbjeoWz6szFJN2rxJvc=;
        b=e9kVpZi4PUeSIXzyR0kz1HfzhtEu+XDlKx2xOH+TyDBNqMG7k6IMk7ZyxMFZAt0tso
         SnxBgXr67xgAoYFpCJYJUWDH28rQVtnTOAf6YoDJZ9gA5paXWpsWQCAyjG8o0LLWoTCL
         atm+t4L6yr+jCmZadIZZb+HAl8jWk9fOG0/B7IygYoIf2BLG+J/yqm1vu0mko+RpUILs
         o5bQhOcoU0xN2B6oKJoLGqYMkXNHhZsIdUC3tbBDVpq/hT48KI/sKut6cVqCtkYge1Yd
         nDEzSXz+u83YCUGLLpdRy9rchSN3ShKuMCmZr9AakLL7X5HhpHG5+MF2ukITxjsnDqRo
         Wmkw==
X-Gm-Message-State: ANoB5pntSp9hrLeFfsIJv0PNnTuqT51GrKYIqtfEicS9WIMlmX+qWn1Y
	DO7Q/t/fieaYSxO+1isuAMh3fIUeIyJuih7N
X-Google-Smtp-Source: AA0mqf5PwrjBAmXHTY5jFvRWiwSx4n85mktzT1TYCnVd96aPRAMmh+CK38tBttAAT9IRIsvn4ScIdg==
X-Received: by 2002:a05:600c:3b08:b0:3d1:e3d6:a0eb with SMTP id m8-20020a05600c3b0800b003d1e3d6a0ebmr6877680wms.83.1670417354402;
        Wed, 07 Dec 2022 04:49:14 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c3b9400b003cfd10a33afsm1802406wms.11.2022.12.07.04.49.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:49:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cookerdata: Ensure layers use LAYERSERIES_COMPAT fairly
Date: Wed,  7 Dec 2022 12:49:13 +0000
Message-Id: <20221207124913.2108579-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 12:49:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14141

Some layers think they're going to be 'clever' and copy the values from
another layer, e.g. using ${LAYERSERIES_COMPAT_core}. The whole point of
this mechanism is to make it clear which releases a layer supports and
show when a layer master branch is bitrotting and is unmaintained.

Therefore add some code to avoid people doing this. I wish we didn't have
to but...

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 28cb59d83a..860968f2e8 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -383,6 +383,8 @@ class CookerDataBuilder(object):
                 parselog.critical("Please check BBLAYERS in %s" % (layerconf))
                 raise bb.BBHandledException()
 
+            layerseries = None
+            compat_entries = {}
             for layer in layers:
                 parselog.debug2("Adding layer %s", layer)
                 if 'HOME' in approved and '~' in layer:
@@ -395,6 +397,23 @@ class CookerDataBuilder(object):
                 data.expandVarref('LAYERDIR')
                 data.expandVarref('LAYERDIR_RE')
 
+                # Sadly we can't have nice things.
+                # Some layers think they're going to be 'clever' and copy the values from
+                # another layer, e.g. using ${LAYERSERIES_COMPAT_core}. The whole point of
+                # this mechanism is to make it clear which releases a layer supports and
+                # show when a layer master branch is bitrotting and is unmaintained.
+                # We therefore avoid people doing this here.
+                collections = (data.getVar('BBFILE_COLLECTIONS') or "").split()
+                for c in collections:
+                    compat_entry = data.getVar("LAYERSERIES_COMPAT_%s" % c)
+                    if compat_entry:
+                        compat_entries[c] = set(compat_entry.split())
+                        data.delVar("LAYERSERIES_COMPAT_%s" % c)
+                if not layerseries:
+                    layerseries = set((data.getVar("LAYERSERIES_CORENAMES") or "").split())
+                    if layerseries:
+                        data.delVar("LAYERSERIES_CORENAMES")
+
             data.delVar('LAYERDIR_RE')
             data.delVar('LAYERDIR')
 
@@ -415,13 +434,17 @@ class CookerDataBuilder(object):
             if invalid:
                 bb.fatal("BBFILES_DYNAMIC entries must be of the form {!}<collection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
 
-            layerseries = set((data.getVar("LAYERSERIES_CORENAMES") or "").split())
             collections_tmp = collections[:]
             for c in collections:
                 collections_tmp.remove(c)
                 if c in collections_tmp:
                     bb.fatal("Found duplicated BBFILE_COLLECTIONS '%s', check bblayers.conf or layer.conf to fix it." % c)
-                compat = set((data.getVar("LAYERSERIES_COMPAT_%s" % c) or "").split())
+
+                compat = set()
+                if c in compat_entries:
+                    compat = compat_entries[c]
+                if compat:
+                    data.delVar("LAYERSERIES_COMPAT_%s" % c)
                 if compat and not layerseries:
                     bb.fatal("No core layer found to work with layer '%s'. Missing entry in bblayers.conf?" % c)
                 if compat and not (compat & layerseries):
@@ -430,6 +453,8 @@ class CookerDataBuilder(object):
                 elif not compat and not data.getVar("BB_WORKERCONTEXT"):
                     bb.warn("Layer %s should set LAYERSERIES_COMPAT_%s in its conf/layer.conf file to list the core layer names it is compatible with." % (c, c))
 
+            data.setVar("LAYERSERIES_CORENAMES", " ".join(layerseries))
+
         if not data.getVar("BBPATH"):
             msg = "The BBPATH variable is not set"
             if not layerconf:
-- 
2.34.1


