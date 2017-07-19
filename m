Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 22A9C7821B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 19 Jul 2017 09:56:46 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2017 02:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,380,1496127600"; d="scan'208";a="880410416"
Received: from gsena-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.213])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2017 02:56:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 19 Jul 2017 11:56:04 +0200
Message-Id: <4e241cfc7b594fc5443b4028d2f69188d427cef6.1500458081.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1500458081.git.paul.eggleton@linux.intel.com>
References: <cover.1500458081.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 05/12] lib/bb/ui/uihelper: indicate to caller of eventHandler() if events handled
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
X-List-Received-Date: Wed, 19 Jul 2017 09:56:46 -0000

It is useful for the caller to know whether the uihelper has handled the
event passed so that it can skip other event handling code if so.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/uihelper.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 113fced..963c1ea 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -61,6 +61,9 @@ class BBUIHelper:
                 self.running_tasks[event.pid]['progress'] = event.progress
                 self.running_tasks[event.pid]['rate'] = event.rate
                 self.needUpdate = True
+        else:
+            return False
+        return True
 
     def getTasks(self):
         self.needUpdate = False
-- 
2.9.4


