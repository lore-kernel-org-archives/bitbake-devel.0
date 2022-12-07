Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5174C352A1
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 14:15:51 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.16166.1670422544781815623
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 06:15:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=higYqVi8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id co23so825517wrb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCYqat5wZQ0Am5XH/LyxplKXwSjLpsv7f8D+Pf0bbdc=;
        b=higYqVi8lrMICmvzWKRhVtPzkcRKECF8W2YffLg6lkkuiqUysjkRJ0CaAxApshY+c7
         ZRNdSzKVHxbp7Er0298PDOi20WwoocV//pY/2DoH1HBcXy/JQY/coUmxxwg6xYXn3L2v
         GcPI2NPvbtVhrtsZtOEZ00i2AP68b74ZMiy4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCYqat5wZQ0Am5XH/LyxplKXwSjLpsv7f8D+Pf0bbdc=;
        b=w8qnllGMPSlGqxcAJFhiqqFHOkjir7NFZBfnyYcOs0Jq/3qKDXLOYq2p3oj5aYCxif
         Ya4eH0EtY8rmSF+HeN5XTi/D0PWCAUvn+eN3Da7xTYATviEv/bjIDtnnGeL5LPQ3KftI
         5lv1nTC/qu5ksv7pALfObcLNEM/nGyOJ5RXVScN9cbII+hE8/ymVI/T8IIRl36LUyF28
         02hlYZlgJ8Bb1qffhdq7Zw9icxplcYEdnECS7FVHZjx9y5KjvJMdL8TQGg2hJN3UZwvE
         WEPsuunhk3MzbkTTLDMbH91cCbh7uAsjQ2wf73GF9SBH3oPUZ+cLFqMKir7PDK6W0tFP
         VIFQ==
X-Gm-Message-State: ANoB5pkf6jHJ3JeLqjKuPpvSyQUzmCKkVhN/qbp/4H3CSXi3OaRTbq4C
	DFO3cY1mqM2I2xFATLRmqybg0duu3QU2qVLx
X-Google-Smtp-Source: AA0mqf6MEswQBLRltvmm0Eo7NrvkdXe0STR7GjoJtf8WRvyTTVzkiUgie2XHUGJtknPG3Qf80BeiVQ==
X-Received: by 2002:adf:db01:0:b0:242:3ddc:2b36 with SMTP id s1-20020adfdb01000000b002423ddc2b36mr15828144wri.288.1670422542479;
        Wed, 07 Dec 2022 06:15:42 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c359100b003c6b7f5567csm7454813wmq.0.2022.12.07.06.15.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:15:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse: Add support for addpylib conf file directive and BB_GLOBAL_PYMODULES
Date: Wed,  7 Dec 2022 14:15:39 +0000
Message-Id: <20221207141539.2129083-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 14:15:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14142

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

The new directive is only applied for .conf files and not other filetypes
as it only makes sense in that context. It is also only allowed in the
"base configuration" context of cookerdata since adding it at the recipe
level wouldn't work properly due to the way it changes the global namespace.

At the same time, move the list of modules to place in the global namespace
into a BB_GLOBAL_PYMODULES variable. It is intended that only the core layer
should touch this and it is meant to be a very small list, usually os and sys.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py                 |  2 +-
 lib/bb/parse/__init__.py             |  4 ++--
 lib/bb/parse/ast.py                  | 27 +++++++++++++++++++++++++++
 lib/bb/parse/parse_py/BBHandler.py   |  4 ++--
 lib/bb/parse/parse_py/ConfHandler.py | 14 +++++++++++---
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c322ab2ffb..28cb59d83a 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -184,7 +184,7 @@ def catch_parse_error(func):
 
 @catch_parse_error
 def parse_config_file(fn, data, include=True):
-    return bb.parse.handle(fn, data, include)
+    return bb.parse.handle(fn, data, include, baseconfig=True)
 
 @catch_parse_error
 def _inherit(bbclass, data):
diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
index 347609513b..4cd82f115b 100644
--- a/lib/bb/parse/__init__.py
+++ b/lib/bb/parse/__init__.py
@@ -99,12 +99,12 @@ def supports(fn, data):
             return 1
     return 0
 
-def handle(fn, data, include = 0):
+def handle(fn, data, include=0, baseconfig=False):
     """Call the handler that is appropriate for this file"""
     for h in handlers:
         if h['supports'](fn, data):
             with data.inchistory.include(fn):
-                return h['handle'](fn, data, include)
+                return h['handle'](fn, data, include, baseconfig)
     raise ParseError("not a BitBake file", fn)
 
 def init(fn, data):
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 9e0a0f5c98..85a9d760b0 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -9,6 +9,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import sys
 import bb
 from bb import methodpool
 from bb.parse import logger
@@ -269,6 +270,29 @@ class BBHandlerNode(AstNode):
             data.setVarFlag(h, "handler", 1)
         data.setVar('__BBHANDLERS', bbhands)
 
+class PyLibNode(AstNode):
+    def __init__(self, filename, lineno, libdir, namespace):
+        AstNode.__init__(self, filename, lineno)
+        self.libdir = libdir
+        self.namespace = namespace
+
+    def eval(self, data):
+        global_mods = (data.getVar("BB_GLOBAL_PYMODULES") or "").split()
+        for m in global_mods:
+            if m not in bb.utils._context:
+                bb.utils._context[m] = __import__(m)
+
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
@@ -320,6 +344,9 @@ def handleDelTask(statements, filename, lineno, m):
 def handleBBHandlers(statements, filename, lineno, m):
     statements.append(BBHandlerNode(filename, lineno, m.group(1)))
 
+def handlePyLib(statements, filename, lineno, m):
+    statements.append(PyLibNode(filename, lineno, m.group(1), m.group(2)))
+
 def handleInherit(statements, filename, lineno, m):
     classes = m.group(1)
     statements.append(InheritNode(filename, lineno, classes))
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 584966fea1..4d5b45e1ef 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -101,7 +101,7 @@ def get_statements(filename, absolute_filename, base_name):
             cached_statements[absolute_filename] = statements
         return statements
 
-def handle(fn, d, include):
+def handle(fn, d, include, baseconfig=False):
     global __infunc__, __body__, __residue__, __classname__
     __body__ = []
     __infunc__ = []
@@ -265,7 +265,7 @@ def feeder(lineno, s, fn, root, statements, eof=False):
         ast.handleInherit(statements, fn, lineno, m)
         return
 
-    return ConfHandler.feeder(lineno, s, fn, statements)
+    return ConfHandler.feeder(lineno, s, fn, statements, conffile=False)
 
 # Add us to the handlers list
 from .. import handlers
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 451e68dd66..3076067287 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -46,6 +46,7 @@ __require_regexp__ = re.compile( r"require\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.]+)\]$" )
+__addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 
 def init(data):
     return
@@ -107,7 +108,7 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
 # parsing. This turns out to be a hard problem to solve any other way.
 confFilters = []
 
-def handle(fn, data, include):
+def handle(fn, data, include, baseconfig=False):
     init(data)
 
     if include == 0:
@@ -144,7 +145,7 @@ def handle(fn, data, include):
             # skip comments
             if s[0] == '#':
                 continue
-            feeder(lineno, s, abs_fn, statements)
+            feeder(lineno, s, abs_fn, statements, baseconfig=baseconfig)
 
     # DONE WITH PARSING... time to evaluate
     data.setVar('FILE', abs_fn)
@@ -157,7 +158,9 @@ def handle(fn, data, include):
 
     return data
 
-def feeder(lineno, s, fn, statements):
+# baseconfig is set for the bblayers/layer.conf cookerdata config parsing
+# The function is also used by BBHandler, conffile would be False
+def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
     m = __config_regexp__.match(s)
     if m:
         groupd = m.groupdict()
@@ -189,6 +192,11 @@ def feeder(lineno, s, fn, statements):
         ast.handleUnsetFlag(statements, fn, lineno, m)
         return
 
+    m = __addpylib_regexp__.match(s)
+    if baseconfig and conffile and m:
+        ast.handlePyLib(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.34.1


