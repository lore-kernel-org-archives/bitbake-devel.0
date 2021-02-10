Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web12.3961.1612955560744871394
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Feb 2021 03:12:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=fg8Fmzf/;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id w36so2236591lfu.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Feb 2021 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeWdTyoyoSW6dvPkZY3qUHIJ0/Zz5QmHLdkj2tyxLIQ=;
        b=fg8Fmzf/8QubU34fUTYJVRheA9hkCR5zECqa6KFnhXqXp6IncHuzpqSWTvzlGKMh0p
         o0/Xm6Novktkw13DXlsCrjKIjq2fJEqdPU8pN7wdjngVworPqWd7wAGcFkvvVXd5KqBN
         5wOEnt+RmmwINN/zCDMxr2Mk2XqrTicEDHS4mglqeNL0Fau0qh6h/bsRXaouG+ssljzL
         TDOXWBi3tCxRYdacBElW0D0xmXsr7fdVf5yWJhpMr2M9M6cQzEJ4JAGDKfhnaeEZ77e9
         puu7isMP18F1j6sKB6EHTY1Gkfkm+0iXzohb6SpBVJDA2YJX1aSEoaVMZUjP7i1dmzD9
         eabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeWdTyoyoSW6dvPkZY3qUHIJ0/Zz5QmHLdkj2tyxLIQ=;
        b=KNbxNq+LxF7Bmz0AKWKB73v+dr+xoJ/xlz1nT2HxjnTHWLybge6if5YBLcWEzgvWFT
         L1KP6ZbBohZS7OCXkXwA/lybfCm+IHLu4A5TyZuONQByKaigvCHyckDHsxM1Bvl6ApwU
         mYyQE94iwTTxD7zC5PQb99szjcCFiiRG4MywfvKcMW7lUd/Dhezvdo3Dj7yuzIQDMSMX
         hBCKXR0fyOCnkYVi1fWRTaXQ3oC0rpdfij7CZgf1t8RQpb6EVDn4PUhSuLU1CWaniHfQ
         OWBrD+D5wKWYgiFkn+HJfIkirP2305CGW4/aHNTxvBIP6ARkUQ2LOZLBA3ddg2GfrqmU
         7lEw==
X-Gm-Message-State: AOAM531j6bByGUnB+yLVzcmzf/a2tcddUAp0gdEFYBsnT4HRdqBmcP4a
	dN4PZapV225wid2wM8l4xuEtYGDrNAo=
X-Google-Smtp-Source: ABdhPJyASaBG5Hwjuiq3wQoeYBIHtL19uvOuTNklKd6rhu2R6OmrVp/gA+vQ3MGHP0e3rZrshj9jew==
X-Received: by 2002:a05:6512:3194:: with SMTP id i20mr1447401lfe.283.1612955558466;
        Wed, 10 Feb 2021 03:12:38 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id w21sm270195lfu.132.2021.02.10.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 03:12:37 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH v5] event: Prevent bitbake from executing event handler for wrong multiconfig target
Date: Wed, 10 Feb 2021 12:15:15 +0100
Message-Id: <20210210111515.1189896-1-tomasz.dziendzielski@gmail.com>
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

Add mc target name as a prefix to event handler name so there won't be
two different handlers with the same name. Add internal __BBHANDLERS_MC
variable to have the handlers lists per machine.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

--- v5 move the whole logic to event.bb, fix tests
---
 lib/bb/cookerdata.py |  2 +-
 lib/bb/event.py      | 26 ++++++++++++++++++++++++--
 lib/bb/parse/ast.py  |  2 +-
 lib/bb/runqueue.py   |  4 ++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c39b5681..1c1e008c 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -429,7 +429,7 @@ class CookerDataBuilder(object):
                 parselog.critical("Undefined event handler function '%s'" % var)
                 raise bb.BBHandledException()
             handlerln = int(data.getVarFlag(var, "lineno", False))
-            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln, data)
 
         data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
 
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 694b4705..ff899594 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,6 +118,8 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
+            if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
+                continue
             execute_handler(name, handler, event, d)
 
 ui_queue = []
@@ -227,9 +229,13 @@ def fire_from_worker(event, d):
     fire_ui_handlers(event, d)
 
 noop = lambda _: None
-def register(name, handler, mask=None, filename=None, lineno=None):
+def register(name, handler, mask=None, filename=None, lineno=None, data=None):
     """Register an Event handler"""
 
+    if data and data.getVar("BB_CURRENT_MC"):
+        mc = data.getVar("BB_CURRENT_MC")
+        name = '%s%s' % (mc, name)
+
     # already registered
     if name in _handlers:
         return AlreadyRegistered
@@ -268,10 +274,20 @@ def register(name, handler, mask=None, filename=None, lineno=None):
                     _event_handler_map[m] = {}
                 _event_handler_map[m][name] = True
 
+        if data:
+            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
+            bbhands_mc.append(name)
+            data.setVar("__BBHANDLERS_MC", bbhands_mc)
+
         return Registered
 
-def remove(name, handler):
+def remove(name, handler, data=None):
     """Remove an Event handler"""
+    if data:
+        if data.getVar("BB_CURRENT_MC"):
+            mc = data.getVar("BB_CURRENT_MC")
+            name = '%s%s' % (mc, name)
+
     _handlers.pop(name)
     if name in _catchall_handlers:
         _catchall_handlers.pop(name)
@@ -279,6 +295,12 @@ def remove(name, handler):
         if name in _event_handler_map[event]:
             _event_handler_map[event].pop(name)
 
+    if data:
+        bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
+        if name in bbhands_mc:
+            bbhands_mc.remove(name)
+            data.setVar("__BBHANDLERS_MC", bbhands_mc)
+
 def get_handlers():
     return _handlers
 
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 0714296a..dc1d7643 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -335,7 +335,7 @@ def finalize(fn, d, variant = None):
             if not handlerfn:
                 bb.fatal("Undefined event handler function '%s'" % var)
             handlerln = int(d.getVarFlag(var, "lineno", False))
-            bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln, data=d)
 
         bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7d493eb4..fe4deb19 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1466,7 +1466,7 @@ class RunQueue:
             if not self.dm_event_handler_registered:
                  res = bb.event.register(self.dm_event_handler_name,
                                          lambda x: self.dm.check(self) if self.state in [runQueueRunning, runQueueCleanUp] else False,
-                                         ('bb.event.HeartbeatEvent',))
+                                         ('bb.event.HeartbeatEvent',), data=self.cfgData)
                  self.dm_event_handler_registered = True
 
             dump = self.cooker.configuration.dump_signatures
@@ -1505,7 +1505,7 @@ class RunQueue:
         build_done = self.state is runQueueComplete or self.state is runQueueFailed
 
         if build_done and self.dm_event_handler_registered:
-            bb.event.remove(self.dm_event_handler_name, None)
+            bb.event.remove(self.dm_event_handler_name, None, data=self.cfgData)
             self.dm_event_handler_registered = False
 
         if build_done and self.rqexe:
-- 
2.30.0

