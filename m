Return-Path: <Li.Wang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id CCBB56080B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Jun 2013 06:31:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r5P6VQYu015527
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jun 2013 23:31:26 -0700 (PDT)
Received: from lwang1-OptiPlex-9010.corp.ad.wrs.com (128.224.162.157) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.342.3; Mon, 24 Jun 2013 23:31:25 -0700
From: Li Wang <li.wang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Jun 2013 14:31:15 +0800
Message-ID: <1372141875-17591-2-git-send-email-li.wang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372141875-17591-1-git-send-email-li.wang@windriver.com>
References: <1372141875-17591-1-git-send-email-li.wang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake: diff path:file and network include special @ character
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Jun 2013 06:31:24 -0000
Content-Type: text/plain

[YOCTO #4772]

When fetch file, We need to handle the follow address format:
xxx@www.xxx.com:/a/b@c/d
the user name is invalide, when it includes '/' character.
So, we can separate '@' character in username:password, or path:file

Signed-off-by: Li Wang <li.wang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6211cd7..62f3b95 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -333,11 +333,18 @@ def decodeurl(url):
     if not m:
         raise MalformedUrl(url)
 
+    user = m.group('user')
+    if user:
+        n = re.compile('(?P<usr>[^:]+)(:?(?P<pswd>.*))').match(user)
+        usr = n.group('usr')
+        if usr.find('/') != -1:
+            m = re.compile('(?P<type>[^:]*)://?(?P<location>[^;]+)(;(?P<parm>.*))?').match(url)
+            user = ''
+
     type = m.group('type')
     location = m.group('location')
     if not location:
         raise MalformedUrl(url)
-    user = m.group('user')
     parm = m.group('parm')
 
     locidx = location.find('/')
-- 
1.7.9.5


