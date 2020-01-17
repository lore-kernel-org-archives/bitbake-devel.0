Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 136907F9C4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 7058F9C045E;
	Fri, 17 Jan 2020 11:46:01 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id ZDsOZEeFgOJ2; Fri, 17 Jan 2020 11:46:00 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C3B969C044D;
	Fri, 17 Jan 2020 11:46:00 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id XWw6iaoKYgAs; Fri, 17 Jan 2020 11:46:00 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DD7CE9C042B;
	Fri, 17 Jan 2020 11:45:59 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:42 +0100
Message-Id: <20200117164548.28453-7-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 06/12] bitbake: fetch2: allow fetchers to forward the mirrors management
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:10 -0000
Content-Transfer-Encoding: quoted-printable

This commit is necessary to introduce proxy fetchers and do not modify
the behavior of existing fetchers.

This commit allows fetchers to forwards the "try_mirrors" functions to
a proxy fetcher.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/fetch2/__init__.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 45596bef..0d060e19 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1564,6 +1564,12 @@ class FetchMethod(object):
         """
         return True
=20
+    def try_mirrors(self, fetch, urldata, d, mirrors):
+        """
+        Try to use a mirror
+        """
+        return try_mirrors(fetch, d, urldata, mirrors)
+
     def checkstatus(self, fetch, urldata, d):
         """
         Check the status of a URL
@@ -1679,7 +1685,7 @@ class Fetch(object):
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
                     mirrors =3D mirror_from_string(self.d.getVar('PREMIR=
RORS'))
-                    localpath =3D try_mirrors(self, self.d, ud, mirrors,=
 False)
+                    localpath =3D m.try_mirrors(self, ud, self.d, mirror=
s)
                     if localpath:
                         try:
                             # early checksum verification so that if the=
 checksum of the premirror
@@ -1728,7 +1734,7 @@ class Fetch(object):
                             m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
                         mirrors =3D mirror_from_string(self.d.getVar('MI=
RRORS'))
-                        localpath =3D try_mirrors(self, self.d, ud, mirr=
ors)
+                        localpath =3D m.try_mirrors(self, ud, self.d, mi=
rrors)
=20
                 if not localpath or ((not os.path.exists(localpath)) and=
 localpath.find("*") =3D=3D -1):
                     if firsterr:
--=20
2.20.1


