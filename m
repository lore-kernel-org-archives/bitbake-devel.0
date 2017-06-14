Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id DD872782EF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 10:10:51 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	14 Jun 2017 03:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,340,1493708400"; d="scan'208";a="867840908"
Received: from petrova-mobl12.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.48.250])
	by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2017 03:10:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jun 2017 12:10:25 +0200
Message-Id: <be5e5d97538e3ab7e946ed144c24674e2d62c4b8.1497434991.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1497434991.git.paul.eggleton@linux.intel.com>
References: <cover.1497434991.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] cooker: ensure graceful exit after exception during BuildCompleted handler
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
X-List-Received-Date: Wed, 14 Jun 2017 10:10:52 -0000

If an event handler for bb.event.BuildCompleted fails, we still need to
call finishAsyncCommand() or else BitBake will just exit immediately
without showing any error summary, or worse in the case of memory
resident mode BitBake will hang and if you Ctrl+C to break out, the
command won't be marked as finished which means that no further commands
will be able to be executed until the server is manually restarted.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/cooker.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 6a1b649..479dc5a 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1361,8 +1361,10 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, targets, failures, interrupted), self.data)
-                self.command.finishAsyncCommand(msg)
+                try:
+                    bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, targets, failures, interrupted), self.data)
+                finally:
+                    self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
                 return True
-- 
2.9.4


