Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1TGnvq-0000mG-Fr
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 11:29:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8Q9GZbL017570
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Sep 2012 02:16:35 -0700 (PDT)
Received: from usp-ub10.wrs.com (128.224.163.69) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 26 Sep 2012 02:16:35 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 26 Sep 2012 17:07:57 +0800
Message-ID: <a396909f81ca30ac584002d0fe1b672afdefc46e.1348646054.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1348646054.git.liezhi.yang@windriver.com>
References: <cover.1348646054.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] fetch2: add "-d" option to cpio
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
X-List-Received-Date: Wed, 26 Sep 2012 09:29:26 -0000
Content-Type: text/plain

Add "-d" option to cpio since it is useful:
  -d
  --make-directories
  Create leading directories where needed.

[YOCTO #3137]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index a713418..ea52874 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -950,11 +950,11 @@ class FetchMethod(object):
             elif file.endswith('.rpm') or file.endswith('.srpm'):
                 if 'extract' in urldata.parm:
                     unpack_file = urldata.parm.get('extract')
-                    cmd = 'rpm2cpio.sh %s | cpio -i %s' % (file, unpack_file)
+                    cmd = 'rpm2cpio.sh %s | cpio -id %s' % (file, unpack_file)
                     iterate = True
                     iterate_file = unpack_file
                 else:
-                    cmd = 'rpm2cpio.sh %s | cpio -i' % (file)
+                    cmd = 'rpm2cpio.sh %s | cpio -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
                 cmd = 'ar -p %s data.tar.gz | zcat | tar --no-same-owner -xpf -' % file
 
-- 
1.7.1



