Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB991C0218E
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 12:29:35 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.242])
 by mx.groups.io with SMTP id smtpd.web11.8668.1737808171574059887
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 04:29:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=U9ntFV/s;
 spf=pass (domain: freemail.hu, ip: 46.107.16.242, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YgDWs4mhjzHm;
	Sat, 25 Jan 2025 13:29:29 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v3 3/4] bitbake: knotty: Use 40 Hz refresh rate (FPS) for footer update.
Date: Sat, 25 Jan 2025 13:27:51 +0100
Message-ID: <20250125122752.649-4-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
In-Reply-To: <20250125122752.649-1-egyszeregy@freemail.hu>
References: <20250125122752.649-1-egyszeregy@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737808169;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 12:29:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17086

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=1985; bh=UgjLq2rOYnxJyFRcHguc0UUKUy6d0z7WKZnhmYaqtLE=;

	b=U9ntFV/sVOK8VnmARtCtpAXstiDNu3C3qjSZt5I4gWR4X1S4MD5VvXJNKIYO1uLt

	zEQ8rZ72Fj2AIqlWYW4U6YuGU2Wac/nKOFnYdx5NkzX1wJFLtETOBJiWwf3wz3tVKUD

	nRy/nznbimWPPVuAVzOdk2I3w1qMgjfPlcfXknpyYNxRgOs8HcWKZjQY5YO2lD5W57h

	R1ZWAt8fMEQ50lf5I23LE/2XT0crWjhpoMDzSO8HuU77SnyNAsbQysfNdmlA5OwVTGP

	xhuvCJF3Iogt8S/O9fmG8LOxmQY/M3p/2mbkgKDVUUvYhI9heVZWM5HJqPG8C5Uii11

	ed4i0QD/pg==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

Refresh footer in 40 Hz to avoid heavy print() flooding but keep it fluen=
t for human eyes.

Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
---
 lib/bb/ui/knotty.py | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 416ea166f..bef45cad6 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -128,6 +128,10 @@ class InteractConsoleLogFilter(logging.Filter):
         return True
=20
 class TerminalFilter(object):
+
+    # 40 Hz (FPS) -> 0.025 secs
+    _DEFAULT_PRINT_INTERVAL =3D 0.025
+
     rows =3D 25
     columns =3D 80
=20
@@ -166,7 +170,7 @@ class TerminalFilter(object):
         self.interactive =3D sys.stdout.isatty()
         self.footer_present =3D False
         self.lastpids =3D []
-        self.lasttime =3D None
+        self.lasttime =3D time.time()
         self.quiet =3D quiet
=20
         self._footer_buf =3D io.StringIO()
@@ -251,11 +255,23 @@ class TerminalFilter(object):
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
         if (not self.helper.tasknumber_total or self.helper.tasknumber_c=
urrent =3D=3D self.helper.tasknumber_total) and not len(activetasks):
             self.clearFooter()
--=20
2.47.1.windows.2


