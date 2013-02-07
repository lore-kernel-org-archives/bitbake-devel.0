Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U3bYb-0006x2-Uf for bitbake-devel@lists.openembedded.org;
	Fri, 08 Feb 2013 01:11:10 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1800hN1009358
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Feb 2013 00:00:43 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mVTxM4TYGWkf for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Feb 2013 00:00:43 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1800aUC009204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 8 Feb 2013 00:00:39 GMT
Message-ID: <1360281302.10722.68.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 07 Feb 2013 23:55:02 +0000
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Subject: [PATCH] utils: Use rm -rf in remove()
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
X-List-Received-Date: Fri, 08 Feb 2013 00:11:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Whilst shutils.rmtree() is pythonic, its also slow. Its faster to
use rm -rf which makes optimal use of the right syscalls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 484fb2d..94ef447 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -533,13 +533,15 @@ def remove(path, recurse=False):
     """Equivalent to rm -f or rm -rf"""
     if not path:
         return
-    import os, errno, shutil, glob
+    import os, errno, glob, subprocess
     for name in glob.glob(path):
         try:
             os.unlink(name)
         except OSError as exc:
             if recurse and exc.errno == errno.EISDIR:
-                shutil.rmtree(name)
+                # shutil.rmtree(name) would be ideal but its too slow
+                subprocess.call('rm -rf %s' % path, shell=True)
+                return
             elif exc.errno != errno.ENOENT:
                 raise
 




