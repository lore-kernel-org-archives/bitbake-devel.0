Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9EDC0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 12:29:35 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.242])
 by mx.groups.io with SMTP id smtpd.web10.8926.1737808166434792688
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 04:29:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=KRKFY94l;
 spf=pass (domain: freemail.hu, ip: 46.107.16.242, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YgDWm264Kz8q;
	Sat, 25 Jan 2025 13:29:24 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v3 1/4] bitbake: progressbar: Add self._fd_console to use for self._handle_resize()
Date: Sat, 25 Jan 2025 13:27:49 +0100
Message-ID: <20250125122752.649-2-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250125122752.649-1-egyszeregy@freemail.hu>
References: <20250125122752.649-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737808164;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 12:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17084

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1756; bh=OMbJ1pXWmsldkpXzCJhrbnm3JgAdcrjxZC3B6XkI6RA=;

	b=KRKFY94lFtcTjT2XO1BedIo1zEF+uEgBwjYKuNfoW5MvqazsEtw5ot1mAtH+jzud

	I9x3Qsgk9Eiggot56XetRnkqXfnphfPrroW1nAPGOTikeSLSWQ4tNJkBXji2FY17rEP

	QiPrPUWIOaR01DmF0KBAB8RJjob4H27E/NcxJWvBZfElQBc5etSWIgpSyG2MN5/HHQj

	SyU8GDX22/NxvjqEB3DZY5HkRepfWaQZ/NlvwpSVaE/GQIwmBi3tszk2PUJ42fF7HSq

	GbZq77j/gnj1bhPfVMoKbil22OybGgPPkeZtKZPdL3xLmSSMgzlWLWf6I0ZTJFR+8A+

	vGPKoRzSwA==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Introduce self._fd_console as a dedicated attribute of self._handle_resiz=
e().

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/progressbar/progressbar.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar=
.py
index d4da10ab7..eccc45849 100644
--- a/lib/progressbar/progressbar.py
+++ b/lib/progressbar/progressbar.py
@@ -110,18 +110,25 @@ class ProgressBar(object):
         self.widgets =3D widgets
         self.fd =3D fd
         self.left_justify =3D left_justify
+        self._fd_console =3D None
=20
         self.signal_set =3D False
         if term_width is not None:
             self.term_width =3D term_width
         else:
             try:
+                # Check if given file descriptor is resizable for exampl=
e belong
+                # to a terminal/console as STDOUT or STDERR. If file des=
criptor
+                # is resizable, let's allow to use for self._handle_resi=
ze()
+                # in a dedicated self._fd_console in order to be able to=
 set
+                # temporarily/permanently self.fd to any StringIO or oth=
er
+                # file descriptor later.
+                self._fd_console =3D fd
                 self._handle_resize(None, None)
                 signal.signal(signal.SIGWINCH, self._handle_resize)
                 self.signal_set =3D True
             except (SystemExit, KeyboardInterrupt): raise
             except Exception as e:
-                print("DEBUG 5 %s" % e)
                 self.term_width =3D self._env_size()
=20
         self.__iterable =3D None
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


