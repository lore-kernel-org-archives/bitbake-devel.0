Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6DC4708E
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 12:38:41 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.14170.1670416713111121092
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 04:38:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gum+TwCj;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id ay8-20020a05600c1e0800b003d0808d2826so2446760wmb.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 04:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HqhCqfGcJpUcd7Efp4nswFMPo1lBd8tIXI22YgHbRW4=;
        b=gum+TwCjnBG+9HtmCOS4NXTBiY0xWbAK9UbPu+JayRl8p8jmjLWdKtQD6J/f4Tvoe6
         ueS+33Hb9OR1WzVqWh3BfxPpSlifWeOsH87piBFi5pOcVNc9r2/zOA/7wWiktoAd0EzC
         5VIgbah9O3Pj4i5RJLj8Fgpnsiwt1CXs6qEW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqhCqfGcJpUcd7Efp4nswFMPo1lBd8tIXI22YgHbRW4=;
        b=qTeGFTCKMbO36/ATKiCoc45FVWHtNz+JUFggkij8K21c3FKNxFuuxKXd9tHmjBp6Ay
         tqHWeAjNgxPB8nrF44w7btRswZ+G7mV7ulonCzDzD2vdbBBQt8VmVggle1Txg08c8yKi
         EVKPXrtcFS5ZtnFmeOG3m+EqmR92trU+HQ0YViYUGmYedvnLcWJv4vMyUCIcysdsdI10
         tnhth4cero31fvJx4dEGIyAfY40qhxqGl3v4XHC+rBSIPMfaa5fxRsbi1lGodMzh/6ox
         nk/KflTY6NDCsSc1cYxl5Y+0Hjrz0kkVUhQvyj2rIbvEwjSVWdgOOlKN0ySJcQVXWDhW
         Dd0g==
X-Gm-Message-State: ANoB5pmdd0RHQ/RGIMDBSGBy8b4O46vYBdYatHxjM8s7iNBHZ+vPbARm
	0Kdaic+S6RJg+VhTZEK5f/Q4iqm6v/hR+E4x
X-Google-Smtp-Source: AA0mqf5FtYd2bJg22OXfR3SDtU4hnvBEbF9n1WmjCobegDxukaEueCCdmynreH9Ooi8WqnZg7qqzZQ==
X-Received: by 2002:a05:600c:a4f:b0:3d1:f298:5fde with SMTP id c15-20020a05600c0a4f00b003d1f2985fdemr2735479wmq.171.1670416710818;
        Wed, 07 Dec 2022 04:38:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8])
        by smtp.gmail.com with ESMTPSA id i2-20020adff302000000b002421a8f4fa6sm19220515wro.92.2022.12.07.04.38.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:38:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] parse: Add support for addpylib conf file directive
Date: Wed,  7 Dec 2022 12:38:29 +0000
Message-Id: <20221207123829.2106891-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 12:38:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14140

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

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---

v2: Limit the directive to conf files in the base configuration

 lib/bb/cookerdata.py                 |  2 +-
 lib/bb/parse/__init__.py             |  4 ++--
 lib/bb/parse/ast.py                  | 22 ++++++++++++++++++++++
 lib/bb/parse/parse_py/BBHandler.py   |  4 ++--
 lib/bb/parse/parse_py/ConfHandler.py | 14 +++++++++++---
 5 files changed, 38 insertions(+), 8 deletions(-)

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


