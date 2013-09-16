Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C958360FED
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:00 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM884M029330; Mon, 16 Sep 2013 23:08:08 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gq2SycrCH-qW; Mon, 16 Sep 2013 23:08:08 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM852n029300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjr-0002ZU-Ge; Mon, 16 Sep 2013 22:53:47 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:23 +0100
Message-Id: <1379368413-9808-6-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 06/16] data: Use direct iteration, not keys()
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

Profiling shows the creation of keys() has overhead and we're better using
an iterator rather than the memory associated with the huge list of keys
when iterating the whoe datastore. We minimise the number of times
we do this to twice only per recipe.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index e6d5232..beaf089 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -148,7 +148,7 @@ def expandKeys(alterdata, readdata = None):
         readdata = alterdata
 
     todolist = {}
-    for key in keys(alterdata):
+    for key in alterdata:
         if not '${' in key:
             continue
 
@@ -341,7 +341,7 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
 
 def generate_dependencies(d):
 
-    keys = set(key for key in d.keys() if not key.startswith("__"))
+    keys = set(key for key in d if not key.startswith("__"))
     shelldeps = set(key for key in keys if d.getVarFlag(key, "export") and not d.getVarFlag(key, "unexport"))
     vardepvals = set(key for key in keys if d.getVarFlag(key, "vardepvalue"))
 
-- 
1.8.1.2


