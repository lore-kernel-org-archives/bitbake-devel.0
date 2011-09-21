Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <julian.pidancet@gmail.com>) id 1R6Acj-0007ZK-Pp
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Sep 2011 02:25:13 +0200
Received: by wyh5 with SMTP id 5so1401921wyh.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 20 Sep 2011 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer:to;
	bh=Hwctr0yzozr2+JCr3aoxSDBbTL9PvE1Sy+a2x97JjfQ=;
	b=Ze83FtGGz1GJoMUesh1EsLdRDagsbh3xkF9XoBan5CHaxCUeAcR7nMOb/N7GYuMD70
	N8EMAPZfeDChQPbsxf6h2dWMllbgMLppH+7P8qlv6lRUKBYOHH8T6SslYkLndl1eUd/m
	8DNdr3+0wl2deNFG/BNuJ3xX0VV/9oXM+PIDk=
Received: by 10.216.230.105 with SMTP id i83mr103799weq.50.1316564395785;
	Tue, 20 Sep 2011 17:19:55 -0700 (PDT)
Received: from localhost.localdomain (188-223-88-44.zone14.bethere.co.uk.
	[188.223.88.44])
	by mx.google.com with ESMTPS id j18sm4664206wbo.6.2011.09.20.17.19.52
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 20 Sep 2011 17:19:55 -0700 (PDT)
From: Julian Pidancet <julian.pidancet@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Sep 2011 02:14:54 +0100
Message-Id: <1316567694-22600-1-git-send-email-julian.pidancet@gmail.com>
X-Mailer: git-send-email 1.7.3.4
To: bitbake-devel@lists.openembedded.org
Cc: Julian Pidancet <julian.pidancet@gmail.com>
Subject: [PATCH] Fix mercurial fetcher in fetch2
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
X-List-Received-Date: Wed, 21 Sep 2011 00:25:13 -0000

The _build_revision method in Hg class gets called with the wrong number
of arguments. This tiny patch adds a 5th argument to the method
declaration to prevent python from throwing an exception.

Signed-off-by: Julian Pidancet <julian.pidancet@gmail.com>
---
 lib/bb/fetch2/hg.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/hg.py b/lib/bb/fetch2/hg.py
index 793831a..ad6e85d 100644
--- a/lib/bb/fetch2/hg.py
+++ b/lib/bb/fetch2/hg.py
@@ -166,7 +166,7 @@ class Hg(FetchMethod):
         output = runfetchcmd(self._buildhgcommand(ud, d, "info"), d)
         return output.strip()
 
-    def _build_revision(self, url, ud, d):
+    def _build_revision(self, url, ud, d, name):
         return ud.revision
 
     def _revision_key(self, url, ud, d, name):
-- 
1.7.3.4



