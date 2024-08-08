Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8583DC52D7D
	for <webhook@archiver.kernel.org>; Thu,  8 Aug 2024 14:48:38 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.61878.1723128516087162122
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Aug 2024 07:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=EIUocR1+;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6CA049C5FBB;
	Thu,  8 Aug 2024 10:48:35 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id F1bUFwtxgF7m; Thu,  8 Aug 2024 10:48:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 15EC19C5FB8;
	Thu,  8 Aug 2024 10:48:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 15EC19C5FB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723128515; bh=Bwfw3CXLZVYVtln2c60/nVP7y+6OwDouDuxGZil+684=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=EIUocR1+NXlZiROVboOCDEocdTCaEavdcl+FTEaKkcPYVFLvYJERHch4JweKdlNQZ
	 4lxPuGPwdoPyD4TsWUfENQgsF5v0fRctJwFQ2f4W2wBWXrZzJVytlkMzEHGpRs4SOt
	 PvzBH5UIjyAVJyS9k42UXX9mJWBLMqvVG4x8zhBCUdoO1FISlq0OZQplqN39ZeIvUz
	 eKEBTSu5tM208djwq17iAWOVcth7TE6+/1FUBxj/uiU27D+QE8EWN+yig+Jr/iGtmr
	 j58wh8TtnZYi9FeULdMJ0m0oOfW6NURB+Pz7srX03cqBJoqopqVZK0BhIiQM1xKcr4
	 4HOVEmuj3NTFg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 6GkcmOKpP_E9; Thu,  8 Aug 2024 10:48:35 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 279D59C5FA1;
	Thu,  8 Aug 2024 10:48:34 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v3 3/6] npmsw: accept unspecified versions in package.json
Date: Thu,  8 Aug 2024 16:48:21 +0200
Message-Id: <20240808144824.543208-4-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808144824.543208-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240808144824.543208-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Aug 2024 14:48:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16456

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
index 018e0ad546..78ce6c3a8d 100644
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


