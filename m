Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3751CCE7AE6
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:12:59 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15651.1763118770188731724
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:12:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=ywIYUv1Q;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18CF5C10F67
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBA5760724;
	Fri, 14 Nov 2025 11:12:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75CCC103713C2;
	Fri, 14 Nov 2025 12:12:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=I9PeT6MjFTtnPD4lgP/GgnCBz6JGEw0jG9SvhbJH5Xg=;
	b=ywIYUv1Qxqh9DhQDDr192613LeYxiILPE3Rz3V3iXSHltDO4rnZpZTAqYxlhbm/uzvCmr1
	hRZwalKODba5Gl+Dq8iSGtvckIPvZrjaEnpbHbBvSgoEIKW0s1D3xqnprHrK0gMk5xCCw3
	gzy7eujc1WAo2x6RIj2Bn+RRPunnxV2JnabJD1StWyvnonTMMM5bKQugChjo4wlbncbdSd
	yG+v/yFBE8bps8DHQv/6WJcswEkv4CIA7WSI/2xEPoa2N5ebZU6Kv1C69slCuGMztsJtPh
	yUaNeE7aEY7zDUXpvCZ6wYbi4tQBqxScqU6WE/GDzFCcPVVYTF5Fi5dBzkg64Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 12:12:35 +0100
Subject: [PATCH 2/3] doc/bitbake-setup: quick start: change top dir path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20251114-update-bbsetup-doc-v1-2-044070bdffec@bootlin.com>
References: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
In-Reply-To: <20251114-update-bbsetup-doc-v1-0-044070bdffec@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1340;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=0qN3awy8Jh6TzIUAMF7DKxnANChk7IxxrcYxJfeRXFk=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw6qLoILvk2cPfL3aCgmy+/vu56egudrmfACx
 HJ4uZdz0dOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcOqgAKCRDRgEFAKaOo
 NqfoEADJJA7ym9fNgD08VMyeYF0hhywL05hhr8r6Y+m7biXjdoAiO7jnO5XwPhErVw4FTWq8NbA
 Dmr56/qQIVmCJE6RtIhR5Kjwlqrws0AkZVxi54us5/HTS0c66+Yit4tBLrQUUqCCOU4UG3TOPun
 mcDo6ByaHQ9tqmpoNMYsIPnkoCN9I3u1Sbwb5BIz/ajz+q/rfXLOeBsdpTnEWhMX8BKoBHlc3nT
 cc70fPHOhzUAuTIDkTek7PPG7l6rVEh4PPS5W85rPk97aREdGWj0Eyv7+I/jTAmEI6jSf5dWOb6
 Nv8ezpRLWFIfRwYcp+t0IN6qP5vgTuS2mEA3gGI6w3PClfrQ684sIGF0UV47HZ1OpLL/7TkIEe2
 ITJZ4vpBXbrSV8vpekKSZ001BEQlhG0hX2s+eM1L2BhkcbYEDIxIGxqMhHmM12ZkkIWjVKRd4PD
 FmbyCaXOYKkvlUp2RomBmgX1kDwjaj542+kRPwoG3/IsVwCVU9qv/oZ5JUX0QKSPFSDtsII5W51
 q65jChp2BHxaqwEqqS+8xCWmOc0np0kUNIXDTksBp7LDqr45ZbQiG4o0qVKfq8Tf1wUEuohWWI/
 SJa7tOxsJNvfGyR20p7VcPIJSQ8deXyA8Cmd2qmjTG6e1W/3CFaTz09RlBqZllN5dzjeAjkrHRp
 XPWesH25ruRJOQQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:12:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18396

The top-directory is now created in the CWD, so replace ~ by . in the
example.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 4 ++=
--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setu=
p.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 9ae8ca7fb9..91caeb041d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -53,7 +53,7 @@ Quick Start
 #. With the default choices, the ``bitbake-setup init`` command creates =
the
    following directories::
=20
-      ~/bitbake-builds/
+      ./bitbake-builds/
       =E2=94=94=E2=94=80=E2=94=80 poky-master-poky-distro_poky-machine_q=
emux86-64/
        =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 build/
        =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 config/
@@ -61,7 +61,7 @@ Quick Start
=20
    With:
=20
-   -  ``~/bitbake-build``: the :term:`Top Directory`, where ``bitbake-se=
tup``
+   -  ``./bitbake-builds``: the :term:`Top Directory`, where ``bitbake-s=
etup``
       configures everything. This directory can be configured with the
       :ref:`ref-bbsetup-setting-top-dir-prefix` and
       :ref:`ref-bbsetup-setting-top-dir-name` settings.

--=20
2.51.0


