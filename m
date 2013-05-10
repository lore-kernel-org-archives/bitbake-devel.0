Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UapNd-0000Om-Nz for bitbake-devel@lists.openembedded.org;
	Fri, 10 May 2013 17:37:10 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4AFLadE010733 for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:21:36 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id udsSNnWyqT_R for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:21:36 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4AFLYSh010717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 May 2013 16:21:35 +0100
Message-ID: <1368199134.11129.37.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 May 2013 16:18:54 +0100
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] cooker.py: Drop confusing updateCache calls
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
X-List-Received-Date: Fri, 10 May 2013 15:37:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

updateCache() gets called by command.py when needed and needs to be iterated
over. The calls in cooker.py are therefore just plain wrong/confusing now.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index cd3b6e3..b717de5 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -359,9 +359,6 @@ class BBCooker:
 
     def showVersions(self):
 
-        # Need files parsed
-        self.updateCache()
-
         pkg_pn = self.status.pkg_pn
         (latest_versions, preferred_versions) = bb.providers.findProviders(self.configuration.data, self.status, pkg_pn)
 
@@ -396,8 +393,6 @@ class BBCooker:
             fn = self.matchFile(fn)
             fn = bb.cache.Cache.realfn2virtual(fn, cls)
         elif len(pkgs_to_build) == 1:
-            self.updateCache()
-
             ignore = self.configuration.data.getVar("ASSUME_PROVIDED", True) or ""
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
@@ -445,8 +440,7 @@ class BBCooker:
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
         bb.event.fire(bb.event.TreeDataPreparationStarted(), self.configuration.data)
-        # Need files parsed
-        self.updateCache()
+
         # If we are told to do the None task then query the default task
         if (task == None):
             task = self.configuration.cmd
@@ -1208,9 +1202,6 @@ class BBCooker:
         Attempt to build the targets specified
         """
 
-        # Need files parsed
-        self.updateCache()
-
         # If we are told to do the NULL task then query the default task
         if (task == None):
             task = self.configuration.cmd




