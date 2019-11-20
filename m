Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 530167F88E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2019 09:34:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8FACA9C0420;
	Wed, 20 Nov 2019 04:34:37 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 6q7hWwq-3u75; Wed, 20 Nov 2019 04:34:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B61409C0410;
	Wed, 20 Nov 2019 04:34:36 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id Ph_KmcUQg-Od; Wed, 20 Nov 2019 04:34:36 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id EDB219C03AF;
	Wed, 20 Nov 2019 04:34:35 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Nov 2019 10:34:08 +0100
Message-Id: <20191120093412.11519-4-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191120093412.11519-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v3 3/7] fetch2/npm.py: restrict version parameter
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
X-List-Received-Date: Wed, 20 Nov 2019 09:34:36 -0000
Content-Transfer-Encoding: quoted-printable

The npm command allows version to be actual versions, tags or ranges.
The fetcher must be more restrictive and only allows fixed versions
(which are following the semver specification [1]).

The 'latest' tag which is automatically set to the latest published
version is also allowed to make the use of the 'devtool add' command
easier.

1: https://semver.org/spec/v2.0.0.html

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/npm.py | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index e377d18a..e253cf3e 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -46,6 +46,33 @@ class Npm(FetchMethod):
         """
         return ud.type in ['npm']
=20
+    @staticmethod
+    def _is_semver(version):
+        """
+            Is the version string following the semver semantic?
+
+            https://semver.org/spec/v2.0.0.html
+        """
+        regex =3D re.compile(
+        r"""
+        ^
+        (0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)
+        (?:-(
+            (?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)
+            (?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*
+        ))?
+        (?:\+(
+            [0-9a-zA-Z-]+
+            (?:\.[0-9a-zA-Z-]+)*
+        ))?
+        $
+        """, re.VERBOSE)
+
+        if regex.match(version) is None:
+            return False
+
+        return True
+
     def urldata_init(self, ud, d):
         """
             Init npm specific variables within url data
@@ -65,6 +92,9 @@ class Npm(FetchMethod):
         if not ud.version:
             raise MissingParameterError("Parameter 'version' required", =
ud.url)
=20
+        if not self._is_semver(ud.version) and not ud.version =3D=3D "la=
test":
+            raise ParameterError("Parameter 'version' is invalid", ud.ur=
l)
+
         # Get the 'registry' part of the url
         registry =3D re.sub(r"^npm://", "", ud.url.split(";")[0])
         ud.registry =3D "http://" + registry
@@ -96,6 +126,18 @@ class Npm(FetchMethod):
             ud.basecmd +=3D " --passive-ftp"
             ud.basecmd +=3D " --no-check-certificate"
=20
+    def need_update(self, ud, d):
+        """
+            Force a fetch, even if localpath exists?
+        """
+        if ud.version =3D=3D "latest":
+            return True
+
+        if os.path.exists(ud.localpath):
+            return False
+
+        return True
+
     @staticmethod
     def _run_npm_view(ud, d):
         """
@@ -158,6 +200,14 @@ class Npm(FetchMethod):
         integrity =3D view.get("dist", {}).get("integrity")
         shasum =3D view.get("dist", {}).get("shasum")
=20
+        # Check if version is valid
+        if ud.version =3D=3D "latest":
+            bb.warn("The npm package '{}' is using the latest version " =
\
+                    "available. This could lead to non-reproducible " \
+                    "builds.".format(ud.name))
+        elif ud.version !=3D view.get("version"):
+            raise ParameterError("Parameter 'version' is invalid", ud.ur=
l)
+
         cmd =3D ud.basecmd
=20
         bb.utils.mkdirhier(os.path.dirname(ud.localpath))
--=20
2.20.1


