Received: from mail-pb0-f43.google.com ([209.85.160.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1U0yre-0007jZ-IV
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 19:28:06 +0100
Received: by mail-pb0-f43.google.com with SMTP id jt11so1727419pbb.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Jan 2013 10:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=VoiLrx3Kimm+d5AnOtMmz5lfSYcgfqbf2ceY5DEU1SU=;
	b=a5ouFvEi2yFMyOYvv8XwEMmhDcU6uE33szlt/r1bayEXeRO2tpenwx9erKxahApF3e
	W/+Iqi9qh6HHLpWwtf/IPSaAQndtk0Z4c8RFlmmOXilxP6/l01ToJvNk1Ey91nXtZHvf
	fzvornmvNayyUIwpfIjNcGuip82HumBEbbinCjbnsHBQRLePAL4/cxqMv8mQa6ogOlgW
	AHMJ1mheG54UHbHjrUzGnwgaRRnYtjw4PmUksWz/THZRHcZFlu9fSTGUedFwhBrrQ0xl
	ebROYhWnND7Lr0wniCwIgyT8bX0Q9apWBMspBUjHRYzCqo9vtn5+an3bFuKYDrMtfsgk
	fzhQ==
X-Received: by 10.68.217.42 with SMTP id ov10mr24573535pbc.51.1359655934988;
	Thu, 31 Jan 2013 10:12:14 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id mz10sm5654889pbc.37.2013.01.31.10.12.11
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 31 Jan 2013 10:12:13 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Jan 2013 19:12:08 +0100
Message-Id: <1359655930-1404-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [PATCH][for-1.16 1/3] ssh: fix fetcher
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
X-List-Received-Date: Thu, 31 Jan 2013 18:28:06 -0000

From: Martin Jansa <martin.jansa@gmail.com>

* set localpath in urldata_init
  otherwise localpath and basename were None, when fetcher was trying to
  define .lock and .done paths
  basepath = d.expand("${DL_DIR}/%s" % os.path.basename(self.localpath or self.basename))
* remove "host" from localpath
  .done and .lock files are always using just basename, so if someone
  has 2 recipes with:
  SRC_URI = "ssh://foo/file.txt"
  SRC_URI = "ssh://bar/file.txt"
  then there will be only one file.txt.done in downloads anyway (and
  only first file.txt from first server will be returned on do_fetch

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/ssh.py | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 8d6434a..61db435 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -72,15 +72,14 @@ class SSH(FetchMethod):
     def supports_checksum(self, urldata):
         return False
 
-    def localpath(self, url, urldata, d):
+    def urldata_init(self, urldata, d):
         m = __pattern__.match(urldata.url)
         path = m.group('path')
         host = m.group('host')
-        lpath = os.path.join(data.getVar('DL_DIR', d, True), host, os.path.basename(path))
-        return lpath
+        urldata.localpath = os.path.join(d.getVar('DL_DIR', True), os.path.basename(path))
 
     def download(self, url, urldata, d):
-        dldir = data.getVar('DL_DIR', d, True)
+        dldir = d.getVar('DL_DIR', True)
 
         m = __pattern__.match(url)
         path = m.group('path')
@@ -89,16 +88,10 @@ class SSH(FetchMethod):
         user = m.group('user')
         password = m.group('pass')
 
-        ldir = os.path.join(dldir, host)
-        lpath = os.path.join(ldir, os.path.basename(path))
-
-        if not os.path.exists(ldir):
-            os.makedirs(ldir)
-
         if port:
-            port = '-P %s' % port
+            portarg = '-P %s' % port
         else:
-            port = ''
+            portarg = ''
 
         if user:
             fr = user
@@ -112,9 +105,9 @@ class SSH(FetchMethod):
 
         import commands
         cmd = 'scp -B -r %s %s %s/' % (
-            port,
+            portarg,
             commands.mkarg(fr),
-            commands.mkarg(ldir)
+            commands.mkarg(dldir)
         )
 
         bb.fetch2.check_network_access(d, cmd, urldata.url)
-- 
1.8.1.2



