Return-Path: <olof.johansson@axis.com>
X-Greylist: delayed 588 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 21 Aug 2014 08:35:14 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6A26060169
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 08:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id D639B1810B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id dsbNbbFMLyaX for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id B059B18104
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 930ED124D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 87E521086
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 85A5E34005
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Thu, 21 Aug 2014
	10:25:24 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 45B9C9C567; 
	Thu, 21 Aug 2014 10:25:24 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Aug 2014 10:25:24 +0200
Message-ID: <1408609524-1637-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] depexp: don't use undefined variable 'logging'
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
X-List-Received-Date: Thu, 21 Aug 2014 08:35:23 -0000
Content-Type: text/plain

This fixes an issue when trying to use depexp without specifying a
recipe. Before change:

  $ bitbake -g -udepexp
  Traceback (most recent call last):
    File ".../bitbake/bin/bitbake", line 382, in <module>
      ret = main()
    File ".../bitbake/bin/bitbake", line 370, in main
      return ui_module.main(server_connection.connection, server_connection.events, configParams)
    File ".../bitbake/lib/bb/ui/depexp.py", line 201, in main
      logger.error(cmdline['msg'])
  NameError: global name 'logger' is not defined

After change:

  $ bitbake -g -udepexp
  Please specify a package name for dependency graph generation.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/ui/depexp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/depexp.py b/lib/bb/ui/depexp.py
index 4578dce..5d13b5b 100644
--- a/lib/bb/ui/depexp.py
+++ b/lib/bb/ui/depexp.py
@@ -198,7 +198,7 @@ def main(server, eventHandler, params):
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
         if 'msg' in cmdline and cmdline['msg']:
-            logger.error(cmdline['msg'])
+            print(cmdline['msg'])
             return 1
         cmdline = cmdline['action']
         if not cmdline or cmdline[0] != "generateDotGraph":
-- 
1.9.1


