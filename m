Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 24C327FD80
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jan 2020 17:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5C5439C02ED;
	Fri, 24 Jan 2020 12:08:23 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id wapl_POGbdsr; Fri, 24 Jan 2020 12:08:22 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AB4089C02D7;
	Fri, 24 Jan 2020 12:08:22 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id iMQHYaTX1cKz; Fri, 24 Jan 2020 12:08:22 -0500 (EST)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AFFA59C02ED;
	Fri, 24 Jan 2020 12:08:21 -0500 (EST)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jan 2020 18:08:04 +0100
Message-Id: <20200124170814.20510-3-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
References: <20200124170814.20510-1-jean-marie.lemetayer@savoirfairelinux.com>
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com, rennes-dev@savoirfairelinux.com
Subject: [PATCH v6 02/12] utils: add is_semver function
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
X-List-Received-Date: Fri, 24 Jan 2020 17:08:22 -0000
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
index 28368f0a..47805d02 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1611,3 +1611,29 @@ class LogCatcher(logging.Handler):
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


