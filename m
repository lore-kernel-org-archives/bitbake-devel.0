Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7A2C28B26
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 12:01:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.9303.1741348863516214324
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Mar 2025 04:01:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNx-0006hN-R2; Fri, 07 Mar 2025 13:01:01 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNw-004Tky-2t;
	Fri, 07 Mar 2025 13:01:00 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tqWNw-0088s3-2h;
	Fri, 07 Mar 2025 13:01:00 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH v3 5/5] doc: document the GitHub Release Artifact fetcher and BB_FETCH_GHRA_TOKEN
Date: Fri,  7 Mar 2025 13:00:55 +0100
Message-Id: <20250307120055.1816436-6-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307120055.1816436-1-l.goehrs@pengutronix.de>
References: <20250307120055.1816436-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Mar 2025 12:01:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17402

The fetcher is quite niche, as it is only required when working with
private GitHub repositories (public releases have a stable public download
URL and do not need any authentication).

Hence it is only documented like a niche feature.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 .../bitbake-user-manual-fetching.rst                 |  2 ++
 .../bitbake-user-manual-ref-variables.rst            | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d..2f5224482 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -842,6 +842,8 @@ Fetch submodules also exist for the following:
 
 -  Trees using Git Annex (``gitannex://``)
 
+-  Private GitHub Release Artifacts (``ghra://``)
+
 No documentation currently exists for these lesser used fetcher
 submodules. However, you might find the code helpful and readable.
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index dd8cf2409..51bb336b0 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1098,6 +1098,18 @@ overview of their function and contents.
       layer containing the recipe file. Code can use this to identify which
       layer a recipe is from.
 
+   :term:`BB_FETCH_GHRA_TOKEN`
+      GitHub Access Token. When using the
+      :ref:`GitHub Release Artifact fetcher <bitbake-user-manual/bitbake-user-manual-fetching:fetchers>`
+      This variable can be defined to be used by the fetcher to authenticate
+      and gain access to non-public release artifacts::
+
+         BB_FETCH_GHRA_TOKEN = "github_pat_..."
+
+      Make sure to always use fine-grained personal access tokens that only
+      enable downloading of artifacts in the relevant repositories or the
+      short-lived access tokens provided to GitHub actions.
+
    :term:`GITDIR`
       The directory in which a local copy of a Git repository is stored
       when it is cloned.
-- 
2.39.5


