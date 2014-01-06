Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id F3D4860D86
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  6 Jan 2014 09:52:38 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s069qe2D020443
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 6 Jan 2014 01:52:40 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 6 Jan 2014 01:52:39 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 6 Jan 2014 04:52:35 -0500
Message-ID: <101ef843af724489d409a5be10600c57a82d0dad.1389001793.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1389001793.git.liezhi.yang@windriver.com>
References: <cover.1389001793.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] bitbake/lib/bb/build.py: fix the task flags cleandirs
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
X-List-Received-Date: Mon, 06 Jan 2014 09:52:40 -0000
Content-Type: text/plain

The user manual said:

'cleandirs' - directories which should created before the task runs but should be empty

But it only removes the dir, doesn't create it

[YOCTO #5703]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/build.py |    1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 1524da0..3aa6375 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -154,6 +154,7 @@ def exec_func(func, d, dirs = None):
     if cleandirs:
         for cdir in d.expand(cleandirs).split():
             bb.utils.remove(cdir, True)
+            bb.utils.mkdirhier(cdir)
 
     if dirs is None:
         dirs = flags.get('dirs')
-- 
1.7.10.4


