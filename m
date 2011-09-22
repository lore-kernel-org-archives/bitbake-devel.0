Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>) id 1R6fC9-0008Dn-Ec
	for bitbake-devel@lists.linuxtogo.org; Thu, 22 Sep 2011 11:03:49 +0200
Received: by fxi1 with SMTP id 1so2542882fxi.6
	for <bitbake-devel@lists.linuxtogo.org>;
	Thu, 22 Sep 2011 01:58:30 -0700 (PDT)
Received: by 10.223.45.209 with SMTP id g17mr2688536faf.96.1316681909526;
	Thu, 22 Sep 2011 01:58:29 -0700 (PDT)
Received: from localhost (ip545070eb.adsl-surfen.hetnet.nl. [84.80.112.235])
	by mx.google.com with ESMTPS id t13sm17913666fae.0.2011.09.22.01.58.27
	(version=TLSv1/SSLv3 cipher=OTHER);
	Thu, 22 Sep 2011 01:58:28 -0700 (PDT)
From: Koen Kooi <koen@dominion.thruhere.net>
To: openembedded-core@lists.openembedded.org
Date: Thu, 22 Sep 2011 10:58:24 +0200
Message-Id: <1316681904-10860-1-git-send-email-koen@dominion.thruhere.net>
X-Mailer: git-send-email 1.6.6.1
Cc: Koen Kooi <koen@dominion.thruhere.net>, bitbake-devel@lists.linuxtogo.org
Subject: [RFC] fetch2: introduce BB_GENERATE_MIRROR_VERSIONED_TARBALLS to enable classic versioned scm snapshots
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
X-List-Received-Date: Thu, 22 Sep 2011 09:03:49 -0000

When enabled fetch2 will generate tarballs with the SRCREV embbeded like so:

	git2_git.pingu.fi.xf86-video-omapfb_28c006c94e57ea71df11ec4fff79d7ffcfc4860f.tar.gz

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index fb6125c..f889562 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -93,7 +93,7 @@ class Git(FetchMethod):
 
         ud.nocheckout = ud.parm.get("nocheckout","0") == "1"
 
-        ud.rebaseable = ud.parm.get("rebaseable","0") == "1"
+        ud.rebaseable = ud.parm.get("rebaseable","0") == "1" or ((data.getVar("BB_GENERATE_MIRROR_VERSIONED_TARBALLS", d, True) or "0") != "0")
 
         branches = ud.parm.get("branch", "master").split(',')
         if len(branches) != len(ud.names):
-- 
1.6.6.1



