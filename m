Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E454FD7F9F
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 11:30:31 +0000 (UTC)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.93816.1772191827392867180
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 03:30:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@0leil.net header.s=20231125 header.b=WJDTKoVO;
 spf=pass (domain: 0leil.net, ip: 84.16.66.171, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fMmN16rtSzKqP;
	Fri, 27 Feb 2026 12:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1772191825;
	bh=pfq0RdRFtwZdl2Hd9w5oHNrQv+vxkEzprMQ2DTfbkJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WJDTKoVOeT/FY7SEd9ThcTlLlxe0e0IAEsskKyoUQx18acG+dtGOG5oJOP3d2iuhG
	 OtgcOwtM0Bq4/Q/bUouJXAEivNrwONrqNPSdUecvdw09KqvxRFTnG8F7RcobdFRwo9
	 ctZQou9ZZwr4KzP9Klr5Ud/DL3jXj83sSiEU7qBhe2naRbzzroSBRDUAL3TjaHr37x
	 576l866H6nBuOpWJTFSLJpUPX45dN9njIbXTO2xgoUCLeK5ZrfkD9BtcyxiaqKDYBY
	 2hOrMdjNiV+vzt9UYXuPSdZG1ald03N48To7IBucR8B9rg3LfC5EDLKh22uw7jdk3w
	 2nrFm0ISyyB9g==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fMmN145PPz50t;
	Fri, 27 Feb 2026 12:30:25 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Fri, 27 Feb 2026 12:30:16 +0100
Subject: [PATCH v2 2/2] doc: bitbake-user-manual-metadata: list known
 limitations for shell tasks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20260227-shell-invalid-v2-2-df5cec5718bd@cherry.de>
References: <20260227-shell-invalid-v2-0-df5cec5718bd@cherry.de>
In-Reply-To: <20260227-shell-invalid-v2-0-df5cec5718bd@cherry.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 11:30:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19089

From: Quentin Schulz <quentin.schulz@cherry.de>

Javier Tia reported[1] they keep forgetting `[[` conditional isn't
supported and scouring our BugZilla, I found[2] another "bug" where
arithmetic expansion isn't supported either.

Let's add a subsection of the shell tasks with the known limitations.

[1] https://lore.kernel.org/bitbake-devel/20250320003358.977774-1-javier.=
tia@linaro.org/
[2] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11314

Reported-by: Javier Tia <javier.tia@linaro.org>
Suggested-by: Javier Tia <javier.tia@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 .../bitbake-user-manual-metadata.rst                   | 18 ++++++++++++=
+++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 1b7941335..1ae94ccd6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1231,7 +1231,9 @@ When you create these types of functions in
 your recipe or class files, you need to follow the shell programming
 rules. The scripts are executed by ``/bin/sh``, which may not be a bash
 shell but might be something such as ``dash``. You should not use
-Bash-specific script (bashisms).
+Bash-specific script (bashisms), such as ``[[`` (use ``[`` instead). The=
 BitBake
+shell parser also has further
+:ref:`limitations <bitbake-user-manual/bitbake-user-manual-metadata:limi=
tations>`.
=20
 Overrides and override-style operators like ``:append`` and ``:prepend``
 can also be applied to shell functions. Most commonly, this application
@@ -1272,6 +1274,20 @@ Running ``do_foo`` prints the following::
 You can use the ``bitbake -e=C2=A0recipename`` command to view the final
 assembled function after all overrides have been applied.
=20
+Limitations
+^^^^^^^^^^^
+
+Shell functions must be parsable by BitBake, which cannot handle all
+syntax supported by POSIX shells. In particular:
+
+#. Arithmetic expansion is not supported. This means you cannot do:
+
+    .. code-block:: shell
+
+       VAR=3D$(( i + 1 ))
+
+    See https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11314.
+
 BitBake-Style Python Functions
 ------------------------------
=20

--=20
2.53.0


