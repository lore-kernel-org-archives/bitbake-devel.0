Received: from bgl-iport-1.cisco.com ([72.163.197.25])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mertsas@cisco.com>) id 1Srp8r-0002pw-BK
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jul 2012 13:43:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=cisco.com; i=mertsas@cisco.com; l=1005; q=dns/txt;
	s=iport; t=1342697538; x=1343907138;
	h=from:to:cc:subject:date:message-id;
	bh=AGwrj8swoyo9XyIr6wcsliHoOTcap/JmwfG6joKJ7ns=;
	b=VSlDzuV2aHCXjhNnGO0iy4XhcIZepZceTZ8L63N/oqzJfnNGwHHzLqN8
	bphQBQXVF03Ru9vD2uBHgdfuuNO1C28R6pAqj1iI4A5c6EKtiWMEREOOE
	WVbHoGbi1gmQ4iJZ1icyTT2c4MTbyAUWaduT/tFmeJQZor6pjxLjP4f9a w=;
X-IronPort-AV: E=Sophos;i="4.77,615,1336348800"; d="scan'208";a="15162024"
Received: from vla196-nat.cisco.com (HELO bgl-core-3.cisco.com)
	([72.163.197.24])
	by bgl-iport-1.cisco.com with ESMTP; 19 Jul 2012 11:31:08 +0000
Received: from Lan.cisco.com (dhcp-10-54-74-11.cisco.com [10.54.74.11])
	by bgl-core-3.cisco.com (8.14.5/8.14.5) with ESMTP id q6JBV6r6020271;
	Thu, 19 Jul 2012 11:31:06 GMT
From: Martin Ertsaas <mertsas@cisco.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jul 2012 13:26:25 +0200
Message-Id: <1342697185-7332-1-git-send-email-mertsas@cisco.com>
X-Mailer: git-send-email 1.7.8.6
Subject: [PATCH] Change bzr fetcher to use branch instead of co. Fixes: bzr: ERROR: No pull location known or specified.
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
X-List-Received-Date: Thu, 19 Jul 2012 11:43:37 -0000

This problem occurs when fetching a different revision of the same source. Which mean every time you update a bzr package.
Using branch sets the pull location, and are the preferred way of cloning/branching a repository in bzr.

Signed-off-by: Martin Ertsaas <mertsas@cisco.com>
---
 lib/bb/fetch2/bzr.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/bzr.py b/lib/bb/fetch2/bzr.py
index 97daa62..58e80c8 100644
--- a/lib/bb/fetch2/bzr.py
+++ b/lib/bb/fetch2/bzr.py
@@ -73,7 +73,7 @@ class Bzr(FetchMethod):
                 options.append("-r %s" % ud.revision)
 
             if command == "fetch":
-                bzrcmd = "%s co %s %s://%s" % (basecmd, " ".join(options), proto, bzrroot)
+                bzrcmd = "%s branch %s %s://%s" % (basecmd, " ".join(options), proto, bzrroot)
             elif command == "update":
                 bzrcmd = "%s pull %s --overwrite" % (basecmd, " ".join(options))
             else:
-- 
1.7.8.6



