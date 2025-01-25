Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D65C0218D
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 12:29:35 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.242])
 by mx.groups.io with SMTP id smtpd.web10.8928.1737808169590906672
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 04:29:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=lYHV/Kc8;
 spf=pass (domain: freemail.hu, ip: 46.107.16.242, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YgDWq4zRtz1QP;
	Sat, 25 Jan 2025 13:29:27 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v3 2/4] bitbake: knotty: Use a StringIO buffer for update footer.
Date: Sat, 25 Jan 2025 13:27:50 +0100
Message-ID: <20250125122752.649-3-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250125122752.649-1-egyszeregy@freemail.hu>
References: <20250125122752.649-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737808168;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 12:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17085

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=4500; bh=7Hdy5SuwLqPXCfbDpMxD+jOsdh1E8uImXi9ca3InbzY=;

	b=lYHV/Kc830QMrJv5Vg8tbxDSdXjk3l4LbqKsAdUYZJdHLPIuacHtgB/tvD+oHrdu

	LoxOvHu9cch6PW7RJrx3fY8sHEMM9KX6cM7iABISAke2of8zSB4m1LviG4oiW2lwRqQ

	ZHsjtOT9ldQCA3ehBYZRNEPkUxJ5N1+VnztccG1KG2EgNgIfDHt/+o7UamOJqfPeWYV

	nAPQhGluYeKhQjHuEiS/2iEp6Gj+tdqGSA76+vG4h5jMQQd/YDTje0Sd7cSvHpR1zux

	IF9GSkp34evvQqgIsYyaKlDqL1dC6p0R9Ikz05NAytqr5H6opDkG6fXEaPWb5aDdpdx

	nkbJY/E2Jg==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Optimize printing in footer update with use a StringIO buffer and it
prints content to terminal in a single call in every cycle.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/ui/knotty.py | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 2fff1b366..416ea166f 100644
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
@@ -168,6 +169,9 @@ class TerminalFilter(object):
         self.lasttime =3D None
         self.quiet =3D quiet
=20
+        self._footer_buf =3D io.StringIO()
+        self._footer_lines =3D None
+
         if not self.interactive:
             return
=20
@@ -215,11 +219,11 @@ class TerminalFilter(object):
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
@@ -253,10 +257,14 @@ class TerminalFilter(object):
         if self.footer_present and not self.helper.needUpdate:
             return
         self.helper.needUpdate =3D False
-        if self.footer_present:
-            self.clearFooter()
         if (not self.helper.tasknumber_total or self.helper.tasknumber_c=
urrent =3D=3D self.helper.tasknumber_total) and not len(activetasks):
+            self.clearFooter()
             return
+
+        # Clear footer buffer.
+        self._footer_buf.truncate(0)
+        self._footer_buf.seek(0)
+
         tasks =3D []
         for t in runningpids:
             start_time =3D activetasks[t].get("starttime", None)
@@ -275,6 +283,7 @@ class TerminalFilter(object):
                     else:
                         pbar =3D BBProgress("0: %s" % msg, 100, widgets=3D=
[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=3D5=
, resize_handler=3Dself.sigwinch_handle)
                         pbar.bouncing =3D False
+                    pbar.fd =3D self._footer_buf
                     activetasks[t]["progressbar"] =3D pbar
                 tasks.append((pbar, msg, progress, rate, start_time))
             else:
@@ -285,7 +294,7 @@ class TerminalFilter(object):
                                 "Waiting for %s running tasks to finish"=
, len(activetasks))
             if not self.quiet:
                 content +=3D ':'
-            print(content)
+            print(content, file=3Dself._footer_buf)
         else:
             scene_tasks =3D "%s of %s" % (self.helper.setscene_current, =
self.helper.setscene_total)
             cur_tasks =3D "%s of %s" % (self.helper.tasknumber_current, =
self.helper.tasknumber_total)
@@ -294,7 +303,7 @@ class TerminalFilter(object):
             if not self.quiet:
                 msg =3D "Setscene tasks: %s" % scene_tasks
                 content +=3D msg + "\n"
-                print(msg)
+                print(msg, file=3Dself._footer_buf)
=20
             if self.quiet:
                 msg =3D "Running tasks (%s, %s)" % (scene_tasks, cur_tas=
ks)
@@ -306,11 +315,12 @@ class TerminalFilter(object):
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
+            print('', file=3Dself._footer_buf)
         lines =3D self.getlines(content)
         if not self.quiet:
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines=
)]):
@@ -326,15 +336,20 @@ class TerminalFilter(object):
                         content =3D pbar.update(progress)
                     else:
                         content =3D pbar.update(1)
-                    print('')
+                    print('', file=3Dself._footer_buf)
                 else:
                     content =3D "%s: %s" % (tasknum, task)
-                    print(content)
+                    print(content, file=3Dself._footer_buf)
                 lines =3D lines + self.getlines(content)
-        self.footer_present =3D lines
         self.lastpids =3D runningpids[:]
         self.lastcount =3D self.helper.tasknumber_current
=20
+        # Clear footer and Print buffer.
+        self.clearFooter()
+        print(self._footer_buf.getvalue(), end=3D'')
+        self._footer_lines =3D lines
+        self.footer_present =3D True
+
     def getlines(self, content):
         lines =3D 0
         for line in content.split("\n"):
@@ -342,6 +357,7 @@ class TerminalFilter(object):
         return lines
=20
     def finish(self):
+        self._footer_buf.close()
         if self.stdinbackup:
             fd =3D sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdi=
nbackup)
--=20
2.47.1.windows.2


