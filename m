Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1T81bE-0002wD-5p
	for bitbake-devel@lists.openembedded.org;
	Sun, 02 Sep 2012 06:15:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8243WGD004058
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 1 Sep 2012 21:03:32 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Sat, 1 Sep 2012 21:03:32 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 2 Sep 2012 12:08:51 +0800
Message-ID: <2b3b5cbd804f6d0d1949c7f15970be301a6900f4.1346558600.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1346558600.git.liezhi.yang@windriver.com>
References: <cover.1346558600.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] fetch2: unpack rpm, ipk and deb binary package
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
X-List-Received-Date: Sun, 02 Sep 2012 04:15:52 -0000
Content-Type: text/plain

* Unpack the ".rpm" binary package (only .src.rpm in the past)

* Unpack the .deb and .ipk binary package, their unpack commands are the same.

* This is useful for binary package recipe.

[YOCTO #1592]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 12ebce2..00fafb6 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -938,7 +938,7 @@ class FetchMethod(object):
                 if dos:
                     cmd = '%s -a' % cmd
                 cmd = "%s '%s'" % (cmd, file)
-            elif file.endswith('.src.rpm') or file.endswith('.srpm'):
+            elif file.endswith('.rpm') or file.endswith('.srpm'):
                 if 'extract' in urldata.parm:
                     unpack_file = urldata.parm.get('extract')
                     cmd = 'rpm2cpio.sh %s | cpio -i %s' % (file, unpack_file)
@@ -946,6 +946,8 @@ class FetchMethod(object):
                     iterate_file = unpack_file
                 else:
                     cmd = 'rpm2cpio.sh %s | cpio -i' % (file)
+            elif file.endswith('.deb') or file.endswith('.ipk'):
+                cmd = 'ar -p %s data.tar.gz | zcat | tar --no-same-owner -xpf -' % file
 
         if not unpack or not cmd:
             # If file == dest, then avoid any copies, as we already put the file into dest!
-- 
1.7.11.2



