Return-Path: <public@smn.dk>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935FCC77B75
	for <webhook@archiver.kernel.org>; Tue, 18 Apr 2023 20:50:55 +0000 (UTC)
Received: from server6121.serverpark.dk (server6121.serverpark.dk [80.208.28.131])
 by mx.groups.io with SMTP id smtpd.web10.21485.1681851046481608628
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Apr 2023 13:50:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: smn.dk, ip: 80.208.28.131, mailfrom: public@smn.dk)
Received: from localhost (unknown [127.0.0.1])
	by server6121.serverpark.dk (Postfix) with ESMTP id 3A9523B409D7
	for <bitbake-devel@lists.openembedded.org>; Tue, 18 Apr 2023 20:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at server6121.serverpark.dk
Received: from server6121.serverpark.dk ([127.0.0.1])
	by localhost (server6121.serverpark.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s0fIi_ak-PXb; Tue, 18 Apr 2023 22:50:35 +0200 (CEST)
Received: from dk-svni-01-7770.nktri.local (130228029038.mbb.telenor.dk [130.228.29.38])
	(Authenticated sender: public@smn.dk)
	by server6121.serverpark.dk (Postfix) with ESMTPSA id 2578F3B407B2;
	Tue, 18 Apr 2023 22:50:18 +0200 (CEST)
From: Svend Meyland Nicolaisen <public@smn.dk>
To: bitbake-devel@lists.openembedded.org
Cc: Svend Meyland Nicolaisen <public@smn.dk>
Subject: [PATCH v2] npmsw fetcher: Avoid instantiating Fetch class if url list is empty
Date: Tue, 18 Apr 2023 22:49:27 +0200
Message-Id: <20230418204928.993-1-public@smn.dk>
X-Mailer: git-send-email 2.40.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Apr 2023 20:50:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14717

Recipes containing both git and npmsw sources in the SRC_URI fail
during fetch from the shrinkwrap. It seems that when the fetcher is
fetching from the shrinkwrap, the SRCREV variable has been deleted but it
till ends up fetching from the git source resulting in an error because
SRCREV is undefined. The root cause of this is that the Fetch class defau=
lts
to urls from the SRC_URI when the urls parameter contains an empty list. =
This
patch will ensure that Fetch is not instantiated if the urls list is empt=
y.

Signed-off-by: Svend Meyland Nicolaisen <public@smn.dk>
---
 lib/bb/fetch2/npmsw.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 36fcbfba..cc81100b 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -205,7 +205,9 @@ class NpmShrinkWrap(FetchMethod):
         # This fetcher resolves multiple URIs from a shrinkwrap file and=
 then
         # forwards it to a proxy fetcher. The management of the donestam=
p file,
         # the lockfile and the checksums are forwarded to the proxy fetc=
her.
-        ud.proxy =3D Fetch([dep["url"] for dep in ud.deps if dep["url"]]=
, data)
+        shrinkwrap_urls =3D [dep["url"] for dep in ud.deps if dep["url"]=
]
+        if shrinkwrap_urls:
+            ud.proxy =3D Fetch(shrinkwrap_urls, data)
         ud.needdonestamp =3D False
=20
     @staticmethod
--=20
2.40.0.windows.1


