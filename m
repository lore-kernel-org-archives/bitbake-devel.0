Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.336.1612549147980763470
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 10:19:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=REaOM6uK;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id d3so11148966lfg.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbdvrbcMGby44LAhUi5g/2Qi36tYjnTVGDmQrMznO6k=;
        b=REaOM6uK4IemO+Sit1t8s/b69xiHqH1AQGJHSrWso9f39bH5CahIMurl3ac1HaTvpl
         tkWCsETZUmLpFEAHhYVRafJcd6j/sAR7+bYAAcSBoW8aLTr3YNNkf4PZgKiHckQeIOc0
         rsW0ArWuo6c7AHmTTQwKjwWxH9puVfwASemFJ9IL0GQ9m/hglDmc4CZ18B7J9metNz7M
         oFLbQlRdJG6Gl8z7Do5whxr5QhQZTRCzKPSBzHb36i6FDQviMYjoCYV6l0zzbk4tmTxj
         XDoeV44FhxTSkeJOn8DmGdCtbwfZ3/LWU0BdOvzagDaFfCXFpsCd5VPS2XgjMDEGmmLV
         RH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PbdvrbcMGby44LAhUi5g/2Qi36tYjnTVGDmQrMznO6k=;
        b=Cz7cTp9V2bVMSjmSyZHNtJGf10W3KUt6HMCWrfTlbtnJ3r50UA/9FiP5XyzaUuUkqb
         oFKkK/aiU+/Vl8uEfsDGUi6Onl6Or0JDk7+hhzUHpDH0xv8B8L4A7wStoWpIj90oSQbp
         DwckB9RZB1UMRh8dPFEKih4Eex/XR6G4441p7BPn0mxcLs27Ep0YwF3GrnGqI5v1IuZg
         qkF/WRjW/8NdF7nlHhn/XfEB9Wq1QMwdNS+7NNQjMGMs/kqg12GrgWMejJG3qxrbgUU0
         1x3xtZeE7VQSBTx2na4Ri+PLMAXPfr1LXDMRmolhOuayu3dRpW9KanjXuyIZ/o7q6ZIs
         NbTw==
X-Gm-Message-State: AOAM531iLXKrHTj4gxVei6WQhYqCALVMZteoX1eGg1lIL8rpe16PWWGl
	9BNIzbSq/l5Y2OIbxlNmhMCqUS1cN40=
X-Google-Smtp-Source: ABdhPJynLiYTGEm4jBbgQbU7qneYylauQWrcIKvJ0mmkdUkAGb58m6wbvQzUUk0nfTUEb0P2cdbHGw==
X-Received: by 2002:a05:6512:3a8e:: with SMTP id q14mr2923825lfu.209.1612549145711;
        Fri, 05 Feb 2021 10:19:05 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id i204sm1082770lfd.120.2021.02.05.10.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:19:03 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH v2] event: Prevent bitbake from executing event handler for wrong multiconfig target
Date: Fri,  5 Feb 2021 19:21:41 +0100
Message-Id: <20210205182141.753810-1-tomasz.dziendzielski@gmail.com>
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

I added a mc target name as a prefix to event handler name so there
won't be two different handlers with the same name.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

--- compared to previous patch I added mc prefix before putting to __BBHANDLERS, so hashes are not changed during the build and oe-selftest paseses
---
 lib/bb/cookerdata.py | 5 ++++-
 lib/bb/event.py      | 2 ++
 lib/bb/parse/ast.py  | 7 ++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

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
 
-- 
2.30.0

