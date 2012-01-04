Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RiRj8-0000Bz-PU
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Jan 2012 15:22:04 +0100
Received: by opal (Postfix, from userid 111)
	id ACECE10331; Wed,  4 Jan 2012 14:22:14 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120104142214.ACECE10331@opal>
Date: Wed,  4 Jan 2012 14:22:14 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake-layers: fix Python error during parse
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
X-List-Received-Date: Wed, 04 Jan 2012 14:22:04 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: a228f0a32c2c14d62effbbba5f4fada4cd3817f6
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=a228f0a32c2c14d62effbbba5f4fada4cd3817f6

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Thu Dec 29 14:34:12 2011 +0000

bitbake-layers: fix Python error during parse

If "bitbake-layers show_layers" was run when the cache was dirty forcing
a parse, it failed with the following error:

ERROR: Failure expanding variable SRCPV, expression was
${@bb.fetch2.get_srcrev(d)} which triggered exception AttributeError:
'module' object has no attribute 'fetch2'

A simple import of bb.fetch2 in bitbake-layers fixes this.

Fixes [YOCTO #1855].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake-layers |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 119b15c..b2781bb 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -18,6 +18,7 @@ import bb.cooker
 import bb.providers
 import bb.utils
 from bb.cooker import state
+import bb.fetch2
 
 
 logger = logging.getLogger('BitBake')



