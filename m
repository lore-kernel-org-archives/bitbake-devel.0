Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081EC4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:51:24 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.159177.1698695474814613375
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=Jng1am1t;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 32EE49C2848
	for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 15:51:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Wyec9vzEUNGZ; Mon, 30 Oct 2023 15:51:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C986C9C284C;
	Mon, 30 Oct 2023 15:51:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C986C9C284C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698695473; bh=9ZmjA4jVXRKl7D0tU2mh3T4CRmbXyy0ig+56aOGFxaw=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Jng1am1tz6gbrnSz7xuK6SvoLy+bMSep/IkshULBW6GmAfO5wn6xa2v5Uh0iAmZQo
	 fneUVtrfOmVKhPvnITvXrFfxqJvY7hpTY9l1DXxUB+crn2PyBupJF7u/8JvHWs72f8
	 zoUbHLM7ttl4vp5LsScgeyihyqAztRLfLleZilCj9Fv0v6nKVpkJvbOGywn+90jrW6
	 8GVLUYD8WBd49UT1VYBMECVwfv/enAhaSMmGNZuMADxG6dEIZnGKxQD4ppneghK6fI
	 lBOQXi9BlUqZhuGWlmj7VR1Ll+t0ZHJ8v0eTRNk0Eje7L922bOAcCBghOJYaspDALM
	 1McfENdUOwWJQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id SwWzVNup08Fc; Mon, 30 Oct 2023 15:51:13 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E7EDA9C2848;
	Mon, 30 Oct 2023 15:51:12 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Subject: [PATCH 6/8] Toaster: Move toaster tests requirements in bitbake/lib/toaster/toaster-tests-requirements
Date: Mon, 30 Oct 2023 20:50:35 +0100
Message-Id: <20231030195037.232912-6-alassane.yattara@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:51:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15330

To make difference between bitbake and toaster python requirements,
a dedicated requirements file is created for toaster in root of toaster d=
ir.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
---
 lib/toaster/tests/toaster-tests-requirements.txt | 5 +++++
 toaster-requirements.txt                         | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toast=
er/tests/toaster-tests-requirements.txt
index f30ac070..7109c625 100644
--- a/lib/toaster/tests/toaster-tests-requirements.txt
+++ b/lib/toaster/tests/toaster-tests-requirements.txt
@@ -1 +1,6 @@
 selenium>=3D4.13.0
+pytest=3D=3D7.4.2
+pytest-django=3D=3D4.5.2
+pytest-env=3D=3D1.1.0
+pytest-html=3D=3D4.0.2
+pytest-metadata=3D=3D3.0.0
diff --git a/toaster-requirements.txt b/toaster-requirements.txt
index 19bf6fd2..d8e48b7f 100644
--- a/toaster-requirements.txt
+++ b/toaster-requirements.txt
@@ -2,8 +2,3 @@ Django>4.2,<4.3
 beautifulsoup4>=3D4.4.0
 pytz
 django-log-viewer=3D=3D1.1.7
-pytest=3D=3D7.4.2
-pytest-django=3D=3D4.5.2
-pytest-env=3D=3D1.1.0
-pytest-html=3D=3D4.0.2
-pytest-metadata=3D=3D3.0.0
--=20
2.34.1


