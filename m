Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web12.3562.1612476733764909479
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Feb 2021 14:12:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=kcwPATwF;
 spf=pass (domain: gmail.com, ip: 209.85.208.171, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f171.google.com with SMTP id t8so5311477ljk.10
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Feb 2021 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKl5Yc3sTef11qlsjUbwQ6Ape5m79/YjDiwBUcU0xbc=;
        b=kcwPATwFnVPs8K9ZDq1XjSSH/WpHh9QJyDizD8ipNi9a/HeQBt8zpFlZCY5PIVbBtz
         dijESuwSB1kXSoLX1bWcQoifbYcMeb7wZboSyJ+gliJojhBD9YLrrUZQ4Gde8PfxlXdf
         reFdOJT4XEkgTjWh2oSaccuuaWrSP3ULqKsMhUxlve0sdaqh/vXnTuXc19vnOSllASX0
         wfI9NBWwhGy3K6BAwWaE6xoIKDviBeDx1MnpRs/f6dlEUnfKAg8E9M9Ew4Ufi/3i0QIl
         QcyRIlnbD9I0SrLYmP16/nJsmbYN+TvW0xRNju3wYRk4jFa3NQZBVmy4pAKpXFaxOZ6O
         Mh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKl5Yc3sTef11qlsjUbwQ6Ape5m79/YjDiwBUcU0xbc=;
        b=nLGtqFcsKGqGDm2+09WWtmxVbs9R3OBdD05fuBVVnkhlYezRM9vH2wd+swdyAT/by7
         Uxg2nQ3DMWWIYENQD0xQy1KLlwyS/r6ZI7yR903L+MJ1IkBLvEJZPG1RnavryNlGshiG
         0S04xALKDfvoTpedG3tppap9LkamwiisM8qELOsKQj/xPMfoieqydU7z3GdL+stl6zQx
         HlhRqZCcGFtNT1aGWtdKeVWMGROyRnIRGrVbjkF8M1V09R2l+D0ZB7k74Q5RcCt7FxK4
         ZKIhc3hj88HN1Jh1FkwNJmTg0gkwoUBeOI9ECjohmtgXtvZemfXP8pTReGqkcLVEoys9
         nIdg==
X-Gm-Message-State: AOAM532Y0shXwkK7DZAKYl0GUUWRasGghY1aGGJ5qYP2loZXJ/47eEu2
	xYyJJB6KGC8IMsZmbQcsEqz9K5sxV9JkRA==
X-Google-Smtp-Source: ABdhPJxbU+22yg9cDxdpR/HRPLUwuD/Ho5JNCeK/vMuGLYRvJ6d5KtC9XlUiK5C3cYg9UXoFux8Lmg==
X-Received: by 2002:a2e:a406:: with SMTP id p6mr863695ljn.30.1612476731542;
        Thu, 04 Feb 2021 14:12:11 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id l9sm754890lfk.76.2021.02.04.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 14:12:10 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH] event: Prevent bitbake from executing event handler for wrong multiconfig target
Date: Thu,  4 Feb 2021 23:14:22 +0100
Message-Id: <20210204221422.16042-1-tomasz.dziendzielski@gmail.com>
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
---
 lib/bb/cookerdata.py | 3 ++-
 lib/bb/event.py      | 5 +++++
 lib/bb/parse/ast.py  | 7 ++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c39b5681..108346ce 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -429,7 +429,8 @@ class CookerDataBuilder(object):
                 parselog.critical("Undefined event handler function '%s'" % var)
                 raise bb.BBHandledException()
             handlerln = int(data.getVarFlag(var, "lineno", False))
-            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            nvar = mc + var
+            bb.event.register(nvar, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
 
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 694b4705..d0ddac23 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,6 +118,11 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
+
+            mc_prefix = d.getVar('BB_CURRENT_MC') or ""
+            if mc_prefix and not name[len(mc_prefix):] in (d.getVar("__BBHANDLERS") or []):
+                continue
+
             execute_handler(name, handler, event, d)
 
 ui_queue = []
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 0714296a..202cbffb 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -335,7 +335,12 @@ def finalize(fn, d, variant = None):
             if not handlerfn:
                 bb.fatal("Undefined event handler function '%s'" % var)
             handlerln = int(d.getVarFlag(var, "lineno", False))
-            bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+
+            nvar = var
+            if d.getVar('BB_CURRENT_MC', False):
+                nvar = d.getVar('BB_CURRENT_MC', False) + var
+
+            bb.event.register(nvar, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
-- 
2.30.0

