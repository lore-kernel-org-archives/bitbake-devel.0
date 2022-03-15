Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD626C433EF
	for <webhook@archiver.kernel.org>; Tue, 15 Mar 2022 14:21:35 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web12.11301.1647354094281172083
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Mar 2022 07:21:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iK/4tpfN;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 426711BF207;
	Tue, 15 Mar 2022 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1647354092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x2mmp6xOhSIlpBe4sP0JwYvmATOYgaMtje5kqguznRQ=;
	b=iK/4tpfNkM27LsMOkTS0hUGGVLVhJ+0dcp7WvMtSRRKJ05Kt8tksH8tO7IQZMojwHBoRjN
	SLLl4qKWNLoAeqr+ZNXPDM68DhgC2h1RMygu7Xy0OlJ9hYlBl6xtu86EouWTBjnnPnQqO6
	+S1YQkofibhi73gevIRCXyKZLYS7c6OEqHJxegZUnYJbM+F2ooxBbT37cq4uel7N66PT2M
	vHEFwGjdIlX74LvvnLWiia64SB8S5yKF5Z7LdXnJnWDbA03NVHJE15UH14WCpACugPX/dq
	u5qPaPdaG1tlm9p3LwNH24Go0TAr76IZ4H0IewgbfW1ovZEz8JMiGyOq9UiJOQ==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: bitbake-user-manual: reorder variable definitions
Date: Tue, 15 Mar 2022 15:21:22 +0100
Message-Id: <20220315142122.130520-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Mar 2022 14:21:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13482

By alphabetical order, to get the same order as in the HTML
output, sorted thanks to the ":sorted:" directive.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---

The change was made manually, but the source order was compared automatically
with the generated one thanks to these quick and dirty commands...
egrep -o "^<dt id=\"term-([0-9A-Za-z\-_])*" _build/html/bitbake-user-manual/bitbake-user-manual-ref-variables.html | cut -c 14- > ~/tmp/sorted
cd doc; make html; git grep "   :term:" bitbake-user-manual/bitbake-user-manual-ref-variables.rst | grep -v "    " | cut -d ":" -f4  | cut -d "\`" -f2 > ~/tmp/unsorted
---
 .../bitbake-user-manual-ref-variables.rst     | 62 +++++++++----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 59a9de2f..25af563d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -93,6 +93,13 @@ overview of their function and contents.
       fetcher does not attempt to use the host listed in :term:`SRC_URI` after
       a successful fetch from the :term:`PREMIRRORS` occurs.
 
+   :term:`BB_BASEHASH_IGNORE_VARS`
+      Lists variables that are excluded from checksum and dependency data.
+      Variables that are excluded can therefore change without affecting
+      the checksum mechanism. A common example would be the variable for
+      the path of the build. BitBake's output should not (and usually does
+      not) depend on the directory in which it was built.
+
    :term:`BB_CHECK_SSL_CERTS`
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
@@ -236,17 +243,6 @@ overview of their function and contents.
       based on the interval occur each time a respective interval is
       reached beyond the initial warning (i.e. 1 Gbytes and 100 Kbytes).
 
-   :term:`BB_ENV_PASSTHROUGH_ADDITIONS`
-      Specifies an additional set of variables to allow through from the
-      external environment into BitBake's datastore. This list of variables
-      are on top of the internal list set in
-      :term:`BB_ENV_PASSTHROUGH`.
-
-      .. note::
-
-         You must set this variable in the external environment in order
-         for it to work.
-
    :term:`BB_ENV_PASSTHROUGH`
       Specifies the internal list of variables to allow through from
       the external environment into BitBake's datastore. If the value of
@@ -259,6 +255,17 @@ overview of their function and contents.
          You must set this variable in the external environment in order
          for it to work.
 
+   :term:`BB_ENV_PASSTHROUGH_ADDITIONS`
+      Specifies an additional set of variables to allow through from the
+      external environment into BitBake's datastore. This list of variables
+      are on top of the internal list set in
+      :term:`BB_ENV_PASSTHROUGH`.
+
+      .. note::
+
+         You must set this variable in the external environment in order
+         for it to work.
+
    :term:`BB_FETCH_PREMIRRORONLY`
       When set to "1", causes BitBake's fetcher module to only search
       :term:`PREMIRRORS` for files. BitBake will not
@@ -337,13 +344,6 @@ overview of their function and contents.
 
       For example usage, see :term:`BB_GIT_SHALLOW`.
 
-   :term:`BB_BASEHASH_IGNORE_VARS`
-      Lists variables that are excluded from checksum and dependency data.
-      Variables that are excluded can therefore change without affecting
-      the checksum mechanism. A common example would be the variable for
-      the path of the build. BitBake's output should not (and usually does
-      not) depend on the directory in which it was built.
-
    :term:`BB_HASHCHECK_FUNCTION`
       Specifies the name of the function to call during the "setscene" part
       of the task's execution in order to validate the list of task hashes.
@@ -426,6 +426,19 @@ overview of their function and contents.
       If you want to force log files to take a specific name, you can set this
       variable in a configuration file.
 
+   :term:`BB_MULTI_PROVIDER_ALLOWED`
+      Allows you to suppress BitBake warnings caused when building two
+      separate recipes that provide the same output.
+
+      BitBake normally issues a warning when building two different recipes
+      where each provides the same output. This scenario is usually
+      something the user does not want. However, cases do exist where it
+      makes sense, particularly in the ``virtual/*`` namespace. You can use
+      this variable to suppress BitBake's warnings.
+
+      To use the variable, list provider names (e.g. recipe names,
+      ``virtual/kernel``, and so forth).
+
    :term:`BB_NICE_LEVEL`
       Allows BitBake to run at a specific priority (i.e. nice level).
       System permissions usually mean that BitBake can reduce its priority
@@ -1054,19 +1067,6 @@ overview of their function and contents.
       upstream source, and then locations specified by :term:`MIRRORS` in that
       order.
 
-   :term:`BB_MULTI_PROVIDER_ALLOWED`
-      Allows you to suppress BitBake warnings caused when building two
-      separate recipes that provide the same output.
-
-      BitBake normally issues a warning when building two different recipes
-      where each provides the same output. This scenario is usually
-      something the user does not want. However, cases do exist where it
-      makes sense, particularly in the ``virtual/*`` namespace. You can use
-      this variable to suppress BitBake's warnings.
-
-      To use the variable, list provider names (e.g. recipe names,
-      ``virtual/kernel``, and so forth).
-
    :term:`OVERRIDES`
       BitBake uses :term:`OVERRIDES` to control what variables are overridden
       after BitBake parses recipes and configuration files.
-- 
2.25.1


