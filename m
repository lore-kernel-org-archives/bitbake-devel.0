Return-Path: <jasper@fancydomain.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF5C4332F
	for <webhook@archiver.kernel.org>; Wed, 24 Nov 2021 23:37:41 +0000 (UTC)
Received: from mx.walter.deinstapel.de (mx.walter.deinstapel.de
 [116.202.209.171])
 by mx.groups.io with SMTP id smtpd.web11.5618.1637797056873013519
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Nov 2021 15:37:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fancydomain.eu header.s=mail
 header.b=iijmom9g;
 spf=pass (domain: fancydomain.eu, ip: 116.202.209.171,
 mailfrom: jasper@fancydomain.eu)
From: jasper@fancydomain.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fancydomain.eu;
	s=mail; t=1637797054;
	bh=dnbEC265MujYkrdLVuJD61EC0uo5UzigBQwZhTS1Tlk=;
	h=From:To:Cc:Subject;
	b=iijmom9g5BNRi0oW/m9014bONbzQCU6Prm10ZqkttzSSJXcpbhbx0v8b/1QhpiE1D
	 ta4qvhzQraR/sHhWIfk76iMCrQkhlCoTl8+IuRl5HlkciEHwS/hv3xz6ej3wmqUwyd
	 4rQIOUVLKKeArpZ8NAZleu/7+ikujbdrBYFhhxYayIcZpDikq8ZDZzl3LnrUDYc0k2
	 0QhwjKaASXJL73KCDTRcpq2R/FDgw0tnwFL1NJc6S16oz2cKE64yCqoH9IJbZ7+/bL
	 xZyoyjJMqqlTBypsQzM9MqfaN/tM3aF6Ba0PsKhDdo1hTgyn7/t8j4y76P1kQvwAri
	 oWiua+IDjJBMg==
To: openembedded-core@lists.openembedded.org
Cc: martin@mko.dev,
	Daniel.Baumgart@iris-sensing.com,
	bitbake-devel@lists.openembedded.org,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
Subject: [oe-core][PATCH v7 1/2] repo: Add recipe for 2.17.3
Date: Thu, 25 Nov 2021 00:37:01 +0100
Message-Id: <20211124233702.74352-1-jasper@fancydomain.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Nov 2021 23:37:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13103

From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>

Add a recipe for repo 2.17.3, prerequisite for the repo fetcher.

Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
---
 meta/conf/distro/include/maintainers.inc      |  1 +
 .../0001-Set-REPO_REV-to-v2.17.3.patch        | 35 +++++++++++++++++++
 .../repo/repo/0001-python3-shebang.patch      | 26 ++++++++++++++
 meta/recipes-devtools/repo/repo_2.17.3.bb     | 28 +++++++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_=
REV-to-v2.17.3.patch
 create mode 100644 meta/recipes-devtools/repo/repo/0001-python3-shebang.=
patch
 create mode 100644 meta/recipes-devtools/repo/repo_2.17.3.bb

diff --git a/meta/conf/distro/include/maintainers.inc b/meta/conf/distro/=
include/maintainers.inc
index f3e0a75d56..58a0a9615f 100644
--- a/meta/conf/distro/include/maintainers.inc
+++ b/meta/conf/distro/include/maintainers.inc
@@ -652,6 +652,7 @@ RECIPE_MAINTAINER:pn-quilt-native =3D "Robert Yang <l=
iezhi.yang@windriver.com>"
 RECIPE_MAINTAINER:pn-quota =3D "Anuj Mittal <anuj.mittal@intel.com>"
 RECIPE_MAINTAINER:pn-re2c =3D "Khem Raj <raj.khem@gmail.com>"
 RECIPE_MAINTAINER:pn-readline =3D "Hongxu Jia <hongxu.jia@windriver.com>=
"
+RECIPE_MAINTAINER:pn-repo =3D "Jasper Orschulko <Jasper.Orschulko@iris-s=
ensing.com>"
 RECIPE_MAINTAINER:pn-resolvconf =3D "Chen Qi <Qi.Chen@windriver.com>"
 RECIPE_MAINTAINER:pn-rgb =3D "Unassigned <unassigned@yoctoproject.org>"
 RECIPE_MAINTAINER:pn-rpcbind =3D "Hongxu Jia <hongxu.jia@windriver.com>"
diff --git a/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-=
v2.17.3.patch b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-=
to-v2.17.3.patch
new file mode 100644
index 0000000000..60f1086b32
--- /dev/null
+++ b/meta/recipes-devtools/repo/repo-2.17.3/0001-Set-REPO_REV-to-v2.17.3=
.patch
@@ -0,0 +1,35 @@
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
+folders, we hardcode the default REPO_REV to a SHA1 that corresponds to
+the version of the recipe. REPO_REV can still be overwriten by the user,
+by specifying the REPO_REV environment variable.
+
+Upstream-Status: Inappropriate [configuration]
+Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
+---
+ repo | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/repo b/repo
+index 4cddbf1..5c3551f 100755
+--- a/repo
++++ b/repo
+@@ -144,7 +144,7 @@ if not REPO_URL:
+   REPO_URL =3D 'https://gerrit.googlesource.com/git-repo'
+ REPO_REV =3D os.environ.get('REPO_REV')
+ if not REPO_REV:
+-  REPO_REV =3D 'stable'
++  REPO_REV =3D '11b30b91df1f0e03b53da970ec2588e85817bacc'
+ # URL to file bug reports for repo tool issues.
+ BUG_URL =3D 'https://bugs.chromium.org/p/gerrit/issues/entry?template=3D=
Repo+tool+issue'
+=20
+--=20
+2.34.0
diff --git a/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch b=
/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
new file mode 100644
index 0000000000..d3888c8bb2
--- /dev/null
+++ b/meta/recipes-devtools/repo/repo/0001-python3-shebang.patch
@@ -0,0 +1,26 @@
+From b8e84b202cd302a7c99288d3835dc9c63071f8f2 Mon Sep 17 00:00:00 2001
+From: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
+Date: Tue, 14 Sep 2021 16:46:51 +0200
+Subject: [PATCH] python3 shebang
+
+Yocto does not symlink from python to python3, thus change the shebang f=
rom
+python to python3.
+
+Upstream-Status: Inappropriate [configuration]
+Signed-off-by: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>
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
diff --git a/meta/recipes-devtools/repo/repo_2.17.3.bb b/meta/recipes-dev=
tools/repo/repo_2.17.3.bb
new file mode 100644
index 0000000000..f7bbb22964
--- /dev/null
+++ b/meta/recipes-devtools/repo/repo_2.17.3.bb
@@ -0,0 +1,28 @@
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
+LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3b83ef96387f14655fc854ddc3c6b=
d57"
+
+SRC_URI =3D "git://gerrit.googlesource.com/git-repo.git;protocol=3Dhttps=
;branch=3Dmain"
+SRCREV =3D "11b30b91df1f0e03b53da970ec2588e85817bacc"
+
+SRC_URI +=3D "file://0001-python3-shebang.patch \
+            file://0001-Set-REPO_REV-to-v2.17.3.patch"
+
+MIRRORS +=3D "git://gerrit.googlesource.com/git-repo.git git://github.co=
m/GerritCodeReview/git-repo.git"
+
+S =3D "${WORKDIR}/git"
+
+do_install() {
+	install -D ${WORKDIR}/git/repo ${D}${bindir}/repo
+}
+
+RDEPENDS:${PN} =3D "python3 git"
+
+BBCLASSEXTEND =3D "native nativesdk"
--=20
2.34.0


