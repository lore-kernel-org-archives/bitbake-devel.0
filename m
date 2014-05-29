Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D0E1A65E42
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 May 2014 17:18:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 May 2014 10:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,935,1392192000"; d="scan'208";a="548480131"
Received: from acdivito-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.240])
	by orsmga002.jf.intel.com with ESMTP; 29 May 2014 10:18:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 May 2014 18:17:16 +0100
Message-Id: <85658d5f5073fcdda8f8109253efb01e5b8abef7.1401383609.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1401383609.git.paul.eggleton@linux.intel.com>
References: <cover.1401383609.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1401383609.git.paul.eggleton@linux.intel.com>
References: <cover.1401383609.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] utils: avoid printing traceback on ExpansionError during parsing
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
X-List-Received-Date: Thu, 29 May 2014 17:18:41 -0000

If an ExpansionError occurs during better_exec() we should just raise it
instead of printing the traceback, so that recipe errors (such as broken
URLs in SRC_URI) are more easily comprehensible.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1be1874..ead5f36 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -357,6 +357,8 @@ def better_exec(code, context, text = None, realfile = "<code>"):
     except bb.BBHandledException:
         # Error already shown so passthrough
         raise
+    except bb.data_smart.ExpansionError:
+        raise
     except Exception as e:
         (t, value, tb) = sys.exc_info()
 
-- 
1.9.3


