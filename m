Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB322C433FE
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 14:35:47 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web12.6172.1648218946561163998
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 07:35:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mniEJLzi;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200,
 mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 549B220010;
	Fri, 25 Mar 2022 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1648218944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v+WwDmg5ZRDW3rAEC040TsIDJTDxMzaQ7HhImnvcpW8=;
	b=mniEJLziYhIs/Nb77Hey/nLpk+5mgkDbuDihmLIOPPV2qpTDonjv0N1PPAJSZKdKQRFXPF
	prvsUv56434CyvoQBX+NA2jJY+Rvth6ZeXJf1xfLFjywSglmzFukhinVYu9De4+Sc1iP1p
	7WnB5iPxbZmwUCj+Bgtk65rOZM2Rl5EuEkv2HpwoOF1VpZbxUH5yDpQTiUs0+8+fsgJH7Q
	6Aoj8Es6IKQZjQ9ifapjvsLDrUDFuEtHDfygrT1xajFYAc+dI76y9wUvBWiOn/4e97dkLZ
	flLyyPJkrkdXceDcfemO5DZI2bbo6OK1oC1SW0NEbaAq5hSG6DCKol3eWCT+/Q==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH RESEND 1/2] doc: bitbake-user-manual: add branch parameter to
 git SRC_URI examples
Date: Fri, 25 Mar 2022 15:35:35 +0100
Message-Id: <20220325143536.139665-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 14:35:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13507

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This parameter is now required by the git fetcher module

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst  | 8 ++++----
 .../bitbake-user-manual-ref-variables.rst                 | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 9ff4e161..07885392 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -405,7 +405,7 @@ This fetcher supports the following parameters:
      ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
      :term:`SRC_URI` is the following::
 
-       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
+       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
 
      Note the ``:`` character changed for a ``/`` before the path to the project.
 
@@ -457,9 +457,9 @@ This fetcher supports the following parameters:
 
 Here are some example URLs::
 
-   SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
-   SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
-   SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
+   SRC_URI = "git://github.com/fronteed/icheck.git;protocol=https;branch=${PV};tag=${PV}"
+   SRC_URI = "git://github.com/asciidoc/asciidoc-py;protocol=https;branch=main"
+   SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;branch=main;protocol=ssh;..."
 
 .. note::
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 25af563d..96cfdc82 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1413,8 +1413,8 @@ overview of their function and contents.
          :term:`SRC_URI` checksums or :term:`SRCREV` when you have more than one
          file or git repository specified in :term:`SRC_URI`. For example::
 
-            SRC_URI = "git://example.com/foo.git;name=first \
-                       git://example.com/bar.git;name=second \
+            SRC_URI = "git://example.com/foo.git;branch=main;name=first \
+                       git://example.com/bar.git;branch=main;name=second \
                        http://example.com/file.tar.gz;name=third"
 
             SRCREV_first = "f1d2d2f924e986ac86fdf7b36c94bcdf32beec15"
-- 
2.25.1


