Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id C3E2571B87
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:09:05 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961550"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:09:05 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:14 +1300
Message-Id: <ce79c9d82bd21a08445c2cafd28c68bee76c376f.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 15/15] server/process: don't change UI process signal handler on terminate
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
X-List-Received-Date: Tue, 13 Dec 2016 07:09:05 -0000

On terminating the connection to the server, we were disabling SIGINT -
and this is executed on the UI side. I'm not sure whether the intention
here was to undo the SIGINT disabling we did in the server, and it was
just a mistake that it disabled rather than restored and it's run on the
wrong side, or whether we wanted to stop the user from breaking out of
the shutdown code - the commit message provides no clues either way.
Regardless, we do not want to permanently disable Ctrl+C here - it's
legitimate to terminate the connection to the server and then
re-establish it within the same process; at least currently, devtool
modify by virtue of using tinfoil in two separate parts of the code does
this, and the result of this disabling is that during the second tinfoil
usage we can potentially be parsing all recipes without the ability to
easily interrupt the process.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/server/process.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 1654faf..1036366 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -224,7 +224,6 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
                 if isinstance(event, logging.LogRecord):
                     logger.handle(event)
 
-        signal.signal(signal.SIGINT, signal.SIG_IGN)
         self.procserver.stop()
 
         while self.procserver.is_alive():
-- 
2.5.5


