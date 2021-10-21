Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F10C43219
	for <webhook@archiver.kernel.org>; Thu, 21 Oct 2021 16:22:33 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web09.72.1634833352433592307
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Oct 2021 09:22:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 15693FF802;
	Thu, 21 Oct 2021 16:22:29 +0000 (UTC)
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: paul@pbarker.dev,
	bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Quentin Schulz <foss@0leil.net>
Subject: [PATCH v2 1/1] doc: bitbake-user-manual: Document BB_GIT_SHALLOW and
 friends
Date: Thu, 21 Oct 2021 18:22:26 +0200
Message-Id: <20211021162226.2141234-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021162226.2141234-1-michael.opdenacker@bootlin.com>
References: <20211021162226.2141234-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Oct 2021 16:22:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12812

From: Paul Barker <paul@pbarker.dev>

Documentation is based on the commit message of bitbake rev 5ed7d85fda
and mailing list discussion.

[YOCTO #14493]

Signed-off-by: Paul Barker <paul@pbarker.dev>
Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Reviewed-by: Quentin Schulz <foss@0leil.net>
---
 .../bitbake-user-manual-ref-variables.rst     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index cbd1e795..e955beb1 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -281,6 +281,62 @@ overview of their function and contents.
 
          BB_GENERATE_MIRROR_TARBALLS = "1"
 
+   :term:`BB_GENERATE_SHALLOW_TARBALLS`
+      Setting this variable to "1" when :term:`BB_GIT_SHALLOW` is also set to
+      "1" causes bitbake to generate shallow mirror tarballs when fetching git
+      repositories. The number of commits included in the shallow mirror
+      tarballs is controlled by :term:`BB_GIT_SHALLOW_DEPTH`.
+
+      If both :term:`BB_GIT_SHALLOW` and :term:`BB_GENERATE_MIRROR_TARBALLS` are
+      enabled, bitbake will generate shallow mirror tarballs by default for git
+      repositories. This separate variable exists so that shallow tarball
+      generation can be enabled without needing to also enable normal mirror
+      generation if it is not desired.
+
+      For example usage, see :term:`BB_GIT_SHALLOW`.
+
+   :term:`BB_GIT_SHALLOW`
+      Setting this variable to "1" enables the support for fetching, using and
+      generating mirror tarballs of `shallow git repositories <https://riptutorial.com/git/example/4584/shallow-clone>`_.
+      The external `git-make-shallow <https://git.openembedded.org/bitbake/tree/bin/git-make-shallow>`_
+      script is used for shallow mirror tarball creation.
+
+      When :term:`BB_GIT_SHALLOW` is enabled, bitbake will attempt to fetch a shallow
+      mirror tarball. If the shallow mirror tarball cannot be fetched, it will
+      try to fetch the full mirror tarball and use that.
+
+      When a mirror tarball is not available, a full git clone will be performed
+      regardless of whether this variable is set or not. Support for shallow
+      clones is not currently implemented as git does not directly support
+      shallow cloning a particular git commit hash (it only supports cloning
+      from a tag or branch reference).
+
+      See also :term:`BB_GIT_SHALLOW_DEPTH` and
+      :term:`BB_GENERATE_SHALLOW_TARBALLS`.
+
+      Example usage::
+
+         BB_GIT_SHALLOW ?= "1"
+
+         # Keep only the top commit
+         BB_GIT_SHALLOW_DEPTH ?= "1"
+
+         # This defaults to enabled if both BB_GIT_SHALLOW and
+         # BB_GENERATE_MIRROR_TARBALLS are enabled
+         BB_GENERATE_SHALLOW_TARBALLS ?= "1"
+
+   :term:`BB_GIT_SHALLOW_DEPTH`
+      When used with :term:`BB_GENERATE_SHALLOW_TARBALLS`, this variable sets
+      the number of commits to include in generated shallow mirror tarballs.
+      With a depth of 1, only the commit referenced in :term:`SRCREV` is
+      included in the shallow mirror tarball. Increasing the depth includes
+      additional parent commits, working back through the commit history.
+
+      If this variable is unset, bitbake will default to a depth of 1 when
+      generating shallow mirror tarballs.
+
+      For example usage, see :term:`BB_GIT_SHALLOW`.
+
    :term:`BB_HASHBASE_WHITELIST`
       Lists variables that are excluded from checksum and dependency data.
       Variables that are excluded can therefore change without affecting
-- 
2.25.1


