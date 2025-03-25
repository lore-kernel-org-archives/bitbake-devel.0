Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20973C35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 12:24:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web11.64113.1742905490937728656
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Mar 2025 05:24:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C8591756
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 05:24:56 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BADD3F58B
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 05:24:49 -0700 (PDT)
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2 1/6] fetch2/wget: consider downloadfilename when checking for upstream
Date: Tue, 25 Mar 2025 12:24:35 +0000
Message-ID: <20250325122441.2521891-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Mar 2025 12:24:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17486

latest_versionstring() currently looks at just the end of the URI when
guessing what the filename to look for is, but this doesn't work if the
URL filename is not simple.

For example, miniupnpd has a SRC_URI of:

  http://miniupnp.tuxfamily.org/files/download.php?file=3D${BP}.tar.gz;do=
wnloadfilename=3D${BP}.tar.gz

The filename component of this is "download.php", which causes the
heuristics in latest_versionstring() to exit early.

Instead, if the downloadfilename is set then use that, as it's often the
actual filename that we're after.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/wget.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
index 6cb728ab43c..df3e649312f 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -650,13 +650,17 @@ class Wget(FetchMethod):
=20
         sanity check to ensure same name and type.
         """
-        package =3D ud.path.split("/")[-1]
+        if 'downloadfilename' in ud.parm:
+            package =3D ud.parm['downloadfilename']
+        else:
+            package =3D ud.path.split("/")[-1]
         current_version =3D ['', d.getVar('PV'), '']
=20
         """possible to have no version in pkg name, such as spectrum-fw"=
""
         if not re.search(r"\d+", package):
             current_version[1] =3D re.sub('_', '.', current_version[1])
             current_version[1] =3D re.sub('-', '.', current_version[1])
+            bb.debug(3, "latest_versionstring: no version found in %s" %=
 package)
             return (current_version[1], '')
=20
         package_regex =3D self._init_regexes(package, ud, d)
--=20
2.43.0


