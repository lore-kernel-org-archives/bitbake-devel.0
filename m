Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F70FC4167B
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.209999.1672333660484354404
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AdrdQNAB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id bx10so17932605wrb.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FotYd+yw6uokjiN37vk0vRJ4lgA31+9nocaqRYU1erg=;
        b=AdrdQNABYwOgHia5iXDdc7oZlx86ZO86s6m/JTriA9HyzcnanyjnFmltVw3gDaMtWa
         /DPwmu0z6wInGHb60QmJBAKT+fvIH0mssofaniozGJ84RfbcBie20EFDPXWxtUg3BjyO
         ZLkAKmgLRyebFLjtgkmKUhJQPf1IqO1DrxG+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FotYd+yw6uokjiN37vk0vRJ4lgA31+9nocaqRYU1erg=;
        b=I21ylo98XXKjVFZO6ruI5+QjvYGbBSaxxunI1UCWB/2AJ//6ySkt9K9qVIvSj3SG5j
         fwq4RgqqCM4RlbPowUBo4YidQh3EtrdWAAcPXPawDCCR9PMFuBXuCKwL1URGKUIDeD2C
         JQ6jwYGTkcqLhcHPNijfiDf8CW/guD974hgkvrwvnAk6yLxnBfx5fiRMRCZ4EtxF5c81
         lrDcO9CSOofEDPpxtwFjMyfY7xfYlLEy16bkTgzTdFRm9Tf0DbrPJVVXJvyGJBnmQBfS
         bBg9pvzwgPoBpnj91OBc2ZprKoDiJ5KcKpklY0myrqOP2wAwya+CSHelLpspNBWs+yj9
         bsUw==
X-Gm-Message-State: AFqh2krvp1ifoL1CZ3fenOH57xm7FKwpDbxQC1O8eBmjQ1NdzwjhhT6V
	le8uk9Rg5/3PMCiE9Q303vmdkl9yVX/aWKSD
X-Google-Smtp-Source: AMrXdXua/Bnf3WW6oPWuTX89AJAV2UHd00wfVl0Z6nHicrH59ee7A6G8Yzs6TPcKaXyqVVIHfn0+nw==
X-Received: by 2002:a5d:45c8:0:b0:242:4c28:c9a9 with SMTP id b8-20020a5d45c8000000b002424c28c9a9mr17724510wrs.46.1672333658755;
        Thu, 29 Dec 2022 09:07:38 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:38 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 13/15] cooker: Ensure we clean up active idle handlers
Date: Thu, 29 Dec 2022 17:07:26 +0000
Message-Id: <20221229170728.880367-14-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14257

When the cooker shutdown method is called, ensure we clean up any
active idle handlers before we exit as these could have trees of
processes in them and these need to be notified and reaped.

Ensure at actual shutdown when the idle loop has been terminated
we don't trigger the idle loop call though as it will no longer
be active at that point.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 10 +++++++---
 lib/bb/server/process.py | 12 ++++++++----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index ff7e48f6c0..a5a635858c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -149,7 +149,7 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, featureSet=None, idleCallBackRegister=None):
+    def __init__(self, featureSet=None, idleCallBackRegister=None, waitIdle=None):
         self.recipecaches = None
         self.eventlog = None
         self.skiplist = {}
@@ -164,6 +164,7 @@ class BBCooker:
         self.configuration = bb.cookerdata.CookerConfiguration()
 
         self.idleCallBackRegister = idleCallBackRegister
+        self.waitIdle = waitIdle
 
         bb.debug(1, "BBCooker starting %s" % time.time())
         sys.stdout.flush()
@@ -1753,7 +1754,7 @@ class BBCooker:
         return
 
     def post_serve(self):
-        self.shutdown(force=True)
+        self.shutdown(force=True, idle=False)
         prserv.serv.auto_shutdown()
         if hasattr(bb.parse, "siggen"):
             bb.parse.siggen.exit()
@@ -1763,12 +1764,15 @@ class BBCooker:
         if hasattr(self, "data"):
             bb.event.fire(CookerExit(), self.data)
 
-    def shutdown(self, force = False):
+    def shutdown(self, force=False, idle=True):
         if force:
             self.state = state.forceshutdown
         else:
             self.state = state.shutdown
 
+        if idle:
+            self.waitIdle(30)
+
         if self.parser:
             self.parser.shutdown(clean=not force)
             self.parser.final_cleanup()
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 3038c63f55..365758f85a 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -150,6 +150,11 @@ class ProcessServer():
 
         return ret
 
+    def wait_for_idle(self, timeout=30):
+        # Wait for the idle loop to have cleared (30s max)
+        self.is_idle.clear()
+        self.is_idle.wait(timeout=timeout)
+
     def main(self):
         self.cooker.pre_serve()
 
@@ -174,8 +179,7 @@ class ProcessServer():
                 self.controllersock = False
             if self.haveui:
                 # Wait for the idle loop to have cleared (30s max)
-                self.is_idle.clear()
-                self.is_idle.wait(timeout=30)
+                self.wait_for_idle(30)
                 if self.cooker.command.currentAsyncCommand is not None:
                     serverlog("Idle loop didn't finish queued commands after 30s, exiting.")
                     self.quit = True
@@ -309,7 +313,7 @@ class ProcessServer():
         self.sock.close()
 
         try:
-            self.cooker.shutdown(True)
+            self.cooker.shutdown(True, idle=False)
             self.cooker.notifier.stop()
             self.cooker.confignotifier.stop()
         except:
@@ -607,7 +611,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
         writer = ConnectionWriter(readypipeinfd)
         try:
             featureset = []
-            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function)
+            cooker = bb.cooker.BBCooker(featureset, server.register_idle_function, server.wait_for_idle)
             cooker.configuration.profile = profile
         except bb.BBHandledException:
             return None
-- 
2.37.2


