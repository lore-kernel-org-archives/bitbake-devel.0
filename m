Return-Path: <s.mueller-klieser@phytec.de>
X-Greylist: delayed 581 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 06 Nov 2014 12:14:39 UTC
Received: from root.phytec.de (mail.microcatalog.org.uk [217.6.246.34])
	by mail.openembedded.org (Postfix) with ESMTP id 5303072070
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Nov 2014 12:14:39 +0000 (UTC)
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
	by root.phytec.de (Postfix) with ESMTP id 90BB2A00323
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Nov 2014 13:05:08 +0100 (CET)
Received: from lws-mklieser.phytec.de ([172.16.10.21])
	by idefix.phytec.de (Lotus Domino Release 8.5.3FP6)
	with ESMTP id 2014110613045875-48249 ;
	Thu, 6 Nov 2014 13:04:58 +0100 
From: =?UTF-8?q?Stefan=20M=C3=BCller-Klieser?= <s.mueller-klieser@phytec.de>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 6 Nov 2014 13:03:38 +0100
Message-Id: <1415275418-8007-2-git-send-email-s.mueller-klieser@phytec.de>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1415275418-8007-1-git-send-email-s.mueller-klieser@phytec.de>
References: <1415275418-8007-1-git-send-email-s.mueller-klieser@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 8.5.3FP6|November
	21, 2013) at 06.11.2014 13:04:58,
	Serialize by Router on Idefix/Phytec(Release 8.5.3FP6|November 21,
	2013) at 06.11.2014 13:04:58
Subject: [PATCH 1/1] data_smart.py: fix variable splitting at _remove mechanism
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 06 Nov 2014 12:14:44 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

If we split variables only at whitespaces, a slipped in tab will render
a value unremovable.

Signed-off-by: Stefan M=C3=BCller-Klieser <s.mueller-klieser@phytec.de>
---
 lib/bb/data=5Fsmart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data=5Fsmart.py b/lib/bb/data=5Fsmart.py
index d862308..9a42a17 100644
--- a/lib/bb/data=5Fsmart.py
+++ b/lib/bb/data=5Fsmart.py
@@ -618,7 +618,7 @@ class DataSmart(MutableMapping):
         if value and flag =3D=3D "=5Fcontent" and local=5Fvar is not None =
and "=5Fremoveactive" in local=5Fvar:
             removes =3D [self.expand(r) for r in local=5Fvar["=5Fremoveact=
ive"]]
             filtered =3D filter(lambda v: v not in removes,
-                              value.split(" "))
+                              value.split())
             value =3D " ".join(filtered)
             if expand:
                  # We need to ensure the expand cache has the correct value
--=20
1.9.1


