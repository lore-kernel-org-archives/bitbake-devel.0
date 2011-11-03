Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RM6Gx-00045f-Vm
	for bitbake-devel@lists.openembedded.org;
	Fri, 04 Nov 2011 00:00:36 +0100
Received: by opal (Postfix, from userid 111)
	id 49DBD1032D; Thu,  3 Nov 2011 22:54:28 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111103225428.49DBD1032D@opal>
Date: Thu,  3 Nov 2011 22:54:28 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : Release 1.14.0
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
X-List-Received-Date: Thu, 03 Nov 2011 23:00:36 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: 1.14
Commit: 8df3f86bbc0edc40349362aa4a72672142ce6dbd
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=8df3f86bbc0edc40349362aa4a72672142ce6dbd

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov  3 17:12:36 2011 +0000

Release 1.14.0

---

 bin/bitbake        |    2 +-
 lib/bb/__init__.py |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 56f39f8..fcf85ce 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -40,7 +40,7 @@ from bb import cooker
 from bb import ui
 from bb import server
 
-__version__ = "1.13.3"
+__version__ = "1.14.0"
 logger = logging.getLogger("BitBake")
 
 
diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index 4981daa..53abe1a 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.13.3"
+__version__ = "1.14.0"
 
 import sys
 if sys.version_info < (2, 6, 0):



