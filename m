Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U66iX-0004Lb-49 for bitbake-devel@lists.openembedded.org;
	Thu, 14 Feb 2013 22:51:45 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1ELflkd013358 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:41:47 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o4ILA5YI7Ell for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:41:47 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1ELfabd013348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:41:39 GMT
Message-ID: <1360877725.11225.124.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Feb 2013 21:35:25 +0000
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Subject: [PATCH] tests/codeparser: Hack around circular inclusion problem
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
X-List-Received-Date: Thu, 14 Feb 2013 21:51:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is a circular dependency issue where bb.data can't directly depend on
bb.parse. The tests were failing due to this issue which is misleading. This
patch hacks around it for now. I'd rather that than not running tests at all.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/tests/codeparser.py b/bitbake/lib/bb/tests/codeparser.py
index 9b2d588..e544586 100644
--- a/bitbake/lib/bb/tests/codeparser.py
+++ b/bitbake/lib/bb/tests/codeparser.py
@@ -24,6 +24,9 @@ import bb
 
 logger = logging.getLogger('BitBake.TestCodeParser')
 
+# bb.data references bb.parse but can't directly import due to circular dependencies.
+# Hack around it for now :( 
+import bb.parse
 import bb.data
 
 class ReferenceTest(unittest.TestCase):




