Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SQMQ4-0004HZ-7S for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 19:35:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44HQ5ns016023
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 18:26:05 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15276-07 for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 May 2012 18:26:01 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44HPuug016017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 18:25:57 +0100
Message-ID: <1336152360.23777.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 May 2012 18:26:00 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2/wget: Remove unnecessary use of OVERRIDES
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
X-List-Received-Date: Fri, 04 May 2012 17:35:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This allows some simplifications of the function and is slightly faster.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index d3be069..89bf57b 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -55,12 +55,12 @@ class Wget(FetchMethod):
 
         def fetch_uri(uri, ud, d):
             if checkonly:
-                fetchcmd = data.getVar("CHECKCOMMAND", d, True)
+                fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True)
             elif os.path.exists(ud.localpath):
                 # file exists, but we didnt complete it.. trying again..
-                fetchcmd = data.getVar("RESUMECOMMAND", d, True)
+                fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True)
             else:
-                fetchcmd = data.getVar("FETCHCOMMAND", d, True)
+                fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True)
 
             uri = uri.split(";")[0]
             uri_decoded = list(decodeurl(uri))
@@ -80,10 +80,6 @@ class Wget(FetchMethod):
             if not os.path.exists(ud.localpath) and not checkonly:
                 raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
 
-        localdata = data.createCopy(d)
-        data.setVar('OVERRIDES', "wget:" + data.getVar('OVERRIDES', localdata), localdata)
-        data.update_data(localdata)
-
         fetch_uri(uri, ud, localdata)
         
         return True




