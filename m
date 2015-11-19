Return-Path: <martin.samuelsson@axis.com>
X-Greylist: delayed 488 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 19 Nov 2015 13:04:49 UTC
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 065436010D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 691BA2E1F8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:56:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id sndVBu3LxsKB for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:56:40 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id B934C2E0D5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:56:40 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 9B57488
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:56:40 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 8F06F75
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:56:40 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 8A7DB3E45B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Nov 2015 13:56:40 +0100 (CET)
Received: from lnxmartinsa2.se.axis.com (10.92.55.2) by smtp-x.axis.com
	(10.0.5.74) with Microsoft SMTP Server (TLS) id 8.3.342.0;
	Thu, 19 Nov 2015 13:56:40 +0100
Date: Thu, 19 Nov 2015 13:56:39 +0100
From: Martin Samuelsson <martin.samuelsson@axis.com>
To: bitbake development advancement <bitbake-devel@lists.openembedded.org>
Message-ID: <20151119125639.GC19141@lnxmartinsa2.se.axis.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Subject: [PATCH] user-manual-metadata: Clarify functionality of task flag 'dirs'.
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
X-List-Received-Date: Thu, 19 Nov 2015 13:04:50 -0000
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline

Signed-off-by: Martin Samuelsson <martin.samuelsson@axis.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index 1b9d800..1d8bb92 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -1233,7 +1233,9 @@
                     section for more information.
                     </para></listitem>
                 <listitem><para><emphasis>dirs:</emphasis>
-                    Directories that should be created before the task runs.
+                    Directories that should be created before the task runs. The
+                    last directory listed will be used as the work directory for the
+                    task.
                     </para></listitem>
                 <listitem><para><emphasis>lockfiles:</emphasis>
                      Specifies one or more lockfiles to lock while the task
-- 
2.1.4


