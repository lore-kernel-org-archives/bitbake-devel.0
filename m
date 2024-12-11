Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4EAE77182
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 13:46:25 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.11251.1733924781385018537
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Dec 2024 05:46:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YCQLj5VO;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43618283dedso15168895e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733924780; x=1734529580; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdyqGbzagk0HKo9XbLSQPdW+vo2Tn7p/XuvBAIk0eCs=;
        b=YCQLj5VO6tx/HbgOthGW1IaUFevWRpymGFiRLqc1apuu26rDxc46K0gPdZkK+wJPLv
         PQK6HfIIu+lSzxmVxFzZw3dCCwpPsiN2c1R96RKFs0aimd6SyMSxYo1ycpmyyHfFQfUF
         u+EtToxsauGDLZ45xeZEj0xsxOjRcM8HfOZS9RNO917UP2b3EwHL5cfp4RgDBEUBC93C
         jFqwQR/jPkjxXGKPxg3R65hSs2SkGt4b+IQ57RDR1VGeEdz0BqLy0HG360GlPoiDoCdS
         a5dzfal9Imef6AJe1SOUTYWatRIWE6hihMy9WKPts4yM/a9C7iCwwbhBKq0UnrVG2XNY
         VnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733924780; x=1734529580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdyqGbzagk0HKo9XbLSQPdW+vo2Tn7p/XuvBAIk0eCs=;
        b=QjONWhkXMjW2XLoSWSTxNl25s2oXP0vXcBC1GUclCA0UV7NqE4w9KVYSDKLgjICcws
         uBIGdK2QpNtNMmoJd6/OqA8T8GfySNbi68EPcXczhn1LM99yjPoAw/ZvFOOQDb8oztKG
         EyPWtO0iFCCuxN0cn/ARfqWLTJKcvva0eo/3FuO0HuLSe/LO1OL1kDPpSgt/ImTnP1Ml
         hwgUP9sNgV/3ELyTNlhaBFhP390OlUtTwMRK4j0HaikQuQNGqXHr4dMPlIEwP7h+A/YU
         c2t/dbJVHf6KxISVeMJHlN43dW/z+TXsCabFbeSHjX3g+iC04CjYFSpb6ccPJTTIcXZt
         1LVg==
X-Gm-Message-State: AOJu0YzSuoCvcRdy5eiuCohHuMBdvjmu07ybcIzrisH/57QWDyAu3nJU
	pg/5D/+PIwNOIPY/Z+q3/7DbFwoVmEY9jvJd58jsSslJxI0w6xTJ5x93rQ==
X-Gm-Gg: ASbGnctRIF4qgrejgX+5PMQZ+lKXCULFCM1hhNvHCIJEuBz1bwwVkE/C6nYtpsMvNAM
	QqONzQL/9cZSmFHuo8uITtmxKQzW4ljA/y9L0BUdFXiH/I2yKqlOceAzgzF/X7Y4gD2670+pP6J
	elTI0ISRpIhG4WKhL4YWvbgdE2/nb3H3nJQG961Cc8/WbOKnAcFFLDw6LGBF42z3SBmFKzaFlUq
	Mno/+dBwmEAJkUfnMKLuno9Hi4NssqyVhB5CfUU+7D9eZcKpVdq5fR3MfvjHMD/sQNP/SJqtvwM
	mg/UQ2fenF5t+EE=
X-Google-Smtp-Source: AGHT+IFqxEZCVR7ZX+B/Ypy4Y3hRik9WFJWsLmx2rzAKW469aLKlqQrGXm6UtPaVlXUyh8uIzkprjw==
X-Received: by 2002:a05:600c:3d13:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-4361c3e031amr22772685e9.19.1733924779581;
        Wed, 11 Dec 2024 05:46:19 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ff0e90esm11411035e9.13.2024.12.11.05.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 05:46:18 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/2] bitbake: parse: add support for flagged fragment variables
Date: Wed, 11 Dec 2024 14:46:14 +0100
Message-Id: <20241211134615.2685951-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 13:46:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16907

From: Alexander Kanavin <alex@linutronix.de>

It was suggested that using flags in fragment content to
mark fragment-specific metadata (such as descriptions and
dependencies) is prone to quiet regressions when fragments
are renamed or moved, and it clutters the fragment content.

With this change allowed fragment metadata variables must
be explicitly listed in a variable that is given to addfragment
directive, and parser will add the flag containing the fragment name
to them.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/ast.py                  | 11 +++++++++--
 lib/bb/parse/parse_py/ConfHandler.py |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 7abefab2c2e..03370180e35 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -327,10 +327,11 @@ class InheritDeferredNode(AstNode):
         data.setVar('__BBDEFINHERITS', inherits)
 
 class AddFragmentsNode(AstNode):
-    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable):
+    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable):
         AstNode.__init__(self, filename, lineno)
         self.fragments_path_prefix = fragments_path_prefix
         self.fragments_variable = fragments_variable
+        self.flagged_variables_list_variable = flagged_variables_list_variable
 
     def eval(self, data):
         # No need to use mark_dependency since we would only match a fragment
@@ -345,6 +346,7 @@ class AddFragmentsNode(AstNode):
 
         fragments = data.getVar(self.fragments_variable)
         layers = data.getVar('BBLAYERS')
+        flagged_variables = data.getVar(self.flagged_variables_list_variable).split()
 
         if not fragments:
             return
@@ -354,6 +356,10 @@ class AddFragmentsNode(AstNode):
             fragment_path = find_fragment(layers, layerid, full_fragment_name)
             if fragment_path:
                 bb.parse.ConfHandler.include(self.filename, fragment_path, self.lineno, data, "include fragment")
+                for flagged_var in flagged_variables:
+                    val = data.getVar(flagged_var)
+                    data.setVarFlag(flagged_var, f, val)
+                    data.setVar(flagged_var, None)
             else:
                 bb.error("Could not find fragment {} in enabled layers: {}".format(f, layers))
 
@@ -404,7 +410,8 @@ def handleInheritDeferred(statements, filename, lineno, m):
 def handleAddFragments(statements, filename, lineno, m):
     fragments_path_prefix = m.group(1)
     fragments_variable = m.group(2)
-    statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable))
+    flagged_variables_list_variable = m.group(3)
+    statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable))
 
 def runAnonFuncs(d):
     code = []
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 35321dacfe1..d0711eda042 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -47,7 +47,7 @@ __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
-__addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)" )
+__addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)\s+(.+)" )
 
 def init(data):
     return
-- 
2.39.5


