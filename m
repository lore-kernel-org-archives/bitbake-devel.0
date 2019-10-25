Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id DDE227FA63
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Oct 2019 08:39:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 23B689C0332;
	Fri, 25 Oct 2019 04:39:34 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id G3YxmDnALz-H; Fri, 25 Oct 2019 04:39:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8A13A9C02FE;
	Fri, 25 Oct 2019 04:39:33 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id IEGt5pR7r58O; Fri, 25 Oct 2019 04:39:33 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id B9F479C0325;
	Fri, 25 Oct 2019 04:39:32 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Oct 2019 10:39:23 +0200
Message-Id: <20191025083925.14535-2-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20191025083925.14535-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [RFC][PATCH v2 1/3] bitbake: utils.py: add sha384_file and sha512_file
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
X-List-Received-Date: Fri, 25 Oct 2019 08:39:33 -0000
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


