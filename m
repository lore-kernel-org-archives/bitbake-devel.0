Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A700C54EBD
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.45611.1672505933112061040
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GEc8awTL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so15480867wms.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQVwYqKnKRdBBVAcqZ6blcxUxTziaVQKFtM3IobJZdQ=;
        b=GEc8awTL4TJcPYLlhcd8Ij4SsN3qnh+KIM0soh/eQomlUpAwwyPwp167WEnh1LkOri
         izzWF1T26bb52SDNDtgfVpW5AuvikP6jlYm/ongd0O1QKgZNSR7gSRBTvo/wR0aSuiBP
         MRfY4GPV0MuSPOTM8/czyoSXqztCpw1l7u5PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQVwYqKnKRdBBVAcqZ6blcxUxTziaVQKFtM3IobJZdQ=;
        b=hY/ozPrrJ3IrmKt8X0TKF9j5+GcaogbyJETrOw6/2oN5VjqXk0A1GAxzeDd0pAOXDl
         O1A62iDwaJ7pfEBnI7JClwqdQpMg+Ta1rofTyRYVUeF0Yxdcdwr54qnAuMlVbmlUE8dP
         OSISCs8OcNaKfECrAeGIE7ax/zYYxX1DCLPL+yTHLcEHh99lgsOf3IjVQ7KbBHvA+PWs
         g08M+pHp1vsD62FPJlM/911XuHOqzbc9uLa0Wxkp8Swa0YaU+3St8hnXCmmdeCo4Wylo
         zYfi4wxAQnHxZfze5wW++xDTd/AOzTky2UMYy3LI5ONFCt2mj93cCWiiuEP37N6FR4UP
         pcqQ==
X-Gm-Message-State: AFqh2kolhPQOHMvlcAY3cZWACIYrsH/42Ti1n8ymAMDy5WYChE85aBNe
	xLfm54LhwpQhSksD3PrQ631QyJ0LNcsdYQgM
X-Google-Smtp-Source: AMrXdXt5ymB0Oj2sYb0/Q3T8sVzfbYnmvFiHDNFuDqz3pLBSTCXt4qqIT+fc2ibJ+Ii39py4VQ7EFQ==
X-Received: by 2002:a05:600c:2112:b0:3d3:396e:5e36 with SMTP id u18-20020a05600c211200b003d3396e5e36mr24813471wml.0.1672505935004;
        Sat, 31 Dec 2022 08:58:55 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:54 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/11] server/process: Improve idle loop exit code
Date: Sat, 31 Dec 2022 16:58:45 +0000
Message-Id: <20221231165849.964169-8-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14267

When idle handlers want to exit, returning "False" isn't very clear
and also causes challenges with the ordering of the removing the idle
handler and marking that no async command is running.

Use a specific class to signal the exit condition allowing clearer code
and allowing the async command to be cleared after the handler has been
removed, reducing any opportunity for races.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py        | 13 +++++--------
 lib/bb/cooker.py         | 13 +++++--------
 lib/bb/server/process.py | 11 ++++++++++-
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index cbac07f516..732327d84d 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -128,22 +128,19 @@ class Command:
             else:
                 return False
         except KeyboardInterrupt as exc:
-            self.finishAsyncCommand("Interrupted")
-            return False
+            return bb.server.process.idleFinish("Interrupted")
         except SystemExit as exc:
             arg = exc.args[0]
             if isinstance(arg, str):
-                self.finishAsyncCommand(arg)
+                return bb.server.process.idleFinish(arg)
             else:
-                self.finishAsyncCommand("Exited with %s" % arg)
-            return False
+                return bb.server.process.idleFinish("Exited with %s" % arg)
         except Exception as exc:
             import traceback
             if isinstance(exc, bb.BBHandledException):
-                self.finishAsyncCommand("")
+                return bb.server.process.idleFinish("")
             else:
-                self.finishAsyncCommand(traceback.format_exc())
-            return False
+                return bb.server.process.idleFinish(traceback.format_exc())
 
     def finishAsyncCommand(self, msg=None, code=None):
         if msg or msg == "":
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index adc232e288..ded9369787 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1489,23 +1489,21 @@ class BBCooker:
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
-                self.command.finishAsyncCommand(str(exc))
                 if quietlog:
                     bb.runqueue.logger.setLevel(rqloglevel)
-                return False
+                return bb.server.process.idleFinish(str(exc))
 
             if not retval:
                 if fireevents:
                     bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.databuilder.mcdata[mc])
                     bb.event.disable_heartbeat()
-                self.command.finishAsyncCommand(msg)
                 # We trashed self.recipecaches above
                 self.parsecache_valid = False
                 self.configuration.limited_deps = False
                 bb.parse.siggen.reset(self.data)
                 if quietlog:
                     bb.runqueue.logger.setLevel(rqloglevel)
-                return False
+                return bb.server.process.idleFinish(msg)
             if retval is True:
                 return True
             return retval
@@ -1535,8 +1533,7 @@ class BBCooker:
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
-                self.command.finishAsyncCommand(str(exc))
-                return False
+                return bb.server.process.idleFinish(str(exc))
 
             if not retval:
                 try:
@@ -1544,8 +1541,8 @@ class BBCooker:
                         bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, targets, failures, interrupted), self.databuilder.mcdata[mc])
                 finally:
                     bb.event.disable_heartbeat()
-                    self.command.finishAsyncCommand(msg)
-                return False
+                return bb.server.process.idleFinish(msg)
+
             if retval is True:
                 return True
             return retval
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index eba28ad983..5acc105e08 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -71,6 +71,10 @@ def get_lockfile_process_msg(lockfile):
         return procs.decode("utf-8")
     return None
 
+class idleFinish():
+    def __init__(self, msg):
+         self.msg = msg
+
 class ProcessServer():
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
@@ -361,7 +365,12 @@ class ProcessServer():
         for function, data in list(self._idlefuns.items()):
             try:
                 retval = function(self, data, False)
-                if retval is False:
+                if isinstance(retval, idleFinish):
+                    serverlog("Removing idle function %s at idleFinish" % str(function))
+                    del self._idlefuns[function]
+                    self.cooker.command.finishAsyncCommand(retval.msg)
+                    nextsleep = None
+                elif retval is False:
                     serverlog("Removing idle function %s" % str(function))
                     del self._idlefuns[function]
                     nextsleep = None
-- 
2.37.2


