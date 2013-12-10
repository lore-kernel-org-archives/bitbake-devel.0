Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 688DE6DEDA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 15:09:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBAF9kE1010920
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Dec 2013 07:09:46 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 10 Dec 2013 07:09:45 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 10 Dec 2013 10:09:37 -0500
Message-ID: <535eb5b2fa7aeed2c278bd960e6efd7b4d806a6f.1386680149.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1386680149.git.liezhi.yang@windriver.com>
References: <cover.1386680149.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/5] [dora] bitbake: fetch2: Fix handling of SCM mirrors in MIRRORS
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
X-List-Received-Date: Tue, 10 Dec 2013 15:09:46 -0000
Content-Type: text/plain

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If an SCM mirror is in PREMIRRORS, the tarball is downloaded and then found
by the "upstream" check and handled correctly.

If an SCM mirror is in MIRRORS, the tarball is downloaded but not used
since there is no "upstream" run after MIRRORS completes. It therefore
sits there useless and unused. This code change forces the upstream to
run after a mirror tarball is found and fixes the usage of SCM mirrors
in MIRRORS.

(Bitbake master rev: a66ee0994645aa5658b2f5ea134ed17d89f8751a)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 451d104..b9f673c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -805,6 +805,10 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
             if not os.path.exists(dest):
                 os.symlink(ud.localpath, dest)
+            if not os.path.exists(origud.donestamp) or origud.method.need_update(origud.url, origud, ld):
+                origud.method.download(origud.url, origud, ld)
+                if hasattr(ud.method,"build_mirror_data"):
+                    origud.method.build_mirror_data(origud.url, origud, ld)
             return None
         # Otherwise the result is a local file:// and we symlink to it
         if not os.path.exists(origud.localpath):
-- 
1.7.10.4


