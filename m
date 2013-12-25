Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 982B660D74
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2013 07:59:43 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBP7xiGc024242
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 23:59:44 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.2.347.0;
	Tue, 24 Dec 2013 23:59:44 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Dec 2013 00:01:26 +0800
Message-ID: <a03c298fa11e15dd4800d2436124df82f3525fd8.1387987214.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1387987214.git.liezhi.yang@windriver.com>
References: <cover.1387987214.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/__init__.py: let try_mirror_url return correct value
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
X-List-Received-Date: Wed, 25 Dec 2013 07:59:44 -0000
Content-Type: text/plain

The fetcher will try:

1) PREMIRROR
2) Upstream
3) MIRROR

If it fails to download from the Upstream, but succeeds from the MIRROR,
and ud.localpath != origud.localpath (for example, the git tarball),
then we will get the error (e.g.: xf86-video-omapfb):

ERROR: Function failed: Fetcher failure for URL: 'xxx'. Unable to fetch URL from any source.
ERROR: Logfile of failure stored in: /path/to/log.do_fetch.28024

It should not show the error and let the build go on since it succeeds.
(e.g.: xf86-video-omapfb)

[YOCTO #5686]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 8fdf59c..f93668f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -810,7 +810,7 @@ def try_mirror_url(origud, ud, ld, check = False):
                 origud.method.download(origud, ld)
                 if hasattr(ud.method,"build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
-            return None
+            return ud.localpath
         # Otherwise the result is a local file:// and we symlink to it
         if not os.path.exists(origud.localpath):
             if os.path.islink(origud.localpath):
-- 
1.8.3.1


