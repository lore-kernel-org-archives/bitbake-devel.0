Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C8E77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:14:04 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.17028.1733418837558894669
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 09:13:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eMxXSNn3;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so8347075e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418836; x=1734023636; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oPhY0pdMYbDXwd5q8nfaiGt9njvutYxUMD33pNH9Yw=;
        b=eMxXSNn3E7Uw2NjQM7tbySTiullKy10ACh3W9XC5OkgxuOls9d13CuzGnbBPWhe8sC
         zikDqCb6JKYtqvuh5Cn+FQoJC0H+tO0jsOEXebOooTTEBO5H4ExEanQ86wrigoz+0Qw9
         k06vMYr1G4z7SBIlMm/Jw7s/aJmkFHFJUDw9P1td5w5Uaq3aDsv0M0PoDYU+50YTZdu1
         RFMcsHfbHfuiKq7Xi++fLLYtXO5ClVE+EHo6KRTXfdPRxLnplfYx+BHkQwUNcSyr87iY
         kTbMqpbv/dccn4vdAThMjC1FF28kupIPEX5d/Y4j+SawwQIHhtWj5OrOEcQwep2JDNjB
         QDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418836; x=1734023636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oPhY0pdMYbDXwd5q8nfaiGt9njvutYxUMD33pNH9Yw=;
        b=tPGp0/Wcr8EAkuGXxXpUnEmjN8TKUP0JEUQZXo66q3z709KNS6/JvmNMybiXjr0JMu
         rN6ZgUjxasA/xIYBLH5yB4F23qePc+RuA8J8/cIE8h7G0/cuSy/hbxqpJDC+T9/rIsLc
         2lPIMf+XX7yyKhr02Z0JV7N8JAqSx8o4Sy5Jk7wDtQR8eLEFcnaaqPbG1V6ULPOka1XA
         vxpFJBugomzCKzAnjTYoIHJO9ay/g2XgoNDJyd2JMFdQIJaM1dvjVzSWOXRDFRfVOG1h
         wlw0cZ1L4wEeJ6Fshdtk6Bipk8EU239iet4DbjiSjfJuZzXrtEFVSi91o/R+jt8ot8y0
         yt7g==
X-Gm-Message-State: AOJu0YwYPxGEQdH5cMABTrhViBklolt26yJHRjFHY00txdubSWiDSRMC
	GSFMdqWSj5kaj3VzHxqFlFXHJO8pPO4svHV9oIY06p3+MIe4TOb5cv5iKw==
X-Gm-Gg: ASbGncs7RaEoX0Yrj12zngd1cvgYX1Sa2rowscyg94yFD7t/SvK2qGcHo63c4ol22Xr
	7fVlQ9UcLHliFFVaU2ts1bbw63RQjbzUE0SvO+tRlQSdiP432zkgj+8NBhJKApDsYFvzd6SnVIT
	CYxsRWaxiJ3qtydFMgN243G5bsGd07lLkr/71vrbTMGPKO95Cbcl8wfJHKbJD7xcookF2Du3TV0
	mkCB6ccy7w+WLoPo2k/Ij/UHUdtP0WFYk5XB5zyn4RqLQCPoOMCmIdmHJIU8lV5BJ5XQSfHC0GS
	xs5PbcQM3Co=
X-Google-Smtp-Source: AGHT+IGmvJ6gs+OaJK/XWYEcHtlqiConfeOvV1nHWk518J3GskdL2dGsuVCMdlvF1fnfSuz6i//VpQ==
X-Received: by 2002:a05:600c:314f:b0:431:50cb:2398 with SMTP id 5b1f17b1804b1-434ddea81ecmr1013675e9.2.1733418835627;
        Thu, 05 Dec 2024 09:13:55 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113508sm30238775e9.35.2024.12.05.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:13:55 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v5 2/3] parse: add support for 'addfragments' directive
Date: Thu,  5 Dec 2024 18:13:38 +0100
Message-Id: <20241205171339.4051793-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205171339.4051793-1-alex.kanavin@gmail.com>
References: <20241205171339.4051793-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 17:14:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16885

From: Alexander Kanavin <alex@linutronix.de>

It takes two parameters:
- location prefix for fragments
- name of variable that holds the list of enabled fragments, each of them prefixed
by layer id

Implementation of this directive essentially expands the fragment list
obtained from the variable into absolute fragment paths and hands them to the
implementation of 'require'.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/ast.py                  | 36 ++++++++++++++++++++++++++++
 lib/bb/parse/parse_py/ConfHandler.py |  6 +++++
 2 files changed, 42 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 001ba8d289a..7abefab2c2e 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -326,6 +326,37 @@ class InheritDeferredNode(AstNode):
         inherits.append(self.inherit)
         data.setVar('__BBDEFINHERITS', inherits)
 
+class AddFragmentsNode(AstNode):
+    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable):
+        AstNode.__init__(self, filename, lineno)
+        self.fragments_path_prefix = fragments_path_prefix
+        self.fragments_variable = fragments_variable
+
+    def eval(self, data):
+        # No need to use mark_dependency since we would only match a fragment
+        # from a specific layer and there can only be a single layer with a
+        # given namespace.
+        def find_fragment(layers, layerid, full_fragment_name):
+           for layerpath in layers.split():
+               candidate_fragment_path = os.path.join(layerpath, full_fragment_name)
+               if os.path.exists(candidate_fragment_path) and bb.utils.get_file_layer(candidate_fragment_path, data) == layerid:
+                   return candidate_fragment_path
+           return None
+
+        fragments = data.getVar(self.fragments_variable)
+        layers = data.getVar('BBLAYERS')
+
+        if not fragments:
+            return
+        for f in fragments.split():
+            layerid, fragment_name = f.split('/', 1)
+            full_fragment_name = data.expand("{}/{}.conf".format(self.fragments_path_prefix, fragment_name))
+            fragment_path = find_fragment(layers, layerid, full_fragment_name)
+            if fragment_path:
+                bb.parse.ConfHandler.include(self.filename, fragment_path, self.lineno, data, "include fragment")
+            else:
+                bb.error("Could not find fragment {} in enabled layers: {}".format(f, layers))
+
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
@@ -370,6 +401,11 @@ def handleInheritDeferred(statements, filename, lineno, m):
     classes = m.group(1)
     statements.append(InheritDeferredNode(filename, lineno, classes))
 
+def handleAddFragments(statements, filename, lineno, m):
+    fragments_path_prefix = m.group(1)
+    fragments_variable = m.group(2)
+    statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable))
+
 def runAnonFuncs(d):
     code = []
     for funcname in d.getVar("__BBANONFUNCS", False) or []:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 27665443dd4..35321dacfe1 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -47,6 +47,7 @@ __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
+__addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)" )
 
 def init(data):
     return
@@ -197,6 +198,11 @@ def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
         ast.handlePyLib(statements, fn, lineno, m)
         return
 
+    m = __addfragments_regexp__.match(s)
+    if m:
+        ast.handleAddFragments(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.39.5


