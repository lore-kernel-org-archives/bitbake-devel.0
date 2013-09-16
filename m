Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id AAFCD6C900
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:04 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM884R029330; Mon, 16 Sep 2013 23:08:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hZtWBvf4bVDT; Mon, 16 Sep 2013 23:08:12 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM865v029310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:07 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjs-0002aI-Kz; Mon, 16 Sep 2013 22:53:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:33 +0100
Message-Id: <1379368413-9808-16-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 16/16] bitbake: bb: Drop deprecated functions
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:05 -0000

These functions in the main bb module have long been deprecated
and moved to other modules. Finally remove the compatibility links.

(Bitbake rev: ccd181c3ed4852e2b9169cf19aaf18aeacddcc18)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 018b744..8a23a0f 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -140,6 +140,3 @@ def deprecate_import(current, modulename, fromlist, renames = None):
 
         setattr(sys.modules[current], newname, newobj)
 
-deprecate_import(__name__, "bb.fetch", ("MalformedUrl", "encodeurl", "decodeurl"))
-deprecate_import(__name__, "bb.utils", ("mkdirhier", "movefile", "copyfile", "which"))
-deprecate_import(__name__, "bb.utils", ["vercmp_string"], ["vercmp"])
-- 
1.8.1.2


