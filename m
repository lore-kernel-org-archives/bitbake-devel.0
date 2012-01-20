Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHf7-0003xz-UM
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:50:02 +0100
Received: by opal (Postfix, from userid 111)
	id 83D6710337; Fri, 20 Jan 2012 16:51:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165157.83D6710337@opal>
Date: Fri, 20 Jan 2012 16:51:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : cooker.py: Allow siggen classes to be added by the metadata
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
X-List-Received-Date: Fri, 20 Jan 2012 16:50:02 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 69fd5ad4a8402fab5eb8348260966b337c5648ff
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=69fd5ad4a8402fab5eb8348260966b337c5648ff

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Fri Jan 20 16:15:18 2012 +0000

cooker.py: Allow siggen classes to be added by the metadata

By calling init_parser which sets up the siggen code after the ConfigParsed
event is fired, we can allow the metadata to add siggen classes which
was always what the code intended.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index cbac1f7..b6bd740 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -856,8 +856,8 @@ class BBCooker:
         if data.getVar("BB_WORKERCONTEXT", False) is None:
             bb.fetch.fetcher_init(data)
         bb.codeparser.parser_cache_init(data)
-        bb.parse.init_parser(data)
         bb.event.fire(bb.event.ConfigParsed(), data)
+        bb.parse.init_parser(data)
         self.configuration.data = data
 
     def handleCollections( self, collections ):



