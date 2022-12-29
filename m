Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDEC54EBF
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.208594.1672333652242653825
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Zv0c2p9Q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id bk16so4692588wrb.11
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uqOpyvS9KkDXCZ1VdYD7kmnu7a46UEkOD9VjSvP24I=;
        b=Zv0c2p9QSSq0knSBHhSHYxWWxaYE4yLecy/KKFwbaLEb9y/nJCoYlkGceqeJtAc0EO
         FUgbTG/C9N6kDtYGtNW+D9jGol1e9z8OL6osxxzkLmlUBT7gLNE2WUuCm40cplGbpIUT
         7T8vTw/QkD+xb7mO7Fua0Dm80iu2YyWFSDns0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uqOpyvS9KkDXCZ1VdYD7kmnu7a46UEkOD9VjSvP24I=;
        b=J+iDkHJaDuGnU6iQjD6wH9G+e7ZQtKEg8mWV75W4zZ3b9Qu4K7nMO2nnYLk39cB6ff
         2cmqur55PUZPFzoa/mo+oUu/iFyTXqSLX3VbWAeykTTyM7m3fGo0ChOv+18x3D2WG/MI
         6F/CRs9AZOi8woOMfrpxb4GjL+mAoic24rbsxMM5ZpBTcCaZqbZ8kXI7x+la6KINLzH2
         5EiMWnevba+gdaNBo0d9EavMyPeHs4yo0Ig5etdWLkFSacxpZ4tJP0u2ecYu9GUBWbvS
         ZiMZjhirBg7F1aGhE7yhTmmAmjYa5YqT/wqUmKSKtfMU4WftnMuNQTo3q2JMJyS/4L7v
         nSKg==
X-Gm-Message-State: AFqh2kq9gOuL9REkYrTY+w6XHV1IrEp5JvzFgDEXktB7tlJzqjfNZe9g
	LFsLTNAwST1GZe1sbNquQN2s8Yk95gvI/Ukm
X-Google-Smtp-Source: AMrXdXvwdRs+XXXNb1NDaoOdyrZAkn741VfAUv8i4ArqJeEUEark48RHJ8OLnq5r0EuBy25mQ0f/Eg==
X-Received: by 2002:adf:fc85:0:b0:27f:effe:977 with SMTP id g5-20020adffc85000000b0027feffe0977mr7940441wrr.38.1672333653937;
        Thu, 29 Dec 2022 09:07:33 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:33 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/15] server/process: Improve idle loop exit code
Date: Thu, 29 Dec 2022 17:07:19 +0000
Message-Id: <20221229170728.880367-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14249

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
 lib/bb/server/process.py |  8 ++++++++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index d2c01bf743..d03f35a896 100644
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
index 33e87981c5..5e18c85bb8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1502,23 +1502,21 @@ class BBCooker:
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
@@ -1548,8 +1546,7 @@ class BBCooker:
                 failures += len(exc.args)
                 retval = False
             except SystemExit as exc:
-                self.command.finishAsyncCommand(str(exc))
-                return False
+                return bb.server.process.idleFinish(str(exc))
 
             if not retval:
                 try:
@@ -1557,8 +1554,8 @@ class BBCooker:
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
index 6f43330fae..3c909942aa 100644
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
@@ -364,6 +368,10 @@ class ProcessServer():
             for function, data in list(self._idlefuns.items()):
                 try:
                     retval = function(self, data, False)
+                    if isinstance(retval, idleFinish):
+                        del self._idlefuns[function]
+                        self.cooker.command.finishAsyncCommand(retval.msg)
+                        nextsleep = None
                     if retval is False:
                         del self._idlefuns[function]
                         nextsleep = None
-- 
2.37.2


