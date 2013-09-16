Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 016746C819
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM87O0029322; Mon, 16 Sep 2013 23:08:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WFENtq8HSTIC; Mon, 16 Sep 2013 23:08:09 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85OZ029304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjs-0002Zo-17; Mon, 16 Sep 2013 22:53:48 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:27 +0100
Message-Id: <1379368413-9808-10-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 10/16] data_smart: Allow flags to use the expand cache
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:01 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index bc4ad54..054b5cb 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -598,6 +598,8 @@ class DataSmart(MutableMapping):
             cachename = None
             if flag == "_content":
                 cachename = var
+            else:
+                cachename = var + "[" + flag + "]"
             value = self.expand(value, cachename)
         if value is not None and flag == "_content" and local_var is not None and "_removeactive" in local_var:
             filtered = filter(lambda v: v not in local_var["_removeactive"],
@@ -657,7 +659,7 @@ class DataSmart(MutableMapping):
                     continue
                 flags[i] = local_var[i]
                 if expand and i in expand:
-                    flags[i] = self.expand(flags[i], None)
+                    flags[i] = self.expand(flags[i], var + "[" + i + "]")
         if len(flags) == 0:
             return None
         return flags
-- 
1.8.1.2


