Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF8AC52D7C
	for <webhook@archiver.kernel.org>; Mon, 12 Aug 2024 12:25:54 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.44943.1723465552087597337
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Aug 2024 05:25:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=s9WglGME;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5EA379C5D4F;
	Mon, 12 Aug 2024 08:25:51 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id A9bxW5WUb6cx; Mon, 12 Aug 2024 08:25:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7F5E89C5C98;
	Mon, 12 Aug 2024 08:25:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 7F5E89C5C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1723465549; bh=zzxcbdv9xw6FetVB3J/GbPt7URvvc3TfqrxxCQNaFuY=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=s9WglGMEUEQJHXjOdu+vFcAuztFImj2ln4sXlYUT4fpt7mEOVCZ2BpFdAL4uGIt+H
	 YY6//WNCn4jLeKzKRNTDK3opQeZiv/p4m8IrCceP5vrPMqENqvCdgdFJNVNQp+/+Yd
	 HTwEivOxmaf+52gVjXdclb8+fvpW9RmPYvEFcJCPMD0Ry5kQOr8ESCjz8CbE9YLvsp
	 UIKCmkpTNZFvrE6LeTQT8GMi40ShJHQCivCdbTMYkivMYYl62Jfv6TWRmicyZ9k/De
	 l4yiUqOlHOOyeQxJDMuL50Gy1Ls9iwq2YO1gjdwnAIeNnmRMA/mapQUvnw2c/UrNQd
	 AD56sFZre+7Ww==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id QQ2fVBffakWo; Mon, 12 Aug 2024 08:25:49 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 8CA9B9C56BD;
	Mon, 12 Aug 2024 08:25:48 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	alexandre.belloni@bootlin.com,
	stefan.herbrechtsmeier@weidmueller.com,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [bitbake-devel][PATCH v4 1/2] bitbake: fetch2: npmsw: fix fetching git revisions not on master
Date: Mon, 12 Aug 2024 14:25:38 +0200
Message-Id: <20240812122539.573337-2-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240812122539.573337-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Aug 2024 12:25:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16465

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
index b55e885d7b..d8ed9df327 100644
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


