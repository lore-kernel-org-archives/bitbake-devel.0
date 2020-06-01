Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
 by mx.groups.io with SMTP id smtpd.web12.46945.1591043303936256130
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rVtdpbCR;
 spf=pass (domain: gmail.com, ip: 209.85.166.67, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f67.google.com with SMTP id h4so5113919iob.10
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zrw1R66ptrw8/hN4KHIr7wOkgAZQ7Uta4oSbIRL/xo=;
        b=rVtdpbCRAHou5XUjdMiHSdG1SBdbsV0pm+79N46LcLoAW7DTxPwUY9gq+cCcYQMJdA
         sH3WmtGMC1FAmLKO8wS4T0IQUxkh2NJS94O+zD+qC5T8Lz+B1FYvHd3yFEpXQ4WcrJ43
         Yx9CXNCne/5JGoPZR9jpzFp2hTLqTwo+Tsb3IHACHnJPP5UnTopI1fcowcjSyOgqdnr8
         YENz6mNA3K2b+hdTw1LMNwr7SWiY4MHFV5mDT51hOgAhQ4TWMEGkSmoqB3oCR86buE3h
         Nuh8cF91NnLKemnaSDfy7nFiGw8mdXTdDBfyglswYZ9oTkf0hrZI5y70vqd9V1dp9Isn
         ERZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zrw1R66ptrw8/hN4KHIr7wOkgAZQ7Uta4oSbIRL/xo=;
        b=pG2Lr5oo9Ymm69gU1nRJf8V2f7LrrKX+RiL/eeh+dBvKElT+trl/rxb0sYoDDQpK7I
         vqrDcc2TNpTUjtz1iHN21kYBklSM2TGwAdisK7ccKVS7m9xHsW3BP9rO6iYoukDR70oH
         BDyQaK2vSzoaV9xoA30TZpn8i+0lkt0mkXXVG5Bx9QF7rH7+Xu08YMqH/VsCHBtqv9ob
         Z6zOBp+oHM/b8hpNImWUzvlFxVaq28dBb690QqSbvWfDJv6x3UPaM+3zfCWyCzORLhgl
         J02PJ8aOQyYvOdABEu2unUY9jCDuYca2z++Bd6oTMWzYsLUmFFWQo38O2Rtjt4Q1caLy
         yAAA==
X-Gm-Message-State: AOAM5318VtaG2OIwbH00Y7L55UDJYMG0nr64lvrBSQ3ggGoKnhheagd3
	h0uJ+B8pHs4VR+7sobQ1DqwIbnWzQyo=
X-Google-Smtp-Source: ABdhPJy3fokAZi7+KGx8hZNiUaJkbV6YTI5kNQz1XZtEMco5ECi1OS3kobUJiL/tbQ3cNxhIew0G9w==
X-Received: by 2002:a02:90cd:: with SMTP id c13mr22514950jag.83.1591043303148;
        Mon, 01 Jun 2020 13:28:23 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:22 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 8/8] bitbake: command: Move split_mc_pn to runqueue
Date: Mon,  1 Jun 2020 15:28:07 -0500
Message-Id: <20200601202807.26357-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>

All of the other multiconfig splitting functions are located in runqueue
so move the function to split a pn/fn there also so that its easier to
see them all together. Fixes a case where the findBestProvider() command
wasn't working for multiconfig because it was looking for a prefix of
"multiconfig:" instead of the newer "mc:"

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/command.py  | 8 +-------
 bitbake/lib/bb/runqueue.py | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f45b6e5320..8ed3d8f679 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -138,12 +138,6 @@ class Command:
     def reset(self):
         self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
 
-def split_mc_pn(pn):
-    if pn.startswith("multiconfig:"):
-        _, mc, pn = pn.split(":", 2)
-        return (mc, pn)
-    return ('', pn)
-
 class CommandsSync:
     """
     A class of synchronous commands
@@ -438,7 +432,7 @@ class CommandsSync:
     findProviders.readonly = True
 
     def findBestProvider(self, command, params):
-        (mc, pn) = split_mc_pn(params[0])
+        (mc, pn) = bb.runqueue.split_pn(params[0])
         return command.cooker.findBestProvider(pn, mc)
     findBestProvider.readonly = True
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3d54c2b88a..cb5aa80f2f 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -46,6 +46,12 @@ def split_tid(tid):
     (mc, fn, taskname, _) = split_tid_mcfn(tid)
     return (mc, fn, taskname)
 
+def split_pn(pn):
+    if pn.startswith("mc:"):
+        _, mc, pn = pn.split(":", 2)
+        return (mc, pn)
+    return ('', pn)
+
 def split_tid_mcfn(tid):
     if tid.startswith('mc:'):
         elems = tid.split(':')
-- 
2.17.1

