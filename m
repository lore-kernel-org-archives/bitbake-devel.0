Return-Path: <Rob.Woolley@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A721C73745
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 14:32:25 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t1REWQaa020136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 06:32:26 -0800 (PST)
Received: from yow-rwoolley-lx.wrs.com (128.224.146.40) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Fri, 27 Feb 2015 06:32:26 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Feb 2015 09:32:23 -0500
Message-ID: <1425047544-4820-3-git-send-email-rob.woolley@windriver.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] knotty: Do not log show_versions output
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
X-List-Received-Date: Fri, 27 Feb 2015 14:32:27 -0000
Content-Type: text/plain

Every time the bitbake show versions command (bitbake -s) is run it creates
a 100k log file.

The consolelogfile is disabled for show environment and disabling show
versions would make the behaviour match.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 09a4e0c..df0b854 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -271,7 +271,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         server.terminateServer()
         return
 
-    if consolelogfile and not params.options.show_environment:
+    if consolelogfile and not params.options.show_environment and not params.options.show_versions:
         bb.utils.mkdirhier(os.path.dirname(consolelogfile))
         conlogformat = bb.msg.BBLogFormatter(format_str)
         consolelog = logging.FileHandler(consolelogfile)
-- 
1.8.3.1


