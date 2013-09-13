Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5DCC36100F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 16:34:54 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGm7Pf005191 for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:48:46 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id B0Uu1MVwr8gw for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:48:45 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGmfGQ005209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:48:43 +0100
Message-ID: <1379090082.3484.277.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 13 Sep 2013 17:34:42 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: updateCache should rause exceptions, not sys.exit
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
X-List-Received-Date: Fri, 13 Sep 2013 16:34:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Exiting from the server is antisocial, instead we should raise an exception. This
will correctly fail the current command and reset the server state. We use
the handled exception since for these conditions to occur, something was
already displayed to the user.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 0a4dc7e..a07615b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1172,7 +1172,7 @@ class BBCooker:
 
         if self.state in (state.shutdown, state.forceshutdown):
             self.parser.shutdown(clean=False, force = True)
-            sys.exit(1)
+            raise bb.BBHandledException()
 
         if self.state != state.parsing:
             self.parseConfiguration ()
@@ -1194,7 +1194,7 @@ class BBCooker:
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
             if self.parser.error:
-                sys.exit(1)
+                raise bb.BBHandledException()
             self.show_appends_with_no_recipes()
             self.handlePrefProviders()
             self.recipecache.bbfile_priority = self.collection.collection_priorities(self.recipecache.pkg_fn)



