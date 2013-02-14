Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U66lF-0004QS-NP for bitbake-devel@lists.openembedded.org;
	Thu, 14 Feb 2013 22:54:34 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1ELiZqN013462 for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:44:36 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zxFRSp8ooyUv for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:44:35 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1ELiS3O013458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Feb 2013 21:44:31 GMT
Message-ID: <1360877897.11225.126.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Feb 2013 21:38:17 +0000
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Improve lock/done stamp file paths for local files
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
X-List-Received-Date: Thu, 14 Feb 2013 21:54:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently stamps end up at the top level of DL_DIR even if the files
themselves are in a directory structure. This patch preserves path
components allowing the top level directory to be less populated
which is an advantage for large sstate caches.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 3f5de99..90c894f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -756,6 +756,7 @@ class FetchData(object):
         self.lockfile = None
         self.mirrortarball = None
         self.basename = None
+        self.basepath = None
         (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(data.expand(url, d))
         self.date = self.getSRCDate(d)
         self.url = url
@@ -812,8 +813,14 @@ class FetchData(object):
         elif self.localfile:
             self.localpath = self.method.localpath(self.url, self, d)
 
-        # Note: These files should always be in DL_DIR whereas localpath may not be.
-        basepath = d.expand("${DL_DIR}/%s" % os.path.basename(self.localpath or self.basename))
+        dldir = d.getVar("DL_DIR", True)
+        # Note: .done and .lock files should always be in DL_DIR whereas localpath may not be.
+        if self.localpath and self.localpath.startswith(dldir):
+            basepath = self.localpath
+        elif self.localpath:
+            basepath = dldir + os.sep + os.path.basename(self.localpath)
+        else:
+            basepath = dldir + os.sep + (self.basepath or self.basename)
         self.donestamp = basepath + '.done'
         self.lockfile = basepath + '.lock'
 




