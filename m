Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D78CDB474
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 20:55:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.23978.1697144113559123372
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 13:55:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=gJ6tA2Wg;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 269D19C2994
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 16:55:12 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 12U7rANkM7ED; Thu, 12 Oct 2023 16:55:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B5CA99C2B3C;
	Thu, 12 Oct 2023 16:55:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B5CA99C2B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697144111; bh=C6SlSnOOgGle05yavmxbf+yDSCmXplNfiqtJnKS+KYg=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=gJ6tA2Wgk3HrvkVTva9oPm/cNh407ZSURaVJZehsJ9rvlO632Kai5kevfpXvj5yle
	 E8jKtgXNM//ejmk71AEXw4m0Cq4YsZas+eFp4bFnsgW8vDJjsiqKjAjzhkpOqoJPfl
	 W88wU5Ml5Tl8nmWKKpI6Hr0NKR1rNVVPrCn2yp03/5R/nNXnxSD1cZTwbZKL6r28Zc
	 4VjLcr6AlYEEobLkBQW6ryXaMPyJCIuxkeXfchtvY+aU0Q/yc7Z9TjMbctuxi1Kqki
	 NqEnnip8/UJ7aNb87AV2G1ZwwYA9KbwpAccCILdNn2pD82scztgQl/CL1DlKHWt3iS
	 99rhzOrx+z1gA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id MqYcJ5rD5qKq; Thu, 12 Oct 2023 16:55:11 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 23DC79C2994;
	Thu, 12 Oct 2023 16:55:11 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Update toaster-requirements to add django-log-viewer==1.1.7
Date: Thu, 12 Oct 2023 21:49:04 +0100
Message-Id: <20231012204904.843870-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 20:55:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15217

Django Log Viewer allows you to read & download log files
in the admin page by using DataTables
---
 toaster-requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index c1f433f9..d8e48b7f 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -1,3 +1,4 @@
 Django>4.2,<4.3
 beautifulsoup4>=3D4.4.0
 pytz
+django-log-viewer=3D=3D1.1.7
--=20
2.34.1


