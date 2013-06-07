Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 856996A88F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 17:14:26 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HJVPb002114 for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:19:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KsLepzMgppyn for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 18:19:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r57HJOID002097
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 7 Jun 2013 18:19:26 +0100
Message-ID: <1370625250.6864.56.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 07 Jun 2013 18:14:10 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bitbake: Update version to 1.19.1
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 07 Jun 2013 17:14:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index d263cbd..1fac9fe 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -41,7 +41,7 @@ from bb import ui
 from bb import server
 from bb import cookerdata
 
-__version__ = "1.19.0"
+__version__ = "1.19.1"
 logger = logging.getLogger("BitBake")
 
 # Python multiprocessing requires /dev/shm
diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index deed4e6..3110c85 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
@@ -21,7 +21,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
-__version__ = "1.19.0"
+__version__ = "1.19.1"
 
 import sys
 if sys.version_info < (2, 6, 0):



