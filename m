Return-Path: <b@nbbrfq.cc.univie.ac.at>
X-Greylist: delayed 342 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 22 Aug 2014 11:50:56 UTC
Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1E230617B8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Aug 2014 11:50:56 +0000 (UTC)
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtp (Exim 4.84)
	(envelope-from <b@nbbrfq.cc.univie.ac.at>)
	id 1XKnHN-0003RE-KN; Fri, 22 Aug 2014 13:45:13 +0200
Received: from [2001:62a:4:203:2e59:e5ff:feb9:72ed] (helo=nbbrfq.loc)
	by joan.univie.ac.at with esmtps
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.82)
	(envelope-from <b@nbbrfq.cc.univie.ac.at>)
	id 1XKnHN-0003lp-J8; Fri, 22 Aug 2014 13:45:13 +0200
Received: from b by nbbrfq.loc with local (Exim 4.84_RC2)
	(envelope-from <b@nbbrfq.cc.univie.ac.at>)
	id 1XKnHN-0001sM-Dh; Fri, 22 Aug 2014 13:45:13 +0200
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 22 Aug 2014 13:45:11 +0200
Message-Id: <1408707911-7175-1-git-send-email-rep.dot.nop@gmail.com>
X-Mailer: git-send-email 2.1.0.rc1
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: tweak CookerCollectFiles::find_bbfiles
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
X-List-Received-Date: Fri, 22 Aug 2014 11:51:01 -0000

since python-2.5 string.endswith() takes a tuple

Signed-off-by: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
---
 lib/bb/cooker.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2c7788e..f463603 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1435,7 +1435,7 @@ class CookerCollectFiles(object):
             for ignored in ('SCCS', 'CVS', '.svn'):
                 if ignored in dirs:
                     dirs.remove(ignored)
-            found += [os.path.join(dir, f) for f in files if (f.endswith('.bb') or f.endswith('.bbappend'))]
+            found += [os.path.join(dir, f) for f in files if (f.endswith(['.bb', '.bbappend']))]
 
         return found
 
-- 
1.7.10.4


