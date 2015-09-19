Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id A3F8676FD7
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 21:14:23 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so80581003pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 19 Sep 2015 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=uEhkq0EyAcM8m1OmSOq9/GQP37nlXPV1emlLVGTntxM=;
	b=jWvhM3S8a9DDRwQDO/5+xtMaqDHORdQ3nDKGwmv1tbPwTwThGZU5+liSEJHolJ3ayo
	J9iBf9cnLpQI6z3bj+vGiovLfpE5qCyivNg+pU+kdt2CQ1yKTONzm+cW1f1uyQ3KJAbZ
	qEbwdC8A1hnBuGcNvLxez74d8HS+x2564iIlHPzoNWVr73YsgmIfCqoz1qmP5EMrgH/h
	NTfFaWu6YyiC04uVTg4I80W9y24l64w+U6XuQudh5seBfkcXJt/keT+KRKEHUrgA2h0d
	hmAfkfXjg8ZTQUZQjC+jIkXh4WvTjLFezmxQrOMruW+a/rIxJSHDY2N0DmNWHweDkE7c
	BkMg==
X-Received: by 10.67.15.36 with SMTP id fl4mr14860485pad.152.1442697263727;
	Sat, 19 Sep 2015 14:14:23 -0700 (PDT)
Received: from haswell.localdomain ([2601:646:8601:4580:baca:3aff:fe80:aa8f])
	by smtp.gmail.com with ESMTPSA id
	eu2sm5742826pbc.48.2015.09.19.14.14.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 19 Sep 2015 14:14:22 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 19 Sep 2015 14:23:36 -0700
Message-Id: <1442697816-11303-1-git-send-email-raj.khem@gmail.com>
X-Mailer: git-send-email 2.5.2
Subject: [PATCH V2] bitbake: bb.fetch2.git: Import errno module
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
X-List-Received-Date: Sat, 19 Sep 2015 21:14:23 -0000

From: Romain Perier <romain.perier@gmail.com>

Currently this module is dereferencing errno.ENOENT but the python module "errno"
is not imported, which causes a crash when fetching from a git repository.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Acked-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/bb/fetch2/git.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 4a32a31..9c04da0 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -69,6 +69,7 @@ Supported SRC_URI options are:
 import os
 import re
 import bb
+import errno
 from   bb    import data
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
-- 
2.5.2


