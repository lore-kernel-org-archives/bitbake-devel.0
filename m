Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id CA1617F31F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Oct 2019 09:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 154CF9C0475;
	Tue, 22 Oct 2019 05:04:15 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id rNgTyS9MFTdV; Tue, 22 Oct 2019 05:04:14 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 768A49C0462;
	Tue, 22 Oct 2019 05:04:14 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id RqVyEKSFrlaF; Tue, 22 Oct 2019 05:04:14 -0400 (EDT)
Received: from sulaco.home (lfbn-1-7821-217.w92-167.abo.wanadoo.fr
	[92.167.224.217])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id C1D159C045F;
	Tue, 22 Oct 2019 05:04:13 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Oct 2019 11:04:07 +0200
Message-Id: <20191022090408.1368-2-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: brendan.le.foll@intel.com, paul.eggleton@linux.intel.com,
	rennes@savoirfairelinux.com
Subject: [RFC][PATCH 1/2] bitbake: utils.py: add sha384_file and sha512_file
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
X-List-Received-Date: Tue, 22 Oct 2019 09:04:14 -0000
Content-Transfer-Encoding: quoted-printable

This commit adds the "sha384_file" and "sha512_file" functions in order
to check the integrity of the downloaded npm packages as npm now use
Subresource Integrity:

  https://w3c.github.io/webappsec-subresource-integrity

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/utils.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d035949b..34152855 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -562,6 +562,30 @@ def sha1_file(filename):
             s.update(line)
     return s.hexdigest()
=20
+def sha384_file(filename):
+    """
+    Return the hex string representation of the SHA384 checksum of the f=
ilename
+    """
+    import hashlib
+
+    s =3D hashlib.sha384()
+    with open(filename, "rb") as f:
+        for line in f:
+            s.update(line)
+    return s.hexdigest()
+
+def sha512_file(filename):
+    """
+    Return the hex string representation of the SHA512 checksum of the f=
ilename
+    """
+    import hashlib
+
+    s =3D hashlib.sha512()
+    with open(filename, "rb") as f:
+        for line in f:
+            s.update(line)
+    return s.hexdigest()
+
 def preserved_envvars_exported():
     """Variables which are taken from the environment and placed in and =
exported
     from the metadata"""
--=20
2.20.1


