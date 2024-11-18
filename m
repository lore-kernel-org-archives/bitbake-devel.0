Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C015D4401B
	for <webhook@archiver.kernel.org>; Mon, 18 Nov 2024 16:26:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.45613.1731947186696836835
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Nov 2024 08:26:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PM/saYoZ;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431695fa98bso36013695e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947185; x=1732551985; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OVuCVG4xK7dpZ/PcqRLC8L4F/r18OBZets4vCysDzA=;
        b=PM/saYoZ30vbj5DUrBssUk7yf/5EIWrBRVUMbaBPM7xOVX8tV496jzMgP8TrDFlWb3
         rfFQ+6XSRmV6SbIucMPe6NEixI+p5E3mqxn2JokEMtrB51EM4QxacrMbLiJ+oVjINqOd
         y7eI6vnNHtzam7W3gNJi0P0HIOqmQVZhP6JFwxq/BCC+mkGwcYk8IyDQvqslAGbvS1Xz
         SYcqUoBArFxjdKsFpvT0Hp0QMb8fjVmARWFAYlkZqcMRoT3FkQ7uM8KwTikE+N3ZpJsj
         UBu7JGKZAyZ+YbgwgFzjSXeRwvmr1NCivXlP+ndDJzZg24z1aJa2S/wsEbgxT+deCz8n
         G3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947185; x=1732551985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OVuCVG4xK7dpZ/PcqRLC8L4F/r18OBZets4vCysDzA=;
        b=tvBUB8bRDuM+EE100fqEegPGCLhqnjBXsRMt/7sM6xo37KxPWxyR48FMMQkF03X2AD
         c2VhuWg3EN32OuTtYxm/+iCsOu4jI4SWJ9B2u77gnahOWgcdZTpOGU36JKykiiU+RVCs
         zdIPLUAkunoflP8c6F0b0Q/0j8+AfgCwz2h2JORtIjUqdpYh9kqDosEHjYYNdS2dvWHV
         bKasGB4rgpFFdv9f9bMcb6XUa85Wu8bbMEBhreD1J0pIHsK5g1vsy2fNa+j55NFmuIPW
         p1bf9U1tDDYmhNUeeCVwbfzd1jcWMCUbW0cmL9G0LE6CGnIVQ3kgbPqcSXIP4mKddtKc
         pH6g==
X-Gm-Message-State: AOJu0YxKE6PlHZ6C54VRufA4MLgB5G//SWYXtNnzER7YCwraCPJbM1qT
	JEAS9Vzw5YubSxsl2H59KfayjtqjrOoJYFwidw63npErmn7t7MH5ATmAhg==
X-Google-Smtp-Source: AGHT+IEiVtmKlCzgGUDRgiua9iJA5onJf4eBv9uJEbJQSRfXXO/0QJU96Wl/OLLe1BD6lcWLHt/MAg==
X-Received: by 2002:a05:6000:154b:b0:382:346b:3654 with SMTP id ffacd0b85a97d-382346b47d5mr7201951f8f.56.1731947185050;
        Mon, 18 Nov 2024 08:26:25 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d48c731dsm109341455e9.2.2024.11.18.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:26:24 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v3 3/4] parse: add support for 'addfragments' directive
Date: Mon, 18 Nov 2024 17:26:09 +0100
Message-Id: <20241118162610.1423384-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118162610.1423384-1-alex.kanavin@gmail.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Nov 2024 16:26:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16809

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
 lib/bb/parse/ast.py                  | 33 ++++++++++++++++++++++++++++
 lib/bb/parse/parse_py/ConfHandler.py |  6 +++++
 2 files changed, 39 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 001ba8d289a..d3b7fef9895 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -326,6 +326,34 @@ class InheritDeferredNode(AstNode):
         inherits.append(self.inherit)
         data.setVar('__BBDEFINHERITS', inherits)
 
+class AddFragmentsNode(AstNode):
+    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable):
+        AstNode.__init__(self, filename, lineno)
+        self.path = fragments_path_prefix
+        self.variable = fragments_variable
+
+    def eval(self, data):
+        def find_fragment(layers, layerid, full_fragment_name):
+           for layerpath in layers.split():
+               candidate_fragment_path = os.path.join(layerpath, full_fragment_name)
+               if os.path.exists(candidate_fragment_path) and bb.utils.get_file_layer(candidate_fragment_path, data) == layerid:
+                   return candidate_fragment_path
+           return None
+
+        fragments = data.getVar(self.variable)
+        layers = data.getVar('BBLAYERS')
+
+        if not fragments:
+            return
+        for f in fragments.split():
+            layerid, fragment_name = f.split('/', 1)
+            full_fragment_name = data.expand("{}/{}.conf".format(self.path, fragment_name))
+            fragment_path = find_fragment(layers, layerid, full_fragment_name)
+            if fragment_path:
+                bb.parse.ConfHandler.include(self.filename, fragment_path, self.lineno, data, "include fragment")
+            else:
+                bb.error("Could not find fragment {} in enabled layers: {}".format(f, layers))
+
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
@@ -370,6 +398,11 @@ def handleInheritDeferred(statements, filename, lineno, m):
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


