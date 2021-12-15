Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1733FC4332F
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 01:43:32 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web08.444.1639585357839561318
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 08:22:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay10.mail.gandi.net (Postfix) with ESMTPSA id CB71F240010;
	Wed, 15 Dec 2021 16:22:35 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: conf.py: add more extlinks
Date: Wed, 15 Dec 2021 17:22:27 +0100
Message-Id: <20211215162227.2001656-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Dec 2021 01:43:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13172

Useful in particular to refer to files in git repositories

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/conf.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/conf.py b/doc/conf.py
index fc2ee081..b2369e82 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -36,7 +36,13 @@ author = 'Richard Purdie, Chris Larson, and Phil Blundell'
 # external links and substitutions
 extlinks = {
     'yocto_docs': ('https://docs.yoctoproject.org%s', None),
+    'yocto_git': ('https://git.yoctoproject.org/cgit/cgit.cgi%s', None),
+    'oe_home': ('https://www.openembedded.org%s', None),
     'oe_lists': ('https://lists.openembedded.org%s', None),
+    'oe_git': ('https://git.openembedded.org%s', None),
+    'oe_wiki': ('https://www.openembedded.org/wiki%s', None),
+    'oe_layerindex': ('https://layers.openembedded.org%s', None),
+    'oe_layer': ('https://layers.openembedded.org/layerindex/branch/master/layer%s', None),
 }
 
 # -- General configuration ---------------------------------------------------
-- 
2.25.1


