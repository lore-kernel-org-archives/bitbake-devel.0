Return-Path: <alejandro.hernandez@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id AF45372A23
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Apr 2015 20:21:47 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 09 Apr 2015 13:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,552,1422950400"; d="scan'208";a="706462426"
Received: from carloses-mobl.amr.corp.intel.com (HELO
	aehernan-DevStation.lar.corp.intel.com) ([10.252.254.35])
	by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2015 13:21:48 -0700
From: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Apr 2015 15:21:49 -0500
Message-Id: <1428610909-12661-2-git-send-email-alejandro.hernandez@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1428610909-12661-1-git-send-email-alejandro.hernandez@linux.intel.com>
References: <1428610909-12661-1-git-send-email-alejandro.hernandez@linux.intel.com>
Subject: [PATCH 1/1] [daisy][dizzy] data.py: fixes bad substitution when running devshell
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
X-List-Received-Date: Thu, 09 Apr 2015 20:21:48 -0000

From: Richard Tollerton <rich.tollerton@ni.com>

Running bitbake inside make results in the exported environment variable
MAKEOVERRIDES="${-*-command-variables-*-}", which the shell chokes on
when trying to expand it. But of course, it probably shouldn't have been
trying to expand it in the first place -- so just escape the dollar
sign.

(Bitbake rev: 18cd0ce6a55c9065c3f1bf223b47d817b5efcd8f)

Signed-off-by: Richard Tollerton <rich.tollerton@ni.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Alejandro Hernandez <alejandro.hernandez@linux.intel.com>

---
 bitbake/lib/bb/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index eb628c7..82eefef 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -238,6 +238,7 @@ def emit_var(var, o=sys.__stdout__, d = init(), all=False):
     # to a shell, we need to escape the quotes in the var
     alter = re.sub('"', '\\"', val)
     alter = re.sub('\n', ' \\\n', alter)
+    alter = re.sub('\\$', '\\\\$', alter)
     o.write('%s="%s"\n' % (varExpanded, alter))
     return 0
 
-- 
1.9.1


