Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F7C46467
	for <webhook@archiver.kernel.org>; Sun, 27 Nov 2022 21:36:15 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.102069.1669584973731205105
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Nov 2022 13:36:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Pc0Kv74S;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so10247313wma.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 13:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NuGPkDb35+lGM/91pYwt7URM0NKYgGQbMmsKdKB2Wmk=;
        b=Pc0Kv74SkAggNpmawv2Hjs6dzuFcfqbuzBV0v3mYFrR4m/pKyKYMqi0XEZ2UksGtyT
         AO+BN0CfBPEKlXr6lE+Jb3A9JHRWhZG7jOdC2Bpscx9tsTZPTTLPzELm9gjF++gsn9iE
         PhaG6OC52CHEOhJNbaUHDhaUmtr0JBPdJT+rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuGPkDb35+lGM/91pYwt7URM0NKYgGQbMmsKdKB2Wmk=;
        b=Cg6VAdSB+rkn+C66t8uTZ3ZJ/PUa7hDvUxNZT+E5cZSKs0JCocOLTgUDS6kEp/JySq
         BWcGzU2GUG7nhyaHYDuUiKYnE66IbsmkP1xgzh+Bdey4+Wddyxka2rwWCK6q3psHGtdp
         zZO/dPqTjeKNsIY4O/1VpwlyyIHrZajepXitkORgAYxXDAsROPry7dRf1DPcHhoFGfsv
         v+hrB11+QFNg8jNBqv9z/1rnBwCa9CGCCaEF55qh31wKwSP0GWSBc61ZHF5njEU+Z+Ek
         MfT597esNQnu2DDK89X1QvfidT8YZzv+Ge5puxUWrZ2qWaP+3cy0heKvpM194TI2/yO5
         j1Nw==
X-Gm-Message-State: ANoB5pnhWkqWTWuE4wYEaxNUQbaVku8ZsXp58gJHY0yZsu7fWIQXM2Rl
	tM5+5EwT+oTpzmoi0ow/nxzQTie1TePOMw==
X-Google-Smtp-Source: AA0mqf6ntBoXYm2qUKr9K6Kr1Cx+dDVZ1TQq2rFePDuTLIQZ6Z3Q1qqa7R/X++oNwsEyL9kfCDwSwA==
X-Received: by 2002:a7b:cbcb:0:b0:3cf:a83b:cf25 with SMTP id n11-20020a7bcbcb000000b003cfa83bcf25mr24008017wmi.170.1669584971600;
        Sun, 27 Nov 2022 13:36:11 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:aafe:fe4:d699:e1e9])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b003a84375d0d1sm18262211wmq.44.2022.11.27.13.36.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 13:36:11 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH RFC 1/2] parse: Add support for addpylib conf file directive
Date: Sun, 27 Nov 2022 21:36:09 +0000
Message-Id: <20221127213610.539976-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 21:36:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14115

For many years OE-Core has injected it's own python modules into the
python namespace using an immediate expansion of a variable in base.bbclass.

We really need this to become a first class citizen of the langauge, this new
addpylib directive allows that. Usage is of the form:

addpylib <directory> <namespace>

The namespace is imported and if there is an attribute BBIMPORT, that
list of names is iterated and imported too.

This mirrors what OE-Core has done for a long time with one difference in
implmentation, sys.path is only appended to. This means later imported
namespaces can't overwrite an earlier one and can't overwrite the main
python module space. In practice we've never done that and it isn't
something we should encourage or support.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py                  | 22 ++++++++++++++++++++++
 lib/bb/parse/parse_py/ConfHandler.py |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 9e0a0f5c98..7bfee9ed67 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -9,6 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import sys
 import bb
 from bb import methodpool
 from bb.parse import logger
@@ -269,6 +270,24 @@ class BBHandlerNode(AstNode):
             data.setVarFlag(h, "handler", 1)
         data.setVar('__BBHANDLERS', bbhands)
 
+class PyLibNode(AstNode):
+    def __init__(self, filename, lineno, libdir, namespace):
+        AstNode.__init__(self, filename, lineno)
+        self.libdir = libdir
+        self.namespace = namespace
+
+    def eval(self, data):
+        libdir = data.expand(self.libdir)
+        if libdir not in sys.path:
+            sys.path.append(libdir)
+        try:
+            bb.utils._context[self.namespace] = __import__(self.namespace)
+            toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
+            for i in toimport:
+                bb.utils._context[i.split(".", 1)[0]] = __import__(i)
+        except AttributeError as e:
+            bb.error("Error importing OE modules: %s" % str(e))
+
 class InheritNode(AstNode):
     def __init__(self, filename, lineno, classes):
         AstNode.__init__(self, filename, lineno)
@@ -320,6 +339,9 @@ def handleDelTask(statements, filename, lineno, m):
 def handleBBHandlers(statements, filename, lineno, m):
     statements.append(BBHandlerNode(filename, lineno, m.group(1)))
 
+def handlePyLib(statements, filename, lineno, m):
+    statements.append(PyLibNode(filename, lineno, m.group(1), m.group(2)))
+
 def handleInherit(statements, filename, lineno, m):
     classes = m.group(1)
     statements.append(InheritNode(filename, lineno, classes))
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 451e68dd66..8c15e8d5b6 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -46,6 +46,7 @@ __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
+__addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 
 def init(data):
     return
@@ -189,6 +190,11 @@ def feeder(lineno, s, fn, statements):
         ast.handleUnsetFlag(statements, fn, lineno, m)
         return
 
+    m = __addpylib_regexp__.match(s)
+    if m:
+        ast.handlePyLib(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.34.1


