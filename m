Return-Path: <logan.buchy@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id C7EFC770A6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 07:42:40 +0000 (UTC)
Received: by payp3 with SMTP id p3so32053978pay.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=yICNl5BCEaXvtk6jRpCtZxw2aaNvaIqDLMAnKqxjYXI=;
	b=OlQjHTxSdJ7b4npk9Ve6xH3eheULRliiJQN97GdJu+oFpoj0eIC6W9M5xUjHouB1Xw
	dHI/6gwQo1fajtc080SQ4o8QE2LBNcqLcG8VwiHfT9JTfSw0TwHzfeCcA1NGGiWSkCz9
	FPdwK+mkkyKguGPwuw+2pq34ON/yQ3isXYK7Blej3cQKmaY6/B64ZJNURodPffbjXB5d
	Q0dOsqpDw0i9+IcyoWPIRSNGPcwhdIK0Uh+xYltYMAVqppYE+VPYLRPQpMLJFhkQJEgc
	5xb8ZI5rfTINaxEiZ6whyJTf0QgKl/LW0jUFSES5ma8QPgHrrpFpJgjOx7bVZng2HLhq
	WXHA==
X-Received: by 10.68.96.67 with SMTP id dq3mr8491586pbb.161.1444894960531;
	Thu, 15 Oct 2015 00:42:40 -0700 (PDT)
Received: from localhost.localdomain (S01061859333ffe7a.vc.shawcable.net.
	[24.84.240.126]) by smtp.gmail.com with ESMTPSA id
	si10sm13673980pab.15.2015.10.15.00.42.39
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Oct 2015 00:42:40 -0700 (PDT)
From: Logan Buchy <logan.buchy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 00:42:27 -0700
Message-Id: <1444894947-12726-1-git-send-email-logan.buchy@gmail.com>
X-Mailer: git-send-email 2.5.3
Subject: [PATCH] fetch2/hg: Include missing errno import
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
X-List-Received-Date: Thu, 15 Oct 2015 07:42:44 -0000

errno.ENOENT checked if deletion of the fullmirror fails.
Exception was thrown since module not imported

Signed-off-by: Logan Buchy <logan.buchy@gmail.com>
---
 lib/bb/fetch2/hg.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index bbb4ed9..3b743ff 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -28,6 +28,7 @@ import os
 import sys
 import logging
 import bb
+import errno
 from bb import data
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
-- 
2.5.3


