Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5FEC531DC
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:25:54 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.44946.1723465551625059556
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:25:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YG7Jd06g;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id E4EC19C5480;
	Mon, 12 Aug 2024 08:25:50 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id ncgeoTGiNwKj; Mon, 12 Aug 2024 08:25:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 91E5B9C56BD;
	Mon, 12 Aug 2024 08:25:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 91E5B9C56BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465550; bh=WsjllNXlLq/9nlH/srxN3thv5rIgJ/kZlEAKWFhWAjU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YG7Jd06gVvnaC9GajO0/xOmQDeSdk3JNCmf281QgEaqUZaXrjyi4VbX763aLg5acr
	 SEiIILs2xQH5oWPh9NqTP9FTNP1t6Z3AB3WL6wNenDu0kdw1/VcZakN9KKxjPMgBX/
	 PYwd2BI1X4ysBzEftVIE7JN5CKRICn7w6h5oAqiwGv4FNpCUjWLcay/G800ST+FnLN
	 /RcOYHUo+1JixJYne0wm8OZiiF4PaEU+/wGdv3u162jl1F4eBlxj1dVl4IpDkzmnrY
	 vcAk4S0cr/c7PNcpz6d/u1PtyNQy2oY5ca7W88tMCDw11HK9ap6t0wPxySFXacxYXh
	 i9s2SAvsEkCJw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id eO_k8Y1Y-Nxb; Mon, 12 Aug 2024 08:25:50 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 99AE49C5480;
	Mon, 12 Aug 2024 08:25:49 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [bitbake-devel][PATCH v4 2/2] npmsw: accept unspecified versions in package.json
Date: Mon, 12 Aug 2024 14:25:39 +0200
Message-Id: <20240812122539.573337-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16464

Our current emulation mandates that the package.json contains a version
field. Some packages may not provide it when they are not published to
the registry. The actual `npm pack` would allow such packages, so
should we.

A first commit was required in the npm class.

For the shrinkwrap part , we can actually use the resolved field which
contains the exact source, including the revision, to pass integrity
tests.

v3:
 - Split bitbake npmsw.py modification in another commit

Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 bitbake/lib/bb/fetch2/npmsw.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
index d8ed9df327..a5fa598deb 100644
--- a/bitbake/lib/bb/fetch2/npmsw.py
+++ b/bitbake/lib/bb/fetch2/npmsw.py
@@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
=20
             integrity =3D params.get("integrity", None)
             resolved =3D params.get("resolved", None)
-            version =3D params.get("version", None)
+            version =3D params.get("version", resolved)
=20
             # Handle registry sources
             if is_semver(version) and integrity:
--=20
2.34.1


