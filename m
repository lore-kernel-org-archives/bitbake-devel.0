Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649F1CEACEF
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:16:11 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5031.1763367367950185254
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=bKFcpiD4;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 914B3C12652
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:15:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A2467606B9
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 022AC10371CF5;
	Mon, 17 Nov 2025 09:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367366; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MnSEZW0wRWQ8QN8GaC2bT6iZ4uVXzqAuG97Um+qQH1M=;
	b=bKFcpiD40tUkNiR8IcRdPKbWb/rmmBhvzyfRBMh0KU8lPyvP8EWpUrx8DNZYctTZ5Jxpb6
	ZBjNAqs05tBkKnfENajFdobVS5tOiJxD78RYSdgp1YUI00nGGoMQwPO6ZJ4Ld0DjWIcLOY
	MHHFIjVffN+z4zOOMrn2uSfzSWYG21Jc1kkUu3KEv9x8tPqNQgZM3YlEkNY+b3EQwzEG2A
	YpsReCR928hipcy8oZ10raMr7gh/JSUCAIuRyMhRYPf9gEKHkbZPjFYnzTt5EZexe2Tdeb
	TQCyeuAZrceWpuKXmtb0LfYUfvrC1x7sdbQkDdC4/3o8JyCb4pMZnIWb3MZPrg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 09:15:39 +0100
Subject: [PATCH v2 3/3] bitbake-setup: handle ctrl+c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-abort-v2-3-a73f44e83bc0@bootlin.com>
References: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-abort-v2-0-a73f44e83bc0@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=9UlVZbTkq7Amgm2c4h+zTJxdpl7zse+/A1ySEWamKB4=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtnDQtDpaLY2QXHlx6kZVB8fagsBqd1ORj1Gm
 7sCK/8nk+iJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRrZwwAKCRDRgEFAKaOo
 Nt/7D/4tlqOYgcmXBqhMft9RhL5CiWbyrSj2nNg2kjsLO6YytHoD6WmTkE54gtlj1RebhQ5yji9
 2+nX6W4JO9FrD1WL2gTiK6g5WM6EY7AWQQvyCMgZo2VGLUNShMTlXAJiXcZYXhfOGJHtlC3h6OO
 VqAnsJpD3qzh63ggHo5qE91oHAujDpACziVeURBvbTQJHImN+hiJevBaGgjAV3jk96+LGL8ThTG
 iPmZsmcchNKyfWGQxNuWCKEJ+cdmmMfVSvhgEAM8r94Gu+fqqr9nL6tBahdh+Zp4c2xaFpCVUjD
 4co5TlGy4NSMI7rbMBTFo4x01IF4YVxubcCIvtzZAey3EHBPo4oup3wzapfIcRgfv64KtPrYZBt
 bTQfeoiez/CSzNMTD7B0Qbv1KHqFJw3jRZ2zA6gi/gDAhvGnEYjQTSmkbEfiQ6hLVOU9DRGqCgS
 7qG1DhRFtA7Uf9WgHzDE0eO5HUO6d/kdG7ue13mNwGRPVCWKUdPvd3p0juWYkoXUrrNwC0SlJgS
 gOlkZcUEvNgbQH7jVY6n7xhqxrm53PQw9A6cyNCk7cyvT0LSzaa8cTY7kkW2/gx6TNNvWT+ML7N
 cw/8lFE+NqyZwnjMWKMvOgqWkCmzDW6mbCzzebsyNBYTzZA7T3GY+iuGBeQ++G1Y9Rori5Ce6f/
 t9lnz0PCENt0zyQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:16:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18417

Instead of printing the stack trace, print "Shutting down..." when the
user presses Ctrl+C during command executions. Mention that the
top-directory's setups might be incomplete if the topdir was already
created at this point.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index db6428f8d2..d0a932a6b2 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -17,6 +17,8 @@ import glob
 import subprocess
 import copy
 import textwrap
+import signal
+import functools
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -783,6 +785,15 @@ def merge_settings(builtin_settings, global_settings, topdir_settings, cmdline_s
 
     return all_settings
 
+def sigint_handler(sig, frame, func, top_dir):
+    print(f'\nShutting down...')
+    if isinstance(top_dir, str) and os.path.exists(top_dir):
+        if func in [init_config, build_update]:
+            print(f'{top_dir} may contain an incomplete setup!')
+        elif func == install_buildtools:
+            print(f'{top_dir} may contain an incomplete buildtools installation!')
+    exit()
+
 def main():
     def add_setup_dir_arg(parser):
         setup_dir = get_setup_dir_via_bbpath()
@@ -888,6 +899,12 @@ def main():
         global_settings = load_settings(global_settings_path(args))
         top_dir = get_top_dir(args, merge_settings(builtin_settings, global_settings, {}, args.cmdline_settings))
 
+        # register handler now to pass top_dir
+        _handler = functools.partial(sigint_handler,
+                                     func=args.func,
+                                     top_dir=os.path.abspath(top_dir))
+        signal.signal(signal.SIGINT, _handler)
+
         # This cannot be set with the rest of the builtin settings as top_dir needs to be determined first
         builtin_settings['default']['dl-dir'] = os.path.join(top_dir, '.bitbake-setup-downloads')
 

-- 
2.51.0


