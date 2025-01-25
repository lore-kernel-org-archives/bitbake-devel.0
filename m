Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD64C0218F
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 12:29:35 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.242])
 by mx.groups.io with SMTP id smtpd.web10.8929.1737808173573283869
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 04:29:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=OPO6nQCA;
 spf=pass (domain: freemail.hu, ip: 46.107.16.242, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YgDWv55kFz14t;
	Sat, 25 Jan 2025 13:29:31 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v3 4/4] bitbake: knotty: print() was eliminated from all loops for better performance.
Date: Sat, 25 Jan 2025 13:27:52 +0100
Message-ID: <20250125122752.649-5-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250125122752.649-1-egyszeregy@freemail.hu>
References: <20250125122752.649-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737808171;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 12:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17087

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1871; bh=EeDpWoJlUfOYj/cha3GH0X2emMJbKr/wz+vZNdj7owE=;

	b=OPO6nQCAyPkZUyRK1m6d71y54qVAwi2ooND0ti/xpzckENh6iattrWvntnPmYfAz

	J/9lZevOWbGB+QXm0+SeoUpEPS/yKvbU8Bhd/cxzlfTw3MLZrjGGB/oPtMY0A6goevt

	08wfvI/vTnmD/p71OZpd+NXEh0RoF+UsDgn6cS0T0jm59vfSU4mwvdUuyUM4a5lY4tl

	7QpjUUomiAfSf0nRQobgBJg3nWKyE4x/NfUnRV3LseVzrclwWLs7NCUhK0HNT0mEpam

	EJaenUJCZSHJF+CLsTjIIgdoHmmjdJO5u0Vm6rmcgf4NloSGHFdArwenuOKPxf4qfDg

	hIJUM/xJOQ==
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
index bef45cad6..492ea2076 100644
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
@@ -379,13 +380,12 @@ class TerminalFilter(object):
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
@@ -398,11 +398,11 @@ def print_event_log(event, includelogs, loglines, t=
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


