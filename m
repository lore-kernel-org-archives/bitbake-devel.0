Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75464C5320E
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 07:53:30 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.8454.1724313206023665150
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Aug 2024 00:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=avqkWQ6R;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 647059C5D86;
	Thu, 22 Aug 2024 03:53:25 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id uBTrkUHzsebI; Thu, 22 Aug 2024 03:53:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 0D22F9C60D2;
	Thu, 22 Aug 2024 03:53:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 0D22F9C60D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1724313205; bh=K1Vlnwpi7XAIQBj3P7onMHllRZDIFgL5oUF4NRBLPJk=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=avqkWQ6RZTB51XPlMRXLx3Lj5Ms5D3tkt2qIyj9aOWRcoS5gWyeczbJo5GzeuQNK5
	 Y7Jwd7XOJZdGF0Sw384+JCzllYIupmvVx6+bMnp/HbqEUhKHCjjG3aB5RPxse9TmNp
	 rf7dpka0h1et8s5BNuMrIJ2VCdJ+m1JWcUrQZUI5KQ1ebC0sgG3AIF5L1gzZw+FJDr
	 05SHrb9s+lkALlTTC8paQKmcaBdLRobXBHujztzvRhNoLmnjzM0FogIetU4QPH59CV
	 JRdyNVxx21+/+S2iHY+TCK7GTuGsGZLXoWOt5kw9p/4C5DeigrLDY9xSnXIFkJbhJp
	 GPKavqyFg2hcQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id K3RjRCqaRhOR; Thu, 22 Aug 2024 03:53:24 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 1F2269C5D86;
	Thu, 22 Aug 2024 03:53:24 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [bitbake-devel][PATCH v5 2/2] bitbake: fetch2: npmsw: allow packages not declaring a registry version
Date: Thu, 22 Aug 2024 09:53:15 +0200
Message-Id: <20240822075315.18570-3-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822075315.18570-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240822075315.18570-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 07:53:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16514

We fetch npm dependencies from the npm-shrinkwrap.json file. They can
point to a package on the NPM registry with a version field, or to a
git/http/file URL with the resolved field. Such packages are allowed not
to declare a registry version field because they may not have been
published to the NPM registry. The previous implementation refuses to
fetch such packages and throws an error.

The resolved field contains the exact source, including the revision,
wich we can use to pass as SRC_URI to the git/http/file fetcher. The
integrity field is also mandatory for HTTP tarballs which will ensure
reproducibility. So even if the version field is not present, we are
still fetching a precise revision of the package.

Another commit published along this stack is also required in the npm
class to support these packages.

v5:
 - improve commit message
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


