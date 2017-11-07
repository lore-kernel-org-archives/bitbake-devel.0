Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D28D978479
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Nov 2017 14:43:32 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	vA7EhVuo018147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 7 Nov 2017 14:43:32 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1eC56B-00040N-DZ; Tue, 07 Nov 2017 14:43:31 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Nov 2017 14:43:24 +0000
Message-Id: <1510065804-15357-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] tests/fetch: Add ftp test url
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
X-List-Received-Date: Tue, 07 Nov 2017 14:43:33 -0000

Add in a tets ftp url so we ensure ftp urls contnue to work after the loss
of the ftp.gnu.org ones.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index b07bf00..7d7c5d7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -837,6 +837,7 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://yoctoproject.org/documentation",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
+                      "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
                       "http://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
                       "https://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
                       "https://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
-- 
2.7.4


