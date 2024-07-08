Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7A1C3DA46
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 13:34:08 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.79799.1720445645423304066
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 06:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=muw896fT;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C1E629C5D3D;
	Mon,  8 Jul 2024 09:34:04 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id hEPQnUTb8cnw; Mon,  8 Jul 2024 09:34:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 004939C5C96;
	Mon,  8 Jul 2024 09:34:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 004939C5C96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1720445644; bh=j/U0qvHgxP65CxULR8l/S9mx7FiuqQQE6DBnWuFIXMU=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=muw896fT4n5zj1+xwcXIHgJ9hJdtLPyrtbOAG/W/ATI8dA02HpnHG8jCzJ2za0sl9
	 OPpPILqHTrjjuVO7t5+McQ9etpQmoRvClKvffN7Lj5Y8DYdyolRREY/4QOE1E7PEFx
	 izsTWbwUT2WZrf5LrnYj2gFQG4g0id5RsJJpTxiKjelDUCvR8H0kq6iTQtKBOoF6s2
	 16d519PvoFPF7qBO8GIGYkfXkU/CtFyLgS2X9dfpLu4lUqPgi5UQWhNF55lloBMD3h
	 xZd6p2WlN001Iyd9chJWgWYiL6eL3XA6jVGZn+pDyNje9J34NKmAMDzeDq9iZr/EsC
	 /rIF4Ne6b7mZA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0jcCT_pYwRwA; Mon,  8 Jul 2024 09:34:03 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 4112C9C5D1A;
	Mon,  8 Jul 2024 09:34:03 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v2 1/4] bitbake: fetch2: npmsw: fix fetching git revisions not on master
Date: Mon,  8 Jul 2024 15:33:54 +0200
Message-Id: <20240708133357.306422-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 13:34:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16402

The NPM package.json documentation[1] states that git URLs may contain
a commit-ish suffix to specify a specific revision. When running
`npm install`, this revision will be looked for on any branch of the
repository.

The bitbake implementation however translates the URL stored in
package.json into a git URL to be fetch by the bitbake git fetcher. The
bitbake fetcher git.py, enforces the branch to be master by default. If
the revision specified in the package.json is not on the master branch,
the fetch will fail while the package.json is valid.

To fix this, append the ";nobranch=3D1" suffix to the revision in the git
URL to be fetched. This will make the bitbake git fetcher ignore the
branch and respect the behavior of `npm install``.

This can be tested with the following command:
 $ devtool add --npm-dev https://github.com/seapath/cockpit-cluster-dashb=
oard.git -B version
Which points to a project which has a package.json with a git URL:
```json
  "devDependencies": {
    "cockpit-repo": "git+https://github.com/cockpit-project/cockpit.git#d=
34cabacb8e5e1e028c7eea3d6e3b606d862b8ac"
  }
```
In this repo, the specified revision is on the "main" branch, which
would fail without this fix.

[1] https://docs.npmjs.com/cli/v10/configuring-npm/package-json#git-urls-=
as-dependencies

Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 bitbake/lib/bb/fetch2/npmsw.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/npmsw.py b/bitbake/lib/bb/fetch2/npmsw=
.py
index ff5f8dc755..018e0ad546 100644
--- a/bitbake/lib/bb/fetch2/npmsw.py
+++ b/bitbake/lib/bb/fetch2/npmsw.py
@@ -184,6 +184,7 @@ class NpmShrinkWrap(FetchMethod):
                 uri =3D URI("git://" + str(groups["url"]))
                 uri.params["protocol"] =3D str(groups["protocol"])
                 uri.params["rev"] =3D str(groups["rev"])
+                uri.params["nobranch"] =3D "1"
                 uri.params["destsuffix"] =3D destsuffix
=20
                 url =3D str(uri)
--=20
2.34.1


