Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C20C41513
	for <webhook@archiver.kernel.org>; Thu,  4 Jul 2024 16:23:48 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.14230.1720110221961795309
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jul 2024 09:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=ratpSoRM;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4ABA09C57D2;
	Thu,  4 Jul 2024 12:23:41 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id jMiToq93O8H5; Thu,  4 Jul 2024 12:23:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8BFA99C5C6F;
	Thu,  4 Jul 2024 12:23:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8BFA99C5C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1720110220; bh=xoS5t+T7O5m1fzVdpWs5yqbgUURDaFF8MDl2PM00L9s=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=ratpSoRMhKbUfv0awwjcL6U/dXQf/qRNDQ+ipba3MlCtSJfMLZAA7RGMll50a7eT3
	 9CWyhX+m1Mpd8wDA04FdIYwgDBv6M8LzBlEY7OjBOx4CvFbtSLRSmOgGUJJwPERH47
	 crUlyYo1+nnPG43SYXvlFg9RlKKvYKUFiQ7NujvgHQrnQPRwFxvNZUYRcYoQnem+Ku
	 64OFcTMQrzMS3Mg4FeSpklDNdPFW9pasu7rypD/ZEU9cjxt+6s+1k/Uwf06cEjHIl6
	 RJirzyS7zCb/PIm39RLWnbKvMcH9WC+6rTlUu4DM0gbmx5eGx5SPqIKRS9HsNpqLqX
	 R1Hr6U+DbEaFQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id W8l9OCG8_prn; Thu,  4 Jul 2024 12:23:40 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CC9769C57D2;
	Thu,  4 Jul 2024 12:23:39 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH 2/2] npm: accept unspecified versions in package.json
Date: Thu,  4 Jul 2024 18:23:33 +0200
Message-Id: <20240704162333.1497107-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704162333.1497107-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240704162333.1497107-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jul 2024 16:23:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16390

Our current emulation mandates that the package.json contains a version
field. Some packages may not provide it when they are not published to
the registry. The actual `npm pack` would allow such packages, so
should we.

This patch adds default values to allow building such packages.
For the shrinkwrap, we can actually use the resolved field which
contains the exact source, including the revision, to pass integrity
tests.

This applies for instance to this package which doesn't declare a
version:
 - https://github.com/cockpit-project/cockpit/blob/23701a555a5af13f998ee4=
c7526d27fdb5669d63/package.json#L2

Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 bitbake/lib/bb/fetch2/npmsw.py  | 2 +-
 meta/classes-recipe/npm.bbclass | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
index 018e0ad546..044f5b96f8 100644
--- a/bitbake/lib/bb/fetch2/npmsw.py
+++ b/bitbake/lib/bb/fetch2/npmsw.py
@@ -97,7 +97,7 @@ class NpmShrinkWrap(FetchMethod):
=20
             integrity =3D params.get("integrity", None)
             resolved =3D params.get("resolved", None)
-            version =3D params.get("version", None)
+            version =3D params.get("version", params.get("resolved", Non=
e))
=20
             # Handle registry sources
             if is_semver(version) and integrity:
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


