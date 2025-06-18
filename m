Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B77C71157
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 09:21:05 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.3085.1750238459083267917
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Jun 2025 02:20:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fqI1cu9f;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so75911375e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Jun 2025 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750238457; x=1750843257; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ApuA0eGHRHOHjFavgXImAB98GqAEe1nPg5t2fPOYKPY=;
        b=fqI1cu9f+NgIyUzi3uyU1q3cAgOqHAZrEC7xjffD+9jFYUKb9PVr0yi+q6fZcdybed
         SNgBafn1w+22Xb1nvAWEhrgILaos5rEgjUuQirBnAwaN/DMP5ybw1ha1/yHI86fT70x7
         0CtPWkpA5rSqKEFu+RrQKD1YFZz8U8Ii6ZgdO/k48pBq4Q3REsMQ7+4vnfNz7OeClasQ
         eBh+K6TpZX0nt7HRBWK8bO0+O9Kak3cU4Czbu8JX9rA3qkgr56qRi1OGqc8ycQgaki26
         9uqBwWQ7XjRHCmcwO0w843rIRso5ESbT86PN+X8vCRAJpZi7P1YMjxjnM1DbeijUMJ06
         heFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238457; x=1750843257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApuA0eGHRHOHjFavgXImAB98GqAEe1nPg5t2fPOYKPY=;
        b=gozIVvSFw+b9sXYfbAR/JWWNDbSyCVUK+HmjF9BDVNSaikdKyGPYyOtwvXHpTwGEdg
         niRDZDc92OI7FubDOP6CB8wuhsukMFlxNQY4bPCzpCvD+Tzm9g/jTSHqVtbBRtdEpAAZ
         esbe2fTpMT+NVYG/nim0MiwTIkSLl6IgKHo7dImnxhVZwFWyq3Ivnb3pBooDddqGMIVJ
         qAw8YPdrXa6He2iwT4vNzG31Lmrz2HH03LtGhy2/6qbYYrYwy/n/YLZDOB5X1RvvMjtK
         7Uc/2+bZy27WhMC14N31dTKBkZviKdRtC8tjWVaMwpp7c77IkVcp49wikqeCiCLWP9Zc
         o8Mw==
X-Gm-Message-State: AOJu0YwPiEs77rFwn07P3E4qYxk0lECbCyiTnVykfRjXPZfjAXW86rVq
	p/WxtATfjWxyaNIdjXhZQkHhMMIOKuUfU1gM2p3Jn/v2e2fhGLWed2PqenA8bg==
X-Gm-Gg: ASbGncsoFgxyzSGHZCP6XVAKZAzWCtnYoGP57Lath1kEmlmSvffuxyvDcgGr30TtWqc
	0dDZTr23MNwPGcU63rybLOEWiLFO8LfLr4vliBmM9MSmTdzNO+nVu+HKuk8ltihN2zUzjXL17Ws
	01WTS92I1ef2DX1RSr5KgLYbTH5cNZT3AaYvR4o9yl+WL/LxXrfX4Jhmdi+yIxK/QMt2Uq2QSWU
	dDS7BvPcWLZAwE3hUYRIgDbiKrDyxNM5OD/NZox3SzQiMNQzHWKw8aL8Wo2eqPljE3SF3+UGtqg
	kGvXi6GEBfCxO7X+Vt+rjl4Mx6XvxfA/68/lVaZf3a1dsqSeIqwpsgY30Tyt8MCtHH3Py86DP4b
	LdjELvUlNKbnu8+6P8XP+7xLXP9AX6dol0Q==
X-Google-Smtp-Source: AGHT+IGiZJOY7cPwvN2MgDNrJAUaFi6eB46NKJLK7IZ7a5+INNhfb8TUzZRPcIwQGjidTncr9ZNC3Q==
X-Received: by 2002:a05:600c:1c12:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-4533ca46428mr171089165e9.4.1750238457119;
        Wed, 18 Jun 2025 02:20:57 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b79817sm16629136f8f.99.2025.06.18.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:20:56 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] parse/ast: add support for 'built-in' fragments
Date: Wed, 18 Jun 2025 11:20:53 +0200
Message-Id: <20250618092053.4141972-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Jun 2025 09:21:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17706

From: Alexander Kanavin <alex@linutronix.de>

When reviewing proposed fragments to add settings for DISTRO and MACHINE,
RP noted that such fragments only add clutter and overhead, and there's
no need to maintain them as separate files.

Rather when bitbake sees 'fragmentvar/fragmentvalue' it can expand that into
FRAGMENTVAR = "fragmentvalue".

To achieve that, 'addfragments' directive is extended with a parameter
that sets the name of the variable that holds definitions of such
built-in fragments, for example like this:

"machine:MACHINE distro:DISTRO"

Then each enabled fragment name is matched against these definitions and the
respective variable is set, e.g. 'machine/qemuarm' would match
'machine:MACHINE' and result in MACHINE set to 'qemuarm'.

This happens before any fragment files are looked up on disk,
and no such lookup happens if there was a match, which should prevent
possible misuse of the feature. So the builtin fragment definition
is also an allowlist for them.

Please also see the patches for oe-core that show an application of the feature.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-metadata.rst          | 19 +++++++++++++++++--
 bitbake/lib/bb/parse/ast.py                   | 16 ++++++++++++++--
 bitbake/lib/bb/parse/parse_py/ConfHandler.py  |  2 +-
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index a27b7758d97..f60a9d83123 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -998,9 +998,9 @@ This directive allows fine-tuning local configurations with configuration
 snippets contained in layers in a structured, controlled way. Typically it would
 go into ``bitbake.conf``, for example::
 
-   addfragments conf/fragments OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS
+   addfragments conf/fragments OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS OE_BUILTIN_FRAGMENTS
 
-``addfragments`` takes three parameters:
+``addfragments`` takes four parameters:
 
 -  path prefix for fragment files inside the layer file tree that bitbake
    uses to construct full paths to the fragment files
@@ -1011,6 +1011,8 @@ go into ``bitbake.conf``, for example::
 -  name of variable that contains a list of variable names containing
    fragment-specific metadata (such as descriptions)
 
+-  name of variable that contains definitions for built-in fragments
+
 This allows listing enabled configuration fragments in ``OE_FRAGMENTS``
 variable like this::
 
@@ -1035,6 +1037,19 @@ The implementation will add a flag containing the fragment name to each of those
 when parsing fragments, so that the variables are namespaced by fragment name, and do not override
 each other when several fragments are enabled.
 
+The variable containing a built-in fragment definitions could look like this::
+
+   OE_BUILTIN_FRAGMENTS = "someprefix:SOMEVARIABLE anotherprefix:ANOTHERVARIABLE"
+
+and then if 'someprefix/somevalue' is added to the variable that holds the list
+of enabled fragments:
+
+  OE_FRAGMENTS = "... someprefix/somevalue"
+
+bitbake will treat that as direct value assignment in its configuration::
+
+  SOMEVARIABLE = "somevalue"
+
 Functions
 =========
 
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index ea1096f2de7..49a07880388 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -343,11 +343,12 @@ class InheritDeferredNode(AstNode):
         bb.parse.BBHandler.inherit_defer(*self.inherit, data)
 
 class AddFragmentsNode(AstNode):
-    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable):
+    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable, builtin_fragments_variable):
         AstNode.__init__(self, filename, lineno)
         self.fragments_path_prefix = fragments_path_prefix
         self.fragments_variable = fragments_variable
         self.flagged_variables_list_variable = flagged_variables_list_variable
+        self.builtin_fragments_variable = builtin_fragments_variable
 
     def eval(self, data):
         # No need to use mark_dependency since we would only match a fragment
@@ -360,13 +361,23 @@ class AddFragmentsNode(AstNode):
                    return candidate_fragment_path
            return None
 
+        def check_and_set_builtin_fragment(fragment, data, builtin_fragments):
+            prefix, value = fragment.split('/', 1)
+            if prefix in builtin_fragments.keys():
+                data.setVar(builtin_fragments[prefix], value)
+                return True
+            return False
+
         fragments = data.getVar(self.fragments_variable)
         layers = data.getVar('BBLAYERS')
         flagged_variables = data.getVar(self.flagged_variables_list_variable).split()
+        builtin_fragments = {f[0]:f[1] for f in [f.split(':') for f in data.getVar(self.builtin_fragments_variable).split()] }
 
         if not fragments:
             return
         for f in fragments.split():
+            if check_and_set_builtin_fragment(f, data, builtin_fragments):
+                continue
             layerid, fragment_name = f.split('/', 1)
             full_fragment_name = data.expand("{}/{}.conf".format(self.fragments_path_prefix, fragment_name))
             fragment_path = find_fragment(layers, layerid, full_fragment_name)
@@ -430,7 +441,8 @@ def handleAddFragments(statements, filename, lineno, m):
     fragments_path_prefix = m.group(1)
     fragments_variable = m.group(2)
     flagged_variables_list_variable = m.group(3)
-    statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable))
+    builtin_fragments_variable = m.group(4)
+    statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable, builtin_fragments_variable))
 
 def runAnonFuncs(d):
     code = []
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 675838d8452..9ddbae123dc 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -48,7 +48,7 @@ __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
-__addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)\s+(.+)" )
+__addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)\s+(.+)\s+(.+)" )
 
 def init(data):
     return
-- 
2.39.5


