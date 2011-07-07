Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QeyCX-0002k2-9W for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jul 2011 01:41:46 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p67Nbrcb012796;
	Fri, 8 Jul 2011 00:37:53 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12733-02-2; Fri,  8 Jul 2011 00:37:40 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p67NVLQZ012128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jul 2011 00:31:22 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 08 Jul 2011 00:30:41 +0100
Message-ID: <1310081442.20015.860.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "Flanagan, Elizabeth" <elizabeth.flanagan@intel.com>
Subject: fetch2/git: Tweak git fetcher to handling repo updates correctly
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
X-List-Received-Date: Thu, 07 Jul 2011 23:41:46 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently the git fetcher can malfunction when branches change in remote
repositories since whilst the update code updates the "origin" remote,
this isn't linked to the local heads.

By passing the --mirror option to 'git clone' and 'git remote add',
linkage between the local heads and remote heads is created with a 1:1
mapping, hence all the appropriate heads are then updated correctly.

This fixes some issues which have been seen with the Yocto autobuilder
mirrors.

Signed-off-by: Richard Purdie <richard.purdie@linux-foundation.org>

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index f3bc793..7954f66 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -170,7 +170,7 @@ class Git(FetchMethod):
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            clone_cmd = "%s clone --bare %s://%s%s%s %s" % \
+            clone_cmd = "%s clone --bare --mirror %s://%s%s%s %s" % \
                   (ud.basecmd, ud.proto, username, ud.host, ud.path, ud.clonedir)
             bb.fetch2.check_network_access(d, clone_cmd)
             runfetchcmd(clone_cmd, d)
@@ -188,7 +188,7 @@ class Git(FetchMethod):
             except bb.fetch2.FetchError:
                 logger.debug(1, "No Origin")
             
-            runfetchcmd("%s remote add origin %s://%s%s%s" % (ud.basecmd, ud.proto, username, ud.host, ud.path), d)
+            runfetchcmd("%s remote add --mirror origin %s://%s%s%s" % (ud.basecmd, ud.proto, username, ud.host, ud.path), d)
             fetch_cmd = "%s fetch --all -t" % ud.basecmd
             bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
             runfetchcmd(fetch_cmd, d)



