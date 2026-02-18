Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FDEE9A049
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 13:15:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11682.1771420538932565673
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 05:15:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mBajMpIB;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 44F33C10F46
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C2256074B
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4871910368B90;
	Wed, 18 Feb 2026 14:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771420536; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=76RXd3jeHr8FJ8Sp2GOSjOr1XCug/lBjSYxNjzqUxfs=;
	b=mBajMpIBtbyPKQd27nEVogQWQ2jDt5/ZBIN5iuc1yPUGIxE4Kiq0EIcuRycD68AhEep+Gs
	ierSljalK6EvKxHSvo/RHMSK++4sr7AfoWCA78hZuybsnxrQJCBbrD3/yfO6n38jbnV5z0
	rMU3xnwAgHVVShjKA95w7NwrnaY9um9/FmNNFcEWeSSalINVYKv+W3owxVtg+LJgQVksvc
	1xQ932z8AQjjWrl9DcqY2bwzCtt2CIu2W1AXwWj2llFRhRY3ijF+vqkTc77S6sVBE0a3z2
	ElotxnrZNmcZVyGArnECMYN51orsG8y/ZQSlBCQWIhv8rtAkg0tuarHhRZw2bQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 18 Feb 2026 14:15:29 +0100
Subject: [PATCH v2 4/4] bitbake-setup: drop get_diff and replace by
 run_git_diff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-improve-bbsetup-readability-v2-4-351584e5df9c@bootlin.com>
References: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
In-Reply-To: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=auJhwDgYVWeHQY7B8MndgeBym8zdwl7wT8Vq9TwcR6M=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBplbt11xyeDXQ8UZWe862FUPReTKShMXy7z07K6
 BEV6Lk+R/KJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZW7dQAKCRDRgEFAKaOo
 NgKcD/94It7ApsyNfW0fTlGebLC3xBzRB805emStGhQH94LIg/4EpiDVuKX9gDDH1SQDyqaKSpg
 c70bF4wnpJQTzVFn3L98GIkyXVUkRE8bbk1S5cQauYaN06S9VQwfwFUufofnviJ4b+MUmMFCOZd
 WfLnJB5aeo7d+n7NdbaNO+JMkZTVp6ba9H4Kaqn3uwta0Z2xqEFDcpTTAJA0nk1lip43CJlTdwX
 0CWJUcnQMfhbT8kMiqzB2A2FiCibS1pYtSb6wjZOLESq+J8cvSnnrWYd4OORVnMFKNyLkoB51qF
 t+p1HRXL22OZU43a1CuYjzaBPp40WO7Td5EwNvUi7h1MHnQOe3f/gi1YZYpyb5LgpOGYfz0g90j
 w8YfuvJYjT8Bl+fnDjfU5CgVrVHAQF+ZssymMif6okz5Q4mcvOX6jOHUcG0YIhzjCRIHNLA2J73
 B2dA/8MLGYjGPtwqpKn9tFbyfdYOXsyZ5fSwKqo6nxhIWKVsEF2krBDirXd3GtBXE7SEBQeMcmv
 8tY3POOIkOD1BQ4GRnS4OomQ7uikNdhKbOqpVjqST0qxzbjClufRhTnWPFgXHWOGiOVV4BedVTe
 PfPNOvIdbxiDZFMVAtrKlQKJAnfELs1xCIDXJCmv+5tFB+Y94Bgw+h0F8Y8CT7iphAtI17Koeap
 KOfR6GPou7ujKQg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19062

We have a new run_git_diff() function that can be used both for showing
diffs in git repositories, but also for printing diffs between two
directories or files, making get_diff() redundant. Replace the single
call to get_diff() by run_git_diff().

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e456aa93bf3..56c579d19f7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -430,7 +430,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
     if os.path.exists(backup_bitbake_confdir):
-        conf_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
+        conf_diff = run_git_diff(path1=backup_bitbake_confdir, path2=bitbake_confdir)
         if not conf_diff:
             logger.plain('New bitbake configuration from upstream is the same as the current one, no need to update it.')
             shutil.rmtree(bitbake_confdir)
@@ -759,18 +759,6 @@ def init_config(top_dir, settings, args):
 
     bb.event.remove("bb.build.TaskProgress", None)
 
-def get_diff(file1, file2):
-    try:
-        bb.process.run('diff --color={} -uNr {} {}'.format("always" if BBSETUP_COLOR else "never",
-                                                           file1,
-                                                           file2))
-    except bb.process.ExecutionError as e:
-        if e.exitcode == 1:
-            return e.stdout
-        else:
-            raise e
-    return None
-
 def are_layers_changed(layers, layerdir, d):
     def _is_git_remote_changed(r_remote, repodir):
         changed = False

-- 
2.52.0


