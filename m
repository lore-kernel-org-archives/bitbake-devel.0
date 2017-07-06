Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id DCE2B779C6
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Jul 2017 15:48:13 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v66FmDdO032637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 6 Jul 2017 16:48:14 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dT90n-0003Pi-5s; Thu, 06 Jul 2017 16:48:13 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Jul 2017 16:48:07 +0100
Message-Id: <1499356087-13072-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1499356087-13072-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1499356087-13072-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 06 Jul 2017 16:48:14 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 3/3] data: Micro performance optimisation tweak
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
X-List-Received-Date: Thu, 06 Jul 2017 15:48:14 -0000

The datastore can assume internal API, this just removes the function indirection
overhead involved in this very common codepath (800,000 calls in parsing OE-Core).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 134afaa..80a7879 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -290,7 +290,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             return deps, value
         varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
-        value = d.getVar(key, False)
+        value = d.getVarFlag(key, "_content", False)
 
         def handle_contains(value, contains, d):
             newvalue = ""
-- 
2.7.4


