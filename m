Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web10.17958.1595334829088170145
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jul 2020 05:33:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K5Yz0iT0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id z2so21075105wrp.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jul 2020 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VxtGAYVcKmBLTrxzT461kMDg6Brbe0HpXA8MErQIpb0=;
        b=K5Yz0iT0aHQz9RnOY781nmb5Qo4FtLemHB8J8YGI56Djr2wDhcJJxDvfsD+KnqKROt
         96uwicQkKrcNjy+42bMm1B1ks/ty/FLLrobyOWZ7xW68Y3s43WbmvshHDnG4yS8pZx5H
         ahJaYRtM0LcyiuqoZ4tY9wCDP9nduw5RQG/NA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxtGAYVcKmBLTrxzT461kMDg6Brbe0HpXA8MErQIpb0=;
        b=JPrJvw0N7a93vvuua9g5wQBBw+unyXqjlSudW8jXYi9X3slQIXLHpUL1mAJAnM5fru
         ZmLXMUvL+Xp6UBeuKZbHcs+bzp6vBx1chU/VZcD6Icc1FFpl4D556dVn72UDDi7WLI0d
         eV2WUiSxDm6MEfKv5B1sddGcScvbmh9qfzLIn0sJKpuHL1KtVMN7IZ6qLelqUj/ZbirT
         J3SmtVsnOlSk5Hru7HUJKv79+7WqnnPH4jK4Hq586kj+TAF0CF4dbFktjTwTeEl4suNc
         cbwpFrabmlRqQsEu8fe/Wg+/uxvVqR5Dn59j/IZLux8qIcSTdEhpXzyHtXQsK9HdEe77
         +7rg==
X-Gm-Message-State: AOAM530G4CYZABClHkrEno2DDkxTBtJ6IvV+tAljzYDMq+HszZX6GQ4R
	dSkSbOL+UTinzUd1YvuusAVS8W2rJoNooA==
X-Google-Smtp-Source: ABdhPJwLH2e7Cbbbxv0zzpXvNbmsumXOyFbrLpZUiK3xcMEm2LQQ+VyHDNM7dE6rzaAy3n0R8/abLQ==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr10803195wro.239.1595334827070;
        Tue, 21 Jul 2020 05:33:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (6.d.c.a.e.4.9.c.8.4.4.2.b.1.8.1.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:181b:2448:c94e:acd6])
        by smtp.gmail.com with ESMTPSA id x13sm1815113wro.64.2020.07.21.05.33.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 05:33:46 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] build: Allow deltask to take multiple tasknames
Date: Tue, 21 Jul 2020 13:33:44 +0100
Message-Id: <20200721123344.121156-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200721123344.121156-1-richard.purdie@linuxfoundation.org>
References: <20200721123344.121156-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

deltask currently supports only one task to delete but it would be useful
if it could support a variable which gets expanded to allow flexibility
in the metadata.

This is simple to support in bitbake and is how other directives such
as inherit operate so adjust the parser/code to handle that. It means
that syntax like:

EXTRA_NOPACKAGE_DELTASKS = ""
deltask ${EXTRA_NOPACKAGE_DELTASKS}

is now allowed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py                | 10 ++++++----
 lib/bb/parse/parse_py/BBHandler.py |  5 +----
 lib/bb/tests/parse.py              |  6 ++++--
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 785aa974eb..0714296af2 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -244,12 +244,14 @@ class AddTaskNode(AstNode):
         bb.build.addtask(self.func, self.before, self.after, data)
 
 class DelTaskNode(AstNode):
-    def __init__(self, filename, lineno, func):
+    def __init__(self, filename, lineno, tasks):
         AstNode.__init__(self, filename, lineno)
-        self.func = func
+        self.tasks = tasks
 
     def eval(self, data):
-        bb.build.deltask(self.func, data)
+        tasks = data.expand(self.tasks).split()
+        for task in tasks:
+            bb.build.deltask(task, data)
 
 class BBHandlerNode(AstNode):
     def __init__(self, filename, lineno, fns):
@@ -305,7 +307,7 @@ def handleAddTask(statements, filename, lineno, m):
     statements.append(AddTaskNode(filename, lineno, func, before, after))
 
 def handleDelTask(statements, filename, lineno, m):
-    func = m.group("func")
+    func = m.group(1)
     if func is None:
         return
 
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 6e216effb8..215f940b60 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -26,7 +26,7 @@ __func_start_regexp__    = re.compile(r"(((?P<py>python)|(?P<fr>fakeroot))\s*)*(
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
 __addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
-__deltask_regexp__       = re.compile(r"deltask\s+(?P<func>\w+)(?P<ignores>.*)")
+__deltask_regexp__       = re.compile(r"deltask\s+(.+)")
 __addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile(r"def\s+(\w+).*:" )
 __python_func_regexp__   = re.compile(r"(\s+.*)|(^$)|(^#)" )
@@ -238,9 +238,6 @@ def feeder(lineno, s, fn, root, statements, eof=False):
 
     m = __deltask_regexp__.match(s)
     if m:
-        # Check and warn "for deltask task1 task2"
-        if m.group('ignores'):
-            logger.warning('deltask ignored: "%s"' % m.group('ignores'))
         ast.handleDelTask(statements, fn, lineno, m)
         return
 
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 9afd1b208e..9e21e18425 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -178,7 +178,10 @@ python () {
 addtask do_patch after do_foo after do_unpack before do_configure before do_compile
 addtask do_fetch do_patch
 
-deltask do_fetch do_patch
+MYVAR = "do_patch"
+EMPTYVAR = ""
+deltask do_fetch ${MYVAR} ${EMPTYVAR}
+deltask ${EMPTYVAR}
 """
     def test_parse_addtask_deltask(self):
         import sys
@@ -189,6 +192,5 @@ deltask do_fetch do_patch
         self.assertTrue("addtask contained multiple 'before' keywords" in stdout)
         self.assertTrue("addtask contained multiple 'after' keywords" in stdout)
         self.assertTrue('addtask ignored: " do_patch"' in stdout)
-        self.assertTrue('deltask ignored: " do_patch"' in stdout)
         #self.assertTrue('dependent task do_foo for do_patch does not exist' in stdout)
 
-- 
2.25.1

