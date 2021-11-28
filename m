Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2264C433F5
	for <webhook@archiver.kernel.org>; Sun, 28 Nov 2021 22:03:09 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.53529.1638136989463756874
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=CD45nBQe;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id y7so10530147plp.0
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 28 Nov 2021 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h/Hu1zUkIsQdr+Xl34NZBEuj3boBT0QuxND4ErFziEo=;
        b=CD45nBQe93dxYYSX0D44+K8ZX0iNvSL+jekMrGK0BWnwlDiEACmyka1ksK1VkKrFr4
         hjMQP1CjiaUQR051DrQUxpMgCwweXsWZ3ZPGeBRwNEu15uYglDkum8fRmXeH7aGyuQJT
         xORY0l28OfXA7i6WVig5AcGeYxveBrXNUppld5Wdl3lBECfbyQMZ9k5sPRuurH2KcvNE
         MySf/HcFBU35sdBbVscjnJjRVY7v15dzFDHLdl7KSs2MdOU/UsVAmElk5XkL9CKSlxs6
         Sbbq0SF0dYllTjNApuQDmeLdyHlUhIuPMBbBeRhHyzaPRAU+1gsJywxHoLKVFvIpSIuE
         ZFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/Hu1zUkIsQdr+Xl34NZBEuj3boBT0QuxND4ErFziEo=;
        b=62r7ZptBItC/8K4g3k6c2tgl9ZTacsi6KkZKphT7DK3E6ii/B+H/bUeXtxUowKe9J7
         7uekJzGHVlYc6zSBCXLzRsHBWXS4V98S8zdpSA/l/P0QAqQABz4WxKp3iFciUjpkGwEo
         y3HBrLCuFKoLtNFcoOeWq6uBlDXuSKHtsxjck+G4rqMx0yILcgKK+U3wk+DjPui1Yeoi
         vwgEjUDVAjR57WhM38ks18ItWtHsRgcD4g+V4v9qGplSpNIcElhX+HT5ayzR/Hl1dpYG
         tZcdktSAH5HpZH3EE2gCXIBQ9eSqvGFqKEYugpmXhrQLqyTwz+zHko5hz1ls81LHcGp3
         0gZA==
X-Gm-Message-State: AOAM533wciAIr29pHlJJ6W0xUjVCfYqd4Uh1NjhIqiAPgWeB10+gnVDB
	zashjKgXTBCT8TiZGhcwnxA3UZ1E+26zaMxtDZ0=
X-Google-Smtp-Source: 
 ABdhPJyHzY1BTzcxXOq4EDldRM8wVNhzItpJnMQoWTl8kGuTnRLD5j8oGjeW4PCuVjhSZ3XbnhhAJg==
X-Received: by 2002:a17:90b:2504:: with SMTP id
 ns4mr32689668pjb.175.1638136988302;
        Sun, 28 Nov 2021 14:03:08 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d9sm19749139pjs.2.2021.11.28.14.03.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 14:03:07 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/3] process/knotty: Improve early
 exception handling
Date: Sun, 28 Nov 2021 12:02:48 -1000
Message-Id: 
 <7fdd43c5cbde38daa013076de2fdedcf3c3d3107.1638136822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638136822.git.steve@sakoman.com>
References: <cover.1638136822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Nov 2021 22:03:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13121

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The new server startup code means exceptions can happen when we aren't
setup to show them to the user correctly, leading to ugly tracebacks.

Add in some special case handling of BBHandledException to at least
ensure that common case doesn't traceback and the user sees meaningful
output.

In the future, the logging setup can likely be improved, as can the way
runCommand handles exceptions, they all should likely become real
exceptions again on the UI side.

[YOCTO #14022]
[YOCTO #14033]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6059d0e77f60ddb679049bd34478f41b1ab7995d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/server/process.py |  7 ++++++-
 lib/bb/ui/knotty.py      | 21 +++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 43061eb3..7b135762 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -348,7 +348,12 @@ class ServerCommunicator():
             logger.info("No reply from server in 30s")
             if not self.recv.poll(30):
                 raise ProcessTimeout("Timeout while waiting for a reply from the bitbake server (60s)")
-        return self.recv.get()
+        ret, exc = self.recv.get()
+        # Should probably turn all exceptions in exc back into exceptions?
+        # For now, at least handle BBHandledException
+        if exc and "BBHandledException" in exc:
+            raise bb.BBHandledException()
+        return ret, exc
 
     def updateFeatureSet(self, featureset):
         _, error = self.runCommand(["setFeatures", featureset])
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 87e873d6..e70c2464 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -380,14 +380,27 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
               "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
               "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.event.ProcessProgress", "bb.event.ProcessFinished"]
 
+def drain_events_errorhandling(eventHandler):
+    # We don't have logging setup, we do need to show any events we see before exiting
+    event = True
+    logger = bb.msg.logger_create('bitbake', sys.stdout)
+    while event:
+        event = eventHandler.waitEvent(0)
+        if isinstance(event, logging.LogRecord):
+            logger.handle(event)
+
 def main(server, eventHandler, params, tf = TerminalFilter):
 
-    if not params.observe_only:
-        params.updateToServer(server, os.environ.copy())
+    try:
+        if not params.observe_only:
+            params.updateToServer(server, os.environ.copy())
 
-    includelogs, loglines, consolelogfile, logconfigfile = _log_settings_from_server(server, params.observe_only)
+        includelogs, loglines, consolelogfile, logconfigfile = _log_settings_from_server(server, params.observe_only)
 
-    loglevel, _ = bb.msg.constructLogOptions()
+        loglevel, _ = bb.msg.constructLogOptions()
+    except bb.BBHandledException:
+        drain_events_errorhandling(eventHandler)
+        return 1
 
     if params.options.quiet == 0:
         console_loglevel = loglevel
-- 
2.25.1


