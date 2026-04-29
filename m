Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E53FF8867
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 14:44:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12943.1777473847788358950
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Apr 2026 07:44:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@arm.com header.s=foss header.b=ts0LteNE;
 spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11C71596
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 07:44:01 -0700 (PDT)
Received: from cesw-amp-gbt-1s-m12830-04.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C95A73F62B
	for <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777473847; bh=wOpgyOR7rwc7w7il+WSlDSFGz7OyiojVOcyD8buI8mI=;
	h=From:To:Subject:Date:From;
	b=ts0LteNEVbZiGhYxRWaxwSMhDbDtti3uBhX82Cigu0pemqJsgCY26Pw2WrKFYNTR/
	 OBtOERv5fq8WygpwTThOQvuNjuxjSzL34ZBL4I6PVVh5eEG3jHPLChHvJZmtPP/YeP
	 xQbQ96pA2+R0aRl861uqSWSN0MPjiqBXggSycUjU=
From: Ross Burton <ross.burton@arm.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2/crate: use CDN endpoint for version checking if possible
Date: Wed, 29 Apr 2026 15:44:01 +0100
Message-ID: <20260429144401.4110241-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Apr 2026 14:44:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19417

If the crate host is crates.io then we can fetch the index for the crate
from index.crates.io instead of hitting the API.  This is the
recommended way to do automated checks and means we don't break the data
access policy[1] by not setting an explicit User-Agent.

[1] https://crates.io/data-access

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 lib/bb/fetch2/crate.py | 43 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 2d30788998..b89817ab94 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -45,6 +45,17 @@ class Crate(Wget):
=20
         super(Crate, self).urldata_init(ud, d)
=20
+    def _generate_index_path(self, name):
+        # https://doc.rust-lang.org/cargo/reference/registry-index.html#=
index-files
+        if len(name) =3D=3D 1:
+            return f"1/{name}"
+        elif len(name) =3D=3D 2:
+            return f"2/{name}"
+        elif len(name) =3D=3D 3:
+            return f"3/{name[0]}/{name}"
+        else:
+            return f"{name[0:2]}/{name[2:4]}/{name}"
+
     def _crate_urldata_init(self, ud, d):
         """
         Sets up the download for a crate
@@ -65,15 +76,15 @@ class Crate(Wget):
         # host (this is to allow custom crate registries to be specified
         host =3D '/'.join(parts[2:-2])
=20
-        # if using upstream just fix it up nicely
+        # If using crates.io use the CDN directly as per https://crates.=
io/data-access
         if host =3D=3D 'crates.io':
-            host =3D 'crates.io/api/v1/crates'
-            cdn_host =3D 'static.crates.io/crates'
+            ud.url =3D "https://static.crates.io/crates/%s/%s/download" =
% (name, version)
+            ud.versionsurl =3D 'https://index.crates.io/' + self._genera=
te_index_path(name)
+            self.latest_versionstring =3D self.latest_versionstring_from=
_index
         else:
-            cdn_host =3D host
+            ud.url =3D "https://%s/%s/%s/download" % (host, name, versio=
n)
+            ud.versionsurl =3D "https://%s/%s/versions" % (host, name)
=20
-        ud.url =3D "https://%s/%s/%s/download" % (cdn_host, name, versio=
n)
-        ud.versionsurl =3D "https://%s/%s/versions" % (host, name)
         ud.parm['downloadfilename'] =3D "%s-%s.crate" % (name, version)
         if 'name' not in ud.parm:
             ud.parm['name'] =3D '%s-%s' % (name, version)
@@ -145,9 +156,29 @@ class Crate(Wget):
                 json.dump(metadata, f)
=20
     def latest_versionstring(self, ud, d):
+        """
+        Return the latest version available when versionsurl is the [nam=
e]/versions URL.
+        """
         from functools import cmp_to_key
         json_data =3D json.loads(self._fetch_index(ud.versionsurl, ud, d=
))
         versions =3D [(0, i["num"], "") for i in json_data["versions"]]
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
=20
         return (versions[-1][1], "")
+
+    def latest_versionstring_from_index(self, ud, d):
+        """
+        Return the latest version available when versionsurl is a Cargo =
index
+        file.
+        https://doc.rust-lang.org/cargo/reference/registry-index.html#in=
dex-files
+        """
+        from functools import cmp_to_key
+
+        versions =3D []
+        response =3D self._fetch_index(ud.versionsurl, ud, d)
+        for line in response.splitlines():
+            data =3D json.loads(line)
+            versions.append((0, data["vers"], ""))
+
+        versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
+        return (versions[-1][1], "")
--=20
2.43.0


