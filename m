Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TYM8J-0001jM-Ml
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 20:26:51 +0100
Received: by mail-ie0-f175.google.com with SMTP id c13so11385450ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Nov 2012 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=x3cXkCY7FdYmwyWuJ/O/lKpmdfLVDARRGTcf412aTSQ=;
	b=uB42Qq/Lw51QRm5wvsoiKhBio8c6JZccXVqX0/ervOJLD+ivksO50z3TEqYLT5keHs
	8IvH/Ic139GluBb9rafQZnjUYuNesPAjBp4RMrdOoBW55oVK1tkzYRkaP01Ta23Mr7k3
	sC/v/BgHbxKFjEg/ypYnpy4q4/GyEpRKWS+TafLy3rgXGRtZk2YMGQCD+7qGtJ7Jmul6
	YlgYeYoFNhQmwKIBirV6R2U264dgT7HqF+nW25ZMUOPJ8s7xk18aqocmhsI1cyQzco0Q
	P22vgMKF4QA4ZrBMdUF25eJx56yHJReiF5Fe7maYOx1EnHgjZwEiGi0MdPCXNhgXQjCj
	a3dA==
Received: by 10.50.36.138 with SMTP id q10mr12202194igj.0.1352833976600;
	Tue, 13 Nov 2012 11:12:56 -0800 (PST)
Received: from precise64.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id
	uj11sm11264848igb.15.2012.11.13.11.12.54
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 13 Nov 2012 11:12:55 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2012 12:12:50 -0700
Message-Id: <1352833970-22315-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.7.12.4
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] knotty: kill duplicated import of 'time'
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
X-List-Received-Date: Tue, 13 Nov 2012 19:26:51 -0000

From: Christopher Larson <chris_larson@mentor.com>

The duplicated import could result in an UnboundLocalError.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/ui/knotty.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index b99a121..77ec730 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -460,7 +460,6 @@ def main(server, eventHandler, tf = TerminalFilter):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
-            import time
             termfilter.clearFooter()
             if main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
-- 
1.7.12.4



