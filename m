Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C02AC02181
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 01:02:59 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.207])
 by mx.groups.io with SMTP id smtpd.web11.6004.1737421372070702728
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Jan 2025 17:02:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=Izz9FClv;
 spf=pass (domain: freemail.hu, ip: 46.107.16.207, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YcTTN6CtRz141r;
	Tue, 21 Jan 2025 02:02:48 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH] bitbake: knotty/progressbar: Optimize footer update and prints
Date: Tue, 21 Jan 2025 02:01:56 +0100
Message-ID: <20250121010156.470-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737421369;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 01:02:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17037

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=8744; bh=f8btanmB0MHEbLinyuPnELB0DeDAojsfNYf5hbG1+T0=;

	b=Izz9FClvWTQ6k1FQlm5qdHoLuJvJG5VMwU2MecNggx82mVWfug/qpacg2vCR3nTu

	MkEgPhRpjWckEkKWd/I3jpprNKO5yxSvG+6gQ/Q1Tv5tF3qd/Fcf/ucqIfVz1v3YgQr

	RNupHb4LPi5cTdjWAOetlJXJmPvApUEH6irKmXRcyRtPeI02Z4QwuX8ca5BJ7xetnNS

	j5l2BOE/ZESyJAPjiS65W3EXObBKu5F00tb7PCX8sgvWBkTVIBxZ+5rfQenr87WQci5

	yQaNbLwWhd+cLQRsRmKKC7gq+fwiuABg+xC0qxO43WYp1S3hte/sSudCl792hiAGnzS

	EAU9dayLyQ==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

- Optimize printing in footer update with use a StringIO buffer.
- Cleaning and refactoring prints in code, print() functions were elimina=
ted from all loops for better performance.
- Use max 10 Hz refresh rate (FPS) for footer update.
- Check file descriptor in ProgressBar() class init to see if it's STDOUT=
 or STDERR and resizable.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/ui/knotty.py            | 81 ++++++++++++++++++++++++----------
 lib/progressbar/progressbar.py | 23 ++++++----
 2 files changed, 71 insertions(+), 33 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 2fff1b366..cd40e76e0 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -10,6 +10,7 @@
=20
 from __future__ import division
=20
+import io
 import os
 import sys
 import logging
@@ -127,6 +128,10 @@ class InteractConsoleLogFilter(logging.Filter):
         return True
=20
 class TerminalFilter(object):
+
+    # 10 Hz (FPS) -> 0.100 secs
+    _DEFAULT_PRINT_INTERVAL =3D 0.100
+
     rows =3D 25
     columns =3D 80
=20
@@ -165,9 +170,12 @@ class TerminalFilter(object):
         self.interactive =3D sys.stdout.isatty()
         self.footer_present =3D False
         self.lastpids =3D []
-        self.lasttime =3D None
+        self.lasttime =3D time.time()
         self.quiet =3D quiet
=20
+        self._footer_buf =3D io.StringIO()
+        self._footer_lines =3D None
+
         if not self.interactive:
             return
=20
@@ -215,11 +223,11 @@ class TerminalFilter(object):
=20
     def clearFooter(self):
         if self.footer_present:
-            lines =3D self.footer_present
-            sys.stdout.buffer.write(self.curses.tparm(self.cuu, lines))
+            sys.stdout.buffer.write(self.curses.tparm(self.cuu, self._fo=
oter_lines))
             sys.stdout.buffer.write(self.curses.tparm(self.ed))
             sys.stdout.flush()
         self.footer_present =3D False
+        self._footer_lines =3D None
=20
     def elapsed(self, sec):
         hrs =3D int(sec / 3600.0)
@@ -235,28 +243,47 @@ class TerminalFilter(object):
=20
     def keepAlive(self, t):
         if not self.cuu:
-            print("Bitbake still alive (no events for %ds). Active tasks=
:" % t)
+            msgbuf =3D ["Bitbake still alive (no events for %ds). Active=
 tasks:" % t]
             for t in self.helper.running_tasks:
-                print(t)
+                msgbuf.append(str(t))
+            print("\n".join(msgbuf))
             sys.stdout.flush()
=20
     def updateFooter(self):
         if not self.cuu:
             return
+
         activetasks =3D self.helper.running_tasks
         failedtasks =3D self.helper.failed_tasks
         runningpids =3D self.helper.running_pids
         currenttime =3D time.time()
-        if not self.lasttime or (currenttime - self.lasttime > 5):
+        deltatime =3D currenttime - self.lasttime
+
+        if (deltatime > 5.0):
             self.helper.needUpdate =3D True
-            self.lasttime =3D currenttime
-        if self.footer_present and not self.helper.needUpdate:
+            need_update =3D self.helper.needUpdate
+        else:
+            # Do not let to update faster then _DEFAULT_PRINT_INTERVAL
+            # to avoid heavy print() flooding.
+            need_update =3D self.helper.needUpdate and (deltatime > self=
._DEFAULT_PRINT_INTERVAL)
+
+        if self.footer_present and (not need_update):
+            # Footer update is not need.
             return
+        else:
+            # Footer update is need and store its "lasttime" value.
+            self.lasttime =3D currenttime
+
         self.helper.needUpdate =3D False
         if self.footer_present:
             self.clearFooter()
         if (not self.helper.tasknumber_total or self.helper.tasknumber_c=
urrent =3D=3D self.helper.tasknumber_total) and not len(activetasks):
             return
+
+        # Clear footer buffer.
+        self._footer_buf.truncate(0)
+        self._footer_buf.seek(0)
+
         tasks =3D []
         for t in runningpids:
             start_time =3D activetasks[t].get("starttime", None)
@@ -275,6 +302,7 @@ class TerminalFilter(object):
                     else:
                         pbar =3D BBProgress("0: %s" % msg, 100, widgets=3D=
[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=3D5=
, resize_handler=3Dself.sigwinch_handle)
                         pbar.bouncing =3D False
+                    pbar.fd =3D self._footer_buf
                     activetasks[t]["progressbar"] =3D pbar
                 tasks.append((pbar, msg, progress, rate, start_time))
             else:
@@ -284,17 +312,17 @@ class TerminalFilter(object):
             content =3D pluralise("Waiting for %s running task to finish=
",
                                 "Waiting for %s running tasks to finish"=
, len(activetasks))
             if not self.quiet:
-                content +=3D ':'
-            print(content)
+                content +=3D ":"
+            print(content, file=3Dself._footer_buf)
         else:
             scene_tasks =3D "%s of %s" % (self.helper.setscene_current, =
self.helper.setscene_total)
             cur_tasks =3D "%s of %s" % (self.helper.tasknumber_current, =
self.helper.tasknumber_total)
=20
-            content =3D ''
+            content =3D ""
             if not self.quiet:
                 msg =3D "Setscene tasks: %s" % scene_tasks
-                content +=3D msg + "\n"
-                print(msg)
+                content +=3D (msg + "\n")
+                print(msg, file=3Dself._footer_buf)
=20
             if self.quiet:
                 msg =3D "Running tasks (%s, %s)" % (scene_tasks, cur_tas=
ks)
@@ -306,11 +334,12 @@ class TerminalFilter(object):
             if not self.main_progress or self.main_progress.maxval !=3D =
maxtask:
                 widgets =3D [' ', progressbar.Percentage(), ' ', progres=
sbar.Bar()]
                 self.main_progress =3D BBProgress("Running tasks", maxta=
sk, widgets=3Dwidgets, resize_handler=3Dself.sigwinch_handle)
+                self.main_progress.fd =3D self._footer_buf
                 self.main_progress.start(False)
             self.main_progress.setmessage(msg)
             progress =3D max(0, self.helper.tasknumber_current - 1)
             content +=3D self.main_progress.update(progress)
-            print('')
+            print("", file=3Dself._footer_buf)
         lines =3D self.getlines(content)
         if not self.quiet:
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines=
)]):
@@ -326,15 +355,19 @@ class TerminalFilter(object):
                         content =3D pbar.update(progress)
                     else:
                         content =3D pbar.update(1)
-                    print('')
+                    print("", file=3Dself._footer_buf)
                 else:
                     content =3D "%s: %s" % (tasknum, task)
-                    print(content)
+                    print(content, file=3Dself._footer_buf)
                 lines =3D lines + self.getlines(content)
-        self.footer_present =3D lines
+        self._footer_lines =3D lines
+        self.footer_present =3D True
         self.lastpids =3D runningpids[:]
         self.lastcount =3D self.helper.tasknumber_current
=20
+        # Print footer buffer.
+        print(self._footer_buf.getvalue(), end=3D"")
+
     def getlines(self, content):
         lines =3D 0
         for line in content.split("\n"):
@@ -342,35 +375,35 @@ class TerminalFilter(object):
         return lines
=20
     def finish(self):
+        self._footer_buf.close()
         if self.stdinbackup:
             fd =3D sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdi=
nbackup)
=20
 def print_event_log(event, includelogs, loglines, termfilter):
-    # FIXME refactor this out further
     logfile =3D event.logfile
     if logfile and os.path.exists(logfile):
         termfilter.clearFooter()
         bb.error("Logfile of failure stored in: %s" % logfile)
         if includelogs and not event.errprinted:
-            print("Log data follows:")
             f =3D open(logfile, "r")
+            msgbuf =3D ["Log data follows:"]
             lines =3D []
             while True:
                 l =3D f.readline()
-                if l =3D=3D '':
+                if l =3D=3D "":
                     break
                 l =3D l.rstrip()
                 if loglines:
-                    lines.append(' | %s' % l)
+                    lines.append(" | %s" % l)
                     if len(lines) > int(loglines):
                         lines.pop(0)
                 else:
-                    print('| %s' % l)
+                    msgbuf.append("| %s" % l)
             f.close()
             if lines:
-                for line in lines:
-                    print(line)
+                msgbuf.extend(lines)
+            print("\n".join(msgbuf))
=20
 def _log_settings_from_server(server, observe_only):
     # Get values of variables which control our output
diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar=
.py
index d4da10ab7..2aa61c015 100644
--- a/lib/progressbar/progressbar.py
+++ b/lib/progressbar/progressbar.py
@@ -110,19 +110,24 @@ class ProgressBar(object):
         self.widgets =3D widgets
         self.fd =3D fd
         self.left_justify =3D left_justify
+        self._fd_console =3D None
+
+        fd_num =3D fd.fileno()
=20
         self.signal_set =3D False
         if term_width is not None:
             self.term_width =3D term_width
+        elif (fd_num =3D=3D 1) or (fd_num =3D=3D 2):
+            # STDOUT is the default writing descriptor with a value of 1=
.
+            # STDERR is the default error descriptor with a value of 2.
+            # Sure, fd is a resizable file descriptor, let's allow to
+            # use for self._handle_resize().
+            self._fd_console =3D fd
+            self._handle_resize(None, None)
+            signal.signal(signal.SIGWINCH, self._handle_resize)
+            self.signal_set =3D True
         else:
-            try:
-                self._handle_resize(None, None)
-                signal.signal(signal.SIGWINCH, self._handle_resize)
-                self.signal_set =3D True
-            except (SystemExit, KeyboardInterrupt): raise
-            except Exception as e:
-                print("DEBUG 5 %s" % e)
-                self.term_width =3D self._env_size()
+            self.term_width =3D self._env_size()
=20
         self.__iterable =3D None
         self._update_widgets()
@@ -182,7 +187,7 @@ class ProgressBar(object):
     def _handle_resize(self, signum=3DNone, frame=3DNone):
         """Tries to catch resize signals sent from the terminal."""
=20
-        h, w =3D array('h', ioctl(self.fd, termios.TIOCGWINSZ, '\0' * 8)=
)[:2]
+        h, w =3D array('h', ioctl(self._fd_console, termios.TIOCGWINSZ, =
'\0' * 8))[:2]
         self.term_width =3D w
=20
=20
--=20
2.47.1.windows.2


