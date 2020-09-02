Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.5312.1599046472536245607
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2020 04:34:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Eutxz880;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id w5so4861945wrp.8
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2020 04:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcAStv94F4e+iNbwsSWx5R4UIuYrzko6MDVdCLbV5wM=;
        b=Eutxz880mTkRn7NmdijJ65M9LRIeF8j8OK7MEjFG0BeK+Y6hqtQ19ye6S7Thmiz2ty
         6lrOkcVo9DSLyzTl5PAfjbYlkqImyEmYTUV+guH6OCiC6PQ9lU7VOGbbBvxASIlvxCe3
         I3w/5daeybHG5fRQ47UccycZvTMEhOCh20rj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcAStv94F4e+iNbwsSWx5R4UIuYrzko6MDVdCLbV5wM=;
        b=oSGlC0bySmjVBi2ULhyvOToatAdUpArh2b+5hatkRzWyIOpRslFJMgPy3p91UpZy/y
         GpF3NjEpuWhJC6kJq98dWPyUWdN0dGxL2qaPSmRgMU2lcawBwMdRucCN9qvBySbL3H4F
         3KkkuXH9JISY2MnAM5QoBfTM84STMG6kNNeLrh1oqIvqYD+q9/a+JccDYEy/S+3xsJOV
         rvT2Enb5Wwqrmn9Fsj/MVaGwpK36S/LBhnKGmO4Y618MCaT29kEw9EtS3NP+HHgLHPFj
         pDDTteeMOO/1q45TAXgsqpwwM+2xpG+MDCdBAVMkXVy1hJp4cy4j0pXQyfNhvelCWIeN
         oQFg==
X-Gm-Message-State: AOAM531V7HXyFBelAW2mHHidJXvPCmHIKsNSuIkSAOHXNK2NCeFdBFoq
	JL4ewFpS3/HfKs2UfBKYx8W9JXvA94fYvJlx
X-Google-Smtp-Source: ABdhPJyHOET2sPJerPlFY0jBB8Xdjfvnnb5hUtkLxFeu+6tFBWrxirKzRz3izgKoEz6miDC6iPXFXg==
X-Received: by 2002:a5d:568d:: with SMTP id f13mr6561986wrv.303.1599046470495;
        Wed, 02 Sep 2020 04:34:30 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (4.a.9.e.c.f.e.5.5.1.2.c.8.4.d.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:9d48:c215:5efc:e9a4])
        by smtp.gmail.com with ESMTPSA id v204sm6297619wmg.20.2020.09.02.04.34.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 04:34:30 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] process/knotty: Improve early exception handling
Date: Wed,  2 Sep 2020 12:34:29 +0100
Message-Id: <20200902113429.1733128-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 lib/bb/server/process.py |  7 ++++++-
 lib/bb/ui/knotty.py      | 21 +++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4d3d1a4308..8699765a31 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -365,7 +365,12 @@ class ServerCommunicator():
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
index a3507afb7c..a91e4fd15c 100644
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

