Return-Path: <marex@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B9DC4332F
	for <webhook@archiver.kernel.org>; Sun, 18 Dec 2022 00:08:44 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by mx.groups.io with SMTP id smtpd.web10.19829.1671322122451804484
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Dec 2022 16:08:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@denx.de header.s=phobos-20191101 header.b=AdOnmthl;
 spf=pass (domain: denx.de, ip: 85.214.62.61, mailfrom: marex@denx.de)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5395584E8F;
	Sun, 18 Dec 2022 01:08:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1671322120;
	bh=smMbuSDJ+cPXgwcNl4/piH/+5HtdeLDQEve+aCC8sr4=;
	h=From:To:Cc:Subject:Date:From;
	b=AdOnmthlD3z757MbajTy+pdu58MTAS4+zvRx4+eetiOikswdMUgBB7wj0hPejRXWK
	 IVWpe4zD/PQeCjJMf+My4zItPx56DwwG8jA+VR+wvHJLYZgjOBK7hUNjzQcZF72b4L
	 SHvzrP/HArl5bFijgqYQ7awsas8XDRimbsDWKqXccK3Ksr5myx9xjDmOkWcoqDmyHW
	 hw8BAMQpe3au8dLDfxdsmn6T2aLFq3+8BGhAuZd0DX3RfNup8QztUzhW3luCc90PPi
	 sJRIB0hLEj2EbG0yBS0g4CTtra+hpoBYgF7+T8wOuiT0RZt4aCk6+wKgDlxTSo87Mm
	 x8zquR/CWTwGA==
From: Marek Vasut <marex@denx.de>
To: bitbake-devel@lists.openembedded.org
Cc: Marek Vasut <marex@denx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Quentin Schulz <foss+yocto@0leil.net>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH] fetch2/git: Clarify the meaning of namespace
Date: Sun, 18 Dec 2022 01:08:37 +0100
Message-Id: <20221218000837.157941-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Dec 2022 00:08:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14193

Namespace in this context means a branch, a tag, etc., clarify
it in the description. Also, fix a typo "a any", replace with
plain "any".

This patch is based of feedback on new applied patch
d32e5b0e ("fetch2/git: Prevent git fetcher from fetching gitlab repositor=
y metadata")

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: Quentin Schulz <foss+yocto@0leil.net>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/git.py                                     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index bd117190..c061bd70 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -424,8 +424,8 @@ This fetcher supports the following parameters:
=20
 -  *"nobranch":* Tells the fetcher to not check the SHA validation for
    the branch when set to "1". The default is "0". Set this option for
-   the recipe that refers to the commit that is valid for a any namespac=
e
-   instead of the branch.
+   the recipe that refers to the commit that is valid for any namespace
+   (branch, tag, ...) instead of the branch.
=20
 -  *"bareclone":* Tells the fetcher to clone a bare clone into the
    destination directory without checking out a working tree. Only the
diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index c80e8e5c..2e3d3251 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -44,7 +44,8 @@ Supported SRC_URI options are:
=20
 - nobranch
    Don't check the SHA validation for branch. set this option for the re=
cipe
-   referring to commit which is valid in any namespace instead of branch=
.
+   referring to commit which is valid in any namespace (branch, tag, ...=
)
+   instead of branch.
    The default is "0", set nobranch=3D1 if needed.
=20
 - usehead
--=20
2.35.1


