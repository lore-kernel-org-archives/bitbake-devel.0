Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E69A96E872
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Feb 2014 14:07:49 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 17 Feb 2014 06:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,860,1384329600"; d="scan'208";a="456876177"
Received: from nithyasr-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.246])
	by orsmga001.jf.intel.com with ESMTP; 17 Feb 2014 06:07:50 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Feb 2014 14:07:41 +0000
Message-Id: <54dc5e6cfb5376c07717eedab121a96454555899.1392645935.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <cover.1392645935.git.paul.eggleton@linux.intel.com>
References: <cover.1392645935.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1392645935.git.paul.eggleton@linux.intel.com>
References: <cover.1392645935.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] build: fix handling of task override for tasks with underscores in their names
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
X-List-Received-Date: Mon, 17 Feb 2014 14:07:50 -0000

Tasks whose names contain underscores (such as do_populate_sdk in OE)
when converted to a task override do not function properly. If we
replace underscores with hyphens we can still have a working override
for these tasks.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 692b91e..50a28dc 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -330,7 +330,7 @@ def _task_data(fn, task, d):
     localdata.setVar('BB_FILENAME', fn)
     localdata.setVar('BB_CURRENTTASK', task[3:])
     localdata.setVar('OVERRIDES', 'task-%s:%s' %
-                     (task[3:], d.getVar('OVERRIDES', False)))
+                     (task[3:].replace('_', '-'), d.getVar('OVERRIDES', False)))
     localdata.finalize()
     bb.data.expandKeys(localdata)
     return localdata
-- 
1.8.5.3


