Return-Path: <jpewhacker@gmail.com>
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com
	[209.85.166.173])
	by mail.openembedded.org (Postfix) with ESMTP id D42DE61C0A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 18:30:08 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id f5so6434455ilq.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=9jAkg69tmQiauE/pIJT7oSwBmWv2zSV0l0x3zhXcCGM=;
	b=hj0B7qDcsxLdVVoIf+H8nSepbzy4+Ogh9tZLLLyM4/uVO45/zfWSQ28mP7Kc2pFBBg
	ttU3ouq+LDBcnC5qDxm1OTIf5SGl+zxwcckvcTgr5NIaE4PNixU/4W3lA16iC2316wuH
	mMrNNYpnC8pDt8aRmAqxnng3Ptzx1hskOl9ZA0iBi13NhROeLEDhv2tN46/YX7a4+Y8e
	gYmhBXgHFIzXq6JIEyz0RnkDcZkrpbHLyLb//AqOyOTUMp5NtNk4Vg+3oFsXY8/2wo8s
	qynzsymqQRgpoWcjEO2GfEAWzL2qEF7KVNyqgSmfJLEGstGEdFG8FrU8mUnKVmT36o5j
	7X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=9jAkg69tmQiauE/pIJT7oSwBmWv2zSV0l0x3zhXcCGM=;
	b=lyr9TtzRTWVFdCesTBO4zcpF9dAG5WINIcxuCMQuVxqB7x/enrRIQxJCjkYIANPs7u
	nYOkz5yxk80+2Nl18OGkK3nQuexF04TKaTlbQ0WDuO6Ex+7mvUF575m5P6v3oBovwFLH
	g2DOpmV7JcY6GO6zqnhaHhv8VNe0SnShBhgS1nVuhobO35XIjjwCRu6OF/DITHS7ksy1
	qdkbKLe2kfdcUji4g7zt8U0CsorKMBM3ewJBoG7Lt7Yd7KFBwXZy3iUV8+WacXEWyweU
	lUC+1PLd08NiJXjtTQMJELZQ5G031y3fIodTNAk5VUza5zIDiax9qUyG2YP3NqJDCQCn
	eHOQ==
X-Gm-Message-State: ANhLgQ3vLpWUUmN3zmsFwiHYudmwDcSaW3E+fy/i0BcveiKoEXmiiKlt
	6Ny71No/crJg5RkwFKN+P6q/c2a5iuo=
X-Google-Smtp-Source: ADFU+vtGA2tc+esN8kEBFjGXyxBjuNU5tWg177O+mC5iPvy+8L9Rt1BqKXKwG8CtgKhBKadhxhCMYA==
X-Received: by 2002:a92:d183:: with SMTP id z3mr9257289ilz.214.1584037809404; 
	Thu, 12 Mar 2020 11:30:09 -0700 (PDT)
Received: from OLA-8C37N23.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id b4sm6929029ilg.58.2020.03.12.11.30.08
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 12 Mar 2020 11:30:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2020 13:30:03 -0500
Message-Id: <20200312183004.8339-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312183004.8339-1-JPEWhacker@gmail.com>
References: <20200312183004.8339-1-JPEWhacker@gmail.com>
Subject: [PATCH 2/3] bitbake: knotty: Treat verbconsole as a console output
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
X-List-Received-Date: Thu, 12 Mar 2020 18:30:09 -0000

The BitBake.verbconsole needs to be treated like a console output logger
(meaning that the TerminalFilter attaches an InteractConsoleLogFilter to
it), even if it's not directly attached to the root 'BitBake' logger.
First, assign a special "is_console" property to the relevant handlers,
then look for the property in the handlers from the configuration object
return by bb.msg.setLoggingConfig(). Finally, pass the list of all
handlers to the TerminalFilter object; it doesn't care about the
difference between console and errconsole, so pass all the relevant
handlers as a list.

This fixes cases where the console output was corrupted when messages
were sent to the 'BitBake.verbconsole' handler.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/ui/knotty.py | 40 +++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b4df5f6e88..db4511844a 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -149,7 +149,7 @@ class TerminalFilter(object):
                 cr = (25, 80)
         return cr
 
-    def __init__(self, main, helper, console, errconsole, quiet):
+    def __init__(self, main, helper, handlers, quiet):
         self.main = main
         self.helper = helper
         self.cuu = None
@@ -179,14 +179,9 @@ class TerminalFilter(object):
             termios.tcsetattr(fd, termios.TCSADRAIN, new)
             curses.setupterm()
             if curses.tigetnum("colors") > 2:
-                if console:
+                for h in handlers:
                     try:
-                        console.formatter.enable_color()
-                    except AttributeError:
-                        pass
-                if errconsole:
-                    try:
-                        errconsole.formatter.enable_color()
+                        h.formatter.enable_color()
                     except AttributeError:
                         pass
             self.ed = curses.tigetstr("ed")
@@ -204,10 +199,9 @@ class TerminalFilter(object):
             self.interactive = False
             bb.note("Unable to use interactive mode for this terminal, using fallback")
             return
-        if console:
-            console.addFilter(InteractConsoleLogFilter(self))
-        if errconsole:
-            errconsole.addFilter(InteractConsoleLogFilter(self))
+
+        for h in handlers:
+            h.addFilter(InteractConsoleLogFilter(self))
 
         self.main_progress = None
 
@@ -411,6 +405,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "level": console_loglevel,
                 "stream": "ext://sys.stdout",
                 "filters": ["BitBake.stdoutFilter"],
+                ".": {
+                    "is_console": True,
+                },
             },
             "BitBake.errconsole": {
                 "class": "logging.StreamHandler",
@@ -418,6 +415,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "level": loglevel,
                 "stream": "ext://sys.stderr",
                 "filters": ["BitBake.stderrFilter"],
+                ".": {
+                    "is_console": True,
+                },
             },
             # This handler can be used if specific loggers should print on
             # the console at a lower severity than the default. It will
@@ -430,6 +430,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 "level": 1,
                 "stream": "ext://sys.stdout",
                 "filters": ["BitBake.verbconsoleFilter"],
+                ".": {
+                    "is_console": True,
+                },
             },
         },
         "formatters": {
@@ -523,7 +526,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         except OSError:
            pass
 
-    bb.msg.setLoggingConfig(logconfig, logconfigfile)
+    conf = bb.msg.setLoggingConfig(logconfig, logconfigfile)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
@@ -534,14 +537,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     # Look for the specially designated handlers which need to be passed to the
     # terminal handler
-    console = None
-    errconsole = None
-    for h in logger.handlers:
-        name = getattr(h, '_name', None)
-        if name == 'BitBake.console':
-            console = h
-        elif name == 'BitBake.errconsole':
-            errconsole = h
+    console_handlers = [h for h in conf.config['handlers'].values() if getattr(h, 'is_console', False)]
 
     bb.utils.set_process_name("KnottyUI")
 
@@ -591,7 +587,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     printinterval = 5000
     lastprint = time.time()
 
-    termfilter = tf(main, helper, console, errconsole, params.options.quiet)
+    termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
 
     while True:
-- 
2.17.1


