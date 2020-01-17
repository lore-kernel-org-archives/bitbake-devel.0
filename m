Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9D8E67FA24
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 91D229C01D1;
	Fri, 17 Jan 2020 11:45:56 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 9ohvZitMvGum; Fri, 17 Jan 2020 11:45:56 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 053BB9C0424;
	Fri, 17 Jan 2020 11:45:56 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id Izu4Lt9f5dWI; Fri, 17 Jan 2020 11:45:55 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 19E3B9C01D1;
	Fri, 17 Jan 2020 11:45:55 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:37 +0100
Message-Id: <20200117164548.28453-2-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 01/12] bitbake: utils: add sha384_file and sha512_file functions
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

The npm fetcher needs these functions to support the subresource
integrity: https://www.w3.org/TR/SRI/

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/utils.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d65265c4..e5d19acf 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -557,6 +557,20 @@ def sha1_file(filename):
     import hashlib
     return _hasher(hashlib.sha1(), filename)
=20
+def sha384_file(filename):
+    """
+    Return the hex string representation of the SHA384 checksum of the f=
ilename
+    """
+    import hashlib
+    return _hasher(hashlib.sha384(), filename)
+
+def sha512_file(filename):
+    """
+    Return the hex string representation of the SHA512 checksum of the f=
ilename
+    """
+    import hashlib
+    return _hasher(hashlib.sha512(), filename)
+
 def preserved_envvars_exported():
     """Variables which are taken from the environment and placed in and =
exported
     from the metadata"""
--=20
2.20.1


