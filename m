Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB2FC3DA7F
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 15:53:46 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.49928.1723478020521829924
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 08:53:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NDPGQ8jo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so35548065e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723478019; x=1724082819; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l/r1seA2c9qLvCw6N7fgypnq3JoEIvNgbnvyNdrF/s=;
        b=NDPGQ8jovwJ2+FOrBOuZTRoC/O5bZZEbuEIQT+Ody1rRFT+XVHUMRmbaLScChV+fVz
         2k3sc95d/GHRa21Ij3uJq7jiSgP3Q++GJD8lnaUfWSLGWoL/F/3IITAFOqWLRuDCk6tb
         PmzWDwsssjOLV1AEJQcEX0NDeJmsZgBOH9PsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723478019; x=1724082819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l/r1seA2c9qLvCw6N7fgypnq3JoEIvNgbnvyNdrF/s=;
        b=fMOCxCF19o7eO12nFj/2NWPTxTVSvfNyCdkD98hXzJxtYg6uy0sYJIOBdR4PkprH3q
         zHwA75QZ7EGWatcaF7kW3B78k7bf1KBLCnGxjoaHN/2gw3BVhM5Ty5JRsN05vWXHBLKS
         kjeveEHtfKccVKbu9bf1U8Lt0J8zuIzddXJOnGiBU1sx51QUK3Gml7JXiFLJzWur//RT
         07L4t5efLVWKTaETCmjArnhHS7rlPdCrR2o+/2gWoTXkUSdszI2Rl7zWdJIaAEKpazHK
         bPZfaDp65JzogtjiJ9Bwys9JoRjyrE8ZDKGO3oE4xR4e4C7w8XY0YYVfBjdlsZxE/IBo
         2a8A==
X-Gm-Message-State: AOJu0YxuMl4qxWPjoQAFzpiqVGxuIJxf8N1hBtkAsn1/0sHrymFOz5H2
	+61VvnqTGx7a+MX1pMA3/nzUOpz7DzgN1DKwt7I1Dh8v7BMXmUJTEadHL1yQJx1QaDKTpAvZm5J
	+XX4=
X-Google-Smtp-Source: AGHT+IH+urJhMCuh/+lrQ9hfJm0aScNQ/kMK/hNW/lEuc26a8HvWY5m9NFKNASyYoKrLAfCln9OE/A==
X-Received: by 2002:a05:600c:4584:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-429d48993e6mr6812815e9.31.1723478018373;
        Mon, 12 Aug 2024 08:53:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:450:fb95:e7af:f3ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c77372e8sm109970015e9.33.2024.08.12.08.53.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:53:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] BBHandler/ast: Improve addtask handling
Date: Mon, 12 Aug 2024 16:53:34 +0100
Message-ID: <20240812155335.904273-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
References: <20240812155335.904273-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 15:53:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16473

The recent addtask improvement to handle comments complicated the regex significantly
and there are already a number of corner cases in that code which aren't handled well.

Instead of trying to complicate the regex further, switch to code logic instead. This
means the following cases are now handled:

* addtask with multiple task names
* addtask with multiple before constraints
* addtask with multiple after constraints

The testcase is updated to match the improvements.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py                | 26 +++++++-------------
 lib/bb/parse/parse_py/BBHandler.py | 38 +++++++++++++++++-------------
 lib/bb/tests/parse.py              | 15 ++++--------
 3 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 7581d003fd..001ba8d289 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -240,14 +240,16 @@ class ExportFuncsNode(AstNode):
                 data.setVar(func, sentinel + "    " + calledfunc + "\n", parsing=True)
 
 class AddTaskNode(AstNode):
-    def __init__(self, filename, lineno, func, before, after):
+    def __init__(self, filename, lineno, tasks, before, after):
         AstNode.__init__(self, filename, lineno)
-        self.func = func
+        self.tasks = tasks
         self.before = before
         self.after = after
 
     def eval(self, data):
-        bb.build.addtask(self.func, self.before, self.after, data)
+        tasks = self.tasks.split()
+        for task in tasks:
+            bb.build.addtask(task, self.before, self.after, data)
 
 class DelTaskNode(AstNode):
     def __init__(self, filename, lineno, tasks):
@@ -348,21 +350,11 @@ def handlePythonMethod(statements, filename, lineno, funcname, modulename, body)
 def handleExportFuncs(statements, filename, lineno, m, classname):
     statements.append(ExportFuncsNode(filename, lineno, m.group(1), classname))
 
-def handleAddTask(statements, filename, lineno, m):
-    func = m.group("func")
-    before = m.group("before")
-    after = m.group("after")
-    if func is None:
-        return
-
-    statements.append(AddTaskNode(filename, lineno, func, before, after))
-
-def handleDelTask(statements, filename, lineno, m):
-    func = m.group(1)
-    if func is None:
-        return
+def handleAddTask(statements, filename, lineno, tasks, before, after):
+    statements.append(AddTaskNode(filename, lineno, tasks, before, after))
 
-    statements.append(DelTaskNode(filename, lineno, func))
+def handleDelTask(statements, filename, lineno, tasks):
+    statements.append(DelTaskNode(filename, lineno, tasks))
 
 def handleBBHandlers(statements, filename, lineno, m):
     statements.append(BBHandlerNode(filename, lineno, m.group(1)))
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index c1653faeee..87c03e9238 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -23,7 +23,7 @@ __func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>faker
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __inherit_def_regexp__   = re.compile(r"inherit_defer\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
-__addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>(([^#\n]*(?=after))|([^#\n]*))))|(after\s*(?P<after>(([^#\n]*(?=before))|([^#\n]*)))))*(?P<comment>#.*|.*?)")
+__addtask_regexp__       = re.compile(r"addtask\s+([^#\n]+)(?P<comment>#.*|.*?)")
 __deltask_regexp__       = re.compile(r"deltask\s+([^#\n]+)(?P<comment>#.*|.*?)")
 __addhandler_regexp__    = re.compile(r"addhandler\s+(.+)" )
 __def_regexp__           = re.compile(r"def\s+(\w+).*:" )
@@ -239,29 +239,35 @@ def feeder(lineno, s, fn, root, statements, eof=False):
 
     m = __addtask_regexp__.match(s)
     if m:
-        if len(m.group().split()) == 2:
-            # Check and warn for "addtask task1 task2"
-            m2 = re.match(r"addtask\s+(?P<func>\w+)(?P<ignores>.*)", s)
-            if m2 and m2.group('ignores'):
-                logger.warning('addtask ignored: "%s"' % m2.group('ignores'))
-
-        # Check and warn for "addtask task1 before task2 before task3", the
-        # similar to "after"
-        taskexpression = s.split()
-        for word in ('before', 'after'):
-            if taskexpression.count(word) > 1:
-                logger.warning("addtask contained multiple '%s' keywords, only one is supported" % word)
+        after = ""
+        before = ""
+        tasks = m.group(1).split(" before ")[0].split(" after ")[0]
+
+        for exp in m.group(1).split(" before "):
+            exp2 = exp.split(" after ")
+            if len(exp2) > 1:
+                after = after + " ".join(exp2[1:])
+
+        for exp in m.group(1).split(" after "):
+            exp2 = exp.split(" before ")
+            if len(exp2) > 1:
+                before = before + " ".join(exp2[1:])
 
-        # Check and warn for having task with exprssion as part of task name
+        # Check and warn for having task with a keyword as part of task name
+        taskexpression = s.split()
         for te in taskexpression:
             if any( ( "%s_" % keyword ) in te for keyword in bb.data_smart.__setvar_keyword__ ):
                 raise ParseError("Task name '%s' contains a keyword which is not recommended/supported.\nPlease rename the task not to include the keyword.\n%s" % (te, ("\n".join(map(str, bb.data_smart.__setvar_keyword__)))), fn)
-        ast.handleAddTask(statements, fn, lineno, m)
+
+        if tasks is not None:
+            ast.handleAddTask(statements, fn, lineno, tasks, before, after)
         return
 
     m = __deltask_regexp__.match(s)
     if m:
-        ast.handleDelTask(statements, fn, lineno, m)
+        task = m.group(1)
+        if task is not None:
+            ast.handleDelTask(statements, fn, lineno, task)
         return
 
     m = __addhandler_regexp__.match(s)
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index d076fcc208..97df2c4590 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -177,7 +177,7 @@ python () {
 
     addtask_deltask = """
 addtask do_patch after do_foo after do_unpack before do_configure before do_compile
-addtask do_fetch do_patch
+addtask do_fetch2 do_patch2
 
 addtask do_myplaintask
 addtask do_myplaintask2
@@ -194,18 +194,11 @@ deltask do_fetch ${MYVAR} ${EMPTYVAR}
 deltask ${EMPTYVAR}
 """
     def test_parse_addtask_deltask(self):
-        import sys
 
-        with self.assertLogs() as logs:
-            f = self.parsehelper(self.addtask_deltask)
-            d = bb.parse.handle(f.name, self.d)['']
+        f = self.parsehelper(self.addtask_deltask)
+        d = bb.parse.handle(f.name, self.d)['']
 
-        output = "".join(logs.output)
-        self.assertTrue("addtask contained multiple 'before' keywords" in output)
-        self.assertTrue("addtask contained multiple 'after' keywords" in output)
-        self.assertTrue('addtask ignored: " do_patch"' in output)
-        self.assertEqual(['do_myplaintask', 'do_mytask', 'do_mytask2'], d.getVar("__BBTASKS"))
-        #self.assertTrue('dependent task do_foo for do_patch does not exist' in output)
+        self.assertEqual(['do_fetch2', 'do_patch2', 'do_myplaintask', 'do_mytask', 'do_mytask2'], d.getVar("__BBTASKS"))
 
     broken_multiline_comment = """
 # First line of comment \\

