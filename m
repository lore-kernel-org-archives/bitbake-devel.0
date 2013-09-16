Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 61D8760A88
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:54:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM884O029330; Mon, 16 Sep 2013 23:08:10 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WXnY8aYYbOow; Mon, 16 Sep 2013 23:08:09 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85uB029302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjr-0002Ze-QT; Mon, 16 Sep 2013 22:53:47 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:25 +0100
Message-Id: <1379368413-9808-8-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 08/16] data_smart: Add explict None checks
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:09 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Simple if xxx checks end up calling len(xxx). We're interested in the specific case
of None which means we can break out the iterator much earlier after the first
item. This adds in the specific tests for None in what is a hot path in the
data store code which gives small performance gains.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 1bb186e..970e404 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -588,7 +588,7 @@ class DataSmart(MutableMapping):
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
         value = None
-        if local_var:
+        if local_var is not None:
             if flag in local_var:
                 value = copy.copy(local_var[flag])
             elif flag == "_content" and "defaultval" in local_var and not noweakdefault:
@@ -599,7 +599,7 @@ class DataSmart(MutableMapping):
             if flag == "_content":
                 cachename = var
             value = self.expand(value, cachename)
-        if value and flag == "_content" and local_var and "_removeactive" in local_var:
+        if value is not None and flag == "_content" and local_var is not None and "_removeactive" in local_var:
             filtered = filter(lambda v: v not in local_var["_removeactive"],
                               value.split(" "))
             value = " ".join(filtered)
-- 
1.8.1.2


