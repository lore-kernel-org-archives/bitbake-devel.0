Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F718C4321E
	for <webhook@archiver.kernel.org>; Fri,  2 Dec 2022 17:40:33 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.82365.1670002828528993080
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Dec 2022 09:40:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=j/Bar0EZ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5D6041BF205;
	Fri,  2 Dec 2022 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1670002826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=StxsxlrpH7jfwLB+T0EroLzAPfW6RJlKlV//wi5KLBU=;
	b=j/Bar0EZz0SkGlNip2gBUFfXNPY9J5vloHT6D1QVqdh7NnWzn6rT89zGtCXPLZqz3WXlnC
	CSwE5Tg+By3qhOejihHjiCTfNsGhU3tboK6vG/goTWD1QgKwnv4U1WDNv8G0jsdV6gQjDr
	IMys0GWnItQl9lC5ZcZrotJFrnvEY96YCfCzemFAOe8ZZANBzDmYkJRQWzLAZZzSJsASHk
	+zrrHIPYoGFA2nwkc/rreXwYwk3HzT8pnx+88s8eq+SIpLTHyUgf+ZA44JtFLEzhGoNWvV
	l/AXX5JsSkksr0j4/97zM7OezW9jHW0b8Ii/6tTYq5oG/1o34leKkx7p3a7Qew==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] bitbake-user-manual: update references to Yocto Project manual
Date: Fri,  2 Dec 2022 18:38:36 +0100
Message-Id: <20221202173836.352854-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 02 Dec 2022 17:40:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14132

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---

Please note that this update will work only when the next release is made, linking to
https://docs.yoctoproject.org/dev-manual/python-development-shell.html#using-a-python-development-shell

Currently, the above link doesn't exist yet; it currently exists only in the "dev" docs:
https://docs.yoctoproject.org/dev/dev-manual/python-development-shell.html#using-a-python-development-shell

It would be nice for the "dev" version of the BitBake manual
to point to the "dev" version of the Yocto manual, but
that's limited to specific needs like this one, so I'm not sure
that's worth implementing a change.
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 9c269ca8..f715dee5 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -740,7 +740,7 @@ Here is an example URL with both fetchers::
        "
 
 See :yocto_docs:`Creating Node Package Manager (NPM) Packages
-</dev-manual/common-tasks.html#creating-node-package-manager-npm-packages>`
+</dev-manual/packages.html#creating-node-package-manager-npm-packages>`
 in the Yocto Project manual for details about using
 :yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-reference.html>`
 to automatically create a recipe from an NPM URL.
@@ -777,7 +777,7 @@ the package which has such dependencies, for example::
 Such a file can automatically be generated using
 :yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-reference.html>`
 as described in the :yocto_docs:`Creating Node Package Manager (NPM) Packages
-</dev-manual/common-tasks.html#creating-node-package-manager-npm-packages>`
+</dev-manual/packages.html#creating-node-package-manager-npm-packages>`
 section of the Yocto Project.
 
 Other Fetchers
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index b7c3d809..b839e669 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1935,7 +1935,7 @@ Testing and Debugging BitBake Python code
 The OpenEmbedded build system implements a convenient ``pydevshell`` target which
 you can use to access the BitBake datastore and experiment with your own Python
 code. See :yocto_docs:`Using a Python Development Shell
-</dev-manual/common-tasks.html#using-a-python-development-shell>` in the Yocto
+</dev-manual/python-development-shell.html#using-a-python-development-shell>` in the Yocto
 Project manual for details.
 
 Task Checksums and Setscene
-- 
2.34.1


