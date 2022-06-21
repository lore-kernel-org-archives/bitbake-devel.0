Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFEFC43334
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 15:54:35 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web08.45310.1655826873109115577
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 08:54:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Eaz5deI7;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id C5C65C0006;
	Tue, 21 Jun 2022 15:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1655826869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+euk6bpP7wmrMycNTwhMGtk+m4YR7CTYLuueQcFoGmI=;
	b=Eaz5deI7G5S2yDWF1AH+DQutJrOzBF1lnL3TanqpQeUT1rhhbyO5y50q8ui651hPfsacgj
	LVFJGDfx2zc32dNpZ8sAY3UHF/sGoVxuYWO3S4cZpjRxqaqJFVd6qdPDyOHqVWQkBhi7w3
	uYgoJ7jQxXuqIbBoqOVFZBiQq6x+fAbClMvbvZAcuiE8O8get18UwKikfbGkdQQG7FyX8+
	yUzKct1h4wuVd5z3jQJpkhuUGfPe5MMCx6mqGIOP4VBHtyWcqawF37SxTtg5j+KLNb6cNQ
	3zEIOcOMyEYRNzV/zfclEG1i0WUvq5L3SqT7nKMjcmqzHW1m/1L5WHK3GAbL9A==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	jean-marie.lemetayer@savoirfairelinux.com,
	stefan.herbrechtsmeier@weidmueller.com,
	cal@brightsign.biz,
	peter.kjellerstedt@axis.com,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: document npm and npmsw fetchers
Date: Tue, 21 Jun 2022 17:54:17 +0200
Message-Id: <20220621155417.2644498-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 15:54:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13775

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This addresses bug [YOCTO #10098]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 .../bitbake-user-manual-fetching.rst          | 78 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f9d9e617..057d494a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -704,6 +704,82 @@ Here is an example URL::
 
    SRC_URI = "crate://crates.io/glob/0.2.11"
 
+.. _nmp-fetcher:
+
+NPM Fetcher (``npm://``)
+------------------------
+
+This submodule fetches source code from an
+`NPM <https://en.wikipedia.org/wiki/Npm_(software)>`__
+Javascript package registry.
+
+The format for the :term:`SRC_URI` setting must be::
+
+   SRC_URI = "npm://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+
+This fetcher supports the following parameters:
+
+-  *"package":* The NPM package name. This is a mandatory parameter.
+
+-  *"version":* The NPM package version. This is a mandatory parameter.
+
+-  *"downloadfilename":* Specifies the filename used when storing the downloaded file.
+
+-  *"destsuffix":* Specifies the directory to use to unpack the package (default: ``npm``).
+
+Note that NPM fetcher only fetches the package source itself. The dependencies
+can be fetched through the :ref:`NPM shrinkwrap
+fetcher <bitbake-user-manual/bitbake-user-manual-fetching:npm shrinkwrap fetcher
+(\`\`npmsw://\`\`)>`
+
+Here is an example URL with both fetchers::
+
+   SRC_URI = " \
+       npm://registry.npmjs.org/;package=cute-files;version=${PV} \
+       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
+       "
+
+See :yocto_docs:`Creating Node Package Manager (NPM) Packages
+</dev-manual/common-tasks.html#creating-node-package-manager-npm-packages>`
+in the Yocto Project manual for details about using
+:yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-reference.html>`
+to automatically create a recipe from an NPM URL.
+
+.. _nmpsw-fetcher:
+
+NPM shrinkwrap Fetcher (``npmsw://``)
+-------------------------------------
+
+This modules fetches source code from an
+`NPM shrinkwrap <https://docs.npmjs.com/cli/v8/commands/npm-shrinkwrap>`__
+description file, which lists the dependencies
+of an NPM package while locking their versions.
+
+The format for the :term:`SRC_URI` setting must be::
+
+   SRC_URI = "npmsw://some.registry.url;OptionA=xxx;OptionB=xxx;..."
+
+This fetcher supports the following parameters:
+
+-  *"dev":* Set this parameter to ``1`` to install "devDependencies".
+
+-  *"destsuffix":* Specifies the directory to use to unpack the dependencies
+   (``${S}`` by default).
+
+Note that the shrinkwrap file can also be provided by the recipe for
+the package which has such dependencies, for example::
+
+   SRC_URI = " \
+       npm://registry.npmjs.org/;package=cute-files;version=${PV} \
+       npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
+       "
+
+Such a file can be automatically be generated using
+:yocto_docs:`devtool <https://docs.yoctoproject.org/ref-manual/devtool-reference.html>`
+as described in the :yocto_docs:`Creating Node Package Manager (NPM) Packages
+</dev-manual/common-tasks.html#creating-node-package-manager-npm-packages>`
+section of the Yocto Project.
+
 Other Fetchers
 --------------
 
@@ -713,8 +789,6 @@ Fetch submodules also exist for the following:
 
 -  Mercurial (``hg://``)
 
--  npm (``npm://``)
-
 -  OSC (``osc://``)
 
 -  Secure FTP (``sftp://``)
-- 
2.34.1


