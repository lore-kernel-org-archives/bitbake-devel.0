Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9C6F165CAD
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 06:41:30 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s646fV0S024400
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jul 2014 23:41:31 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Thu, 3 Jul 2014 23:41:31 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 23:41:30 -0700
Message-ID: <b1c51cb854393ae662b63034b60e1878fe7cdf14.1404455961.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1404455961.git.liezhi.yang@windriver.com>
References: <cover.1404455961.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake-user-manual-metadata.xml: remove populate_staging
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 04 Jul 2014 06:41:38 -0000
Content-Type: text/plain

There is no populate_staging any longer, should be populate_sysroot.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 .../bitbake-user-manual-metadata.xml               |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index a9f5072..a10a660 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -1466,9 +1466,9 @@
                 complete before that task can be executed.
                 Here is an example:
                 <literallayout class='monospaced'>
-     do_configure[deptask] = "do_populate_staging"
+     do_configure[deptask] = "do_populate_sysroot"
                 </literallayout>
-                In this example, the <filename>do_populate_staging</filename>
+                In this example, the <filename>do_populate_sysroot</filename>
                 task of each item in <filename>DEPENDS</filename> must complete before
                 <filename>do_configure</filename> can execute.
             </para>
@@ -1543,9 +1543,9 @@
                 the data in <filename>DEPENDS</filename>.
                 Here is an example:
                 <literallayout class='monospaced'>
-     do_patch[depends] = "quilt-native:do_populate_staging"
+     do_patch[depends] = "quilt-native:do_populate_sysroot"
                 </literallayout>
-                In this example, the <filename>do_populate_staging</filename>
+                In this example, the <filename>do_populate_sysroot</filename>
                 task of the target <filename>quilt-native</filename>
                 must have completed before the
                 <filename>do_patch</filename> task can execute.
-- 
1.7.9.5


