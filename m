Return-Path: <zizuzacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32476E85379
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 15:33:43 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14238.1775230419983599564
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Apr 2026 08:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=JqMMPvE1;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: zizuzacker@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab46931cf1so20896295ad.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230419; x=1775835219; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnl0TUYo+8142DnUokFSc3b7SIb69Zo46cWBW7Rq8fc=;
        b=JqMMPvE1epeVdD/RiZ9c8BGwHbNsOQ/SF7cE/HRvB90mg+y5rLrxpNp0jdXkaQtHgT
         sn8gS+GRTSWi5yO/QsCfd4uqHWqp+GT1cHyOWVm8TwL14O09eV6NvH718mJwbgn99IWA
         bMHHs07xB5UB9esxVDF72GNKBlUhmygELUn2KwxwNp1M7ZM5jUcvdJdmBx6XuVDVqAo/
         QgYB7+xkfVZrqVqVf6RLN3/jVAxwfXdRqpjwOTH3pSUSxaB3vK1fAJX+R+bwq3GK56dg
         xM5qgR8dnZCHrN7TDHjxD0Cm7I82hS+iMzTvMtEd4BogxEPyrBD6EfqYZwSoGdsf36/V
         Eirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230419; x=1775835219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnl0TUYo+8142DnUokFSc3b7SIb69Zo46cWBW7Rq8fc=;
        b=SUqYj56zGtH3qH/eZQ3ciBbhZw1DgPN8AveNYtUzGTZTm70ajvq0NB/adnQnuTRKf1
         ciHgQy+fK1IYnQNa8mMBr8RFLK8/3Z+wE2WWaWZolSnZ6l96V+5Q9HqKZksv1PklqugD
         rfcEfSTUgTJYYlPDdGU0UOiu+XjFFb3VKBB9lVhMiAUfBEdI5i2Tbgv5+SLQ+rK8M0yM
         lBUzD9P7ICKlrYL8nqhf6wihLNjWPu8bLgtXTrC9DGHHvN/fJdmnwYTSihB1MIOm/eTK
         Nse2Hmvu5iZwPUbZIENRjLxSkqcp98DZ8JAbUXPCuPN6UudcP3J33mByHsC0O9y7u4TC
         n1fA==
X-Gm-Message-State: AOJu0Yx+Aw13WDjaLkKMMCGIyNEJZemfSpGMcNl3pwpl4pxcq6OQSJhd
	Tj+wSoW4MDA16WzFbXrWQDsrpskgN4sz1JXm/JgMCcgs6xhzgoOfgLE5Sl8HMA==
X-Gm-Gg: AeBDievh2Q24k1Pgag2Ext+ar2Kf6VKg+aT0fJgYEoVn71eYMm4sZEJRzjKlXXIZDIM
	+c9m1pukg1TKoaPIMDZ6GRv5JTcz7PV1Y4fBaRg09CL2HPVV5vTDebR1N+tycUy46bYZWLdHxt9
	RsHLEjRSrGAErO3WFcg6BdvRcs/vi9tU3/vosRssDE3fPIkxo5VhIlzkiWdHTQclqDGR6cBtIQL
	p9SG8KdNS7xcVttk0fRIQzC31+9oEH1+iBMP/yyOwGFwK3XgY9QGIbuwOQi5mxWCR6328ALmbrt
	FBl6ex/P+ctvLv1JrBC1TbYtoJHksEEFyguv+7SrltEBJNRQIo7VdM3cQuJ+O3Ms6fLQz35e1eM
	3DyvnIZ53AyJpnki4Ib06V2mrEDcLEyJzV0XlTBmx4XpryRHNRuo42RVzrd0PyMWIH8are9C0rt
	3mX8kwX0ru09+B2U855wkR96z7qVMWRPfYEhfreSmjN63KpA==
X-Received: by 2002:a17:903:4b03:b0:2ae:5a38:96bb with SMTP id d9443c01a7336-2b277d633f8mr66102415ad.2.1775230418998;
        Fri, 03 Apr 2026 08:33:38 -0700 (PDT)
Received: from localhost.localdomain ([42.112.63.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a4091sm63667055ad.64.2026.04.03.08.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:33:38 -0700 (PDT)
From: Zk47T <zizuzacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Zk47T <zizuzacker@gmail.com>
Subject: [PATCH] bitbake: Resolve symlink duplicates in layer paths
Date: Fri,  3 Apr 2026 22:33:27 +0700
Message-Id: <20260403153327.64044-1-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Apr 2026 15:33:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19320

When BBLAYERS contains two paths pointing to the same directory via
symlinks, bitbake incorrectly reports duplicated BBFILE_COLLECTIONS.
Use os.path.realpath() to resolve symlinks before comparing layer
paths, and emit a warning instead of a fatal error.
Fixes [YOCTO #15591]

Signed-off-by: Zk47T <zizuzacker@gmail.com>
---
 bitbake/lib/bb/cookerdata.py   | 14 ++++++++++++++
 bitbake/lib/bb/utils.py        |  3 +++
 bitbake/lib/bblayers/action.py |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 0649e40995..823da5f4c4 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -370,6 +370,20 @@ class CookerDataBuilder(object):
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
 
+            # Resolve symlinks in layer paths so that layers referenced
+            # via different paths (e.g. symlinks) are not treated as
+            # duplicates (see Bug 15591)
+            resolved_layers = []
+            seen_real = set()
+            for layer in layers:
+                real = os.path.realpath(layer)
+                if real not in seen_real:
+                    seen_real.add(real)
+                    resolved_layers.append(layer)
+                else:
+                    parselog.warning("Ignoring duplicate layer entry %s (resolves to %s which is already in BBLAYERS)", layer, real)
+            layers = resolved_layers
+
             # Check whether present layer directories exist
             for layer in layers:
                 if not os.path.isdir(layer):
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 1b4fb93a30..1972c9864a 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -1441,6 +1441,9 @@ def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
         pth = remove_trailing_sep(pth)
         if 'HOME' in approved and '~' in pth:
             pth = os.path.expanduser(pth)
+        # Resolve symlinks for real paths, but not for glob patterns
+        if '*' not in pth and '?' not in pth:
+            pth = os.path.realpath(pth)
         return pth
 
     def layerlist_param(value):
diff --git a/bitbake/lib/bblayers/action.py b/bitbake/lib/bblayers/action.py
index a8f2699335..11cca74eb3 100644
--- a/bitbake/lib/bblayers/action.py
+++ b/bitbake/lib/bblayers/action.py
@@ -26,7 +26,7 @@ def plugin_init(plugins):
 class ActionPlugin(LayerPlugin):
     def do_add_layer(self, args):
         """Add one or more layers to bblayers.conf."""
-        layerdirs = [os.path.abspath(ldir) for ldir in args.layerdir]
+        layerdirs = [os.path.realpath(ldir) for ldir in args.layerdir]
 
         for layerdir in layerdirs:
             if not os.path.exists(layerdir):
-- 
2.34.1


