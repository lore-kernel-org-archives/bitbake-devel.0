Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D841DCCA480
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 17:55:05 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web12.46623.1655834099945669460
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 10:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=B9JkI7TE;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id CC82EE0004;
	Tue, 21 Jun 2022 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1655834098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BtXh3TEuGGsLRRFTd5udSn44TlvHOLc9pVO4rrcRDg=;
	b=B9JkI7TE4emUs3aX8EA1Z2NJEv1mqoThiZ7jYyhW6EsTdixtWuWwpdGmdtiU4v4QlSw7ZN
	NElwwcPqdNJauvn4L9VJVeCTq9PDlf4Hz3tviVu28Uk3KeGP0fcaNHQ6zZN4dzp/w3BCsJ
	kYE+JdiDhdXc4etudZ1OsXFjw6cjiIIj1tIDT6F7QtJQjwQOzqX50Xyq03TPaZPms1F/OG
	qa5CMFWxTN9VEY1SVFVlL6XUk1uY4rpLM86f4KXVXTTYgLmubjAXuWSagOUang8GpRcMYW
	rwE4dWGI5hKjlIMNcNLZbDRYEo4t3G2UFwv8Ku2nOytpUoDlSXkKmKwvW/nkRg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2] doc: bitbake-user-manual: document npm and npmsw fetchers
Date: Tue, 21 Jun 2022 19:54:55 +0200
Message-Id: <20220621175455.2655775-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <16FAADC4DA16D2D7.32537@lists.openembedded.org>
References: <16FAADC4DA16D2D7.32537@lists.openembedded.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 17:55:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13777

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This addresses bug [YOCTO #10098]

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---

* Changes in V2:

  - Fix typos in the names of explicit targets ("nmp" instead of "npm")
  - Simplify the reference to the "nmpsw" section:
    no need to use a complex reference when you can directly use
    a target ("`target`_" as defined in ".. _target:")
---
 .../bitbake-user-manual-fetching.rst          | 76 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index f9d9e617..bb521f63 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -704,6 +704,80 @@ Here is an example URL::
 
    SRC_URI = "crate://crates.io/glob/0.2.11"
 
+.. _npm-fetcher:
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
+can be fetched through the `npmsw-fetcher`_.
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
+.. _npmsw-fetcher:
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
 
@@ -713,8 +787,6 @@ Fetch submodules also exist for the following:
 
 -  Mercurial (``hg://``)
 
--  npm (``npm://``)
-
 -  OSC (``osc://``)
 
 -  Secure FTP (``sftp://``)
-- 
2.34.1


