Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 329BD61177
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 21:53:59 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM884L029330; Mon, 16 Sep 2013 23:08:08 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HRpp7XisuUD6; Mon, 16 Sep 2013 23:08:08 +0100 (BST)
Received: from ted (bebox.config [93.97.175.187] (may be forged))
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GM85JB029299
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 16 Sep 2013 23:08:06 +0100
Received: from richard by ted with local (Exim 4.80)
	(envelope-from <richard@dan.rpsys.net>)
	id 1VLgjr-0002ZP-CQ; Mon, 16 Sep 2013 22:53:47 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Sep 2013 22:53:22 +0100
Message-Id: <1379368413-9808-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1379368413-9808-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 05/16] data_smart: use the expand_cache in VariableParse
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
X-List-Received-Date: Mon, 16 Sep 2013 21:54:00 -0000

When in VariableParse, use the expand_cache if possible rather than looking
up data. Ultimately it would come from the same place but this short cuts
a heavily used code block for speed improvements.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 9be5d5e..a6a4b6c 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -94,6 +94,11 @@ class VariableParse:
             if self.varname and key:
                 if self.varname == key:
                     raise Exception("variable %s references itself!" % self.varname)
+            if key in self.d.expand_cache:
+                varparse = self.d.expand_cache[key]
+                self.references |= varparse.references
+                self.execs |= varparse.execs
+                return varparse.value
             var = self.d.getVar(key, True)
             if var is not None:
                 self.references.add(key)
-- 
1.8.1.2


