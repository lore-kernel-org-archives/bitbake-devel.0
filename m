Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8F8C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:42:23 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.2211.1698774134726465112
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:42:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YN2LLGRW;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5A5369C2BF6
	for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 13:42:13 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id KhLVsEYYXbd3; Tue, 31 Oct 2023 13:42:12 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id D62349C279F;
	Tue, 31 Oct 2023 13:42:12 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com D62349C279F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698774132; bh=HNEwh15gbBG152j7VR387hSlJFFLpMZTQmE/+2V/VmU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YN2LLGRWzX5wEpeaMDcgziz9P0x/GmD9uYerw5LgAiZXvIppovNLvFSFXUIn7wUfT
	 p7So3LFf/q+4Ssk9cimbd4L7WVpkeNmJ6aK3fXMW3J4rCYX+pFidBuRFoBoursG+B8
	 65H5zPWiE2Ht0EGXopicEjjOlhdyHQ/DFuYs572A1lPJw7Q4c+WNVKR+s8tqu1sHvH
	 Pbxdb2JgDPYHGXjey0dtM4Qg6AM92zuBOwaVHjm3bodf099UrJ1gYO1Z4HJ3iUwZVU
	 gvwsH852ezyFNmPwXQUw2O4xMUo6snTwCUVa6ugAicfjQHdk9MPuGocYISo0q4o28j
	 qP1kPwaq/Tiyw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ySUEC6DE5ntU; Tue, 31 Oct 2023 13:42:12 -0400 (EDT)
Received: from jedi.. (unknown [196.127.183.75])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id F3B3E9C2BF6;
	Tue, 31 Oct 2023 13:42:11 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH v2 1/8] Toaster: Update toaster-requirements.txt to add pytest and some plugin's
Date: Tue, 31 Oct 2023 18:41:56 +0100
Message-Id: <20231031174159.696667-1-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:42:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15373

The pytest framework makes it easy to write small, readable tests, and ca=
n scale
to support complex functional testing for applications and libraries.
- Pytest-html is a plugin for pytest that generates a HTML report for tes=
t results.
- Pytest-django allows us to test Django project/applications with the py=
test testing tool.
- Pytest-env is a pytest plugin that enables us to set environment variab=
les in a pytest.ini or pyproject.toml file
- Pytest-metadata is a plugin for pytest that provides access to test ses=
sion metadata, required by pytest-html plugin
to provides metadata information in the HTML report like below:

Python 3.10.12
Platform Linux-6.2.0-35-generic-x86_64-with-glibc2.35
Packages:
    - pytest: 7.4.2
    - pluggy: 1.3.0
Plugins	:
    - django: 4.5.2
    - metadata: 3.0.0
    - order: 1.1.0
    - html: 4.0.2
    - env: 1.1.0

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


