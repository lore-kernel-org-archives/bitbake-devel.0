Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 569FE6DF8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Dec 2013 15:21:55 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB5FLntg013719; Thu, 5 Dec 2013 15:21:49 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gJjkk-bVm7dD; Thu,  5 Dec 2013 15:21:49 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB5FLhFJ013702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Thu, 5 Dec 2013 15:21:44 GMT
Message-ID: <1386256898.25847.22.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 05 Dec 2013 15:21:38 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: Gary Thomas <gary@mlbassoc.com>
Subject: [PATCH] fetch2/git: Add sanity check to ensure we really did fetch the correct revisions
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
X-List-Received-Date: Thu, 05 Dec 2013 15:21:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The fetcher made the rather bold assumption that if it fetched from the upstream,
the revisions were present and correct. These checks are fast and ensure that
really is the case. The avoids accidental network accessed and missing
branch configuration problems.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index a9470e4..2b9f8af 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -213,6 +213,9 @@ class Git(FetchMethod):
             runfetchcmd("%s prune-packed" % ud.basecmd, d)
             runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d)
             ud.repochanged = True
+        for name in ud.names:
+            if not self._contains_ref(ud.revisions[name], ud.branches[name], d):
+                raise bb.fetch2.FetchError("Unable to find revision %s in branch %s even from upstream" % (ud.revisions[name], ud.branches[name]))
 
     def build_mirror_data(self, ud, d):
         # Generate a mirror tarball if needed



