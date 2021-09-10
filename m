Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web12.9056.1631280376412214906
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Sep 2021 06:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YxEZZgc0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so1386788wml.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Sep 2021 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6asrJ9F5py39pMwEkO7xrnkeUBrljhducpnGOiSN00=;
        b=YxEZZgc0IQC7ovyc86RTh4JWpljzotRdJr8W52HPsx1GDjoqJcyhwuMOyGBtvQsJJ/
         faSgcFgAXznKSZakOkqVMpNvKCQxOVl11EPahiRKGDywMEWKaUw2/7O1bCvg+JwlQ747
         k8Z6LZUhWvxCB6pWUWs8F3BohFtB+UU5c3q44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6asrJ9F5py39pMwEkO7xrnkeUBrljhducpnGOiSN00=;
        b=yGN6qjpILFY3lTSMMVaeajUstBktfpY3dZekyAIvAdwrTvqBR9sAICCpUGckYB92cy
         aOzvG8tdeWdv7CCrs2+fRjx64Fyv141TfxHeatHBJ/JXJTZQbPc3xgBvTb8bt2Q+YEQ/
         0FtXkadSQjoK9v7lJAWVfVqi9p5K2KuqnYlxDS8ieljt6geCngrpmv/IjqPxLopsLtkO
         4aLGU9fAnbjv66rSDbG9QYCnh/H2iRuZFyjjqSescoHpoBFmC/ubS5SM3Kk4oZYIhWeI
         VcuLAP++qHzysOd9xL0zaZd32SMXtNR8zBFToO8TadDir6j3c/cbXqfvSmHvTPafq2WQ
         K15Q==
X-Gm-Message-State: AOAM530DXI3PtyGe4J+BApXVLtjaITuQYAP9uUmDaRcmgl2FU3iXyvKB
	+5ABMsvSKz7hC3/q7yY6G9IjQzn30lWf4bzX
X-Google-Smtp-Source: ABdhPJwRrW0hcK2eWO3x5eydhQvOOT54QXmqkw2YcKiX68QLJCmpFT6NT5hd/+spwJVzmjDfbzRJVw==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr7127590wmk.37.1631280374617;
        Fri, 10 Sep 2021 06:26:14 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id e2sm4827798wra.40.2021.09.10.06.26.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 06:26:14 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart: Make ExpansionErrors more readable
Date: Fri, 10 Sep 2021 14:26:13 +0100
Message-Id: <20210910132613.1255886-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds context to ExpansionError messages which show the variable chain for which
expansion is being attempted. This should allow users to debug the issues more easily
than the current message (the first line alone below). Example output from a
SRC_URI which references ${S}:

bb.data_smart.ExpansionError: Failure expanding variable PV, expression was 0.1+git${SRCPV} which triggered exception RecursionError: maximum recursion depth exceeded while calling a Python object
The variable dependency chain for the failure is: PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV -> PV -> WORKDIR -> S -> SRC_URI -> SRCPV
-> PV -> BP -> FILESPATH

which is more useful that no output. We could truncate at repetition but I suspect
this makes this clearer as it stands so there is little value in complicating the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 65528c6ae6..515d195fe8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -151,6 +151,7 @@ class ExpansionError(Exception):
         self.expression = expression
         self.variablename = varname
         self.exception = exception
+        self.varlist = [varname or expression]
         if varname:
             if expression:
                 self.msg = "Failure expanding variable %s, expression was %s which triggered exception %s: %s" % (varname, expression, type(exception).__name__, exception)
@@ -160,8 +161,13 @@ class ExpansionError(Exception):
             self.msg = "Failure expanding expression %s which triggered exception %s: %s" % (expression, type(exception).__name__, exception)
         Exception.__init__(self, self.msg)
         self.args = (varname, expression, exception)
+
+    def addVar(self, varname):
+        self.varlist.append(varname)
+
     def __str__(self):
-        return self.msg
+        chain = "\nThe variable dependency chain for the failure is: " + " -> ".join(self.varlist)
+        return self.msg + chain
 
 class IncludeHistory(object):
     def __init__(self, parent = None, filename = '[TOP LEVEL]'):
@@ -407,7 +413,8 @@ class DataSmart(MutableMapping):
                         raise
                 if s == olds:
                     break
-            except ExpansionError:
+            except ExpansionError as e:
+                e.addVar(varname)
                 raise
             except bb.parse.SkipRecipe:
                 raise
-- 
2.32.0

