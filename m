Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 18A5D7737C
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48O007485; Wed, 1 Jun 2016 13:37:07 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Z49084EEF-h1; Wed,  1 Jun 2016 13:37:06 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51CaxXx007447
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000nZ-7y; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:24 +0100
Message-Id: <1464784607-2985-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 05/28] data_smart: Simplify ExpansionError exception
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:09 -0000

This seemingly convoluted syntax doesn't work in python3. Instead
use the chained exception handling syntax which appears to make more
sense here.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 2a61386..25c412c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -397,8 +397,7 @@ class DataSmart(MutableMapping):
             except bb.parse.SkipRecipe:
                 raise
             except Exception as exc:
-                exc_class, exc, tb = sys.exc_info()
-                raise ExpansionError, ExpansionError(varname, s, exc), tb
+                raise ExpansionError(varname, s, exc) from exc
 
         varparse.value = s
 
-- 
2.5.0


