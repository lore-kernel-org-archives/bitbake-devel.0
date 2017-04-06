Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4A4EA77BFD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Apr 2017 11:24:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v36BOP5M002224; 
	Thu, 6 Apr 2017 12:24:43 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XeMjrHl5W8u0; Thu,  6 Apr 2017 12:24:43 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v36BOQ5J002234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 6 Apr 2017 12:24:27 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cw5Wc-0002Uy-EV; Thu, 06 Apr 2017 12:24:26 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Apr 2017 12:24:25 +0100
Message-Id: <1491477865-9566-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] Bump version to 1.33.4
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
X-List-Received-Date: Thu, 06 Apr 2017 11:24:45 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake        | 2 +-
 lib/bb/__init__.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 787d4fd..10115d2 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -38,7 +38,7 @@ from bb.main import bitbake_main, BitBakeConfigParameters, BBMainException
 if sys.getfilesystemencoding() != "utf-8":
     sys.exit("Please use a locale setting which supports utf-8.\nPython can't change the filesystem locale after loading so we need a utf-8 when python starts or things won't work.")
 
-__version__ = "1.33.3"
+__version__ = "1.33.4"
 
 if __name__ == "__main__":
     if __version__ != bb.__version__:
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 42977d0..b3567b1 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.33.3"
+__version__ = "1.33.4"
 
 import sys
 if sys.version_info < (3, 4, 0):
-- 
2.7.4


