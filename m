Return-Path: <kvserr@gmail.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 3034E703F4
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jul 2014 15:14:27 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id k14so3443650wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Jul 2014 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=3iweTombhaeSVXLLFH7pG0IoANYQOpnvogzjODPb2nc=;
	b=ziLcIHyBHNaHwDz2XhDSGTDdkzI2TA83RzQrbIzDfzWnwPar5Hi1fUhhkSfxmp8IZK
	codG0mAme99DCA/pnmXJwKzFT6C13KT63G8ND+8JTUDsjN4RALSXAH/PLWE21eRWPRXO
	ZJbHp66SGJ8UZCqhLMriB/O1d4gToIKRhetFyQdaVl16rlJKGTPQT26Ft6XdoLXiPakk
	YamAJqaacb72QkEwtMdOfHvbqwAsEeYmqCXQwnn1QQB7FBM7Qa5+F+MBiK4SaVAZtell
	MRNncL/B2AhEgqXbx1V6IKuo0+v2iCOoL8BFshIrAntUOc+5IcQSiCIKgnF1nIcHwC0T
	LgpA==
X-Received: by 10.180.102.100 with SMTP id fn4mr4782958wib.22.1404832467934;
	Tue, 08 Jul 2014 08:14:27 -0700 (PDT)
Received: from debivit.LGE.NET ([195.160.253.4])
	by mx.google.com with ESMTPSA id lo18sm8126831wic.1.2014.07.08.08.14.26
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 08 Jul 2014 08:14:27 -0700 (PDT)
From: Vitaliy Kharin <kvserr@gmail.com>
X-Google-Original-From: Vitaliy Kharin <vitaliy.kharin@lge.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Jul 2014 19:09:44 +0400
Message-Id: <1404832184-16471-1-git-send-email-vitaliy.kharin@lge.com>
X-Mailer: git-send-email 2.0.0
Cc: Vitaliy Kharin <vitaliy.kharin@lge.com>
Subject: [PATCH] bb.utils.which is intend to locate regular file only as it is written in comment
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
X-List-Received-Date: Tue, 08 Jul 2014 15:14:29 -0000

Signed-off-by: Vitaliy Kharin <vitaliy.kharin@lge.com>
---
 bitbake/lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 0be45e1..c48b237 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -809,7 +809,7 @@ def which(path, item, direction = 0, history = False):
     for p in paths:
         next = os.path.join(p, item)
         hist.append(next)
-        if os.path.exists(next):
+        if os.path.isfile(next):
             if not os.path.isabs(next):
                 next = os.path.abspath(next)
             if history:
-- 
2.0.0


