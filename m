Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E7DCA6019
	for <webhook@archiver.kernel.org>; Fri,  9 Oct 2026 13:34:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8022.1791552869740970227
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Oct 2026 06:34:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=gsan4XZR;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF5091BB2
	for <bitbake-devel@lists.openembedded.org>; Fri,  9 Oct 2026 06:34:25 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C513A3F763
	for <bitbake-devel@lists.openembedded.org>; Fri,  9 Oct 2026 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791552869; bh=hw2SJcAC7q8SdXAohB/UG5QArnKbGNXz5ml3/u3U/kg=;
	h=From:To:Subject:Date:From;
	b=gsan4XZRii/LHKjBYuFzpCBJ8+5gDuyW0frX2XwjlpAWEPm2wfGC5xITmMpQ0FO2M
	 DfC0IeeDgMA7UflFqobCUoHKxFNC5tgdq6yho5isGPjTWn8iC5jvFVZeGptQ/kHSY+
	 1TZ1xUPKAazWC1uSw8fYM2zY6QsfKDpr5r5K24Eg=
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] packaging-pypi: make bitbake-setup depend on websockets
Date: Fri,  9 Oct 2026 14:34:18 +0100
Message-ID: <20261009133418.215223-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-ARM-No-Footer: NoDisclaimer
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Oct 2026 13:34:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20310

If you're installing bitbake-setup via a venv and pip, you'll usually
have a self-containted venv that doesn't have access to the system-wide
site-packages tree.  This means that even if you have websockets
installed on the host, the venv with bitbake-setup in will not, and if
the same venv is used to run bitbake it won't be able to connect to
the hashserver.

Solve this by adding a dependency on websockets to the bitbake-setup
wheel.  This isn't strictly true as bitbake-setup itself doesn't use the
hashserver, but reusing the venv is common and this solves a common pain
point when setting up a new build environment.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 packaging-pypi/bitbake-setup/pyproject.toml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/packaging-pypi/bitbake-setup/pyproject.toml b/packaging-pypi=
/bitbake-setup/pyproject.toml
index 90ed1ffb98..0cd2d37803 100644
--- a/packaging-pypi/bitbake-setup/pyproject.toml
+++ b/packaging-pypi/bitbake-setup/pyproject.toml
@@ -20,7 +20,9 @@ classifiers =3D [
 ]
=20
 dependencies =3D [
-  # bitbake-setup is mostly self-contained
+  # bitbake-setup is mostly self-contained, but hashserver needs websock=
ets
+  "websockets >=3D 9.0; python_version =3D=3D '3.9'",
+  "websockets >=3D 10.0; python_version >=3D '3.10'"
 ]
=20
 [project.optional-dependencies]
--=20
2.43.0


