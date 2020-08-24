Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.1089.1598288021292302179
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Aug 2020 09:53:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h413IjMb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id s20so4059028wmj.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Aug 2020 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NvDfkbBd7+70KYapPEvUJVLqu0fAUW1GhvZB2Nn0YXw=;
        b=h413IjMbIJ1uy4hefauyrIn3qDt3pv8cTy5J+Zgd2WRpEL36zTLl9d0zNIhR9wvYfC
         emndadpOFK/JohSl5F6+rLNnB2XuzRAya2ZZ/X65H8y8mooXq8HmR7JrgddQ5BTZWFlm
         85wQxGZGyik8WysiZ6HyaHcnogCI1FaigYU/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvDfkbBd7+70KYapPEvUJVLqu0fAUW1GhvZB2Nn0YXw=;
        b=i3gu5E5Cfe5KXa7TxqgYf3a8GN0/LNkxGNr0fUsedmm2unaYUJLk1sh8saT4FMrTuQ
         LR+s8hNni2UcIbjuH2BfX2FSoudiCczWyec4mdJ6AKWrGz1TI/GeMSM3zk9bsVoP/2kX
         BToYxhTkRKbNiZuo08yWesg/hgTmOJc3AJ+aad+FY0RkUKsrRf8JRNC2AKWoFUnVY+Oo
         jfEhopVKZAfRPumtdWJt9wX6ohKZip1pLFd3fB2Q08xizxOprpyCxKrvWCmotAvU6G42
         0u62nMAM4xYn/73p3RqmoOoKe2pkk3TCCWv1dXRx6ioztQhB2E0y7aiduPEmYLzalc8S
         0GKQ==
X-Gm-Message-State: AOAM532VWaTmBaOb5DsHWOJO0xmLQHrqeYIH5TC0FnMxqzTe5w8vULPl
	ltdzFnZkWFxae/FBU3n8ZZmsEe0G0gfJYT3q
X-Google-Smtp-Source: ABdhPJzLSyuXGB4gkEIwrnE0q8PSckUSe7I4pfJLWDAOCqr/0mDhIgLIlMPiLakMRmWg6o4/jX4DLA==
X-Received: by 2002:a7b:cf13:: with SMTP id l19mr158597wmg.115.1598288015454;
        Mon, 24 Aug 2020 09:53:35 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (d.d.0.9.8.0.3.8.5.d.6.d.5.a.5.4.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:45a5:d6d5:8308:90dd])
        by smtp.gmail.com with ESMTPSA id f19sm182127wmh.44.2020.08.24.09.53.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 09:53:34 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 04/10] cooker/cookerdata: Ensure UI event log is updated from commandline
Date: Mon, 24 Aug 2020 17:53:25 +0100
Message-Id: <20200824165331.1373725-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
References: <20200824165331.1373725-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the eventlog is not handled correctly for memory resident
bitbake. Fix this by allowing adpations to configuration changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py     | 18 +++++++++++-------
 lib/bb/cookerdata.py |  2 +-
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c34de303fb..3f351cbea6 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -150,6 +150,7 @@ class BBCooker:
 
     def __init__(self, configuration, featureSet=None, idleCallBackRegister=None):
         self.recipecaches = None
+        self.eventlog = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
         if featureSet:
@@ -199,13 +200,6 @@ class BBCooker:
         bb.debug(1, "BBCooker parsed base configuration %s" % time.time())
         sys.stdout.flush()
 
-        # we log all events to a file if so directed
-        if self.configuration.writeeventlog:
-            # register the log file writer as UI Handler
-            writer = EventWriter(self, self.configuration.writeeventlog)
-            EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
-            bb.event.register_UIHhandler(EventLogWriteHandler(writer))
-
         self.inotify_modified_files = []
 
         def _process_inotify_updates(server, cooker, abort):
@@ -449,6 +443,16 @@ class BBCooker:
             if hasattr(self.configuration, o):
                 setattr(self.configuration, o, options[o])
 
+        if self.configuration.writeeventlog:
+            if self.eventlog and self.eventlog[0] != self.configuration.writeeventlog:
+                bb.event.unregister_UIHhandler(self.eventlog[1])
+            if not self.eventlog or self.eventlog[0] != self.configuration.writeeventlog:
+                # we log all events to a file if so directed
+                # register the log file writer as UI Handler
+                writer = EventWriter(self, self.configuration.writeeventlog)
+                EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
+                self.eventlog = (self.configuration.writeeventlog, bb.event.register_UIHhandler(EventLogWriteHandler(writer)))
+
         bb.msg.loggerDefaultLogLevel = self.configuration.default_loglevel
         bb.msg.loggerDefaultDomains = self.configuration.debug_domains
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 9eddf7cf6a..3baa9ade1b 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -62,7 +62,7 @@ class ConfigParameters(object):
                   "extra_assume_provided", "profile",
                   "prefile", "postfile", "server_timeout",
                   "nosetscene", "setsceneonly", "skipsetscene",
-                  "runall", "runonly"]:
+                  "runall", "runonly", "writeeventlog"]:
             options[o] = getattr(self.options, o)
 
         options['build_verbose_shell'] = self.options.verbose
-- 
2.25.1

