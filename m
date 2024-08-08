Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845E8C52D7B
	for <webhook@archiver.kernel.org>; Thu,  8 Aug 2024 14:48:38 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.61814.1723128515231422132
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Aug 2024 07:48:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=cmsRigqt;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9413B9C2C58;
	Thu,  8 Aug 2024 10:48:34 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id xHB-KQkdgonN; Thu,  8 Aug 2024 10:48:34 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 08A859C5C98;
	Thu,  8 Aug 2024 10:48:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 08A859C5C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723128514; bh=lbO0pa2Jn02xTo78mAckk0NTSUOre2snBO97BCSOUuQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=cmsRigqtqpRFsxtNrOTCjNUXAMmniIYpdL+QsK3znIFn49Xj1yZvdZ1uAACbbkBMM
	 hy7RPEZzCnlHcNq5BKaop7fgTGNEaa2KDCINN3i2i2xdlxW2gZTnk0jbDZveqID19s
	 pqZ1mHbjv5etjirM6TbTe8e1/r3eqHA8c4yjr1viTrXPbTPgs/W1qNke/9ox2mL4n1
	 JikHwUlc760ksad2ktl2hYNUF5pc6EhOHFQx2K/3mb+18vKUMzIHxu3p+KAOIbfA4a
	 gbxOX+b33xV0uMCXMS2Bt2Fxp9Fr/ZAFHRdbSWHJ/F+22n+ilRKhVKytSlpTHJ5Tmf
	 WgtjaHmvZ4g7A==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Hcn8Ea10dvSu; Thu,  8 Aug 2024 10:48:33 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 19EB29C5BAF;
	Thu,  8 Aug 2024 10:48:33 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 2/6] npm: accept unspecified versions in package.json
Date: Thu,  8 Aug 2024 16:48:20 +0200
Message-Id: <20240808144824.543208-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808144824.543208-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240808144824.543208-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Aug 2024 14:48:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16455

Our current emulation mandates that the package.json contains a version
field. Some packages may not provide it when they are not published to
the registry. The actual `npm pack` would allow such packages, so
should we.

This patch adds a default value to allow building such packages.

This applies for instance to this package which doesn't declare a
version:
 - https://github.com/cockpit-project/cockpit/blob/23701a555a5af13f998ee4=
c7526d27fdb5669d63/package.json#L2

v3:
 - Split bitbake npmsw.py modification in another commit

Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 meta/classes-recipe/npm.bbclass | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meta/classes-recipe/npm.bbclass b/meta/classes-recipe/npm.bb=
class
index 91da3295f2..a73ff29be8 100644
--- a/meta/classes-recipe/npm.bbclass
+++ b/meta/classes-recipe/npm.bbclass
@@ -72,8 +72,10 @@ def npm_pack(env, srcdir, workdir):
         j =3D json.load(f)
=20
     # base does not really matter and is for documentation purposes
-    # only.  But the 'version' part must exist because other parts of
+    # only. But the 'version' part must exist because other parts of
     # the bbclass rely on it.
+    if 'version' not in j:
+        j['version'] =3D '0.0.0-unknown'
     base =3D j['name'].split('/')[-1]
     tarball =3D os.path.join(workdir, "%s-%s.tgz" % (base, j['version'])=
);
=20
--=20
2.34.1


