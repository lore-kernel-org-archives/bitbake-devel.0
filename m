Return-Path: <rl@karo-electronics.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE2ACD6E60
	for <webhook@archiver.kernel.org>; Tue,  2 Jun 2026 14:29:47 +0000 (UTC)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26837.1780410585885803228
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jun 2026 07:29:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@karo-electronics.de header.s=kas202603021246 header.b=e/kvSchC;
 spf=pass (domain: karo-electronics.de, ip: 85.13.167.58, mailfrom: rl@karo-electronics.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
	s=kas202603021246; t=1780410583;
	bh=WdZuYHKcz2ymwpMW3cMmTCV+AftsBMfWA8KSf9bZzr0=;
	h=From:To:Cc:Subject:Date:From;
	b=e/kvSchC4wkNoUU4WgfcCQgen9uHvc2tw9w2TqxEkJSYCkQy9tUK2eXEpoe8UYzRy
	 pyEoLSdQKm5KwsusvvurmCJF8LGWkhpPbS/cKXxgkEC5HLY5izDt8Ce0dQeEKAEMQ8
	 BI7yoo9pqACiTiLTft3FccpNOARaL3kvEYAHAW66WezMK1ra1pBz+86OYa4vmxgzJj
	 RzimIja0dcmPAtZqYe+JkXzG1DpW2HwuXz7xHS1rnIZNmW4QnIfURyL7PEcbrqVFBu
	 r9uT81ukerwE+L8KxuvdwHEok5gHS609vAAoAOEucxdqARxp1dzoXXgxcv97+LAJfC
	 9PAqUKPI5FEQw==
Received: from robin-MS-7E12.ka-ro.local (unknown [89.1.81.74])
	by dd54918.kasserver.com (Postfix) with ESMTPSA id D251A77223CA;
	Tue,  2 Jun 2026 16:29:43 +0200 (CEST)
From: Robin Lintermann <rl@karo-electronics.de>
To: bitbake-devel@lists.openembedded.org
Cc: Robin Lintermann <rl@karo-electronics.de>
Subject: [scarthgap][PATCH] bitbake: bitbake-user-manual-metadata: fix missing option to 'echo' command in example
Date: Tue,  2 Jun 2026 16:29:09 +0200
Message-ID: <20260602142909.984239-1-rl@karo-electronics.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: --
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Jun 2026 14:29:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19592

The original text reads:
| values. For these to have an effect, the value must be passed to some
| utility that interprets escape sequences, such as
| ``printf`` or ``echo -n``.

The '-n' option tells echo to not append a newline to the output.
What's missing here is the '-e' option to "enable interpretation of
backslash escapes".

Signed-off-by: Robin Lintermann <rl@karo-electronics.de>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 58975f4c8..3d32e8c1e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -128,7 +128,7 @@ Consider this additional example where the two assign=
ments both assign
    BitBake does not interpret escape sequences like "\\n" in variable
    values. For these to have an effect, the value must be passed to some
    utility that interprets escape sequences, such as
-   ``printf`` or ``echo -n``.
+   ``printf`` or ``echo -ne``.
=20
 Variable Expansion
 ------------------
--=20
2.43.0


