Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id E5CBD616A9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2020 16:34:06 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id p1so5244451ils.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2020 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=p/HNZ8KoGtsbr4jsLYmw4BiFQXXrR6HYEhqea9IBZQM=;
	b=Z2rRW3v6PPtk976/8pa7X4D2WxkGu2XWTDsfYbl6yHmPThDYWiCsVChReCA7/laW6U
	LXlpvgQF7bLX5qDS++eR8h1SYAG98bAi28yytqEZGAh9PgAvv59MVKu/veNm7vwRaCis
	BhUawDl2ZVsz8H16+oMIHiJi4fqPLeucZc5PMyYeDZf9QqnDBCPscEx6LWTGCenKTORS
	Azh2LVPbwGZbDMuxC9Une1Susd1QiND4k98nP9VI0mvStF+Su2cBVlYblPyqfUf/BtXj
	T0NPC+gRti0A5DOufZsseeP24yU48+mvGiPpytCGVYrcYb8KNgdS70dOitlnOAfMByM1
	hIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=p/HNZ8KoGtsbr4jsLYmw4BiFQXXrR6HYEhqea9IBZQM=;
	b=uHDxv63/PKqtsEPETN3Zik/I53J2cH/ONvFT/wAaZRKC/DQ/XU27ZwINBRAx704AL8
	NYl4TarfQa7oZkLuJAVaUkNLZDHvkPqJcaNfg29nsfIfvn8nSZeCgEhDEdL/jjB035j2
	WqgJ75fwRVgmJ8gmd6xKOKquNSypeTv0sAIbbBmvY+miQ5skzyLYhyRt2JthrmZACCRA
	YatZYPWM0UlXvwT7ND1qx3Lmhl8gG84DcTT5iBpx7VdY4XKbVRPGqaUj1GVTk/j7GLgF
	/3tX1iUWHCPv8+1Y8hrS/R2K8CMDtJZke0IvlPcwb35f8n6Lb13Je8VceFCsjHXRhq8U
	3GJg==
X-Gm-Message-State: ANhLgQ1DHq3/NuPtCYMNX3ADIBszqQirCzZ7XBzA+FX8GGfurA3wb3EZ
	zA0dKSuXGbxO6NyzMJdBJOb+N1YOXwU=
X-Google-Smtp-Source: ADFU+vsXJrZSmgHJV902GBrEvhpaV7AfvMPClZKXw3zuUT0brq8wC2PD0fYmnQ5LMgrm7A/gquLhSw==
X-Received: by 2002:a92:cb09:: with SMTP id s9mr16446541ilo.299.1583771647690; 
	Mon, 09 Mar 2020 09:34:07 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q1sm15049593ile.71.2020.03.09.09.34.06
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 09 Mar 2020 09:34:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2020 11:33:47 -0500
Message-Id: <20200309163353.15362-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309163353.15362-1-JPEWhacker@gmail.com>
References: <20200309163353.15362-1-JPEWhacker@gmail.com>
Cc: docs@lists.yoctoproject.org
Subject: [PATCH 09/15] bitbake: knotty: Remove dependency on format variable
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 09 Mar 2020 16:34:07 -0000

Passing around the log formatter variable was unnecessary since the log
levels of interest can be accesses as class members of
bb.msg.BBLogFormatter. Switching to do this will make using the
structured python logging much easier, since it can be difficult to
extract out the formatter for a specific handler.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/tinfoil.py   |  4 +---
 bitbake/lib/bb/ui/knotty.py | 32 ++++++++++++++++++++------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 9560eb5b49..5c5be456e2 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -735,11 +735,9 @@ class Tinfoil:
                         console = handler
                     elif handler.stream == sys.stderr:
                         errconsole = handler
-            format_str = "%(levelname)s: %(message)s"
-            format = bb.msg.BBLogFormatter(format_str)
             helper.shutdown = 0
             parseprogress = None
-            termfilter = bb.ui.knotty.TerminalFilter(helper, helper, console, errconsole, format, quiet=self.quiet)
+            termfilter = bb.ui.knotty.TerminalFilter(helper, helper, console, errconsole, quiet=self.quiet)
             try:
                 while True:
                     try:
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index aac12cd479..d5dce7172a 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -109,12 +109,11 @@ def pluralise(singular, plural, qty):
 
 
 class InteractConsoleLogFilter(logging.Filter):
-    def __init__(self, tf, format):
+    def __init__(self, tf):
         self.tf = tf
-        self.format = format
 
     def filter(self, record):
-        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
+        if record.levelno == bb.msg.BBLogFormatter.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
             return False
         self.tf.clearFooter()
         return True
@@ -150,7 +149,7 @@ class TerminalFilter(object):
                 cr = (25, 80)
         return cr
 
-    def __init__(self, main, helper, console, errconsole, format, quiet):
+    def __init__(self, main, helper, console, errconsole, quiet):
         self.main = main
         self.helper = helper
         self.cuu = None
@@ -180,7 +179,16 @@ class TerminalFilter(object):
             termios.tcsetattr(fd, termios.TCSADRAIN, new)
             curses.setupterm()
             if curses.tigetnum("colors") > 2:
-                format.enable_color()
+                if console:
+                    try:
+                        console.formatter.enable_color()
+                    except AttributeError:
+                        pass
+                if errconsole:
+                    try:
+                        errconsole.formatter.enable_color()
+                    except AttributeError:
+                        pass
             self.ed = curses.tigetstr("ed")
             if self.ed:
                 self.cuu = curses.tigetstr("cuu")
@@ -197,9 +205,9 @@ class TerminalFilter(object):
             bb.note("Unable to use interactive mode for this terminal, using fallback")
             return
         if console:
-            console.addFilter(InteractConsoleLogFilter(self, format))
+            console.addFilter(InteractConsoleLogFilter(self))
         if errconsole:
-            errconsole.addFilter(InteractConsoleLogFilter(self, format))
+            errconsole.addFilter(InteractConsoleLogFilter(self))
 
         self.main_progress = None
 
@@ -469,7 +477,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     printinterval = 5000
     lastprint = time.time()
 
-    termfilter = tf(main, helper, console, errconsole, format, params.options.quiet)
+    termfilter = tf(main, helper, console, errconsole, params.options.quiet)
     atexit.register(termfilter.finish)
 
     while True:
@@ -508,21 +516,21 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, logging.LogRecord):
                 lastprint = time.time()
                 printinterval = 5000
-                if event.levelno >= format.ERROR:
+                if event.levelno >= bb.msg.BBLogFormatter.ERROR:
                     errors = errors + 1
                     return_value = 1
-                elif event.levelno == format.WARNING:
+                elif event.levelno == bb.msg.BBLogFormatter.WARNING:
                     warnings = warnings + 1
 
                 if event.taskpid != 0:
                     # For "normal" logging conditions, don't show note logs from tasks
                     # but do show them if the user has changed the default log level to
                     # include verbose/debug messages
-                    if event.levelno <= format.NOTE and (event.levelno < llevel or (event.levelno == format.NOTE and llevel != format.VERBOSE)):
+                    if event.levelno <= bb.msg.BBLogFormatter.NOTE and (event.levelno < llevel or (event.levelno == bb.msg.BBLogFormatter.NOTE and llevel != bb.msg.BBLogFormatter.VERBOSE)):
                         continue
 
                     # Prefix task messages with recipe/task
-                    if event.taskpid in helper.pidmap and event.levelno != format.PLAIN:
+                    if event.taskpid in helper.pidmap and event.levelno != bb.msg.BBLogFormatter.PLAIN:
                         taskinfo = helper.running_tasks[helper.pidmap[event.taskpid]]
                         event.msg = taskinfo['title'] + ': ' + event.msg
                 if hasattr(event, 'fn'):
-- 
2.17.1


