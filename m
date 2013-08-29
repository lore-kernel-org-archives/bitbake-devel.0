Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id CCC2C6BC98
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 13:27:04 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7TDdXKl014115 for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 14:39:33 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SXOkgEH30VxQ for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 14:39:33 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7TDdVlD014112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Aug 2013 14:39:33 +0100
Message-ID: <1377782813.1059.0.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 29 Aug 2013 14:26:53 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cookerdata: Set TOPDIR when using bblayers.conf
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
X-List-Received-Date: Thu, 29 Aug 2013 13:27:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

By definition, bblayers.conf is at the top of the build tree. We'd like
to support running bitbake anywhere within that build tree but TOPDIR
gets set to wherever cwd is. Change the code to reset TOPDIR
to the top of the build directory.

This shouldn't break anything but does make the system more usable.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index a0379cf..8a0bc22 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -239,6 +239,9 @@ class CookerDataBuilder(object):
         layerconf = self._findLayerConf()
         if layerconf:
             parselog.debug(2, "Found bblayers.conf (%s)", layerconf)
+            # By definition bblayers.conf is in conf/ of TOPDIR.
+            # We may have been called with cwd somewhere else so reset TOPDIR
+            data.setVar("TOPDIR", os.path.dirname(os.path.dirname(layerconf)))
             data = parse_config_file(layerconf, data)
 
             layers = (data.getVar('BBLAYERS', True) or "").split()



