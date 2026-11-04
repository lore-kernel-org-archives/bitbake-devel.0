Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6580.1793789812940860607
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Nov 2026 02:56:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PSQA/PpM;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0F0384E413FB
	for <bitbake-devel@lists.openembedded.org>; Wed,  4 Nov 2026 10:56:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1BA160770;
	Wed,  4 Nov 2026 10:56:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7D6210329171;
	Wed,  4 Nov 2026 11:56:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793789810; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8XSrpCgJNV5IwGG5ajP/KbXg9eutiYeopi+orQoEOCs=;
	b=PSQA/PpMNVag37yLLO0+O9+9Wg80ka3Ts1yZUI2ohbaXieKZzgRj0RNnhzXIKAfkjU5AW4
	QtDlHdzO98d7UVOJ0LQxYo1hmD1pzZil3PCGVPDBWX1/JaXIZbrpqj2guDIoqVL805pSBf
	wcvF4AxwpA93oZkvU7BtXNhQVW6EHVmr5WqDHeMiLCDlf1jr2HKiUpfUgmSSACBYq3N8sE
	pJkGV/IB28IvEs9Z3a1JZxWaTuSxNuyPYx3FnBkdQok+dMi75Exe+dYgGYh+2daR9T06pR
	bwE38duGsvaUHKyxMRcZtE+wEOc4y7Z9HOcWOXYh/pSWCCr7G5Qzay9f8/1UrA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 04 Nov 2026 11:56:38 +0100
Subject: [PATCH 1/2] doc: add a terms glossary and define "datastore"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-terms-doc-v1-1-0ded0b9e1623@bootlin.com>
References: <20261104-terms-doc-v1-0-0ded0b9e1623@bootlin.com>
In-Reply-To: <20261104-terms-doc-v1-0-0ded0b9e1623@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=eUnawpVIw0XcWzKCcOVO4NcOn34t2V3wNqbVWRqzRB8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBq6w9nacG/PEAQFkvBakOJD89ymvE764QmO4rwh
 ZPLINmN6SaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCausPZwAKCRDRgEFAKaOo
 NqwOEACs/GbGkYvyV+nmIwc8r/yC/Sp46uyUQTuUKWo7Nh0qHPZUJqrk61pEPMwiLR8p2Kvypjj
 Eg4sZRjFeVZJZk4O4jFCvXYFC6xL5uqI5g/aPm1c4O4dIdc6J0V7wmR/L/Op+Gp/b2G0RK9A75Y
 suonXDT0CsnIq/llsDOYYi6Y86AjttXkPE4gUC+XybnG2SQkNyMju6rDnY24g7w/745KBfskoBC
 fgF5068ZY9yF0xbHalW1FY4jLJiCDJic4VifKZtp7Z9uTc4du+uC4fyzv+JFlYT+pSbkGFmhvwV
 ry5IKpnyH31y3zGD6CcrEEnRIRKn22AlJB02PbytNZC6/xQnAoLec9mWDLuVc5BLoSErJQ3lI1V
 B854cUCNcKlje1oDRU2CURkSes8zFpPhj68Q4CfvEznwxyrlQJYsgteaOiwlnH6I0MDBif3Kpt9
 b6+aHg38Gkm8OJSMWptdRUCoVTX88j4M95DPQTw7VHA+1hTo0QfrraGsmkCiD9Xdpq85FwhQimk
 gCd1jz8BpIH+lBrwaH26rmIAXu7x6i+LykCX6D5XiBBRswH7oaJrlWbLWuItFlCv0wwusdv1Quc
 6Fn07dSHH30jBlykZUXfvWDE2DymfmDXhnLk3RsbILQjV84OHLs7Fu0NV8GpHXbhRsOYzf6HyNQ
 bkRXJIkFbDDzJjg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 04 Nov 2026 10:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20390

The "datastore" term is used widely in the BitBake documentation with no
formal definition for it. Add a "BitBake Terms" section to store common
definitions which can be cross-referenced with :term:`...`, and define
Datastore.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-terms.rst                  | 25 ++++++++++++++++++++++
 doc/index.rst                                      |  1 +
 2 files changed, 26 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-terms.rst b/doc/bitbake-user-manual/bitbake-user-manual-terms.rst
new file mode 100644
index 00000000000..697f0570ef7
--- /dev/null
+++ b/doc/bitbake-user-manual/bitbake-user-manual-terms.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: CC-BY-2.5
+
+*************
+BitBake Terms
+*************
+
+Below is a list of terms and definitions common to BitBake.
+
+.. glossary::
+
+   :term:`Datastore`
+      The datastore is a dictionary-like object represented by the ``DataSmart``
+      class in BitBake (in ``lib/bb/data_smart.py``) and contains the values of
+      variables under the current execution of BitBake. As explained in
+      :ref:`bitbake-user-manual/bitbake-user-manual-execution:Locating and
+      Parsing Recipes`, BitBake parses recipes, bbappends, and classes and
+      stores the values of various variables into the :term:`datastore`.
+
+      The datastore is available by default in recipes and classes under the
+      name ``d``.
+
+      The :term:`datastore` defines several helper functions to read, write or
+      manipulate BitBake variables, which are documented in the
+      :ref:`bitbake-user-manual/bitbake-user-manual-metadata:Functions for
+      Accessing Datastore Variables` section.
diff --git a/doc/index.rst b/doc/index.rst
index 9f2a9067d38..5dc0cd0ae5f 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -13,6 +13,7 @@ BitBake User Manual
    bitbake-user-manual/bitbake-user-manual-intro
    bitbake-user-manual/bitbake-user-manual-execution
    bitbake-user-manual/bitbake-user-manual-environment-setup
+   bitbake-user-manual/bitbake-user-manual-terms
    bitbake-user-manual/bitbake-user-manual-metadata
    bitbake-user-manual/bitbake-user-manual-ref-variables-context
    bitbake-user-manual/bitbake-user-manual-fetching

-- 
2.55.0

