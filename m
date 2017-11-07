Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B13F478484
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Nov 2017 14:44:01 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vA7Ei10u018197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 7 Nov 2017 14:44:02 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eC56f-00041N-1b; Tue, 07 Nov 2017 14:44:01 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Nov 2017 14:44:00 +0000
Message-Id: <1510065840-15419-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] tests/fetch: Switch gnu.org urls from ftp -> http/https
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
X-List-Received-Date: Tue, 07 Nov 2017 14:44:02 -0000

The ftp server at ftp.gnu.org is likely to be retired at some point soon
so siwtch over to the http/https services.

This means bitbake-selftest doesn't have ftp test urls, however finding stable
ftp test servers is proving increasingly hard.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 154bf17..f1799a7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -837,9 +837,9 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://yoctoproject.org/documentation",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
-                      "ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
-                      "ftp://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
-                      "ftp://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
+                      "http://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
+                      "https://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
+                      "https://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
                       # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
-- 
2.7.4


