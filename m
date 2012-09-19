Received: from [209.85.213.175] (helo=mail-yx0-f175.google.com)
	by linuxtogo.org with esmtp (Exim 4.72) id 1TEAj7-00080M-0t
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Sep 2012 05:13:26 +0200
Received: by yenm2 with SMTP id m2so158984yen.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Sep 2012 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=KraNblLBcijwNElIUpaLroP0rOaqFyn+ieNjGG/2PMs=;
	b=dIRlxUeBbmKIhzmss1SsdlE6r8F272ntF2aZ2wXEPfVot0CAKjC0pV6U4w5qZosWVl
	wN7J85uF4zjPAlMLIePFo7/j+Be6U1vPSMb0cuLvrDyvXVMF9X9s/GFxbLCfElusHhzx
	+dpID0UM8qGAqSRf47exfPb0XlND1iaVw0fJgAvKY86nxLYBk5hHZ866/cDT0fKth23Y
	lkY5unmh641J5t1IOa7dV1WIRepECH7v5+njKlYueFEmC6WsLCKZqsRVRhbOAtOCzAq0
	zCsTpw0+uT+xOt51RyD9ITaGsAnpPoimEpJhacvMZ38KDLq/9iUz7n/W9/xN9vWi4RUM
	wBKQ==
Received: by 10.236.77.7 with SMTP id c7mr2430703yhe.2.1348023643981;
	Tue, 18 Sep 2012 20:00:43 -0700 (PDT)
Received: from localhost.localdomain (dsl-67-55-9-50.acanac.net. [67.55.9.50])
	by mx.google.com with ESMTPS id
	l35sm2352025yhi.12.2012.09.18.20.00.41 (version=SSLv3 cipher=OTHER);
	Tue, 18 Sep 2012 20:00:42 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Sep 2012 23:00:33 -0400
Message-Id: <1348023634-5915-1-git-send-email-twoerner@gmail.com>
X-Mailer: git-send-email 1.7.12.GIT
Subject: [PATCH cooker] cooker: Clarify package/recipe wording
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
X-List-Received-Date: Wed, 19 Sep 2012 03:13:26 -0000

From: Trevor Woerner <twoerner@gmail.com>

When the '-s' option is run, change the heading above the list of recipes
to say "Recipe Name" instead of "Package Name".

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 lib/bb/cooker.py |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 237019c..b281cd0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -278,8 +278,8 @@ class BBCooker:
         pkg_pn = self.status.pkg_pn
         (latest_versions, preferred_versions) = bb.providers.findProviders(self.configuration.data, self.status, pkg_pn)
 
-        logger.plain("%-35s %25s %25s", "Package Name", "Latest Version", "Preferred Version")
-        logger.plain("%-35s %25s %25s\n", "============", "==============", "=================")
+        logger.plain("%-35s %25s %25s", "Recipe Name", "Latest Version", "Preferred Version")
+        logger.plain("%-35s %25s %25s\n", "===========", "==============", "=================")
 
         for p in sorted(pkg_pn):
             pref = preferred_versions[p]
-- 
1.7.10.GIT



