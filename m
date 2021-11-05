Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99EBC433EF
	for <webhook@archiver.kernel.org>; Fri,  5 Nov 2021 13:31:11 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web10.5383.1636119070550240155
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Nov 2021 06:31:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=nVNiroWJ;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: Jasper Orschulko <jasper@fancydomain.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1636119069;
	bh=FdXHzFCfcFD9a0kngQr3DSZP7IbB4QHVL75oJCynnOA=;
	h=From:To:Cc:Subject;
	b=nVNiroWJVCgNanWs3SJKWaQSThhlGYNrTucMYzPSQCZu1OHY2ZNBHolGIIkB2j2c4
	 RsnbbEm249oxOqQcM3czMnvCEa/tAyitusw5CoLsmxCnJJaMq0Lu4tfvkWmbMd3FiO
	 0DdeboV0OghuSUeVT6mx56KwJcYMyAFrnJhd7dEj3JauDlEOWgXQIiwkuPLNyBNsTp
	 ku5JSYmMWU2oaTw9sogulW+k4ye4u0iBoFsEw7/5pyVhJO+k7GcbsVUG7B2ZRc5GuS
	 Ia6OpwPpE7Wd4gBMtYO0MIo6nU3Usx++Zv3iAhn5IDrKXnr+3ZJGbYP/zAPyuZrczF
	 uoMjDAiikQYOQ==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.net,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH 1/2] devtools: Initial recipe for repo 2.17.3
Date: Fri,  5 Nov 2021 14:31:03 +0100
Message-Id: <20211105133104.19895-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Nov 2021 13:31:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12893

From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>

Add a recipe for repo, prerequisite for the repo fetcher.

Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
---
 .../repo/files/0001-python3-shebang.patch     | 21 ++++++++++++
 .../0001-Set-REPO_REV-to-v2.17.3.patch        | 33 +++++++++++++++++++
 meta/recipes-devtools/repo/repo.inc           | 25 ++++++++++++++
 meta/recipes-devtools/repo/repo_2.17.3.bb     |  7 ++++
 4 files changed, 86 insertions(+)
 create mode 100644 meta/recipes-devtools/repo/files/0001-python3-shebang=
.patch
 create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_=
REV-to-v2.17.3.patch
 create mode 100644 meta/recipes-devtools/repo/repo.inc
 create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb

diff --git a/meta/recipes-devtools/repo/files/0001-python3-shebang.patch =
b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
new file mode 100644
index 0000000000..09ccf58264
--- /dev/null
+++ b/meta/recipes-devtools/repo/files/0001-python3-shebang.patch
@@ -0,0 +1,21 @@
+From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
+From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
+Date: Tue, 14 Sep 2021 16:46:51 +0200
+Subject: [PATCH] python3 shebang
+
+---
+ repo | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/repo b/repo
+index b13e34c..205e0e5 100755
+--- a/repo
++++ b/repo
+@@ -1,4 +1,4 @@
+-#!/usr/bin/env python
++#!/usr/bin/env python3
+ # -*- coding:utf-8 -*-
+ #
+ # Copyright (C) 2008 The Android Open Source Project
+--
+2.33.0
diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-=
v2.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-=
to-v2.17.3.patch
new file mode 100644
index 0000000000..294a3af53a
--- /dev/null
+++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3=
.patch
@@ -0,0 +1,33 @@
+From bdd2a528da59c28db8ae2986834926de7cebf3ab Mon Sep 17 00:00:00 2001
+From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
+Date: Thu, 4 Nov 2021 16:55:12 +0100
+Subject: [PATCH] Set REPO_REV to v2.17.3
+
+repo is an unusual tool because it downloads all of its own Python modul=
es
+using GPG-signed git tags, and stores those files as part of the project
+that it is working with.
+
+So in order to have a reproducible repo installation within the project
+folders, we hardcode the REPO_REV variable to this recipes PV.
+
+Upstream-Status: Inappropriate [configuration]
+Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
+---
+ repo | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/repo b/repo
+index 4cddbf1..cf5f6b1 100755
+--- a/repo
++++ b/repo
+@@ -142,7 +142,7 @@ if __name__ =3D=3D '__main__':
+ REPO_URL =3D os.environ.get('REPO_URL', None)
+ if not REPO_URL:
+   REPO_URL =3D 'https://gerrit.googlesource.com/git-repo'
+-REPO_REV =3D os.environ.get('REPO_REV')
++REPO_REV =3D 'v2.17.3'
+ if not REPO_REV:
+   REPO_REV =3D 'stable'
+ # URL to file bug reports for repo tool issues.
+--
+2.33.1
diff --git a/meta/recipes-devtools/repo/repo.inc b/meta/recipes-devtools/=
repo/repo.inc
new file mode 100644
index 0000000000..60b32e4d74
--- /dev/null
+++ b/meta/recipes-devtools/repo/repo.inc
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: MIT
+# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
+
+SUMMARY =3D "Tool for managing many Git repositories"
+DESCRIPTION =3D "Repo is a tool built on top of Git. Repo helps manage m=
any Git repositories, does the uploads to revision control systems, and a=
utomates parts of the development workflow."
+HOMEPAGE =3D "https://android.googlesource.com/tools/repo"
+SECTION =3D "console/utils"
+
+LICENSE =3D "Apache-2.0"
+
+SRC_URI =3D "git://git@gerrit.googlesource.com/git-repo.git;protocol=3Dh=
ttps;branch=3Dmain"
+MIRRORS =3D "git://git@gerrit.googlesource.com/git-repo.git git://github=
.com/GerritCodeReview/git-repo.git \n"
+
+SRC_URI +=3D "file://0001-python3-shebang.patch"
+
+S =3D "${WORKDIR}/git"
+
+RDEPENDS_${PN} =3D "python3"
+
+do_install() {
+    install -d ${D}${bindir}
+    install -m 755 ${WORKDIR}/git/repo ${D}${bindir}
+}
+
+BBCLASSEXTEND =3D "native nativesdk"
diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb b/meta/recipes-dev=
tools/repo/repo_2.17.3.bb
new file mode 100644
index 0000000000..c26264b9e9
--- /dev/null
+++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: MIT
+# Copyright (C) 2021 iris-GmbH infrared & intelligent sensors
+
+require recipes-devtools/repo/repo.inc
+
+SRCREV =3D "11b30b91df1f0e03b53da970ec2588e85817bacc"
+LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
--=20
2.33.1


