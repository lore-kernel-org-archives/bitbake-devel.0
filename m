Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23685CE7AE1
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:12:59 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15650.1763118769346193233
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:12:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=M4+25CLD;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0265E4E416B4
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8EA660723;
	Fri, 14 Nov 2025 11:12:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6008910371C51;
	Fri, 14 Nov 2025 12:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ROiormWOmzlU78JoRAPuRB065Mh/aY6aTXtaj//E0zs=;
	b=M4+25CLDMPZGOyp+bAlc9B415lF3d7uJY8ZECgkxIHO2AAAXliEE/xsfhg1xX/d5auTylH
	JS0qpnHQAPIIHxfynFsqBlKarQskreHD9YH7YpsWZE2wpB4UpavLic2Ucdetuvals9OAQP
	g6a8dVp+HIbA7ibD8rszW94E00MUTA+1nFDsanvLuy+QBpvUUwq2hVbqh8hT7mn/bUpWhN
	/rFdd1SqEEx3vt+jYxH12IO++jM2v9wDxUtotesksY4+9LluizxY0S912uigOFjw2vhBvT
	q8IclWpNYdJfUBuzVaoQ3H/DDENy/lhx4TCfl6jr7+Q7fnR4QV5MZ8vctvGCtg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 12:12:36 +0100
Subject: [PATCH 3/3] doc/bitbake-setup: mention the site.conf file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251114-update-bbsetup-doc-v1-3-044070bdffec@bootlin.com>
References: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
In-Reply-To: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3586;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=1JAVIENtPn2+TJw7nc2gqUXfePZAxB06vxAb58eRCms=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw6r9HYVC+NExy3hJ78tG5eMxwiurxNBJo5RM
 bTg6PmDGHiJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcOqwAKCRDRgEFAKaOo
 Nhx8D/9Qb3O23vMq1Yn8MSY2wB6sksphDzFi+/EjIG4916/K85OmppTUek52GQpDW2n1EXj9qyN
 vPUujTLwrI0DnaHKpi7wmIcaASzuBa3apIZjo6m3TRJfwhxM5vbTCAJ59qUATPfAMAOuYCaF8rM
 W9xI3OD17M/X0VdO4vtxLyGe057wrKXQG9piOD8d6TLn5t4XQjyyFGcQUVF+TXj+ehETptT7zcs
 Fj9Bt3ebv+iER/wqvzbSw5TcuGXq3Y2wdu0aHRoqGrorjWZPhHS7046kDjgutvHAht0yFXIS3ig
 RYZm9H5GdydrMOx9lkCZYH68mCHxqc3ryLrZ9meFSMiTUNeBQOpeVubpx/91sYMW+wo2aMHh1Bv
 opWfGahdPD0mtAjnyN+MkMahhMLOVF5r7zUnXb4EVYgkzNoibln6QV8fIj3GypNdiZ/3wr3dZsQ
 UnHI6uvUxx2r3DSLcFZWy5+jKi+NDD/QG+cjnBEeZd8dM+JjaJ/i3zuh/pj95whk7/Fxlkznoso
 qZgo9+SbbPifBWX8Ey/igt48IVgZiCY7gJQtv6yUeRLes72yddRpjaigW/p4MCpoe263zSUFISP
 Mx1y5OjQHyJxqPX5H9iQYu3suMISnOwJWAu5X1r7lvN+2PzLjDNYmeIf2luH1zNgvsquU8IoNZt
 9MGTpffJ/kReSJw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18395

This file is central to how bitbake-setup works and there was no mention
of it. Add it to the quick start section and the terminology.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-environment-setup.rst      | 28 ++++++++++++++++=
++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 91caeb041d..3193952972 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -51,9 +51,10 @@ Quick Start
       about ``bitbake-setup`` input configuration files.
=20
 #. With the default choices, the ``bitbake-setup init`` command creates =
the
-   following directories::
+   following files and directories::
=20
       ./bitbake-builds/
+      =E2=94=9C=E2=94=80=E2=94=80 site.conf
       =E2=94=94=E2=94=80=E2=94=80 poky-master-poky-distro_poky-machine_q=
emux86-64/
        =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
        =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 config/
@@ -83,6 +84,14 @@ Quick Start
       <bitbake-user-manual/bitbake-user-manual-intro:Layers>` and other
       repositories managed by ``bitbake-setup`` are stored and updated.
=20
+   -  ``site.conf``: a BitBake configuration file that contains site spe=
cific
+      configurations for your build environment. When it is created, it =
contains
+      some variable definitions that are based on your current :term:`se=
ttings`.
+      Comments in this file will help you understand what these variable=
s
+      correspond to.
+
+      These configurations are shared between the :term:`setups <Setup>`=
.
+
 #. Source the ``init-build-env`` file present in the :term:`BitBake Buil=
d`
    directory:
=20
@@ -102,10 +111,11 @@ Terminology
 The ``bitbake-setup`` tool revolves around some common terms we define i=
n this
 section.
=20
-``bitbake-setup`` works with a specific hierarchy of directories, that c=
an be
-represented as follows::
+``bitbake-setup`` works with a specific hierarchy of files and directori=
es, that
+can be represented as follows::
=20
    Top Directory
+   =E2=94=9C=E2=94=80=E2=94=80 site.conf
    =E2=94=9C=E2=94=80=E2=94=80 Setup 1
    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
    =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 config/
@@ -129,7 +139,8 @@ The "Top Directory" and "Setup" directories are defin=
ed as follows:
       :ref:`ref-bbsetup-setting-top-dir-name` settings.
=20
       The top directory contains one or more :term:`Setup` directories, =
each of
-      them containing a :term:`Setup`.
+      them containing a :term:`Setup`, and a :term:`Site Configuration F=
ile`
+      (named ``site.conf``).
=20
    :term:`Setup`
       A Setup is the result of the :ref:`ref-bbsetup-command-init`
@@ -144,6 +155,15 @@ The "Top Directory" and "Setup" directories are defi=
ned as follows:
          <bitbake-user-manual/bitbake-user-manual-intro:Layers>` or othe=
r
          repositories managed by ``bitbake-setup`` (``layers/`` director=
y).
=20
+   :term:`Site Configuration File`
+      This file named ``site.conf`` is a unique file located in the :ter=
m:`Top
+      Directory`, and holds top-level BitBake configuration statements s=
hared
+      between the :term:`Setups <Setup>`.
+
+      When it is created, it contains some variable definitions that are=
 based
+      on your current :term:`settings`. Comments in this file will help =
you
+      understand what these variables correspond to.
+
 The following components are involved to create the content of these dir=
ectories:
=20
 .. glossary::

--=20
2.51.0


