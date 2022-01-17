Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FE6C43217
	for <webhook@archiver.kernel.org>; Mon, 17 Jan 2022 13:08:38 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.10910.1642424915645285258
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jan 2022 05:08:37 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=fail (domain: theobroma-systems.com, ip: 217.70.183.199,
 mailfrom: quentin.schulz@theobroma-systems.com)
Received: (Authenticated sender: foss@0leil.net)
	by mail.gandi.net (Postfix) with ESMTPSA id D6F38FF80D;
	Mon, 17 Jan 2022 13:08:31 +0000 (UTC)
From: quentin.schulz@theobroma-systems.com
To: docs@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH] doc: bitbake-user-manual: specify the URL to be used with SSH
 over git is different from `git clone`'s
Date: Mon, 17 Jan 2022 14:08:16 +0100
Message-Id: <20220117130816.104203-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jan 2022 13:08:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13237

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The URL expected by git fetcher when the SSH protocol is used differs
from the one given by Git servers to be used with the `git clone`
command.

Add a note making this specificity known to users.

Cc: Quentin Schulz <foss+yocto@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../bitbake-user-manual-fetching.rst               | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 0fc2d5e699..77384cfdc7 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -396,6 +396,19 @@ This fetcher supports the following parameters:
    protocol is "file". You can also use "http", "https", "ssh" and
    "rsync".
 
+   .. note::
+
+     When ``protocol`` is "ssh", the URL expected in :term:`SRC_URI` differs
+     from the one that is typically passed to ``git clone`` command and provided
+     by the Git server to fetch from. For example, the URL returned by GitLab
+     server for ``mesa`` when cloning over SSH is
+     ``git@gitlab.freedesktop.org:mesa/mesa.git``, however the expected URL in
+     :term:`SRC_URI` is the following::
+
+       SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
+
+     Note the ``:`` character changed for a ``/`` before the path to the project.
+
 -  *"nocheckout":* Tells the fetcher to not checkout source code when
    unpacking when set to "1". Set this option for the URL where there is
    a custom routine to checkout code. The default is "0".
@@ -446,6 +459,7 @@ Here are some example URLs::
 
    SRC_URI = "git://git.oe.handhelds.org/git/vip.git;tag=version-1"
    SRC_URI = "git://git.oe.handhelds.org/git/vip.git;protocol=http"
+   SRC_URI = "git://git@gitlab.freedesktop.org/mesa/mesa.git;protocol=ssh;..."
 
 .. note::
 
-- 
2.34.1


