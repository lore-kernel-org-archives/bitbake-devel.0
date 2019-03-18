Return-Path: <prvs=973ddaea1=Stefan.Klug@baslerweb.com>
Received: from mail01.baslerweb.com (mail01.baslerweb.com [80.156.24.166])
	by mail.openembedded.org (Postfix) with ESMTP id F087F7C6B5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Mar 2019 14:08:26 +0000 (UTC)
Received: from unknown (HELO ahr206s.basler.corp) ([172.16.20.206])
	by mail01-out.baslerweb.com with ESMTP; 18 Mar 2019 14:58:35 +0100
From: Stefan Klug <stefan.klug@baslerweb.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Mar 2019 14:58:19 +0100
Message-ID: <20190318135820.7344-3-stefan.klug@baslerweb.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318135820.7344-1-stefan.klug@baslerweb.com>
References: <20190318135820.7344-1-stefan.klug@baslerweb.com>
MIME-Version: 1.0
X-Originating-IP: [172.16.85.155]
X-ClientProxiedBy: ahr206s.basler.corp (172.16.20.206) To ahr206s.basler.corp
	(172.16.20.206)
X-C2ProcessedOrg: edc209ba-7b98-423a-8e4d-b8fa22bc0743
Subject: [PATCH 2/3] fetch2: Gracefully handle corrupt download-cache tarballs
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
X-List-Received-Date: Mon, 18 Mar 2019 14:08:27 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

If the fullmirror tarball is corrupt for whatever reason
(IMHO there are no checksums on the download cache)
a series of nasty events was triggered:
- tar left a partially extracted bare git repo there
- on the next yocto build, the corrupt bare repo is
  found and bitbake starts to update that bare repo using git
- git fails to detect it as bare repo. Therefore
  all following git commands ripple up the directory tree,
  in our case modifying a top level git repo.

Signed-off-by: Stefan Klug <stefan.klug@baslerweb.com>
---
 lib/bb/fetch2/git.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 1a8ebe3d..d5f9bbcd 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -334,8 +334,11 @@ class Git(FetchMethod):
             ud.localpath =3D ud.fullshallow
             return
         elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clone=
dir):
-            bb.utils.mkdirhier(ud.clonedir)
-            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud.clo=
nedir)
+            try:
+                bb.utils.mkdirhier(ud.clonedir)
+                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud=
.clonedir, cleanup=3D[ud.clonedir])
+            except:
+                logger.info("Extracting tarball of git repository failed, =
falling back to clone.")
=20
         repourl =3D self._get_repo_url(ud)
=20
--=20



