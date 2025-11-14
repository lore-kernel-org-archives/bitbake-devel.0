Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165F0CE7AE0
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:12:59 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15548.1763118769293850799
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:12:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=WFpOXw4L;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E43E54E416B3
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A818260719;
	Fri, 14 Nov 2025 11:12:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6F1E1037125A;
	Fri, 14 Nov 2025 12:12:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118765; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vt+BOaH1O2gyerUfv4OqVmFACgQCMEhkP7nr0SG5QW0=;
	b=WFpOXw4LXdi+VkJjQum0977Cy3ysx5lamSJXqHpwMOkQnCcyQbT1n9x0YTwcUJoDJpATy0
	q8x60iZy8OIDHMtoUNnBkWIZ1WSi+V7h7tSA5isXFRjN5E6dcXgummT9dtRhUhGZL0GQjx
	n4yCh0ODZhw2/1PTiXE2ifV7tIgtMf8D0KOtkK0KPIII/ORPyevSOFYzunsEoyTAvxyBr8
	PTb+fehqqxUW07VxLkNnxJuWPhpSJzX+2+yV4wdBwC0uc/CtUoV1gr5ftH21m+m27GnDPF
	RhS8HIGMaKdraN7XfEihiGLH+zSD7VAYMdt157afPN7Zl4SMqq1+PFFcFHp+6g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 12:12:34 +0100
Subject: [PATCH 1/3] doc/bitbake-setup: show how to clone bitbake before
 using bitbake-setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-update-bbsetup-doc-v1-1-044070bdffec@bootlin.com>
References: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
In-Reply-To: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=CjcRYyjdqrhysg1WA4TcpwNQeEaoT6kf6i4D92pxORk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw6qyZiZYL3xK0iBm6DqwWl1TicuhNYpQYWfu
 BSbvzPHlQ6JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcOqgAKCRDRgEFAKaOo
 Np0cD/0fxpJshSnBlOpSW/MxvOrxCAGSKwH8bpzZXFR73IO1OF8RkVJAs68P+V4XyDhC0hkoF4V
 px+UeMWtdsYrGSEHCAIa/afvznRdGQKaCRgXkGJxBnc13W1jbjryELRxVEOYy0cRn7zdOJ2G4T+
 frRBD61eJZA4l7i0ttUhwiVC43BN55MpNKLQTr7wXfcSfe6cwTXnbY+f/IFF6nHg+Qw3o/z+rRv
 9uTgn2ScsLgiThR/884Ys5l+i0Rm+UK3U5UQ3PIPcrz5I4lQs/FkHbzJlJoLxqt9cIFHjFAXV6m
 471/u824jZNiRccgr7xdUrjvd76FgdUa9GmoigEgK20oeqMQ5QnC/dlRRxu5CAdGDVy8EIgQ9kk
 9bdwTSK9s2tVv5bi9SWYOFuWA85xwrb/ZJsk8NtUgIP5zVdQH5hcAzrSlczvoP61sveMeRMwDCg
 T8XbW6ZMAPRZeZ0Cg/XAhN+FrCpnogiSjWw4WTJC59ThuOqk+grP+qyrwkbmxMCDVXrLo+AcMOU
 +oWY+VI3sTWNQ9I1XKOEVihGWYkehwsze4fMWnlM3Z/i+2fTWXqQIZ0JC3zTkBsxnS0MP2HWIsW
 QwC1CgjSgtog7iNwjamAddE1ubHV7v3ayqXLsrCo7MpnZyd8K1g3GlM9rKOeDX/UUP1w3TDiv7W
 t/eqSpTjYyCLRZA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18394

Users reading the documentation on the website or else might not have a
copy of bitbake yet. It is not straightforward to users that
bitbake-setup is part of the source tree and that it is the only
location to use it from (for now).

Add a step at the beginning of the Quick Start section that shows how to
clone bitbake-setup. The default branch (master) will be cloned, which
is currently what is recommended. This might be subject to change in the
future if bitbake-setup becomes backwards-incompatible.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst              | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 66c0b0fa68..9ae8ca7fb9 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -25,12 +25,20 @@ the following tasks:
 Quick Start
 ===========
 
-#. ``bitbake-setup`` is part of the BitBake repository under
-   ``./bin/bitbake-setup``. To start, run:
+#. If you haven't already, clone the BitBake repository:
 
    .. code-block:: shell
 
-      $ ./bin/bitbake-setup init
+      $ git clone https://git.openembedded.org/bitbake
+
+#. ``bitbake-setup`` is part of the BitBake source tree under
+   ``./bitbake/bin/bitbake-setup``.
+
+   To start, run:
+
+   .. code-block:: shell
+
+      $ ./bitbake/bin/bitbake-setup init
 
    This command will ask you to choose which configurations to use available as
    part of the default BitBake :term:`generic configurations <generic

-- 
2.51.0


