Return-Path: <Zhixiong.Chi@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A89BD77D17
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 09:22:45 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v3A9MkHC024600
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 02:22:46 -0700 (PDT)
Received: from pek-zchi-d1.corp.ad.wrs.com (128.224.162.239) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.294.0; Mon, 10 Apr 2017 02:22:45 -0700
From: Zhixiong Chi <zhixiong.chi@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 10 Apr 2017 17:22:44 +0800
Message-ID: <1491816164-18274-1-git-send-email-zhixiong.chi@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: bitbake-layers: add signal hander to avoid exception
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
X-List-Received-Date: Mon, 10 Apr 2017 09:22:47 -0000
Content-Type: text/plain

Fixed:
bitbake-layers show-recipes | less
press "q" to exit

There will be a Broken pipe error output as follows:
"BrokenPipeError: [Errno 32] Broken pipe"

Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
---
 bin/bitbake-layers | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 390ad05..d58022d 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -20,6 +20,7 @@
 # with this program; if not, write to the Free Software Foundation, Inc.,
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
+from signal import signal, SIGPIPE, SIG_DFL
 import logging
 import os
 import sys
@@ -35,6 +36,7 @@ import bb.msg
 logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
 
 def main():
+    signal(SIGPIPE, SIG_DFL)
     parser = argparse.ArgumentParser(
         description="BitBake layers utility",
         epilog="Use %(prog)s <subcommand> --help to get help on a specific command",
-- 
1.9.1


