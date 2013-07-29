Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id DC576612D1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 08:19:55 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Jul 2013 01:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,767,1367996400"; d="scan'208";a="378174471"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.206])
	by orsmga002.jf.intel.com with ESMTP; 29 Jul 2013 01:19:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 09:19:42 +0100
Message-Id: <a96b83e3c245749c3fe82de66be6383da6ce7ca6.1375085732.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1375085732.git.paul.eggleton@linux.intel.com>
References: <cover.1375085732.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1375085732.git.paul.eggleton@linux.intel.com>
References: <cover.1375085732.git.paul.eggleton@linux.intel.com>
Subject: [1.18][PATCH 2/2] bitbake: data_smart: Ensure variable flags are accounted for in config data hash
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 08:19:56 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Currently if the flags set against a variable in the base data store
change, it doesn't automatically trigger a reparse when it really
should. For example with the blacklist class setting:

PNBLACKLIST[qemu] = "bar"
PNBLACKLIST[bash] = "foo"

will not trigger a reparse if only one entry is changed and a
blacklisted recipe can still be built.

I did consider using BB_SIGNATURE_EXCLUDE_FLAGS in here however it
doesn't make sense, we want to trigger a reparse when any of the
flags change too (which is different to the sstate signatures which
we wouldn't want to change in those cases).

[YOCTO #4627]

(Bitbake master rev: ed74ea50043f6feb698c891e571feda2b9f8513d)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/data_smart.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 2fd8ccd..fa7811e 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -738,6 +738,12 @@ class DataSmart(MutableMapping):
             value = d.getVar(key, False) or ""
             data.update({key:value})
 
+            varflags = d.getVarFlags(key)
+            if not varflags:
+                continue
+            for f in varflags:
+                data.update({'%s[%s]' % (key, f):varflags[f]})
+
         for key in ["__BBTASKS", "__BBANONFUNCS", "__BBHANDLERS"]:
             bb_list = d.getVar(key, False) or []
             bb_list.sort()
-- 
1.8.1.2


