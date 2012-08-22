Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T4Abr-0008GV-KV for bitbake-devel@lists.openembedded.org;
	Wed, 22 Aug 2012 15:04:35 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCqV9X003112
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:52:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02380-05 for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:52:26 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7MCqOLj003106
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Aug 2012 13:52:25 +0100
Message-ID: <1345639944.3907.105.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Aug 2012 13:52:24 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: methodpool: Remove unused check_insert_method function
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
X-List-Received-Date: Wed, 22 Aug 2012 13:04:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/methodpool.py b/bitbake/lib/bb/methodpool.py
index c5aae9b..3b8e5c1 100644
--- a/bitbake/lib/bb/methodpool.py
+++ b/bitbake/lib/bb/methodpool.py
@@ -56,20 +56,6 @@ def insert_method(modulename, code, fn):
         else:
             _parsed_fns[name] = modulename
 
-def check_insert_method(modulename, code, fn):
-    """
-    Add the code if it wasnt added before. The module
-    name will be used for that
-
-    Variables:
-        @modulename a short name e.g. base.bbclass
-        @code The actual python code
-        @fn   The filename from the outer file
-    """
-    if not modulename in _parsed_methods:
-        return insert_method(modulename, code, fn)
-    _parsed_methods[modulename] = 1
-
 def parsed_module(modulename):
     """
     Inform me file xyz was parsed




