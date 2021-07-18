Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.14397.1626611384877197897
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Jul 2021 05:29:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TbBFzltT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id i94so18018696wri.4
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Jul 2021 05:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+0AyZ8Ul6vzmrGZgKwxPHden32gwmOaes3qSaaNzf0=;
        b=TbBFzltTPixNbtU8dWQ2wpWXDfV2dGO0e5blQKRWJLUISVLOEvn+nAxWFoNkP1pZzK
         mPK6IqZXiw6Gac1JDZz2OVVB24PBFDKWBsyFg9YVpD7KOd/2isq8Sdgou++7T+Jn1c6A
         Sr+rbXaYd+hihfji3FbkPeOCIu6/bJgEOUGxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J+0AyZ8Ul6vzmrGZgKwxPHden32gwmOaes3qSaaNzf0=;
        b=rDoy+vK0vNoG31XTZEbu90+LOv4hFUrEik6tNO9j0OsX+fdrSK/DgUj6Qk4BHLi5UI
         8lCHKVT3JaxgqIiFDLoQGXW1mo44dr5N5up2x7VUfMpanegu2n6+xBlOG3jJJF0amSmi
         utamfVA60I0zNgfvrE6tnLQh/MLG52/A55qtJE8wX/biQ2GbI1BrVXaKvx3hWIUhSb5J
         GUWFCpd0jPHBtLvtZK9tY/RW9TfaWzI0dhK294yz6mzreKVnscQ9iGCCOtXMbLItzylt
         +EdsmBL+N5orUh/mx9YCWhHX2+/OBktQ4IX4jHAJlIUU3A/Ia/lmayymZ1Ar1iiV12py
         Nuyg==
X-Gm-Message-State: AOAM531VcZovCVGTxlME7p2AdfnSTAIQOJSbAO2Xatnew79ZEOQPkUcc
	u8DDsaxomptDoFznlmwu4mkavd6DSV3jKg==
X-Google-Smtp-Source: ABdhPJyAS+TIuxxh50KxJrjEW+mkslv0TD3ViM3wrM0Xh3/ek1j6PEfKYKeaUQ/QaI5+9Ia3Ntxr0g==
X-Received: by 2002:adf:a2c3:: with SMTP id t3mr23748614wra.223.1626611383171;
        Sun, 18 Jul 2021 05:29:43 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5ff5:ebf1:b0ff:a94a])
        by smtp.gmail.com with ESMTPSA id h130sm6894486wmh.1.2021.07.18.05.29.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 05:29:42 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] data_smart/parse: Allow ':' characters in variable/function names
Date: Sun, 18 Jul 2021 13:29:42 +0100
Message-Id: <20210718122942.2975363-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is becomming increasingly clear we need to find a way to show what
is/is not an override in our syntax. We need to do this in a way which
is clear to users, readable and in a way we can transition to.

The most effective way I've found to this is to use the ":" charater
to directly replace "_" where an override is being specified. This
includes "append", "prepend" and "remove" which are effectively special
override directives.

This patch simply adds the character to the parser so bitbake accepts
the value but maps it back to "_" internally so there is no behaviour
change.

This change is simple enough it could potentially be backported to older
version of bitbake meaning layers using the new syntax/markup could
work with older releases. Even if other no other changes are accepted
at this time and we don't backport, it does set us on a path where at
some point in future we could
require a more explict syntax.

I've tested this patch by converting oe-core/meta-yocto to the new
syntax for overrides (9000+ changes) and then seeing that builds
continue to work with this patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py                 | 12 ++++++++++++
 lib/bb/parse/ast.py                  |  2 ++
 lib/bb/parse/parse_py/BBHandler.py   |  2 +-
 lib/bb/parse/parse_py/ConfHandler.py |  2 +-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2328c334ac..f48726a348 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -481,6 +481,7 @@ class DataSmart(MutableMapping):
 
     def setVar(self, var, value, **loginfo):
         #print("var=" + str(var) + "  val=" + str(value))
+        var = var.replace(":", "_")
         self.expand_cache = {}
         parsing=False
         if 'parsing' in loginfo:
@@ -589,6 +590,8 @@ class DataSmart(MutableMapping):
         """
         Rename the variable key to newkey
         """
+        key = key.replace(":", "_")
+        newkey = newkey.replace(":", "_")
         if key == newkey:
             bb.warn("Calling renameVar with equivalent keys (%s) is invalid" % key)
             return
@@ -637,6 +640,7 @@ class DataSmart(MutableMapping):
         self.setVar(var + "_prepend", value, ignore=True, parsing=True)
 
     def delVar(self, var, **loginfo):
+        var = var.replace(":", "_")
         self.expand_cache = {}
 
         loginfo['detail'] = ""
@@ -664,6 +668,7 @@ class DataSmart(MutableMapping):
                          override = None
 
     def setVarFlag(self, var, flag, value, **loginfo):
+        var = var.replace(":", "_")
         self.expand_cache = {}
 
         if 'op' not in loginfo:
@@ -687,6 +692,7 @@ class DataSmart(MutableMapping):
             self.dict["__exportlist"]["_content"].add(var)
 
     def getVarFlag(self, var, flag, expand=True, noweakdefault=False, parsing=False, retparser=False):
+        var = var.replace(":", "_")
         if flag == "_content":
             cachename = var
         else:
@@ -814,6 +820,7 @@ class DataSmart(MutableMapping):
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
+        var = var.replace(":", "_")
         self.expand_cache = {}
 
         local_var, _ = self._findVar(var)
@@ -831,6 +838,7 @@ class DataSmart(MutableMapping):
             del self.dict[var][flag]
 
     def appendVarFlag(self, var, flag, value, **loginfo):
+        var = var.replace(":", "_")
         loginfo['op'] = 'append'
         loginfo['flag'] = flag
         self.varhistory.record(**loginfo)
@@ -838,6 +846,7 @@ class DataSmart(MutableMapping):
         self.setVarFlag(var, flag, newvalue, ignore=True)
 
     def prependVarFlag(self, var, flag, value, **loginfo):
+        var = var.replace(":", "_")
         loginfo['op'] = 'prepend'
         loginfo['flag'] = flag
         self.varhistory.record(**loginfo)
@@ -845,6 +854,7 @@ class DataSmart(MutableMapping):
         self.setVarFlag(var, flag, newvalue, ignore=True)
 
     def setVarFlags(self, var, flags, **loginfo):
+        var = var.replace(":", "_")
         self.expand_cache = {}
         infer_caller_details(loginfo)
         if not var in self.dict:
@@ -859,6 +869,7 @@ class DataSmart(MutableMapping):
             self.dict[var][i] = flags[i]
 
     def getVarFlags(self, var, expand = False, internalflags=False):
+        var = var.replace(":", "_")
         local_var, _ = self._findVar(var)
         flags = {}
 
@@ -875,6 +886,7 @@ class DataSmart(MutableMapping):
 
 
     def delVarFlags(self, var, **loginfo):
+        var = var.replace(":", "_")
         self.expand_cache = {}
         if not var in self.dict:
             self._makeShadowCopy(var)
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 50a88f7da7..db2bdc35ec 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -97,6 +97,7 @@ class DataNode(AstNode):
     def eval(self, data):
         groupd = self.groupd
         key = groupd["var"]
+        key = key.replace(":", "_")
         loginfo = {
             'variable': key,
             'file': self.filename,
@@ -207,6 +208,7 @@ class ExportFuncsNode(AstNode):
     def eval(self, data):
 
         for func in self.n:
+            func = func.replace(":", "_")
             calledfunc = self.classname + "_" + func
 
             if data.getVar(func, False) and not data.getVarFlag(func, 'export_func', False):
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index f8988b8631..152ef6ab72 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -22,7 +22,7 @@ from .ConfHandler import include, init
 # For compatibility
 bb.deprecate_import(__name__, "bb.parse", ["vars_from_file"])
 
-__func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$]+)?\s*\(\s*\)\s*{$" )
+__func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$:]+)?\s*\(\s*\)\s*{$" )
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
 __addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index f171c5c932..0834fe3f9b 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -20,7 +20,7 @@ from bb.parse import ParseError, resolve_file, ast, logger, handle
 __config_regexp__  = re.compile( r"""
     ^
     (?P<exp>export\s+)?
-    (?P<var>[a-zA-Z0-9\-_+.${}/~]+?)
+    (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
     (\[(?P<flag>[a-zA-Z0-9\-_+.]+)\])?
 
     \s* (
-- 
2.30.2

