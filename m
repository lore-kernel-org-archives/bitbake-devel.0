Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TCAYp-0007Aa-Tq for bitbake-devel@lists.openembedded.org;
	Thu, 13 Sep 2012 16:38:32 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8DEPwUC031412
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Sep 2012 15:25:58 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30864-07 for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Sep 2012 15:25:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q8DEPn4J031406
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Sep 2012 15:25:51 +0100
Message-ID: <1347546351.11710.103.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 13 Sep 2012 15:25:51 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: cooker: Fix priority for virtual recipes
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
X-List-Received-Date: Thu, 13 Sep 2012 14:38:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When making filename comparisons for recipes for priority calculations,
we need to split off any virtual prefix. Without this, BBCLASSEXTEND
version of recipes don't follow the priority settings they should.

[YOCTO #2933]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1b3bb84..4861212 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -642,7 +642,8 @@ class BBCooker:
         # Calculate priorities for each file
         matched = set()
         for p in self.status.pkg_fn:
-            self.status.bbfile_priority[p] = self.calc_bbfile_priority(p, matched)
+            realfn, cls = bb.cache.Cache.virtualfn2realfn(p)
+            self.status.bbfile_priority[p] = self.calc_bbfile_priority(realfn, matched)
  
         # Don't show the warning if the BBFILE_PATTERN did match .bbappend files
         unmatched = set()



