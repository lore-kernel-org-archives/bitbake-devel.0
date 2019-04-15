Return-Path: <sk@typedivision.de>
X-Greylist: delayed 511 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 15 Apr 2019 21:51:22 UTC
Received: from smtp03.udag.de (smtp03.udag.de [62.146.106.29])
	by mail.openembedded.org (Postfix) with ESMTP id 665AD7D279
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Apr 2019 21:51:22 +0000 (UTC)
Received: from MyMacBook.fritz.box (x4e369202.dyn.telefonica.de [78.54.146.2])
	by smtp03.udag.de (Postfix) with ESMTPA id 20951CC7B;
	Mon, 15 Apr 2019 23:42:50 +0200 (CEST)
From: sk <sk@typedivision.de>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 15 Apr 2019 23:42:21 +0200
Message-Id: <20190415214221.68755-1-sk@typedivision.de>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
X-Mailman-Approved-At: Wed, 17 Apr 2019 09:09:58 +0000
Cc: Stefan Kral <sk@typedivision.de>
Subject: [PATCH] Add verbnote to shell log commands
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
X-List-Received-Date: Mon, 15 Apr 2019 21:51:22 -0000

From: Stefan Kral <sk@typedivision.de>

Add the missing bbverbnote fifo cmd for logging from shell.
---
 lib/bb/build.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 3e2a94ed..b2208d27 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -407,6 +407,8 @@ exit $ret
                     bb.plain(value)
                 elif cmd == 'bbnote':
                     bb.note(value)
+                elif cmd == 'bbverbnote':
+                    bb.verbnote(value)
                 elif cmd == 'bbwarn':
                     bb.warn(value)
                 elif cmd == 'bberror':
-- 
2.17.2 (Apple Git-113)


