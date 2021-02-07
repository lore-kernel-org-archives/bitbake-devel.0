Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.19110.1612698261918659505
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Feb 2021 03:44:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=MrTs+lvC;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id e18so13106639lja.12
        for <bitbake-devel@lists.openembedded.org>; Sun, 07 Feb 2021 03:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDj0/iepm2zlYNlbCeEAe5WzwB+6DcNkKieLehQSgO4=;
        b=MrTs+lvCijOMawGFfMDjBZGuR1/k8rg6RboW+WunCbaVegCKdRIaHTz1Q1BPf6y1HR
         raOuUGDPzRH7p55HXYoMXBscx2zlg/C6KZyqUvDxMxAbWIxSetF5EDeocu++H5CUfOLZ
         ZpVa6vhmoJG9u51PPTAc/XYYK89TuYJ7kd9ddI02Qubaqa3A+xqRSO3ISdcWJo7jTipX
         RONOWQcWMy9pbiZG02woccA1qkc1JXZOfKGWHtVyFneSun7B+5Mu7+YlPw3nQ3uuKTW3
         VMpzI/2DQCGLV7LvVRqpf4iqUhMgwdhE0qkI+4HYQqbLBC1gxEjjWt2King1N16Y0CcO
         ntNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDj0/iepm2zlYNlbCeEAe5WzwB+6DcNkKieLehQSgO4=;
        b=h1HqSXmCBrDQLKWKL+lGO7bqXyg9VTMvp0HFx9kpiCE/tB9t0nHXnRCwrcNbUw7BgM
         yDrxHTOfxYKyXFeIAFJAYDls1WxTWpfYZ4DNn3XymCtDkBL5zoiP/XZPUO+5lOqE9YWu
         4mb1qkgbMn+V4qy+hifiCaiCamp492U4mkGAe6kuojx+rFIK+H2+otHU/jwbQG2Lmc4z
         Y39D0mfTEDab1DNFEtrFffDgyDKlt7Epin9iNyAd+IhKejHIEVTTSx/TmVCorX1BRyln
         uA4ClFpvZ28gkflUKpkoyXk31epUBueX5KhuGEBlBIlii0CcT2BvNaOy5/ubnMBMKTrk
         6A9Q==
X-Gm-Message-State: AOAM531J4NPfK1eKB5L1Xj8gNkan29vgLr9YExTReRXtSv/frYfJySBw
	D+NpxWgfUWdNurjH2VPcjPDpAOHyvFQ=
X-Google-Smtp-Source: ABdhPJy33cbV4jE6rFBtRsHII+9KDwYG8tg434jJ8yv0xcWGxm+Nyqt895CrJqg61Qhqwh99ytLVQw==
X-Received: by 2002:a2e:9610:: with SMTP id v16mr7574021ljh.374.1612698259684;
        Sun, 07 Feb 2021 03:44:19 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id y10sm1670294lfy.57.2021.02.07.03.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 03:44:19 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH v4] event: Prevent bitbake from executing event handler for wrong multiconfig target
Date: Sun,  7 Feb 2021 12:46:59 +0100
Message-Id: <20210207114659.148514-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiconfig is used bitbake might try to run events that don't
exist for specific mc target. In cooker.py we pass
`self.databuilder.mcdata[mc]` data that contains names of events'
handlers per mc target, but fire_class_handlers uses global _handlers
variable that is created during parsing of all the targets.

This leads to a problem where bitbake runs event handler that don't
exist for a target or even overrides them - if multiple targets use
event handler with the same name but different code then only one
version will be executed for all targets.

See [YOCTO #13071] for detailed bug information.

Add mc target name as a prefix to event handler name so there
won't be two different handlers with the same name.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

--- v4 add mc prefix to _bb_diskmonitor event handler to fix build, both build and test_stoptask_behavior should be working now
---
 lib/bb/cookerdata.py |  5 ++++-
 lib/bb/event.py      |  2 ++
 lib/bb/parse/ast.py  |  7 ++++++-
 lib/bb/runqueue.py   | 15 +++++++++++++--
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c39b5681..02995c8f 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -424,12 +424,15 @@ class CookerDataBuilder(object):
         # Nomally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
         for var in data.getVar('__BBHANDLERS', False) or []:
+            nvar=var
+            if mc:
+                var = nvar[len(mc):]
             handlerfn = data.getVarFlag(var, "filename", False)
             if not handlerfn:
                 parselog.critical("Undefined event handler function '%s'" % var)
                 raise bb.BBHandledException()
             handlerln = int(data.getVarFlag(var, "lineno", False))
-            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            bb.event.register(nvar, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
 
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 694b4705..afef7dbe 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,6 +118,8 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
+            if d and name not in (d.getVar("__BBHANDLERS") or []):
+                    continue
             execute_handler(name, handler, event, d)
 
 ui_queue = []
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 0714296a..b38978d3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -261,6 +261,8 @@ class BBHandlerNode(AstNode):
     def eval(self, data):
         bbhands = data.getVar('__BBHANDLERS', False) or []
         for h in self.hs:
+            if data.getVar('BB_CURRENT_MC', False):
+                h = data.getVar('BB_CURRENT_MC', False) + h
             bbhands.append(h)
             data.setVarFlag(h, "handler", 1)
         data.setVar('__BBHANDLERS', bbhands)
@@ -331,11 +333,14 @@ def finalize(fn, d, variant = None):
     try:
         for var in d.getVar('__BBHANDLERS', False) or []:
             # try to add the handler
+            nvar=var
+            if d.getVar('BB_CURRENT_MC', False):
+                var = nvar[len(d.getVar('BB_CURRENT_MC', False)):]
             handlerfn = d.getVarFlag(var, "filename", False)
             if not handlerfn:
                 bb.fatal("Undefined event handler function '%s'" % var)
             handlerln = int(d.getVarFlag(var, "lineno", False))
-            bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            bb.event.register(nvar, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 28bdadb4..ce14e111 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1464,7 +1464,14 @@ class RunQueue:
             bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
             if not self.dm_event_handler_registered:
-                 res = bb.event.register(self.dm_event_handler_name,
+                 bbhands = self.cfgData.getVar('__BBHANDLERS', False) or []
+                 nvar = self.dm_event_handler_name
+                 if self.cfgData.getVar('BB_CURRENT_MC', False):
+                     nvar = self.cfgData.getVar('BB_CURRENT_MC', False) + nvar
+
+                 bbhands.append(nvar)
+                 self.cfgData.setVar('__BBHANDLERS', bbhands)
+                 res = bb.event.register(nvar,
                                          lambda x: self.dm.check(self) if self.state in [runQueueRunning, runQueueCleanUp] else False,
                                          ('bb.event.HeartbeatEvent',))
                  self.dm_event_handler_registered = True
@@ -1505,7 +1512,11 @@ class RunQueue:
         build_done = self.state is runQueueComplete or self.state is runQueueFailed
 
         if build_done and self.dm_event_handler_registered:
-            bb.event.remove(self.dm_event_handler_name, None)
+            nvar = self.dm_event_handler_name
+            if self.cfgData.getVar('BB_CURRENT_MC', False):
+                nvar = self.cfgData.getVar('BB_CURRENT_MC', False) + nvar
+
+            bb.event.remove(nvar, None)
             self.dm_event_handler_registered = False
 
         if build_done and self.rqexe:
-- 
2.30.0

