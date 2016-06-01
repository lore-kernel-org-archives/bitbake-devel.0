Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 2D3B3773CF
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48N007485; Wed, 1 Jun 2016 13:37:06 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZcogXJ6uiOgb; Wed,  1 Jun 2016 13:37:06 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxGo007461
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000oo-FZ; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:38 +0100
Message-Id: <1464784607-2985-19-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 19/28] toaster: read timezone files in binary mode
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used 'rb' mode to open files to avoid unicode error when code
runs on python 3:
   UnicodeDecodeError: 'utf-8' codec can't decode byte 0x80
                       in position 44: invalid start byte

[YOCTO #9584]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/toastermain/settings.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index c7edff2..3dfa2b2 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -87,17 +87,16 @@ else:
             try:
                 import pytz
                 from pytz.exceptions import UnknownTimeZoneError
-                pass
                 try:
                     if pytz.timezone(zonename) is not None:
-                        zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+                        zonefilelist[hashlib.md5(open(filepath, 'rb').read()).hexdigest()] = zonename
                 except UnknownTimeZoneError as ValueError:
                     # we expect timezone failures here, just move over
                     pass
             except ImportError:
-                zonefilelist[hashlib.md5(open(filepath).read()).hexdigest()] = zonename
+                zonefilelist[hashlib.md5(open(filepath, 'rb').read()).hexdigest()] = zonename
 
-    TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime').read()).hexdigest()]
+    TIME_ZONE = zonefilelist[hashlib.md5(open('/etc/localtime', 'rb').read()).hexdigest()]
 
 # Language code for this installation. All choices can be found here:
 # http://www.i18nguy.com/unicode/language-identifiers.html
-- 
2.5.0


