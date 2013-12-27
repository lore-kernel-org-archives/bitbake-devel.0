Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BA86660E9F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Dec 2013 06:51:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBR6pudt025110
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Dec 2013 22:51:56 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Thu, 26 Dec 2013 22:51:55 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Dec 2013 01:51:51 -0500
Message-ID: <002f9d5044c616b7bbc6997e59bba29004cb8f0a.1388127045.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1388127045.git.liezhi.yang@windriver.com>
References: <cover.1388127045.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake: fetcher2: clean(): remove the .patch.done
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
X-List-Received-Date: Fri, 27 Dec 2013 06:51:55 -0000
Content-Type: text/plain

There was a problem:

$ bitbake xf86-video-omapfb -cfetch && bitbake xf86-video-omapfb -ccleanall

Everything should be removed, but the
0006-omapfb-port-to-new-xserver-video-API.patch.done still exists in the
DL_DIR, this is because the clean() in the fetch2/__init__.py skips
removing the local file, so that it will skip removing the .done.

The local file (file://) isn't needed to be removed since it is not
downloaded into DL_DIR, but the .done should be removed, this patch will
remove the .done, and it doesn't remove anything else since the clean()
in local.py does nothing.

[YOCTO #5687]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 8fdf59c..1d89aaf 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1497,7 +1497,7 @@ class Fetch(object):
             ud = self.ud[url]
             ud.setup_localpath(self.d)
 
-            if not ud.localfile or self.localpath is None:
+            if not ud.localfile and ud.localpath is None:
                 continue
 
             if ud.lockfile:
-- 
1.7.10.4


