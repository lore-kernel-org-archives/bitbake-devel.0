Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85919C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 23:25:47 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.211])
 by mx.groups.io with SMTP id smtpd.web11.8150.1737588340189713294
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 15:25:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=AyzBtTiN;
 spf=pass (domain: freemail.hu, ip: 46.107.16.211, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YdgDL3DvXzLDp;
	Thu, 23 Jan 2025 00:25:38 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2 4/4] bitbake: knotty: print() was eliminated from all loops for better performance.
Date: Thu, 23 Jan 2025 00:24:11 +0100
Message-ID: <20250122232411.133-5-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250122232411.133-1-egyszeregy@freemail.hu>
References: <20250122232411.133-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737588338;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 23:25:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17062

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1871; bh=tOCywO57AdcGssqoQY6VKW8CxCgsY7zpgBWvRbgEBvE=;

	b=AyzBtTiNk9uHQgoYs5u98aWhaXDE/gQykKrohGzF9Pj8oTblLdmIOrdOFsKiN7zV

	cj99R4gYoJNWhukqEJ0e9kPBomBlqyw9ZTxZTfaIZqRl3/6FpnXyKFLnDyXpX/hORQi

	ooBvyovFtrRGXdZdJfMRO3A7Mxdqhexeyci6eoeGAclwaKka3vkW3n5Ujaj449EkRAl

	ET463PuQydDVxmnEiATRCrKQKEaefweFvmDyDnJQsBIIV2HVuDqcG3jpUKReoTzcZCr

	0UAENsHZM7YL/D9tccMFKIROgiZgNsNq9ehcWf/UHKxS6f9hObDz+VmZ0dmduaPOwoA

	4ZS0lWvqkA==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Refactoring prints, print() functions were eliminated from all loops and =
it uses
"\n".join(...) in a single print() call for better performance.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/ui/knotty.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index ad018a182..dfc76483c 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -243,9 +243,10 @@ class TerminalFilter(object):
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
@@ -378,13 +379,12 @@ class TerminalFilter(object):
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
+            msgbuf =3D ["Log data follows:"]
             f =3D open(logfile, "r")
             lines =3D []
             while True:
@@ -397,11 +397,11 @@ def print_event_log(event, includelogs, loglines, t=
ermfilter):
                     if len(lines) > int(loglines):
                         lines.pop(0)
                 else:
-                    print('| %s' % l)
+                    msgbuf.append('| %s' % l)
             f.close()
             if lines:
-                for line in lines:
-                    print(line)
+                msgbuf.extend(lines)
+            print("\n".join(msgbuf))
=20
 def _log_settings_from_server(server, observe_only):
     # Get values of variables which control our output
--=20
2.47.1.windows.2


