Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119BDCCD1BB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 11:32:05 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.6605.1761132716549189813
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 04:31:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E0HgtD69;
 spf=pass (domain: gmail.com, ip: 209.85.128.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47106fc51faso80304305e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 04:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761132715; x=1761737515; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8C/c3gXaWEJkiQwbTJRoia4bWXt7AhJ4Z7w5QDDQdc=;
        b=E0HgtD69Z+Qv/dWaynypVg6NTh/xDLDz3XIeqqZk0p0c4z6WvgonyyT2grfnM/Hzu2
         aLcs7A9LwmLwPiu8lITZZNEizfMOGLNbWoRuY52KyXYzmqmM+/qx4h6wBTpwN+7pMnCy
         GPwrPD5+pbP5hSV4q2CcmHG7NB6qL/wn1KLJK/kfnBJqaj5iI7Zi2JAyWb6ZNuTqTdAx
         m0blsqNsyYfqnUHlq6OrbtsMsZYxYIiDWlHo2m5a41At5UlQk2xKHRotKfk9XNEmI7vC
         VS50T+1PRYHIjIdi+5WmVkodBdw5REk3S/S5lgJCAnKt/DqIK98gW5OCGffYg9Ck/O1o
         j1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132715; x=1761737515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8C/c3gXaWEJkiQwbTJRoia4bWXt7AhJ4Z7w5QDDQdc=;
        b=hogRzXvfg9lsx4ShKVfqEl6Zgc774SZ7KnUVYL1TvjS4aa54kmmAAUzIeGZxmsjbC0
         CIrSlnoHIhLALv0fUdwm9LCtC82c45LSznhvBMdRT7zRyRvLG9F08jjTgUOYf9xm2XtW
         VShs3tk9V1hBh9G2YJbkD3onQYxxswcpQvMDZ5Y+GUcHsldo5E6imnuydAEAOcfGpVDh
         /92oNrh1N6bNTgi14bFReFwEEmmvWyYonZb03Ot9IDiuEwD9SaAmibMcYdcQIDQhV2/M
         Ow3fAz8KSoqqhTtjAmknIvy16/OJ1ytMgcCgawLzntqfNviWZ3WMm0I5oor0dOsosFtO
         /aOw==
X-Gm-Message-State: AOJu0YyqRsfU0iZor0ofiWe00/nwPam/Kd9TarkBTocnrWxW5m4/vYxg
	XIXIm3NpD6BDp26fe7Qp+An3KWLDnUt4ApN9ck/ndHu3UjyYikKglDIabNibuA==
X-Gm-Gg: ASbGncuAIHZRQSgOx1NApTC7K7aDGPO9UIW10qXoDAHSz833o5ypZAhrRCAXqEZ5q5g
	+ugOtzCYbp58qgEnU2ONi1DLI0wBvlfnLzVQ2C3t9qdgwDzLcg9jegvlaYu5TfuBlox5VDsANrg
	eVp+AlQ7MgzaMYa/j3RfuYHHRCr4hN4HF6Oagy0eQA4jWiBgP2c+KU47IE7vU+5wtQ5FzMQPoBd
	oMdZrC947DJhK0/8hTB754975/VKAHO1sgbX7yBMw37Fn+GxKv1/Tthb6dGRNUa0HgPypLweGyh
	7Obx2OTkkUKheLwxkCb7/PM7v//9ihu7ixTcxmPK73flF6LFv2nLAR9u3U42TCmCspHF/EPg8cK
	SK3qQ/7Pb99FwgoFi00czB6alrCKlmnQWG9wN6tczxxYHqwfuWubuVYtMUNXjPD6jaEhFSN6QKz
	4U56dvVPPxZrz02l74klWHAEwmXfwOWaGDZG4yG9zXKgaozBrgmbX2LWFdUD0wp2HjBYSYw1cvK
	U5yg/Th1jHWcuEuUF+zzWeUeSSqWhIeOYjH+4T6SX2xv1izrg==
X-Google-Smtp-Source: AGHT+IFaMgLTSX9s0JOob0zfoGpt+8Z4pF2c6S6OvlIWAks2lyxu7O6Y8aqz2ZmQrDPuDxCdek7uQg==
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr158944445e9.22.1761132714625;
        Wed, 22 Oct 2025 04:31:54 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ae5510sm36131255e9.3.2025.10.22.04.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:31:54 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH] parse: add bitbake version check via bitbake_min_version keyword
Date: Wed, 22 Oct 2025 13:31:46 +0200
Message-Id: <20251022113146.3207795-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 11:32:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18207

From: Alexander Kanavin <alex@linutronix.de>

Layers (e.g. openembedded-core) can specify in conf/layer.conf:

bitbake_min_version 2.15.2

and if bitbake has a lesser version it will stop itself, as early
as possible, to avoid hitting cryptic compatibility issues later on,
with this error:

bb.parse.ParseError: ParseError at /home/alex/bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64/layers/openembedded-core/meta/conf/layer.conf:1: Bitbake version 2.15.3 is required and version 2.15.2 is used

Note that sanity.bbclass in oe-core has a similar check, but as
this thread [1] highlighted, compatibility issues can stop bitbake
sooner and the check is never reached, leaving the user with
confusing errors.

[1] https://lists.openembedded.org/g/openembedded-core/topic/115724008

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/parse/ast.py                  | 12 ++++++++++++
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index cfead466e1c..20c6f51a837 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -412,6 +412,14 @@ class AddFragmentsNode(AstNode):
             else:
                 bb.error("Could not find fragment {} in enabled layers: {}".format(f, layers))
 
+class BbMinVersionNode(AstNode):
+    def __init__(self, filename, lineno, bb_min_version):
+        AstNode.__init__(self, filename, lineno)
+        self.bb_min_version = bb_min_version
+
+    def eval(self, data):
+        bb.parse.ConfHandler.check_bb_version(self.filename, self.lineno, self.bb_min_version)
+
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
@@ -466,6 +474,10 @@ def handleAddFragments(statements, filename, lineno, m):
     builtin_fragments_variable = m.group(4)
     statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable, builtin_fragments_variable))
 
+def handleBbMinVersion(statements, filename, lineno, m):
+    bb_min_version = m.group(1)
+    statements.append(BbMinVersionNode(filename, lineno, bb_min_version))
+
 def runAnonFuncs(d):
     code = []
     for funcname in d.getVar("__BBANONFUNCS", False) or []:
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 9ddbae123dc..eff7f67129d 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -49,6 +49,7 @@ __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 __addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)\s+(.+)\s+(.+)" )
+__bitbake_min_version_regexp__ = re.compile(r"bitbake_min_version\s+(.+)" )
 
 def init(data):
     return
@@ -102,6 +103,10 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
             else:
                 raise ParseError("Error parsing %s: %s" % (fn, exc.strerror), parentfn, lineno)
 
+def check_bb_version(fn, lineno, min_version):
+    if bb.utils.vercmp_string_op(bb.__version__, min_version, "<"):
+        raise ParseError('Bitbake version %s is required and version %s is used\n' % (min_version, bb.__version__), fn, lineno)
+
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
 # a weak default, it turns out to be very difficult to filter out these changes,
@@ -213,6 +218,11 @@ def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
         ast.handleAddFragments(statements, fn, lineno, m)
         return
 
+    m = __bitbake_min_version_regexp__.match(s)
+    if m:
+        ast.handleBbMinVersion(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.39.5


