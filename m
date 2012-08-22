Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4GNS-0007eD-Te for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 21:14:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJ20cq005789
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:02:00 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05660-02 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:01:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MJ1rQR005783
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 20:01:54 +0100
Message-ID: <1345662115.3907.128.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 20:01:55 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] ast: Store anonymous python function contents in the datstore
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 22 Aug 2012 19:14:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is useful if we need to disable part of one during a backtrace
for debugging purposes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index 5367628..4e93630 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -134,6 +134,7 @@ class MethodNode(AstNode):
             anonfuncs = data.getVar('__BBANONFUNCS') or []
             anonfuncs.append(funcname)
             data.setVar('__BBANONFUNCS', anonfuncs)
+            data.setVar(funcname, text)
         else:
             data.setVarFlag(self.func_name, "func", 1)
             data.setVar(self.func_name, text)




