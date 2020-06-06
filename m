Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
 by mx.groups.io with SMTP id smtpd.web11.3633.1591413356998362657
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=opkHv47P;
 spf=pass (domain: gmail.com, ip: 209.85.166.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f196.google.com with SMTP id z2so11581540ilq.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMF0twvA0YdQd7BjgcM64WC1Da9ZrKr1ZFNBLXwXkJA=;
        b=opkHv47PpR2kwR1LOaUO0zCBe3F3XmPobjfmeuIctbuti7M/Awq7h/DoxhBpWCFMe3
         SSW7TZ7nl4ZK5UJsJd77EeLaIcWi5YG3Ul64FBHPGbML+3cZVv5dbWg+C8Rxxz6Wn09I
         O6ZqFR22BLX+eutpy6/5ZsA7+Lhu7zXD/OPGRrFkSGPAN7fnfgiRvv8s1a8nsJH9nMXk
         Iiiq7UGf7sUBP9euLEjS/6aOMITrcUk4dY0EEfHGiF6JYiHbgXSAN9kHmMbe6Yk0UiK3
         YdtOksnCvSS5UO8XZT7Y+WcrliCzIHRDpsQPvmzYrk6Hm2APf9qVP2OhIE/5fjQ0S8iQ
         jgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMF0twvA0YdQd7BjgcM64WC1Da9ZrKr1ZFNBLXwXkJA=;
        b=nbvCWMjMcKbQFNs7dJoniM5tP73AhnAu01mRnMxTfjUu1nBfrI3PXmOWvw01/5lq+J
         +Nfi4NAHXwMEE3H+we+F4uw9wWQvkNra7DyWjG73QUiNMJlmlDLcvoBAycQZx1Zh/6o/
         K2ZfVEKVUDA5vnQX0otaf+RxR40ayYofvdoNcPU8U4ShNcKqilAPx3O6NtPKFLA89KUJ
         vV/BYnZJR9eFXjWrpG5CSo+0Zho17ITW7GadXyqz1rT6+NrjQwa4l/rBQRiLIBoGan7i
         VOQ4ht9D/ckGaqig+ZY7oPf7oNevLj6INBsq8zFVTTiHcw4+taVvz+++rke+NQYIepst
         AoBw==
X-Gm-Message-State: AOAM532pB04FsItix9pTyFs2Zps03riDm6CtXgimx2BfX7RyP4xeEzf/
	pBdcWCYCdzwq8VXR9B63F6wC4yTgIS0=
X-Google-Smtp-Source: ABdhPJyVeh+D/Lv3/zJXHCh5vBQPaoHS5L94adEfOpDdvLW+NGs1MSdnmYcNy8y/0DFq/wgr1C8y8g==
X-Received: by 2002:a92:988a:: with SMTP id a10mr11965220ill.301.1591413356223;
        Fri, 05 Jun 2020 20:15:56 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:55 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 8/8] bitbake: command: Move split_mc_pn to runqueue
Date: Fri,  5 Jun 2020 22:15:36 -0500
Message-Id: <20200606031536.15956-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606031536.15956-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
 <20200606031536.15956-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index d11907e3ba..3902ccca71 100644
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
@@ -442,7 +436,7 @@ class CommandsSync:
     findProviders.readonly = True
 
     def findBestProvider(self, command, params):
-        (mc, pn) = split_mc_pn(params[0])
+        (mc, pn) = bb.runqueue.split_mc(params[0])
         return command.cooker.findBestProvider(pn, mc)
     findBestProvider.readonly = True
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3d54c2b88a..5b7dab8d79 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -46,6 +46,12 @@ def split_tid(tid):
     (mc, fn, taskname, _) = split_tid_mcfn(tid)
     return (mc, fn, taskname)
 
+def split_mc(n):
+    if n.startswith("mc:"):
+        _, mc, n = n.split(":", 2)
+        return (mc, n)
+    return ('', n)
+
 def split_tid_mcfn(tid):
     if tid.startswith('mc:'):
         elems = tid.split(':')
-- 
2.26.2

