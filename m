Return-Path: <jacob.kroon@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id B0A2860EFA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 17:16:29 +0000 (UTC)
Received: by mail-la0-f53.google.com with SMTP id ec20so5309649lab.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:subject:date:message-id;
	bh=0fpYq89Kgypip9Pl8ZIAk5dQ7rnCgz5sttq89id+u2g=;
	b=tqqI1XxsxApiZ6lQs8DQDKGMTm14nUoWMvz1yTo2chfbBGt26HbOj7qCpE6RM8e8qs
	gbFGld3G/b5uWX4OTzOPBbWw9iadMpd9PYO3+nz3fm0L8PD2rmMAEvNIxk4jEew6+lw0
	IsPJ6OG5eA73TWUJNzvYYjyzb3OVNGGenrvDMQY92rm2U9Q5Nmy8DSsmfEi6zRj9UTgm
	fgAXMFK9PYroS+vFBjHn+Dx4sa9wA4GRgWFDZleOmQrG82BU/Oowk6jKuURAxg1/9ZCk
	e14tkeuBYmSLbhDNv/GHaJKRhGEOLFp4fGu/X2LWVeR5t/Aku3qR2acnI7ZXFwM+JYGK
	ay9Q==
X-Received: by 10.152.197.98 with SMTP id it2mr1657864lac.53.1398705389736;
	Mon, 28 Apr 2014 10:16:29 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
	[89.253.118.72]) by mx.google.com with ESMTPSA id
	jo7sm19551683lbc.28.2014.04.28.10.16.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Apr 2014 10:16:29 -0700 (PDT)
Sender: Jacob Kroon <jacob.kroon@gmail.com>
From: Jacob Kroon <jacob.kroon@mikrodidakt.se>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Apr 2014 19:14:56 +0200
Message-Id: <1398705296-14237-1-git-send-email-jacob.kroon@mikrodidakt.se>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH] fetch2: Cleanup file checksum generation, v2
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
X-List-Received-Date: Mon, 28 Apr 2014 17:16:31 -0000

The initial version of this patch was reverted in

0a94e568152de550dedc8135a766beb18bf064ab

However, it was later agreed upon that it was reverted due to
a misunderstanding during code review; the patch is ok.

This version of the patch also removes an unneeded initialization of
the 'checksum' variable outside the scopes it is being used in.

Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
---
 lib/bb/fetch2/__init__.py | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5a03a0e..5a9c72f 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -975,7 +975,6 @@ def get_file_checksums(filelist, pn):
 
     checksums = []
     for pth in filelist.split():
-        checksum = None
         if '*' in pth:
             # Handle globs
             for f in glob.glob(pth):
@@ -985,15 +984,12 @@ def get_file_checksums(filelist, pn):
                     checksum = checksum_file(f)
                     if checksum:
                         checksums.append((f, checksum))
-            continue
         elif os.path.isdir(pth):
             checksums.extend(checksum_dir(pth))
-            continue
         else:
             checksum = checksum_file(pth)
-
-        if checksum:
-            checksums.append((pth, checksum))
+            if checksum:
+                checksums.append((pth, checksum))
 
     checksums.sort(key=operator.itemgetter(1))
     return checksums
-- 
1.9.0


