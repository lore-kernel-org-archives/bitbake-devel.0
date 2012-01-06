Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFS-0001Ip-UN
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:31 +0100
Received: by opal (Postfix, from userid 111)
	id 64E8E10337; Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160257.64E8E10337@opal>
Date: Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : cooker: remove command import in cooker.py
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:31 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 92fec2788e33d301cc63848901bc6adc764a2ecf
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=92fec2788e33d301cc63848901bc6adc764a2ecf

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:28 2012 +0800

cooker: remove command import in cooker.py

There is no direct use of command in cooker.py, and it is using
bb.command instead. Remove command in the import list.

This fixes a problem of embedded import between command.py and
cooker.py.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1faf821..102d40f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -34,8 +34,8 @@ from cStringIO import StringIO
 from contextlib import closing
 from functools import wraps
 from collections import defaultdict
-import bb, bb.exceptions
-from bb import utils, data, parse, event, cache, providers, taskdata, command, runqueue
+import bb, bb.exceptions, bb.command
+from bb import utils, data, parse, event, cache, providers, taskdata, runqueue
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")



