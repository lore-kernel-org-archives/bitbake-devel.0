Return-Path: <romain.perier@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 1BE1973D13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Sep 2015 16:35:24 +0000 (UTC)
Received: by wicge5 with SMTP id ge5so40149189wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Sep 2015 09:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=sXgOAo5V2kRV2YJZOFPwXLLHD3zYlSD8jE3F+rHzbgc=;
	b=DjDZdISnrkViPHwBoTQNV+R8MhegrR5nlXiyVPJkNwWTloYtvLr42ep1jfd4xF3eeu
	6ZwflYQUyJtxT16djnKVbPxQlgmrMkuN3JEfYpLzskg86dWpv1D6/2Sb0Y4qaN5Vb73U
	wHse9QBBRr9/uX6ST+4FG8ZLR3IrLeeMZU1VEeXYBq34v7aDTEPFL8VGJWmVOoZlXSOl
	HLwmZ13itebdYnSenf3ijUgoKaIIw/du3lfv3Q62RalNbcrXc9s1BZeQWSmNhX//crxE
	8IixeaKKYTXDVibdAdKmkEYfM2GXfjzCNS0GaXr1/aICQ3Y20OygquSKT1O8DnJ8bC5d
	Xq3Q==
X-Received: by 10.194.122.200 with SMTP id lu8mr7916940wjb.83.1442594124599;
	Fri, 18 Sep 2015 09:35:24 -0700 (PDT)
Received: from localhost.localdomain
	(i19-les01-ntr-176-186-2-137.sfr.lns.abo.bbox.fr. [176.186.2.137])
	by smtp.gmail.com with ESMTPSA id
	ry1sm9682298wjb.24.2015.09.18.09.35.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Sep 2015 09:35:24 -0700 (PDT)
From: Romain Perier <romain.perier@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 18 Sep 2015 18:35:22 +0200
Message-Id: <1442594122-20623-1-git-send-email-romain.perier@gmail.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: bb.fetch2.git: Import errno module
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
X-List-Received-Date: Fri, 18 Sep 2015 16:35:26 -0000

Currently this module is dereferencing errno.ENOENT but the python module "errno"
is not imported, which causes a crash when fetching from a git repository.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 bitbake/lib/bb/fetch2/git.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 4a32a31..9bd87ad 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -66,6 +66,7 @@ Supported SRC_URI options are:
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+import errno
 import os
 import re
 import bb
-- 
2.1.4


