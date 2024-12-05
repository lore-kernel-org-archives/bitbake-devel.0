Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8054AE7716C
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 16:39:44 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.16082.1733416781595279797
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 08:39:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EHdqhHBM;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso598557f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 08:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733416780; x=1734021580; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7dM6ei4SpcFtAe6QxbnuUivgTevDFbqknffVh8tiHs=;
        b=EHdqhHBMEWm6rETDR/7YGVdYnNTtVFWLQ+MwVFI4Y/Vw7ciBm3QPG10MnYYavDDnZT
         4IDfvR++8tUW5CHLvwcXvFrXEK6aTpp1oo/GAYNXMu1cw+baYP5JOS3x4g352aolZbIi
         ANkhnVmAPa2l+at6hgS/m06My6G0rnmwE1OitCijCd0XcAnqz3QlGFK8rQH/XLg9hTeO
         y/VvXc8mvIqtjiHhhe+0mBWu5hHNLG8gzrUHUYpFWe3pfmxPQJx2wG2a3MFzlafKYJ98
         l0mb+yVvndAry899pMGdpjm/mfbh7lr9bF1NeWZudYCCxdv7s0/DkcEMrh91KdjLflgg
         FHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733416780; x=1734021580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7dM6ei4SpcFtAe6QxbnuUivgTevDFbqknffVh8tiHs=;
        b=icuQPFSyk4CRQt8mCchynSIyMGeRPeQsdNQJ2giH3UxyGH/9SpegICVSfT0CLe7QHe
         +mEQ3LP4NtQPCklEwctiIajB3N0E8lj1WDeos5Ryc3VUItk/MaxfdA5/lw4hjOL/i70W
         iqxk0mM6RcmVxCO9hjGmgLZ3+cSDGtlda2OxrtjTK1ofoOk+ck7KX49cOwFi8HHuU7+9
         KDSSgRljg90Lrb5LMpjxjcAKzlyqxirlvtjcsMUKlJdANDN6k+QBCiBEZ47q4Ekg0/FP
         eT8OHiAliIkH9L4gbeH83BC9JifyMdEPy5BkF3LUzKJ8sfTcXWPh/2C5eCzAYCWzTpFO
         AXeQ==
X-Gm-Message-State: AOJu0YzOTi/IzCor2+oGAjk/kb8yhF3G+iSxEm/xdM6e3AMQx/G9HDGK
	WPN7geKeXIQbqp1BEtflf+9FSQF+U0uzeTYWyMsYxgBH4ZUQ08B2FPLhpQ==
X-Gm-Gg: ASbGnctFpGv7am53lomnTuXzHgISgrEH3TJHQbQ3VevpTITdlQLn+B5Kj1l+aJ0Q2BT
	B+gyAtX8ZiUn7SOH/9iBD+9AEs6dUFZjuULfnYMA+CeSXGglw5fnk8+t/XW9meispCS6Aqnqlm2
	iHwRgFnV35PYo1pKhBfwUSpD+slyepinazxRMEctJ0n0Op0PScr2pRP92vMghD5G5rJCYfNHqtA
	c4RcoTxJbkbphvojZv3Q0d9n3cDzvCAe9U6me/1czMDgY6YQ4Jj1XYd3TJkffnwoljTnXhi2Z8A
	polBxkYe99I=
X-Google-Smtp-Source: AGHT+IGE1b6brqGOgS3PE5CVvUn3C+2wknlYkQi+tYSgNm6t2DD2XoA5UNvxBIDgCb1OjKm0ZJ9vjA==
X-Received: by 2002:a5d:64c7:0:b0:385:e22e:288b with SMTP id ffacd0b85a97d-385fd436c26mr10349872f8f.59.1733416779777;
        Thu, 05 Dec 2024 08:39:39 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219095desm2338468f8f.64.2024.12.05.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 08:39:39 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v4 2/3] parse: add support for 'addfragments' directive
Date: Thu,  5 Dec 2024 17:39:31 +0100
Message-Id: <20241205163932.4049957-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205163932.4049957-1-alex.kanavin@gmail.com>
References: <20241205163932.4049957-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 16:39:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16881

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
index 001ba8d289a..00603796c25 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -326,6 +326,34 @@ class InheritDeferredNode(AstNode):
         inherits.append(self.inherit)
         data.setVar('__BBDEFINHERITS', inherits)
 
+class AddFragmentsNode(AstNode):
+    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable):
+        AstNode.__init__(self, filename, lineno)
+        self.fragments_path_prefix = fragments_path_prefix
+        self.fragments_variable = fragments_variable
+
+    def eval(self, data):
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


