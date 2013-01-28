Received: from mail-we0-f177.google.com ([74.125.82.177])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TzrJj-0008In-74
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 17:12:20 +0100
Received: by mail-we0-f177.google.com with SMTP id d7so1608152wer.22
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=w7F7NI+ZOR2joVEcgkdeHCddNJt+0nkV14Z5O/MeZ4M=;
	b=AoTB1tvPYuZsl3qpD6rTS4N6RruaEGGCMEw+6AF/AGjc94qI6JVVvuf+mo3KhXn4yW
	a6ASRL3JZnuZobKieUWwwL2BXVfcdILXliaOI+9G4jB6+zUy5lB2gc5cC1Snli9GVroH
	uo1WlVIzdIJgfkoPlLt5tR4dpwJQBMgb4NIWa5ZRwmqOO7gzs6fClevfa7W5veqTkSpH
	KQFjbuBdmiOC42rwueZDcNSwwp9OJ6L4ijlIaDqhgDxzZBgpoGJQbVx9hqikfkvwoADX
	c3142KSal1oNZRHwzBu7RwyCEZC7n8kR9DY2puixyynlaM/2F3lnpbcLT5NfIsJ5OtBN
	BCvQ==
X-Received: by 10.180.99.72 with SMTP id eo8mr10660753wib.34.1359388600793;
	Mon, 28 Jan 2013 07:56:40 -0800 (PST)
Received: from localhost (ip-62-24-80-7.net.upcbroadband.cz. [62.24.80.7])
	by mx.google.com with ESMTPS id be1sm13842151wib.10.2013.01.28.07.56.39
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 28 Jan 2013 07:56:40 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Jan 2013 16:56:40 +0100
Message-Id: <1359388602-30536-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.1.1
Subject: [PATCH 1/3] ssh: fix fetcher
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
X-List-Received-Date: Mon, 28 Jan 2013 16:12:25 -0000

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
1.8.1.1



