Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78207CA5FD7
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 14:08:22 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12549.1769004494112518181
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 06:08:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dx5d772yDzSTc;
	Wed, 21 Jan 2026 15:08:11 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4dx5d61ydZz979;
	Wed, 21 Jan 2026 15:08:09 +0100 (CET)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Wed, 21 Jan 2026 15:07:57 +0100
Subject: [PATCH] doc: bitbake-user-manual-metadata: list known limitations
 for shell tasks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20260121-shell-invalid-v1-1-3d49dfcd78a7@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBP8Q6irRAvRMQfEQkGC8O5Jy
 2/x3gsNK2GDjb1QsVOjq0zIhYFPrpzIKUyDEsoKqSRvCXPmVLrLFLjSVq/ORKM9wmzuipGe/7c
 fY3wVDUuiXwAAAA==
X-Change-ID: 20260121-shell-invalid-23639a4f43ce
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 14:08:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18838

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
I see[1] that Antonin wasn't really for adding the [[ conditional to the
list of limitations, so maybe I should remove that part from the patch?

[1] https://lore.kernel.org/bitbake-devel/D8R3DBLE3C5T.12J03WL0YNGID@boot=
lin.com/

Richard said that "there are open bugs" but my "shell" and "parser"
search on bugzilla didn't return much outside from the limitation I just
added. There used to be a bug for handling background processes with &
but it was fixed (according to the bugzilla entry:
https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10668).
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 13 ++++++++++=
+++
 1 file changed, 13 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index 18f293f4b..c93845f01 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -1272,6 +1272,19 @@ Running ``do_foo`` prints the following::
 You can use the ``bitbake -e=C2=A0recipename`` command to view the final
 assembled function after all overrides have been applied.
=20
+Limitations
+^^^^^^^^^^^
+
+#. Arithmetic expansion is not supported. This means you cannot do:
+
+    .. code-block:: shell
+
+       VAR=3D$(( i + 1 ))
+
+    See `https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D11314`__
+
+#. The ``[[`` conditional command is not supported (it also is not valid=
 POSIX shell).
+
 BitBake-Style Python Functions
 ------------------------------
=20

---
base-commit: 5127faf986d8543bb88e73cf3dccb407d80c9a25
change-id: 20260121-shell-invalid-23639a4f43ce

Best regards,
--=20
Quentin Schulz <quentin.schulz@cherry.de>


