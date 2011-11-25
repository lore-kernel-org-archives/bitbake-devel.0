Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RTjlb-0007r0-GB
	for bitbake-devel@lists.openembedded.org;
	Fri, 25 Nov 2011 01:35:47 +0100
Received: by opal (Postfix, from userid 111)
	id DBF441032F; Fri, 25 Nov 2011 00:31:45 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111125003145.DBF441032F@opal>
Date: Fri, 25 Nov 2011 00:31:45 +0000 (UTC)
From: git@git.openembedded.org
Subject: Matthew McClintock : Nothing uses USERNAME, remove it - can cause sstate-cache conflicts
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
X-List-Received-Date: Fri, 25 Nov 2011 00:35:47 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: d7f9edda65dae2e046871afa275c5a51dff48fc4
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=d7f9edda65dae2e046871afa275c5a51dff48fc4

Author: Matthew McClintock <msm@freescale.com>
Date:   Wed Nov 23 19:11:27 2011 -0600

Nothing uses USERNAME, remove it - can cause sstate-cache conflicts

USER is the correct variable to use, also this can affect sstate
cache as well.

Signed-off-by: Matthew McClintock <msm@freescale.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/utils.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f905702..521a068 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -505,7 +505,6 @@ def preserved_envvars_exported():
         'SHELL',
         'TERM',
         'USER',
-        'USERNAME',
     ]
 
 def preserved_envvars_exported_interactive():



