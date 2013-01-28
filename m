Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TzqIC-0007pg-3L for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 16:06:40 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0SEtU84006073 for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 14:55:30 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wKajfqbaW4rN for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 14:55:30 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r0SEtNtv006059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Jan 2013 14:55:27 GMT
Message-ID: <1359384646.22371.59.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 28 Jan 2013 14:50:46 +0000
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Subject: [PATCH] cache.py: Drop support for BROKEN variable
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
X-List-Received-Date: Mon, 28 Jan 2013 15:06:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

All it now does is function in a similar way to EXCLUDE_FROM_WORLD and
since we have a better named variable for this, lets just drop the
usage of BROKEN at the bitbake level.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index fd5fbb3..1c975b6 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -126,7 +126,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
         self.pv = self.getvar('PV', metadata)
         self.pr = self.getvar('PR', metadata)
         self.defaultpref = self.intvar('DEFAULT_PREFERENCE', metadata)
-        self.broken = self.getvar('BROKEN', metadata)
         self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
         self.stamp = self.getvar('STAMP', metadata)
         self.stampclean = self.getvar('STAMPCLEAN', metadata)        
@@ -233,7 +232,7 @@ class CoreRecipeInfo(RecipeInfoCommon):
 
         # Collect files we may need for possible world-dep
         # calculations
-        if not self.broken and not self.not_world:
+        if not self.not_world:
             cachedata.possible_world.append(fn)
 
         # create a collection of all targets for sanity checking




