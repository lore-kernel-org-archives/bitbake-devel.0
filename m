Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AD0C5DF6D
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:28:48 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5868.1787142518712120777
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 05:28:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=aMhplp75;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 73CAD4E412D2;
	Wed, 19 Aug 2026 12:28:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 47ECF5FF42;
	Wed, 19 Aug 2026 12:28:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52BC811C70544;
	Wed, 19 Aug 2026 14:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787142511; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=c+ImPhO8d8mhOa4o/0+m2woMjKd9anuPHKOACn6R+ws=;
	b=aMhplp75ZOiYcVqSsdZApTum+2JOV5YmDiscCJ80LI2qO3O2rigjw33UsbUBDCIZTxzoal
	LnreJMrTnUmL04BPypRV49QPlLaG57RFESJYG3R7BnNLXulOMwtI7jGkWMUEhnxj/Vt5Ub
	NinHHH42OgIr+pykP1N5159OE1k6KMBmfFs6RMEBUY2RYfauPz0PJMA93NPJlKyg1KFRvb
	69eFA7WP2wel+Amz5jHwoFjBXVQkJsQ50iFhxH748W7VFlNbnxIpgdyJfynQG07i92BlpS
	qti0G8anIllwTVuB9vRW4T9nmnWHo5BiCUkmW667WySaeRC70ExI1G9vlrJaRA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 19 Aug 2026 14:28:22 +0200
Subject: [2.18][PATCH] doc: bitbake-user-manual-environment-setup: use pip
 to install bitbake-setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-bitbake-setup-pip-wrynose-v1-1-bbc52222dfed@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTumbYiAVyEs2nHU0aQ0neJPC
 He36vJbvLeCchZWODYrZH6Iyhwr7K4Buvp4YZRTNTjjDqa3AwYpwd8ZlcuSMEnCZ37HWRnJt53
 xLQ8dEdQ+ZT7L6/cep791CTem8h2Obm/7CbbtA0DavmCDAAAA
X-Change-ID: 20260819-bitbake-setup-pip-wrynose-ca470a4e97cc
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4001;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=elv4S7wCsPxEnBGCxMaEtpYE2b0+q0pQ9lo4Ub2BxPY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqhaFuxyw5MwuEcYUQRShXp1w1eWumDVY7ZwnbY
 7Q8aEBD/OGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaoWhbgAKCRDRgEFAKaOo
 NgVMD/4/UXu9ZP280DlPd5Ug/Dod12GXXt0vTWdqr11Sjoj2za9ES6+ArQpXua4kV4hkPYPX/WW
 R7GX1jCeSSBbmWkSZjppGDjZumx3xAViBbFXqGxCw7zQDxG6FNKgVQLhkcABXlDgRRPnNjLAM1M
 ojQ9OBFui14ziJxQoxkXLYBTgQEd6FfVacVD+8IyjWk70vaK6SB7JZoUd3WnN3WJrNg4j+Doz/a
 +5cXDxIDju6QP80y1dJ3n82xDWYPMDPRlO/OlN5z4oz/5FyIvLU5BPQKpIGZdsrjaucaljd0oMu
 nryyjNAVR2IMMzigKzuUe/U4E3Wc2VurL/7fHaFvImX0FWOnAFxNAa/3W8nmMi3Qf6QLb2oQMH/
 x1C3vxrs/At3wKd8W/sKHui8tUGgBP3xx40m78lshnRGYcJudvTisTLi5vLd7toyTcJFbj9pZit
 UNJpKy1IbcP2lfBEFfgVsMvCIBKGTt/OKFpA3ecJ1gJR2XZw/9BQNycigoTAT5C7Xx2n2CotVs1
 T2gwAqKeihIvrxlYGmQ3vfgMUhnKNXQbeiOteziGPm63OlPCK/MzWvwY0zfCVioFjL8tucRhWm/
 zEH9Z6CgcDtKD7/iHDoVGujTYfnHAOV9liOEemwf4qAvicU+MCYRRkxAzDNBi+MpcEPsTKSDpFJ
 kuCMNv6PoCLa/YA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 12:28:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19998

bitbake-setup is now available on Pypi[1], so let's use it instead of
a clone of bitbake to use the CLI tool. Refresh commands in consequence.
Keep git clone instructions in a note as an alternative way of setting
things up, and mention how to update it if needed.

[1]: https://pypi.org/project/bitbake-setup/

(cherry picked from commit 414646d56398c7f331872e4ce9820ccffce93abe)

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst      | 37 ++++++++++++++++------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index c22e19bd665..b3ed2129dd9 100644
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
base-commit: fae9db3168dbff1b8c76fe9c6726a9687ff97514
change-id: 20260819-bitbake-setup-pip-wrynose-ca470a4e97cc


