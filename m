Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3EED37704E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 10:33:42 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 03 Feb 2016 02:33:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,389,1449561600"; d="scan'208";a="907544462"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2016 02:33:42 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Feb 2016 12:33:39 +0200
Message-Id: <1454495619-15453-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 2/2] data_smart: handle '\x7d' in python parsing
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
X-List-Received-Date: Wed, 03 Feb 2016 10:33:42 -0000

At least ncurses recipe uses a workaround (for former bitbake python
parser) where closing curly bracket inside a python string was replaced
by '\x7d' ascii code. The previous "curly bracket matching" patch broke
parsing of constructs like this as bitbake wouldn't correctly find the
closing bracket. This patch fixes this by accepting '\x7d' as a closing
bracket.

Hopefully, this patch could be reverted (and the python regexp thus
simplified) in the future after making sure that no recipes use the
'\x7d' workaround, anymore.

[YOCTO #8849]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 6069499..5f48fe3 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -41,7 +41,7 @@ logger = logging.getLogger("BitBake.Data")
 __setvar_keyword__ = ["_append", "_prepend", "_remove"]
 __setvar_regexp__ = re.compile('(?P<base>.*?)(?P<keyword>_append|_prepend|_remove)(_(?P<add>.*))?$')
 __expand_var_regexp__ = re.compile(r"\${[^{}@\n\t ]+}")
-__expand_python_regexp__ = re.compile(r"\${@(({[^{]*?})|.)+?}")
+__expand_python_regexp__ = re.compile(r"\${@(({[^{]*?(}|\\x7d))|.)+?}")
 
 def infer_caller_details(loginfo, parent = False, varval = True):
     """Save the caller the trouble of specifying everything."""
-- 
2.1.4


