Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoJQh-00073L-4b
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 19:43:15 +0100
Received: by opal (Postfix, from userid 111)
	id 0F6FD10334; Fri, 20 Jan 2012 18:37:05 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120183705.0F6FD10334@opal>
Date: Fri, 20 Jan 2012 18:37:05 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : Bump the version to 1.15.1
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
X-List-Received-Date: Fri, 20 Jan 2012 18:43:15 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 65c2eb1c095fe7ba3259060aefd4ba0e20cae319
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=65c2eb1c095fe7ba3259060aefd4ba0e20cae319

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Fri Jan 20 18:26:36 2012 +0000

Bump the version to 1.15.1

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitbake        |    2 +-
 lib/bb/__init__.py |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index c2e6822..6da4980 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -40,7 +40,7 @@ from bb import cooker
 from bb import ui
 from bb import server
 
-__version__ = "1.15.0"
+__version__ = "1.15.1"
 logger = logging.getLogger("BitBake")
 
 
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 81f83c8..dce5610 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.15.0"
+__version__ = "1.15.1"
 
 import sys
 if sys.version_info < (2, 6, 0):



