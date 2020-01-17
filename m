Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
X-Greylist: delayed 375 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 17 Jan 2020 16:52:09 UTC
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 9C9A27FA21
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2020 16:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 9B4EB9C0421;
	Fri, 17 Jan 2020 11:45:57 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id fqpnO4Y_ro_i; Fri, 17 Jan 2020 11:45:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EA73D9C0423;
	Fri, 17 Jan 2020 11:45:56 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id i9V63v3wIPpF; Fri, 17 Jan 2020 11:45:56 -0500 (EST)
Received: from sulaco.example.com (40.73.12.109.rev.sfr.net [109.12.73.40])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 113FD9C0421;
	Fri, 17 Jan 2020 11:45:55 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Jan 2020 17:45:38 +0100
Message-Id: <20200117164548.28453-3-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200117164548.28453-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: rennes-dev@savoirfairelinux.com, paul.eggleton@linux.intel.com
Subject: [PATCH v4 02/12] bitbake: utils: add is_semver function
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
X-List-Received-Date: Fri, 17 Jan 2020 16:52:09 -0000
Content-Transfer-Encoding: quoted-printable

This function checks if a string is a semantic version:
    https://semver.org/spec/v2.0.0.html

The npm fetcher needs this function to validate its version parameter.

Signed-off-by: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinu=
x.com>
---
 lib/bb/utils.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index e5d19acf..7571d8d9 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1575,3 +1575,29 @@ class LogCatcher(logging.Handler):
         self.messages.append(bb.build.logformatter.format(record))
     def contains(self, message):
         return (message in self.messages)
+
+def is_semver(version):
+    """
+        Is the version string following the semver semantic?
+
+        https://semver.org/spec/v2.0.0.html
+    """
+    regex =3D re.compile(
+    r"""
+    ^
+    (0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)
+    (?:-(
+        (?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)
+        (?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*
+    ))?
+    (?:\+(
+        [0-9a-zA-Z-]+
+        (?:\.[0-9a-zA-Z-]+)*
+    ))?
+    $
+    """, re.VERBOSE)
+
+    if regex.match(version) is None:
+        return False
+
+    return True
--=20
2.20.1


