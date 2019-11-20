Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id CFCD57F867
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2019 09:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 197679C03AF;
	Wed, 20 Nov 2019 04:34:39 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 9yU5iJzIL8yH; Wed, 20 Nov 2019 04:34:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 77CEA9C0407;
	Wed, 20 Nov 2019 04:34:38 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id h89qkDgZledX; Wed, 20 Nov 2019 04:34:38 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A82349C0410;
	Wed, 20 Nov 2019 04:34:37 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Nov 2019 10:34:10 +0100
Message-Id: <20191120093412.11519-6-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v3 5/7] fetch2/npm.py: unpack the dependencies in a node_modules directory
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
X-List-Received-Date: Wed, 20 Nov 2019 09:34:38 -0000
Content-Transfer-Encoding: quoted-printable

This commit unpacks the dependencies in a node_modules directory in the
source tree. This is needed to allow license file management for all the
dependencies. This way the license files of the dependencies can be
tracked in the LIC_FILES_CHKSUM variable.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/npm.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index bd6e32ca..9beb84bf 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -325,16 +325,27 @@ def unpack_dependencies(d, shrinkwrap_file=3DNone):
         unpacked in the source tree and added to the npm cache.
     """
     bb.utils.remove(d.getVar("NPM_CACHE_DIR"), recurse=3DTrue)
+    bb.utils.remove(d.expand("${S}/node_modules/"), recurse=3DTrue)
=20
     def cache_dependency(tarball):
         cmd =3D "npm cache add '{}'".format(tarball)
         cmd +=3D d.expand(" --cache=3D${NPM_CACHE_DIR}")
         runfetchcmd(cmd, d)
=20
-    def handle_dependency(name, version, *unused):
+    def unpack_dependency(tarball, srctree):
+        cmd =3D "tar --extract --gzip --file=3D'{}'".format(tarball)
+        cmd +=3D " --no-same-owner"
+        cmd +=3D " --transform 's:^package/::'"
+        bb.utils.mkdirhier(srctree)
+        runfetchcmd(cmd, d, workdir=3Dsrctree)
+
+    def handle_dependency(name, version, deptree):
         url =3D _get_url(d, name, version)
         fetcher =3D bb.fetch2.Fetch([url], d)
         tarball =3D fetcher.localpath(url)
         cache_dependency(tarball)
+        relpath =3D os.path.join(*[os.path.join("node_modules", d) for d=
 in deptree])
+        abspath =3D os.path.join(d.getVar("S"), relpath)
+        unpack_dependency(tarball, abspath)
=20
     foreach_dependencies(d, handle_dependency, shrinkwrap_file)
--=20
2.20.1


