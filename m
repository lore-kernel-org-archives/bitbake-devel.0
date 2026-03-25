Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5639FEA82E
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:12 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17085.1774422847652635894
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=EWbKDBtW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-2026032507140509b76e9a230002077d-txhmhy@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026032507140509b76e9a230002077d
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tHatzJkj8v41S00Pvw0rYn2RiqmtE0gHkGSd5U3RR+E=;
 b=EWbKDBtWruBT++t7xA0P8v4LvSqCl+SQblh47YSWDetz1qbWYqsvLieYUr3SUo9c/VN60T
 frab2UcNfup37y4zPCVSmzKdt5/RlBxQpWgAKS7ZV39V4Ij3RM6EwBGzXTrRInyIrlnRgveu
 qozYh54ye8ihywfMpNC/Qxw90Rj5on8+6cDx/8E8Fj6ybuOCXYd6ZWyFKC+6OVG/hgU8GfGy
 z1RjrrO7PYfXHLQ8b3CeO8xV3xFSe6z+iS4URXmAqPTm512r2JoCFhkW7Ja7lBDB6IcpuhDu
 IKDqoa1K/6t8cyhCgYTymZ11JYYWB67099FsOSPNqVJwG9J6u5Yi4afA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 06/10] tests/setup: fix dead check_setupdir_files guards
Date: Wed, 25 Mar 2026 07:51:48 +0100
Message-ID: <20260325071342.47272-7-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19229

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Two conditions in check_setupdir_files used wrong key names and
so never triggered:

- 'oe-fragment' -> 'oe-fragments' (plural): fragment-existence
  assertions were never reached for any variant that has fragments.

- 'bb-environment-passthrough' -> 'bb-env-passthrough-additions':
  BB_ENV_PASSTHROUGH_ADDITIONS assertions were never reached for
  the gizmo-env-passthrough variant.

Also drop the redundant .keys() call on both guards.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index d52a81395..1af3d8b50 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -260,11 +260,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                         )
                     self.assertIn(filerelative_layer, bblayers)
 
-        if 'oe-fragment' in bitbake_config.keys():
+        if 'oe-fragments' in bitbake_config:
             for f in bitbake_config["oe-fragments"]:
                 self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
 
-        if 'bb-environment-passthrough' in bitbake_config.keys():
+        if 'bb-env-passthrough-additions' in bitbake_config:
             with open(os.path.join(bb_build_path, 'init-build-env'), 'r') as f:
                 init_build_env = f.read()
             self.assertTrue('BB_ENV_PASSTHROUGH_ADDITIONS' in init_build_env)
-- 
2.53.0


