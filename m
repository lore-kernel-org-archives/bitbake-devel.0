Return-Path: <git@cookiesoft.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E634CA5FCE
	for <webhook@archiver.kernel.org>; Mon,  5 Oct 2026 08:36:43 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15449.1791189398789425771
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 Oct 2026 01:36:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cookiesoft.de header.s=MBO0001 header.b=z2pcMMTZ;
 spf=pass (domain: cookiesoft.de, ip: 80.241.56.152, mailfrom: git@cookiesoft.de)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hyt5w1Qg7zKp6g;
	Mon, 05 Oct 2026 10:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cookiesoft.de;
	s=MBO0001; t=1791189396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hg/6YG7hehAghfwo0ah4LKKsmaYVBxlRtBoIcUCsyns=;
	b=z2pcMMTZ68ZG34F4n5zLdi/fbWE8NFPCTTYPpsFNWRIUmXLnQbOOG7IxxyLDIieMzQ9Sur
	rnH+iw+euHIVpeZ6B3NHzkxZQLDtNV/ob6NhbG8HsZLitfOx42BVumwRrqNxiQATKhGpog
	AV5Sh7p4zzijB67s8aIr0r7x3/umjIH0o2M/i2nRedRb+xrBbzI0hCQLVXSSwDFMeP+xLR
	GF+aGUG2XtK1ShYRxyHriW683VZpYWmySBgubnpTezw71DpbKBmb+mW7oB5afDB7ezVLWF
	++kXXXxxPjQB8WOtTlPddStNzMlM8MrDfZi39JIYpn8xYcW63oKGGMTmjR6m+g==
From: git@cookiesoft.de
To: bitbake-devel@lists.openembedded.org
Cc: Marcel Hellwig <git@cookiesoft.de>
Subject: [PATCH] knotty: add OSC 9;4 sequence for progress display
Date: Mon,  5 Oct 2026 10:36:22 +0200
Message-ID: <20261005083628.1451356-1-git@cookiesoft.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Oct 2026 08:36:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20294

From: Marcel Hellwig <git@cookiesoft.de>

OSC 9;4[0] allows the terminal emulator to display a progress bar.
This is helpful for the long-running tasks in both Bitbake and Devtool.

The most prominent supporters are Windows Terminal and KDE's Konsole.
Terminals that do not support the sequence simply ignore it, so no
special treament is required.

[0]: https://learn.microsoft.com/en-us/windows/terminal/tutorials/progres=
s-bar-sequences

Signed-off-by: Marcel Hellwig <git@cookiesoft.de>
---
 bitbake/lib/bb/ui/knotty.py | 58 +++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 5198e93d8d..b7388f2948 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -119,6 +119,58 @@ class InteractConsoleLogFilter(logging.Filter):
         self.tf.clearFooter()
         return True
=20
+class Osc94FilterNotifier(logging.Filter):
+    def __init__(self, tf):
+        self.tf =3D tf
+
+    def filter(self, record):
+        if record.levelno =3D=3D bb.msg.BBLogFormatter.ERROR:
+            self.tf.osc94.error()
+        elif record.levelno =3D=3D bb.msg.BBLogFormatter.WARNING:
+            self.tf.osc94.warning()
+
+        return True
+
+class Osc94(object):
+    REMOVE =3D 0
+    SET =3D 1
+    ERROR =3D 2
+    INDETERMINATE =3D 3
+    WARNING =3D 4
+
+    def __init__(self, fd =3D None):
+        self.fd =3D fd
+        self._warning =3D False
+        self._error =3D False
+
+    def _write(self, what, argument =3D None):
+        if self.fd is not None:
+            argument =3D "" if argument is None else argument
+            self.fd.write(f"\x1b]9;4;{what};{argument}\x07")
+            self.fd.flush()
+
+    def clear(self):
+        self._write(self.REMOVE)
+
+    def indeterminate(self):
+        self._write(self.INDETERMINATE)
+
+    def error(self):
+        self._error =3D True
+
+    def warning(self):
+        self._warning =3D True
+
+    def progress(self, value):
+        value =3D int(min(max(value, 0), 100))
+        if self._error:
+            self._write(self.ERROR, value)
+        elif self._warning:
+            self._write(self.WARNING, value)
+        else:
+            self._write(self.SET, value)
+
+
 class TerminalFilter(object):
     rows =3D 25
     columns =3D 80
@@ -160,6 +212,7 @@ class TerminalFilter(object):
         self.lastpids =3D []
         self.lasttime =3D None
         self.quiet =3D quiet
+        self.osc94 =3D Osc94(sys.stdout)
=20
         if not self.interactive:
             return
@@ -203,8 +256,10 @@ class TerminalFilter(object):
=20
         for h in handlers:
             h.addFilter(InteractConsoleLogFilter(self))
+            h.addFilter(Osc94FilterNotifier(self))
=20
         self.main_progress =3D None
+        self.osc94.indeterminate()
=20
     def clearFooter(self):
         if self.footer_present:
@@ -274,6 +329,7 @@ class TerminalFilter(object):
                 tasks.append(msg)
=20
         if self.main.shutdown:
+            self.osc94.indeterminate()
             content =3D pluralise("Waiting for %s running task to finish=
",
                                 "Waiting for %s running tasks to finish"=
, len(activetasks))
             if not self.quiet:
@@ -303,6 +359,7 @@ class TerminalFilter(object):
             self.main_progress.setmessage(msg)
             progress =3D max(0, self.helper.tasknumber_current - 1)
             content +=3D self.main_progress.update(progress)
+            self.osc94.progress(self.main_progress.percent)
             print('')
         lines =3D self.getlines(content)
         if not self.quiet:
@@ -335,6 +392,7 @@ class TerminalFilter(object):
         return lines
=20
     def finish(self):
+        self.osc94.clear()
         if self.stdinbackup:
             fd =3D sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdi=
nbackup)
--=20
2.53.0


