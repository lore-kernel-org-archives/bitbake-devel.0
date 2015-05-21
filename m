Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5437160168
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 May 2015 01:01:23 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t4L11O22022826
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 May 2015 18:01:24 -0700 (PDT)
Received: from localhost.localdomain (147.11.119.7) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Wed, 20 May 2015 18:01:23 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 May 2015 20:01:02 -0500
Message-ID: <1432170062-20572-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] bitbake-worker: Fix regression with unbuffered logs
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
X-List-Received-Date: Thu, 21 May 2015 01:01:25 -0000
Content-Type: text/plain

I noticed that I was seeing loss of the log files when hitting
control-c while debugging a function in bitbake.  In fact if you
take a recipe and replace its compile function as shown below let
it run for a few seconds and hit control-c, you will see first
hand that log data is not there.

do_compile () {
        while [ 1 ] ; do
                echo -n "Output date: "
                date
                sleep 1
        done
}

It turns out there was a regression introduced by commit:
d0f0e5d9e69 which created the bitbake worker.  Since the bitbake
worker is started in its own process space, it needs the exact
same code added from commit: 88429f018b where the problem was
fixed the first time around.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake-worker | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 8a24161..96a4d4c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -24,6 +24,15 @@ if sys.argv[1] == "decafbadbad":
     except:
         import profile
 
+# Unbuffer stdout to avoid log truncation in the event
+# of an unorderly exit as well as to provide timely
+# updates to log files for use with tail
+try:
+    if sys.stdout.name == '<stdout>':
+        sys.stdout = os.fdopen(sys.stdout.fileno(), 'w', 0)
+except:
+    pass
+
 logger = logging.getLogger("BitBake")
 
 try:
-- 
1.9.1


