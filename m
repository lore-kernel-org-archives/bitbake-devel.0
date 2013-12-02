Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D1F716D86B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 17:48:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB2Hm00r000366
	for <bitbake-devel@lists.openembedded.org>; Mon, 2 Dec 2013 17:48:00 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id e20KlMsTlCtU for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 17:48:00 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB2Hlwsq000303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 2 Dec 2013 17:47:59 GMT
Message-ID: <1386006476.11222.110.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 02 Dec 2013 17:47:56 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] hob: Use BASEDATASTORE_TRACKING feature
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
X-List-Received-Date: Mon, 02 Dec 2013 17:48:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Might as well use this functionality now we have it available.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 817f638..06a05b6 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -308,9 +308,7 @@ class HobHandler(gobject.GObject):
         self.runCommand(["createConfigFile", ".hob.conf"])
 
     def reset_cooker(self):
-        self.runCommand(["enableDataTracking"])
         self.runCommand(["resetCooker"])
-        self.runCommand(["disableDataTracking"])
 
     def set_extra_inherit(self, bbclass):
         inherits = self.runCommand(["getVariable", "INHERIT"]) or ""
diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index 154a3b3..da5b411 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -46,7 +46,7 @@ from bb.ui.crumbs.hoblistmodel import RecipeListModel, PackageListModel
 from bb.ui.crumbs.hobeventhandler import HobHandler
 from bb.ui.crumbs.builder import Builder
 
-featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES]
+featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES, bb.cooker.CookerFeatures.BASEDATASTORE_TRACKING]
 
 def event_handle_idle_func(eventHandler, hobHandler):
     # Consume as many messages as we can in the time available to us



