Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895E2C02182
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 23:25:37 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.211])
 by mx.groups.io with SMTP id smtpd.web11.8147.1737588331076405001
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 15:25:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=GTkEGhTM;
 spf=pass (domain: freemail.hu, ip: 46.107.16.211, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YdgD86XLDzMf4;
	Thu, 23 Jan 2025 00:25:28 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2 1/4] bitbake: progressbar: Check resizable file descriptor.
Date: Thu, 23 Jan 2025 00:24:08 +0100
Message-ID: <20250122232411.133-2-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250122232411.133-1-egyszeregy@freemail.hu>
References: <20250122232411.133-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737588329;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 23:25:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17059

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=2110; bh=FpTb7TZgCeBDZ6gBQVX9Oz9GJT0bDbIFEUtYaCztHxs=;

	b=GTkEGhTMvm6LL73h+Mrq96Z97vvy2b0TNGGFSdzDK05E7pJ9Lhh6tg4jvh8T8ipO

	hGSnvhx2M2Ko10CnODHOn+VTAli/DTWk8egU3cnUXyUsXEOkRALLLHqvWY3f5snAKaH

	Dii0cxhBcGM+fkDKAHc8YxnF34AX3t6SiUYui4YVLU9KpU/bzl9yv9uYqvKI9oQYEmM

	Ri6hzbgAy72E0nCEEdns/M1MMCJFPX7/n82z64w9ILCdqXgwZCaRknpBh8uATziT+Dk

	idhhtzVulaLNI8kdML7GhFq2aFG6CSfdvVuCY2tjSdLNR8PSXYPCuWZQ2uojixtSINp

	vCngpnaa8Q==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

- Check if given file descriptor is resizable.
- Introduce self._fd_console as a dedicated attribute of self._handle_res=
ize().

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/progressbar/progressbar.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar=
.py
index d4da10ab7..203ff804f 100644
--- a/lib/progressbar/progressbar.py
+++ b/lib/progressbar/progressbar.py
@@ -110,19 +110,26 @@ class ProgressBar(object):
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
+        elif (fd_num =3D=3D sys.stdout.fileno()) or (fd_num =3D=3D sys.s=
tderr.fileno()):
+            # Check if given file descriptor is resizable for example be=
long
+            # to a terminal/console as STDOUT or STDERR. If file descrip=
tor
+            # is resizable, let's allow to use for self._handle_resize()
+            # in a dedicated self._fd_console in order to be able to set
+            # temporarily/permanently self.fd to any StringIO or other
+            # file descriptor later.
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
@@ -182,7 +189,7 @@ class ProgressBar(object):
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


