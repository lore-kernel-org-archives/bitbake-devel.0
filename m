Return-Path: <louis.rannou@syslinbit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8AEC02198
	for <webhook@archiver.kernel.org>; Wed, 12 Feb 2025 12:17:16 +0000 (UTC)
Received: from 14.mo583.mail-out.ovh.net (14.mo583.mail-out.ovh.net [188.165.51.82])
 by mx.groups.io with SMTP id smtpd.web10.14315.1739362626135587854
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 04:17:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@syslinbit.com header.s=ovhmo4479509-selector1 header.b=dPTqQCL3;
 spf=softfail (domain: syslinbit.com, ip: 188.165.51.82, mailfrom: louis.rannou@syslinbit.com)
Received: from director8.ghost.mail-out.ovh.net (unknown [10.108.2.201])
	by mo583.mail-out.ovh.net (Postfix) with ESMTP id 4YtHP80kT7z1Jf8
	for <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 12:16:59 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-fb9gf (unknown [10.110.96.146])
	by director8.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 33F761FE09;
	Wed, 12 Feb 2025 12:16:59 +0000 (UTC)
Received: from syslinbit.com ([37.59.142.113])
	by ghost-submission-5b5ff79f4f-fb9gf with ESMTPSA
	id n0MkBzqRrGfDjQAAM+UVKg:T2
	(envelope-from <louis.rannou@syslinbit.com>); Wed, 12 Feb 2025 12:16:59 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-113S007098ac2fc-a838-4e12-ac99-cd5556d54a71,
                    74B36F6499D71BB1255966C6406869B815799905) smtp.auth=louis.rannou@syslinbit.com
X-OVh-ClientIp: 45.81.62.9
From: Louis Rannou <louis.rannou@syslinbit.com>
Date: Wed, 12 Feb 2025 13:16:18 +0100
Subject: [PATCH 1/2] bitbake: data_smart: fix ??= operator for getVarFlags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-varflags-v1-1-3a756c7aa95c@syslinbit.com>
References: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
In-Reply-To: <20250212-varflags-v1-0-3a756c7aa95c@syslinbit.com>
To: bitbake-devel@lists.openembedded.org
Cc: Louis Rannou <louis.rannou@syslinbit.com>, louis.rannou@non.se.com, 
 pascal.eberhard@se.com, yoann.congal@smile.fr
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739362618; l=1772;
 i=louis.rannou@syslinbit.com; s=20230614; h=from:subject:message-id;
 bh=D9ArnlHtPoWyYx3q6kEtxcmEW8A9Vn/xCItByG5SwGw=;
 b=4qzIkEw7cK1GXlPVS9LiuWuUW//NZHKkUDVPLhx6nZSKZsl5uGIyOkkNdQx78JRQoJzJm4NhC
 H0uo4lKK9cRBDyZGrLsTMB370pLj68aAUcHK53lC5FgD5HFaZPicEBY
X-Developer-Key: i=louis.rannou@syslinbit.com; a=ed25519;
 pk=QLSK64UNeqThVe2CiH917a68zTpexYuA7iXw6WQ0bbI=
X-Ovh-Tracer-Id: 10464958159720537409
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucftrghnnhhouhcuoehlohhuihhsrdhrrghnnhhouhesshihshhlihhnsghithdrtghomheqnecuggftrfgrthhtvghrnhepudfhueeutdehffdvhfejleffudekieduffffteefiedutdeuhfehkeffueehfeevnecukfhppeduvdejrddtrddtrddupdeghedrkedurdeivddrledpfeejrdehledrudegvddruddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheplhhouhhishdrrhgrnhhnohhusehshihslhhinhgsihhtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdfovfetjfhoshhtpehmohehkeefmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=fB/iSf2DcWhIRCw94uzcJ3ePYh/PARZx56RY83f+vHk=;
 c=relaxed/relaxed; d=syslinbit.com; h=From; s=ovhmo4479509-selector1;
 t=1739362620; v=1;
 b=dPTqQCL3Fr6jczk2m/4U2jxkWl/Ca+XJQNh/qKfTcJzH90/0qcQsKKq3Q5egnAiGet/oDIvJ
 pgrZCLfOqGZnvLkmzfPXILNqyV4aOdtE62Rp3IcFeIHnk7hca+yuBkp7gmfBFq2S3AWwsKVuU5A
 3KK3PvBSv4r4G1Ffb3woQFi42ECj3lRDdE7hJ28PG5IAa03jJ2cI3ZlPqF849fi6+z/4bbQXIL8
 mO6PWjBiiRO63UolRTmDuDN5OZd4MrCRsKlLZOkg7tO3Hf64gnbbqMMFO+aM7punOTfB4oPtUcu
 hoeka26CIB4ScBHdr/1v1XN+23xt9nATQZ4t7IiuJkD6w==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Feb 2025 12:17:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17203

From: Louis Rannou <louis.rannou@non.se.com>

Variable flags have been fixed in commit
0329a7e3ac694737f2d2c1861f65492551360663 which introduces the
"_defaultval_flag_" prefix for default values. This must not be ignored as
others "_"-prefixed flags names.

Split the processing of default values to be sure they are overwritted by the
others operators disregarding of their order.

Fixes [YOCTO #15685]

Signed-off-by: Louis Rannou <louis.rannou@non.se.com>
---
 lib/bb/data_smart.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 897ceeb32c7ce0acb8ed44c25e1bf2f2f28aa9dc..7663f28c5071a77c8452c1016e5ee0d969c84bec 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -952,12 +952,22 @@ class DataSmart(MutableMapping):
     def getVarFlags(self, var, expand = False, internalflags=False):
         local_var = self._findVar(var)
         flags = {}
+        flags_set = {}
 
         if local_var:
-            for i in local_var:
-                if i.startswith(("_", ":")) and not internalflags:
+            for i, val in local_var.items():
+                if i.startswith("_defaultval_flag_"):
+                    i = i[len("_defaultval_flag_"):]
+                    flags[i] = val
+                elif i.startswith(("_", ":")) and not internalflags:
                     continue
-                flags[i] = local_var[i]
+                else:
+                    flags_set[i] = val
+
+            # Flags sets take over defaults
+            flags.update(flags_set)
+
+            for i in flags:
                 if expand and i in expand:
                     flags[i] = self.expand(flags[i], var + "[" + i + "]")
         if len(flags) == 0:

-- 
2.48.1


