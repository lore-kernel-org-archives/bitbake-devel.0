Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0B2C43219
	for <webhook@archiver.kernel.org>; Thu, 17 Nov 2022 15:29:34 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.18836.1668698972556497435
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Nov 2022 07:29:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ofz6fWZ1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id g12so4402377wrs.10
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Nov 2022 07:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PX3GxPFqiDcbYTipsTgt+wBqsX/BStwJFOODAIlWUFs=;
        b=Ofz6fWZ1m2dgU552S4wB3tn6tsJ2a+Y2gYnsoy9zWE1AfbyovUvWDCThag+kP7hoLR
         SEZhMs/TNK776/ZH5cImZPMz6xm1wieWcBO/y39yjYqK7pekVQb93jyQptiv/vycrSQg
         2E35hXWV1dKjEDtC+Mcb0CoWMJgRf0LxGUkRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX3GxPFqiDcbYTipsTgt+wBqsX/BStwJFOODAIlWUFs=;
        b=JEGTJkCTp01gv4XrJIZffkjyPaPmj4GfZaQtRua2xdBe5OFLmub+ABL0mzRNJHifrj
         oJWf6q/5VGagT0ekcW4hvGDgyRbcaVTjayKJAHZYzAuC/ysBQCypFKpNcL9R1nY/Gdr5
         nWScnnEOWkjj+pWrG9XxHQpzmWDDjDTAus1PHHwhOcXlqC3OWTUXsg+78nHe5zTPWluR
         cpt+nyRrvg33pYpNjIyPJVSV/au3JouLL1hCfGfypVRH4LXr/fWtAVhg5+JNpIhKV5Ms
         vrX1zsrwznMhl/LZxc1FxUfhh9Bn9DjNh/imlCFgK4iAizevlR1czDrm9MMevrQt1ysW
         JuJQ==
X-Gm-Message-State: ANoB5pnP1yoTpfVPCJ9xEGaxJxvzlu6fin1E1YXYAn5dkPcTdTCoCKBQ
	J+ehKIO6s9y7QsBcpTzU4sx8zQvAX+pTWw==
X-Google-Smtp-Source: AA0mqf5REVKAh6MgL0d3RQr+etoQgrI5wgM+R9I1JMCvBq+BBHEPEmddWGdcQE5BuvG6dGthtEGC1A==
X-Received: by 2002:adf:e4cf:0:b0:241:a047:d011 with SMTP id v15-20020adfe4cf000000b00241a047d011mr1823370wrm.258.1668698969792;
        Thu, 17 Nov 2022 07:29:29 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:76d7:bdc9:5165:906c])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d604d000000b00236695ff94fsm1254306wrt.34.2022.11.17.07.29.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 07:29:29 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] server: Ensure cooker profiling works
Date: Thu, 17 Nov 2022 15:29:26 +0000
Message-Id: <20221117152928.2738113-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Nov 2022 15:29:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14088

The previous cleanups meant that when the cooker was started, profiling
was always disabled as configuration was sent to the server later and this
was too late to profile the main loop.

Pass the "profile" option over the server commandline so that we can
profile cooker itself again, the setting can now take effect early enough.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-server       | 7 ++++---
 lib/bb/main.py           | 2 +-
 lib/bb/server/process.py | 8 +++++---
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-server b/bin/bitbake-server
index f53f88b6b0..825e9d56af 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -16,7 +16,7 @@ if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports UTF-8 (such as LANG=en_US.UTF-8).\nPython can't change the filesystem locale after loading so we need a UTF-8 when Python starts or things won't work.")
 
 # Users shouldn't be running this code directly
-if len(sys.argv) != 10 or not sys.argv[1].startswith("decafbad"):
+if len(sys.argv) != 11 or not sys.argv[1].startswith("decafbad"):
     print("bitbake-server is meant for internal execution by bitbake itself, please don't use it standalone.")
     sys.exit(1)
 
@@ -28,7 +28,8 @@ logfile = sys.argv[4]
 lockname = sys.argv[5]
 sockname = sys.argv[6]
 timeout = float(sys.argv[7])
-xmlrpcinterface = (sys.argv[8], int(sys.argv[9]))
+profile = bool(int(sys.argv[8]))
+xmlrpcinterface = (sys.argv[9], int(sys.argv[10]))
 if xmlrpcinterface[0] == "None":
     xmlrpcinterface = (None, xmlrpcinterface[1])
 
@@ -49,5 +50,5 @@ logger = logging.getLogger("BitBake")
 handler = bb.event.LogHandler()
 logger.addHandler(handler)
 
-bb.server.process.execServer(lockfd, readypipeinfd, lockname, sockname, timeout, xmlrpcinterface)
+bb.server.process.execServer(lockfd, readypipeinfd, lockname, sockname, timeout, xmlrpcinterface, profile)
 
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 93eda3632e..f56c3d46a2 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -429,7 +429,7 @@ def setup_bitbake(configParams, extrafeatures=None):
                     logger.info("Starting bitbake server...")
                     # Clear the event queue since we already displayed messages
                     bb.event.ui_queue = []
-                    server = bb.server.process.BitBakeServer(lock, sockname, featureset, configParams.server_timeout, configParams.xmlrpcinterface)
+                    server = bb.server.process.BitBakeServer(lock, sockname, featureset, configParams.server_timeout, configParams.xmlrpcinterface, configParams.profile)
 
                 else:
                     logger.info("Reconnecting to bitbake server...")
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 5d02c0b9f5..afd77ac0a5 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -448,13 +448,14 @@ start_log_datetime_format = '%Y-%m-%d %H:%M:%S.%f'
 
 class BitBakeServer(object):
 
-    def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface):
+    def __init__(self, lock, sockname, featureset, server_timeout, xmlrpcinterface, profile):
 
         self.server_timeout = server_timeout
         self.xmlrpcinterface = xmlrpcinterface
         self.featureset = featureset
         self.sockname = sockname
         self.bitbake_lock = lock
+        self.profile = profile
         self.readypipe, self.readypipein = os.pipe()
 
         # Place the log in the builddirectory alongside the lock file
@@ -518,9 +519,9 @@ class BitBakeServer(object):
         os.set_inheritable(self.bitbake_lock.fileno(), True)
         os.set_inheritable(self.readypipein, True)
         serverscript = os.path.realpath(os.path.dirname(__file__) + "/../../../bin/bitbake-server")
-        os.execl(sys.executable, "bitbake-server", serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
+        os.execl(sys.executable, "bitbake-server", serverscript, "decafbad", str(self.bitbake_lock.fileno()), str(self.readypipein), self.logfile, self.bitbake_lock.name, self.sockname,  str(self.server_timeout or 0), str(int(self.profile)), str(self.xmlrpcinterface[0]), str(self.xmlrpcinterface[1]))
 
-def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface):
+def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpcinterface, profile):
 
     import bb.cookerdata
     import bb.cooker
@@ -549,6 +550,7 @@ def execServer(lockfd, readypipeinfd, lockname, sockname, server_timeout, xmlrpc
         try:
             featureset = []
             cooker = bb.cooker.BBCooker(featureset, server.register_idle_function)
+            cooker.configuration.profile = profile
         except bb.BBHandledException:
             return None
         writer.send("r")
-- 
2.34.1


