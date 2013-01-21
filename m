Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1TxDu6-0005yK-VL
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 Jan 2013 10:43:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 596BE11FAA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w1F3U4FCOLfq for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id 8264811F7E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 2AEAD3E29D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Jan 2013 10:18:04 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Mon, 21 Jan 2013
	10:18:04 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id ED83E9C076; 
	Mon, 21 Jan 2013 10:18:03 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Jan 2013 10:18:02 +0100
Message-ID: <1358759883-7566-6-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 5/6] fetch2: Add editor modelines for bb.tests.*
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 21 Jan 2013 09:43:01 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/tests/codeparser.py |    2 ++
 lib/bb/tests/cow.py        |    2 ++
 lib/bb/tests/data.py       |    2 ++
 lib/bb/tests/fetch.py      |    2 ++
 lib/bb/tests/utils.py      |    2 ++
 5 files changed, 10 insertions(+)

diff --git lib/bb/tests/codeparser.py lib/bb/tests/codeparser.py
index 9b2d588..d2bd4a2 100644
--- lib/bb/tests/codeparser.py
+++ lib/bb/tests/codeparser.py
@@ -1,3 +1,5 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Test for codeparser.py
 #
diff --git lib/bb/tests/cow.py lib/bb/tests/cow.py
index 599b2aa..35c5841 100644
--- lib/bb/tests/cow.py
+++ lib/bb/tests/cow.py
@@ -1,3 +1,5 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for Copy-on-Write (cow.py)
 #
diff --git lib/bb/tests/data.py lib/bb/tests/data.py
index b2ab8ee..5161586 100644
--- lib/bb/tests/data.py
+++ lib/bb/tests/data.py
@@ -1,3 +1,5 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for the Data Store (data.py/data_smart.py)
 #
diff --git lib/bb/tests/fetch.py lib/bb/tests/fetch.py
index e765ca7..778d94f 100644
--- lib/bb/tests/fetch.py
+++ lib/bb/tests/fetch.py
@@ -1,3 +1,5 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for the Fetcher (fetch2/)
 #
diff --git lib/bb/tests/utils.py lib/bb/tests/utils.py
index 9f60491..7c50b1d 100644
--- lib/bb/tests/utils.py
+++ lib/bb/tests/utils.py
@@ -1,3 +1,5 @@
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
 #
 # BitBake Tests for utils.py
 #
-- 
1.7.10.4



