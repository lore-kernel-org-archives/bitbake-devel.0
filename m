Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC368C00142
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:14 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.159370.1698695471945533476
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Kb0JeADI;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 32B5C9C332F
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id zdkBYB74FJsa; Mon, 30 Oct 2023 15:51:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id A95E59C284C;
	Mon, 30 Oct 2023 15:51:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com A95E59C284C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695467; bh=cubH3MRaAVO5vupGVR+sNvHO6ZC5u9ghm5HvtaTi7+I=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Kb0JeADIstpbxO7vMUJyX0zXW25BzGQ3Yy5MhKJsdM1bJdqMbeP/mbEoyJ7srZNr+
	 uC5yC/BWOrHg35MRxkIo7WnGjiFEytbrCzNy/iwTXL/feTQNseC56aMevGl3LEgshZ
	 crTbe6Klhxy9D0Zs4iW3IdbAiZV4uBXpMlmUIOpUQ07Tl+WGDl1EFvZxcenioABCQK
	 CA9n7svBHlpmfnwN8urtp+fFOlxzzGyDUl/DPwsX2F0nRjP+dctIluWJ2iC1q4r4EI
	 iXYrYZwayiop5xCrXd/vvtWmTOpTBTgqjpnTh8dasA9Pl0Tcue6zuV1aOiWlaUJQ8Z
	 ukfnNtNejNmIQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id yRownN7y7D3J; Mon, 30 Oct 2023 15:51:07 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 048B29C2848;
	Mon, 30 Oct 2023 15:51:06 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 1/8] Toaster: Update toaster-requirements.txt to add pytest and some plugin's
Date: Mon, 30 Oct 2023 20:50:30 +0100
Message-Id: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15326

The pytest framework makes it easy to write small, readable tests, and ca=
n scale
to support complex functional testing for applications and libraries.
- Pytest-html is a plugin for pytest that generates a HTML report for tes=
t results.
- Pytest-django allows us to test Django project/applications with the py=
test testing tool.
- Pytest-env is a pytest plugin that enables us to set environment variab=
les in a pytest.ini or pyproject.toml file

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 toaster-requirements.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index d8e48b7f..19bf6fd2 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,3 +2,8 @@ Django>4.2,<4.3
 beautifulsoup4>=3D4.4.0
 pytz
 django-log-viewer=3D=3D1.1.7
+pytest=3D=3D7.4.2
+pytest-django=3D=3D4.5.2
+pytest-env=3D=3D1.1.0
+pytest-html=3D=3D4.0.2
+pytest-metadata=3D=3D3.0.0
--=20
2.34.1


