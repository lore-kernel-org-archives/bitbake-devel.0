Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 76A986B566
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Dec 2013 06:51:56 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id rBR6pv78012769
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Dec 2013 22:51:57 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Thu, 26 Dec 2013 22:51:57 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Dec 2013 01:51:52 -0500
Message-ID: <4cee50f7cc50c44750c61f5bf5a45f29ad1b6342.1388127045.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1388127045.git.liezhi.yang@windriver.com>
References: <cover.1388127045.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bitbake: fetcher2: git.py: clean(): remove the .tar.gz.done
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
X-List-Received-Date: Fri, 27 Dec 2013 06:51:56 -0000
Content-Type: text/plain

There was a problem:

$ bitbake xf86-video-omapfb -cfetch && bitbake xf86-video-omapfb -ccleanall

The git2_git.pingu.fi.xf86-video-omapfb.tar.gz has been removed from the
DL_DIR, but the git2_git.pingu.fi.xf86-video-omapfb.tar.gz.done still exists,
this is because the "open(ud.donestamp, 'w').close()" in try_mirror_url() will
create the git2_git.xxx.tar.gz.done, but no one removes it (the clean() in
fetch2/__init__.py removes the DL_DIR/git2/pkg.done)

This only happens on the git fetcher AFAIK.

[YOCTO #5688]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index bd107db..b4b9368 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -283,6 +283,7 @@ class Git(FetchMethod):
 
         bb.utils.remove(ud.localpath, True)
         bb.utils.remove(ud.fullmirror)
+        bb.utils.remove(ud.fullmirror + ".done")
 
     def supports_srcrev(self):
         return True
-- 
1.7.10.4


