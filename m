Return-Path: <tobias.hagelborn@axis.com>
X-Greylist: delayed 558 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 29 Jan 2018 15:09:27 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2DA55605C3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 15:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 6BD8E1843D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:13 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id WKsWRAAJUN7m for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:12 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id C4F791829F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:12 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B306D1E077
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:12 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7D861E074
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:12 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:12 +0100 (CET)
Received: from XBOX02.axis.com (xbox02.axis.com [10.0.5.16])
	by seth.se.axis.com (Postfix) with ESMTP id 9BEFA3178
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 16:00:12 +0100 (CET)
Received: from lnxtobiasha.se.axis.com (10.0.5.60) by XBOX02.axis.com
	(10.0.5.16) with Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Mon, 29 Jan 2018 16:00:11 +0100
From: Tobias Hagelborn <tobias.hagelborn@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 Jan 2018 15:59:52 +0100
Message-ID: <1517237992-4829-2-git-send-email-tobiasha@axis.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1517237992-4829-1-git-send-email-tobiasha@axis.com>
References: <1517237992-4829-1-git-send-email-tobiasha@axis.com>
MIME-Version: 1.0
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: XBOX03.axis.com (10.0.5.17) To XBOX02.axis.com (10.0.5.16)
X-TM-AS-GCONF: 00
Cc: Tobias Hagelborn <tobiasha@axis.com>
Subject: [PATCH] utils.py: Support cross device move into existing directory
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
X-List-Received-Date: Mon, 29 Jan 2018 15:09:28 -0000
Content-Type: text/plain

movefile fails copying files cross-device into existing target
directory.

Using copy instead of copyfile in this case.

Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>
---
 bitbake/lib/bb/utils.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index c540b49..6769ed6 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -791,9 +791,8 @@ def movefile(src, dest, newmtime = None, sstat = None):
     if renamefailed:
         didcopy = 0
         if stat.S_ISREG(sstat[stat.ST_MODE]):
-            try: # For safety copy then move it over.
-                shutil.copyfile(src, destpath + "#new")
-                os.rename(destpath + "#new", destpath)
+            try:
+                shutil.copy(src, dest)
                 didcopy = 1
             except Exception as e:
                 print('movefile: copy', src, '->', dest, 'failed.', e)
-- 
2.1.4


