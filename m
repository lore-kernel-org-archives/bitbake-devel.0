Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mx.groups.io with SMTP id smtpd.web10.5407.1611226217432319939
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Jan 2021 02:50:17 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: arm.com, ip: 217.140.110.172, mailfrom: ross.burton@arm.com)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B3C0D6E
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jan 2021 02:50:17 -0800 (PST)
Received: from oss-tx204.lab.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE303F719
	for <bitbake-devel@lists.openembedded.org>; Thu, 21 Jan 2021 02:50:16 -0800 (PST)
From: "Ross Burton" <ross@burtonini.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] fetch2: handle empty elements in _param_str_split
Date: Thu, 21 Jan 2021 10:50:10 +0000
Message-Id: <20210121105011.3766882-1-ross.burton@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

_param_str_split is used to split ?foo=3D1;bar=3D2 into a dictionary, but=
 throws
an exception if a lone semicolon is used as the value doesn't split into =
two
items.

Fix by checking that the result of the first split has content.

Signed-off-by: Ross Burton <ross.burton@arm.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__=
init__.py
index 07b7ae41b4..ee3d7b1672 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -290,7 +290,7 @@ class URI(object):
=20
     def _param_str_split(self, string, elmdelim, kvdelim=3D"=3D"):
         ret =3D collections.OrderedDict()
-        for k, v in [x.split(kvdelim, 1) for x in string.split(elmdelim)=
]:
+        for k, v in [x.split(kvdelim, 1) for x in string.split(elmdelim)=
 if x]:
             ret[k] =3D v
         return ret
=20
--=20
2.25.1

