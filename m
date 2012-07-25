Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Su93x-0006uu-Lm for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 23:24:10 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PLCd3Z014917
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 22:12:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14144-04 for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 22:12:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PLCUon014909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 22:12:32 +0100
Message-ID: <1343250750.29991.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2012 22:12:30 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch/local: Allow preservation of path components in relative file:// urls
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
X-List-Received-Date: Wed, 25 Jul 2012 21:24:10 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This enhances the fetcher to allow preservation of the path component in urls
like: file://xxx/yyy/somefile.patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 1f4ec37..bfef079 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -60,9 +60,10 @@ class Local(FetchMethod):
                 filesdir = data.getVar('FILESDIR', d, True)
                 if filesdir:
                     newpath = os.path.join(filesdir, path)
-        if not os.path.exists(newpath) and path.find("*") == -1:
-            dldirfile = os.path.join(data.getVar("DL_DIR", d, True), os.path.basename(path))
-            return dldirfile
+            if not os.path.exists(newpath) and path.find("*") == -1:
+                dldirfile = os.path.join(d.getVar("DL_DIR", True), path)
+                bb.utils.mkdirhier(os.path.dirname(dldirfile))
+                return dldirfile
         return newpath
 
     def need_update(self, url, ud, d):




