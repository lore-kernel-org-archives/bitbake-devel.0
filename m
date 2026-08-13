Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E0C5B572
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 07:51:11 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14119.1786607465919527290
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Aug 2026 00:51:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ois7R0Ue;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BE72D4E411E0
	for <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 07:51:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 772B7602B8;
	Thu, 13 Aug 2026 07:51:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CE5411C4DA68;
	Thu, 13 Aug 2026 09:51:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786607462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7A32b7YISxjh5B5cJuYy+/YUx15hA8YOGwu/oQ9D7ak=;
	b=ois7R0UeREIHZLmGQu/8Fb4n7FPdH0b3vfmyAZR9DzymYHcQKepMK2S9FnnagIUvXDiWMw
	WVd3gJukt5dADoRCBVkXU++LuRo15L++WQUld/6NzAux7rucw7oDp9nZn9S2G89hwnqJuO
	q1zaHuetJk7o7Gq7KGNah22MwMkppIXTjI6qdLeDVYaGH2IBz7D/LSAFKQo9tuMeRM6TAY
	Uht8s3ODJf0TCPjn3oQQZjnzFG38HTluK3VPa72DgH93eF1NC/guyNFbnRx+/9ZzMeCfk2
	hk6nN46M/x4r3XJ4QO/R84bH2uMtL3OLBi3aRh3agXA2123QJ7eHv/c1irrZOg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 13 Aug 2026 09:50:43 +0200
Subject: [PATCH] doc: bitbake-user-manual-environment-setup: use pip to
 install bitbake-setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-bitbake-setup-pip-v1-1-f45ae8cd5fb0@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTsJbY2gVzEsKPzAaIJNpxASw
 t2tuPwW7+2kiAKlR7FTxCoqnznDXArqpnYewdJnky3trayNYy/Jt2+wIi2BgwR2DuZa3ytbDY5
 yFyIG2c7ns/lbF/9Cl34jOo4vDE6oWnUAAAA=
X-Change-ID: 20260813-bitbake-setup-pip-33e1489727f3
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3719;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=EefXFv+ONkSyA8Er9+D/4yQSwOIwzG2APzZyegyuAzs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqfXdlhSqrtPPcTOxJKblqXPPG7zA1u+vsmLV5r
 LWHNcugLUWJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCan13ZQAKCRDRgEFAKaOo
 Nk0eD/0RMyfmnlg8aogNYk89p+ThC44xj5FNLvks2cLHbXDoRjAjIsjJM5q5Ywti8DsxpG4HGQV
 Chha29fGinDR3KYyah2WDggcaBssubt89wHShk/bImFVDiEycn6vEhPFjVQHYJeeWILyGQs/BVX
 dgBRW8e+5yIcfYsanK3Efw7A/3NZUD6Ox9ojMG/Vl2WnaCZeN7ujWrX71GU04kHgPCs4AuntzYX
 RYvox87/5ZDZ1YQYQ9+f3a1scpJ4uTscagpcdnHArvF+uAU9yeH5golj2hx2w88RLTdkNGHV4XN
 5MkVZp5eN8rhowk0FBobV77LG20Op/eEKWeFrjotQQYQ/sojPnhqFxssugAK0Qn0ciC9aoKaeO0
 Y9jz22qj1tcHt5zlQ5HOBaqt4cM7kTLx5NdOY5CgSj4104AkOVX0zYtvlY7QdEl1KqckGJ1hHh/
 gIgyp1UzsCuaBKb9s7p143Tl4Qcd1pwK7LALkM2BclBhqmdSDFReuRzzROk6LmVGAH3bLQfrxzp
 C1uMPY87I3zRw8a+oL2iUaFstjoo8oEgVB+eEw+x9Y9sSK+4TzRQLly+f2TBqGSZ2m5/lP9YHIq
 Lp+WB58PSv5z7gFRQMEtTsFEiz1kX5PlCCu8EOU78Qvoe+S//6eAFeDLNaknlxFgBDlc/eqy4E0
 sT8MGZBT/zl7EeQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Aug 2026 07:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19922

bitbake-setup is now available on Pypi[1], so let's use it instead of
a clone of bitbake to use the CLI tool. Refresh commands in consequence.
Keep git clone instructions in a note as an alternative way of setting
things up, and mention how to update it if needed.

[1]: https://pypi.org/project/bitbake-setup/

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst      | 37 ++++++++++++++++------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index c32a6964a43..e15c9ed0de2 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -25,20 +25,29 @@ the following tasks:
 Quick Start
 ===========
 
-#. If you haven't already, clone the BitBake repository:
+#. First, run the following command to install the ``bitbake-setup``
+   command-line tool in a Python `virtual environment
+   <https://docs.python.org/3/library/venv.html>`__:
 
    .. code-block:: shell
 
-      $ git clone https://git.openembedded.org/bitbake
+      $ python3 -m venv --clear ./bitbake-setup-venv
+      $ . ./bitbake-setup-venv/bin/activate
+      $ pip install bitbake-setup
 
-#. ``bitbake-setup`` is part of the BitBake source tree under
-   ``./bitbake/bin/bitbake-setup``.
+   .. tip::
 
-   To start, run:
+      To update ``bitbake-setup`` when already installed, you can run:
+
+      .. code-block:: console
+
+         $ pip install --upgrade bitbake-setup
+
+#. To start using ``bitbake-setup``, run:
 
    .. code-block:: shell
 
-      $ ./bitbake/bin/bitbake-setup init
+      $ bitbake-setup init
 
    This command will ask you to choose which configurations to use available as
    part of the default BitBake :term:`Configuration Templates <Configuration
@@ -104,6 +113,16 @@ Quick Start
    on how to use ``bitbake``, see the :doc:`/bitbake-user-manual/bitbake-user-manual-execution`
    section of this manual.
 
+.. note::
+
+   The ``bitbake-setup`` tool is developed and maintained in the BitBake
+   repository and can also be used directly from there:
+
+   .. code-block:: console
+
+      $ git clone https://git.openembedded.org/bitbake ./bitbake
+      $ ./bitbake/bin/bitbake-setup ...
+
 Terminology
 ===========
 
@@ -345,7 +364,7 @@ In addition, the command can take the following arguments:
 
    .. code-block:: shell
 
-      $ ./bitbake/bin/bitbake-setup \
+      $ bitbake-setup \
           --setting default registry 'git://example.com/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main' \
           init
 
@@ -354,7 +373,7 @@ In addition, the command can take the following arguments:
 
    .. code-block:: shell
 
-      $ ./bitbake/bin/bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro-master.conf.json
+      $ bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro-master.conf.json
 
 -  This example initializes a :term:`Setup` with:
 
@@ -365,7 +384,7 @@ In addition, the command can take the following arguments:
 
    .. code-block:: shell
 
-      $ ./bitbake/bin/bitbake-setup \
+      $ bitbake-setup \
           --setting default top-dir-prefix /work/bitbake-setup \
           --setting default top-dir-name custom-project \
           init \

---
base-commit: 7a3cb0d55e3698e883a9ff8491febc9d155482ca
change-id: 20260813-bitbake-setup-pip-33e1489727f3


