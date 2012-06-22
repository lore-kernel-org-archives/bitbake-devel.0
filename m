Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Si2cJ-0000Wm-PX for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jun 2012 14:05:36 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBsnhA001151
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:54:49 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01132-01 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:54:44 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBseBC001145
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:54:41 +0100
Message-ID: <1340366082.394.17.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jun 2012 12:54:42 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2: Handle errors orruring when building mirror urls
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
X-List-Received-Date: Fri, 22 Jun 2012 12:05:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When we build the mirror urls, its possible an error will occur. If it
does, it should just mean we don't attempt this mirror url. The current
code actually aborts *all* the mirrors, not just the failed url.

This patch catches and logs the exception allowing things to continue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0b256ae..a38cb8f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -503,9 +503,18 @@ def build_mirroruris(origud, mirrors, ld):
             newuri = uri_replace(ud, find, replace, replacements, ld)
             if not newuri or newuri in uris or newuri == origud.url:
                 continue
+            try:
+                newud = FetchData(newuri, ld)
+                newud.setup_localpath(ld)
+            except bb.fetch2.BBFetchException as e:
+                logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
+                logger.debug(1, str(e))
+                try:
+                    ud.method.clean(ud, ld)
+                except UnboundLocalError:
+                    pass
+                continue   
             uris.append(newuri)
-            newud = FetchData(newuri, ld)
-            newud.setup_localpath(ld)
             uds.append(newud)
 
             adduri(newuri, newud, uris, uds)



