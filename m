Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174FC433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Mar 2022 17:53:38 +0000 (UTC)
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net
 [217.70.178.230])
 by mx.groups.io with SMTP id smtpd.web12.536.1646848416969500148
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Mar 2022 09:53:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gsr3tyLp;
 spf=pass (domain: bootlin.com, ip: 217.70.178.230,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id E448F24000D;
	Wed,  9 Mar 2022 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1646848415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aTpHZirCE1rkrQa1ootxZnKEOZBe+eCYPuMBQarqbH4=;
	b=gsr3tyLpYx09FHSw3Lg1YAuF0riMt+jEuRvOnZSHMjvyPKkIUkQUPSBgeEk/L2PKD8vmCS
	V/HoepeqIyTX+StXtXTwGccd9dd7b9GkZiLqqSspz6vFHqFPnHtQpqaKrHq3HQIwRs0rdD
	MQkEyLKeHQNeDciOBNlfeUPf4/Ce/KkWA0DPKWQqbtzOPZrA4+aLSVXwXH7p8kU3As4fAa
	r1zQQPBvdcEjeemarvUJDwF3jdXNWKKWvM6Q8/IlB3PjAY8lXuDAM0Jm26Oztew94ngjW7
	kVFXHXbhunwXiGbk2IyMlREyDQHvTdSeA38wFyowsTtmQt1vDomXiCyXsR1ldA==
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 1/2] doc: bitbake-user-manual: add branch parameter to git
 SRC_URI examples
Date: Wed,  9 Mar 2022 18:53:18 +0100
Message-Id: <20220309175319.620707-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Mar 2022 17:53:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13455

This parameter is now required by the git fetcher module

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst  | 8 ++++----
 .../bitbake-user-manual-ref-variables.rst                 | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 9ff4e161..ae2d3a17 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -405,7 +405,7 @@ This fetcher supports the following parameters:
      ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
      :term:`SRC_URI` is the following::
 
-       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
+       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=master;protocol=ssh;..."
 
      Note the ``:`` character changed for a ``/`` before the path to the project.
 
@@ -457,9 +457,9 @@ This fetcher supports the following parameters:
 
 Here are some example URLs::
 
-   SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
-   SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
-   SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
+   SRC_URI = "git://git.oe.handhelds.org/git/vip.git;branch=master;tag=version-1"
+   SRC_URI = "git://git.oe.handhelds.org/git/vip.git;branch=master;protocol=http"
+   SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=master;protocol=ssh;..."
 
 .. note::
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 59a9de2f..c89503c8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1413,8 +1413,8 @@ overview of their function and contents.
          :term:`SRC_URI` checksums or :term:`SRCREV` when you have more than one
          file or git repository specified in :term:`SRC_URI`. For example::
 
-            SRC_URI = "git://example.com/foo.git;name=first \
-                       git://example.com/bar.git;name=second \
+            SRC_URI = "git://example.com/foo.git;branch=master;name=first \
+                       git://example.com/bar.git;branch=master;name=second \
                        http://example.com/file.tar.gz;name=third"
 
             SRCREV_first = "f1d2d2f924e986ac86fdf7b36c94bcdf32beec15"
-- 
2.25.1


