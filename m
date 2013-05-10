Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UapMW-00009E-0C for bitbake-devel@lists.openembedded.org;
	Fri, 10 May 2013 17:36:03 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4AFKQRJ010552 for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:20:27 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FG3aTxAqyk4r for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:20:26 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4AFKLoJ010544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:20:23 +0100
Message-ID: <1368199061.11129.35.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 May 2013 16:17:41 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Fix get_bbfiles()
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
X-List-Received-Date: Fri, 10 May 2013 15:36:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Its clear looking at the code the path argument has never been used and doesn't
work. Tweak the function to be a little more readable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index da598c9..85761e0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1419,14 +1419,14 @@ class CookerCollectFiles(object):
                 return pri
         return 0
 
-    def get_bbfiles(self, path = os.getcwd()):
+    def get_bbfiles(self):
         """Get list of default .bb files by reading out the current directory"""
+        path = os.getcwd()
         contents = os.listdir(path)
         bbfiles = []
         for f in contents:
-            (root, ext) = os.path.splitext(f)
-            if ext == ".bb":
-                bbfiles.append(os.path.abspath(os.path.join(os.getcwd(), f)))
+            if f.endswith(".bb"):
+                bbfiles.append(os.path.abspath(os.path.join(path, f)))
         return bbfiles
 
     def find_bbfiles(self, path):




