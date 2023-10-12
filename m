Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F6CDB474
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 23:39:35 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.27519.1697153965921108506
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 16:39:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=CDWJPFKl;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 3198D9C2813
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 19:39:25 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jEgDm1ebGpso; Thu, 12 Oct 2023 19:39:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B9F389C2A59;
	Thu, 12 Oct 2023 19:39:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B9F389C2A59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1697153964; bh=NNU3jAHuhT5ISSTF3V7kb81fwbiQiSslDUaxg4l2Z9U=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=CDWJPFKl4pc6a7+jiGzxEHWWOO+3zjRNQh3YwlB8SUYuS8i+yp3C/L2Kv64MzBWJR
	 3TPvYoOfSywyiqP99A2FwlnfmMOjTxPjgnxVeRAyu6SoBysvCdWV5HU3BBJFVfUvVD
	 eNjlH+8Ta/x2A2A1K2foCdVWK3kGHc+6OU6P4i+WtHOnQOlW2gnH78LJxgfUDmfUs9
	 GdNJlC42DMfs6Grt4z3qxx+7AoB9gRN5k8lDzBLWhzh8oTrNwFhg0FZByjGy7F+ohZ
	 mb+7f61cKQXEv9gLzvxNUAXpudSdlOo1R+JjHj/twPqCURRRHMioazji6mxedQZMZP
	 29ugEjWDH9UiA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id G3IVcchUvzlR; Thu, 12 Oct 2023 19:39:24 -0400 (EDT)
Received: from jedi.. (unknown [196.117.75.249])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DB4E59C2813;
	Thu, 12 Oct 2023 19:39:23 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH] Update toaster-requirements to add django-log-viewer==1.1.7
Date: Fri, 13 Oct 2023 00:39:18 +0100
Message-Id: <20231012233918.1209234-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 23:39:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15237

Django Log Viewer allows us to read & download log files
in the admin page by using DataTables

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
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


