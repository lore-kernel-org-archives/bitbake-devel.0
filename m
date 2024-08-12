Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB467C531DC
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:28:44 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.44996.1723465719439957078
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:28:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=adLBueth;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C1BF29C5F1F;
	Mon, 12 Aug 2024 08:28:38 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id H1AGxTbJbR-t; Mon, 12 Aug 2024 08:28:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C199A9C5DB6;
	Mon, 12 Aug 2024 08:28:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com C199A9C5DB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465717; bh=lbO0pa2Jn02xTo78mAckk0NTSUOre2snBO97BCSOUuQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=adLBuethw3SINeCVcS5p1dh9snUI0NDKVHz9VPv7c9YH/KsvHSGozeadM1aQXl2qK
	 HS2T6U/i3HBcawjL5aTQWmpSFaRCKzabHWyx3PndpxcaKbmMle6glnfRClnI/e6Y88
	 tvjruVS6T3DTA6s5zvKz4sqjigX/8ufFTTOIpt0eK/MAXTVWGYoZQBw4tY2fs/yRCu
	 hlHqIfWnMl6DrfwgrWYyg2T63XytUV9fQAqxOIGiKrRW++3blWTlIr6nnOsiF1Vuah
	 bEP0LEX2jMIA73vctiyrq8QnjJ3rz0HnS/fUjmETRj+904zHeG+SA71Omx62mzTWM9
	 kvLBq+U3+f4eg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RhOJXfBsdTF8; Mon, 12 Aug 2024 08:28:37 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id D31249C5E53;
	Mon, 12 Aug 2024 08:28:36 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [OE-core][PATCH v4 1/4] npm: accept unspecified versions in package.json
Date: Mon, 12 Aug 2024 14:28:26 +0200
Message-Id: <20240812122829.577515-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240812122829.577515-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:28:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16467

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


