Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF22DC71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 10:56:04 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.27630.1750071362197113273
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Jun 2025 03:56:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FytCiVPs;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so50843445e9.3;
        Mon, 16 Jun 2025 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750071360; x=1750676160; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=903ZXdBGhNxlTtfWLgyGskT2Fi0+iq+Bqm3IGpb07S4=;
        b=FytCiVPsb0Z5uXkh3m9PR/O/4sgOB0oi/tRSf8n93VIIhczlr7PiPdkYIXZpIm9lGR
         XaAl78sdlaA7fo0a/P9NvU1PXm0AILO9c09CV8w9Wvn9nfFBLPsTKZ1KPVheQSmTMWVy
         CGr5iCwXdrhTUOw1Ek42OFazLoZR8FnKUVt9iExIHW12//i4cbGqFrFIzJjP7KSb428o
         0cBticL7zHgMbUmpRHb2Cfjm5AkTGMh2sHD+ptR1GNNyvmeqZv+sYAyzko8tAYkVJ5Gq
         3KzXULfSgR2NN7e1uBlZAi07l8+txm1hofpHoIK14KzRLVNPVo1qdOocLJwoZnzEW2k7
         xhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750071360; x=1750676160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=903ZXdBGhNxlTtfWLgyGskT2Fi0+iq+Bqm3IGpb07S4=;
        b=J3x5riNC7Xwfr+Irl5P3UPFx0BT6dJPFGbBQH9ngV77be5kRez20yM6CG/lezkwRXX
         N1+X+g13KF47yT6YyTNtzSgQywB7zIwdqVLzzbZKVLtXjBjDacQns/LhI78yjP9mTh1U
         rXJggzMwKvnzbIvZnM95jF4z6d1T3u8AH4++weBnVkWhGMy247ZmkYtZI1iDZJ/wKmKR
         JZ15iXRX6htY58h1qjbZzdkN8f3wWlt4nZclYOdJlwlaCzDy4bbZFQbpmgbvNMMYQ2eZ
         uDE3cmgZaEwO5M41S+BeI1S2yln2/OYiFU3yBrBqOw5u42Qs7wWSMHoBOV6q5uAIHqcV
         +2qw==
X-Forwarded-Encrypted: i=1; AJvYcCXd8z1ME5oxrnhZEKfL6Q/Zqg1AJMHzd7/yaBTyZZ+A0wWX6pOa8qWjwqBAo+8osqf6Fs4BwOgbnOSiZtkZKCEUSA==@lists.openembedded.org
X-Gm-Message-State: AOJu0YzQHAgyiJanKlg3Ls1VapldyULdt5fkc0jrYCqMOkwjuVxY3fEc
	Ef5PadXCpF/2VANaYMiHB2/9Sg0VADrch6wzNqx18mXO//HnLV4vlrkRXZgBVQ==
X-Gm-Gg: ASbGncvKpL8WaVgREb+5J4jlt5gInNde0nZtSR293QEINm3nVtLmD+L54U9yyJsryZY
	iTPJdUQxs+Qpb2bBus4pd0gEvALegmPG7CgtkoE+pQTcPYkX4i09wbvfeh7kOLwN1v7VA8OeGLf
	kFQZI5aPLcGulbbBWFdMsCG+BT2TstLa0JaqQeWOeL1ke/UFmFCnzMMb6/YZjf85vxF8GHfAB0K
	JFsmm8E99655rzaNfyIExI1L41frSVSS2uQtzSCbf1uo2cBnkvnZa6MQ2jFHe30tIg4PvJgG3OL
	CB8tceZ93D1KttJB3bHTPp22SAxwQO5+IFtEOKi8kKCvJzjVFHbhazLeFbZy75/TGQ/J1Uq9lGm
	NL0p+s9PnXh+nx3A8t+6hbW4=
X-Google-Smtp-Source: AGHT+IFX0GEVX8u+IbpAtKIYb7x+8qU+RiFhTYlV2Sc1KonJiKRMaEWSt8bNBNamiNHDpBSvlG+1pQ==
X-Received: by 2002:a05:600c:c16a:b0:450:d614:cb with SMTP id 5b1f17b1804b1-4533cacab63mr74173085e9.33.1750071360183;
        Mon, 16 Jun 2025 03:56:00 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b628ecsm10870394f8f.92.2025.06.16.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 03:55:59 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH] bitbake: add support for 'built-in' fragments
Date: Mon, 16 Jun 2025 12:55:52 +0200
Message-Id: <20250616105552.2939169-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Jun 2025 10:56:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17703

From: Alexander Kanavin <alex@linutronix.de>

Note: this deliberately puts bitbake and core changes into one commit
to make RFC review easier.

When reviewing proposed fragments to add settings for DISTRO and MACHINE,
RP noted that such fragments only add clutter and overhead, and there's
no need to maintain them as separate files.

Rather when bitbake sees 'fragmentvar/fragmentvalue' it can expand that into
FRAGMENTVAR = "fragmentvalue".

This is a RFC proposal to add such 'built-in' fragments; I had to pick a
name for the concept, and open to alternative suggestions.

The centerpiece is the

OE_FRAGMENTS_BUILTIN ?= "machine:MACHINE distro:DISTRO"

setting in bitbake.conf, which acts as both a definition and an allowlist
for such fragments.

With that in place, it's possible to set

OE_FRAGMENTS += "distro/poky machine/qemuarm"

and bitbake will interpret that as

DISTRO = "poky"
MACHINE = "qemuarm"

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../bitbake-user-manual-metadata.rst          | 19 ++++++++++++++--
 bitbake/lib/bb/parse/ast.py                   | 16 ++++++++++++--
 bitbake/lib/bb/parse/parse_py/ConfHandler.py  |  2 +-
 meta/conf/bitbake.conf                        |  3 ++-
 meta/lib/bbconfigbuild/configfragments.py     | 22 ++++++++++++++++++-
 5 files changed, 55 insertions(+), 7 deletions(-)

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
index 290ed45048c..f9133c4e60b 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -345,11 +345,12 @@ class InheritDeferredNode(AstNode):
         data.setVar('__BBDEFINHERITS', inherits)
 
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
@@ -362,13 +363,23 @@ class AddFragmentsNode(AstNode):
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
@@ -432,7 +443,8 @@ def handleAddFragments(statements, filename, lineno, m):
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
diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
index e600d9d774a..b2414ec2a7f 100644
--- a/meta/conf/bitbake.conf
+++ b/meta/conf/bitbake.conf
@@ -821,7 +821,8 @@ include conf/local.conf
 
 OE_FRAGMENTS_PREFIX ?= "conf/fragments"
 OE_FRAGMENTS_METADATA_VARS ?= "BB_CONF_FRAGMENT_SUMMARY BB_CONF_FRAGMENT_DESCRIPTION"
-addfragments ${OE_FRAGMENTS_PREFIX} OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS
+OE_FRAGMENTS_BUILTIN ?= "machine:MACHINE distro:DISTRO"
+addfragments ${OE_FRAGMENTS_PREFIX} OE_FRAGMENTS OE_FRAGMENTS_METADATA_VARS OE_FRAGMENTS_BUILTIN
 
 require ${@"conf/multiconfig/${BB_CURRENT_MC}.conf" if "${BB_CURRENT_MC}" != "" else ""}
 include conf/machine/${MACHINE}.conf
diff --git a/meta/lib/bbconfigbuild/configfragments.py b/meta/lib/bbconfigbuild/configfragments.py
index c1dddc3e4cb..61c33ac3161 100644
--- a/meta/lib/bbconfigbuild/configfragments.py
+++ b/meta/lib/bbconfigbuild/configfragments.py
@@ -62,7 +62,22 @@ class ConfigFragmentsPlugin(LayerPlugin):
             else:
                 print('Name: {}\nPath: {}\nEnabled: {}\nSummary: {}\nDescription:\n{}\n'.format(f['name'], f['path'], 'yes' if is_enabled else 'no', f['summary'],''.join(f['description'])))
 
+        def print_builtin_fragments(builtin, enabled):
+            print('Available built-in fragments:')
+            builtin_dict = {i[0]:i[1] for i in [f.split(':') for f in builtin]}
+            for prefix,var in builtin_dict.items():
+                print('{}/...\tSets {} = ...'.format(prefix, var))
+            print('')
+            enabled_builtin_fragments = [f for f in enabled if self.builtin_fragment_exists(f)]
+            print('Enabled built-in fragments:')
+            for f in enabled_builtin_fragments:
+                 prefix, value = f.split('/', 1)
+                 print('{}\tSets {} = "{}"'.format(f, builtin_dict[prefix], value))
+            print('')
+
         all_enabled_fragments = (self.tinfoil.config_data.getVar('OE_FRAGMENTS') or "").split()
+        all_builtin_fragments = (self.tinfoil.config_data.getVar('OE_FRAGMENTS_BUILTIN') or "").split()
+        print_builtin_fragments(all_builtin_fragments, all_enabled_fragments)
 
         for layername, layerdata in self.discover_fragments().items():
             layerdir = layerdata['layerdir']
@@ -89,6 +104,11 @@ class ConfigFragmentsPlugin(LayerPlugin):
                   return True
         return False
 
+    def builtin_fragment_exists(self, fragmentname):
+        fragment_prefix = fragmentname.split("/",1)[0]
+        fragment_prefix_defs = set([f.split(':')[0] for f in self.tinfoil.config_data.getVar('OE_FRAGMENTS_BUILTIN').split()])
+        return fragment_prefix in fragment_prefix_defs
+
     def create_conf(self, confpath):
         if not os.path.exists(confpath):
             with open(confpath, 'w') as f:
@@ -112,7 +132,7 @@ class ConfigFragmentsPlugin(LayerPlugin):
             return " ".join(enabled_fragments), None, 0, True
 
         for f in args.fragmentname:
-            if not self.fragment_exists(f):
+            if not self.fragment_exists(f) and not self.builtin_fragment_exists(f):
                 raise Exception("Fragment {} does not exist; use 'list-fragments' to see the full list.".format(f))
 
         self.create_conf(args.confpath)
-- 
2.39.5


