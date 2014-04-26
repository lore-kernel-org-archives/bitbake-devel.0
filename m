Return-Path: <jacob.kroon@gmail.com>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
	[209.85.217.172])
	by mail.openembedded.org (Postfix) with ESMTP id 23D2065D30
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 14:34:08 +0000 (UTC)
Received: by mail-lb0-f172.google.com with SMTP id p9so2651949lbv.17
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Apr 2014 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=sender:from:to:subject:date:message-id;
	bh=w95rB04wqb8RjRYMW/GpNWAlvKAXGSUwQugkdRsjguw=;
	b=j+JAZ+3lg3UV1QuO83KUv1A6uKsccEw2rw1QEfileedh0vWcc2mvw1tUP2LvWyCr40
	1PXsYmGYHhv9Eu4FczBhp/NVA599WE6H374dzT+OIOoYM7n1R7mNmUYBAAjcLWHY/mUF
	Ew0HiAC+MmnDwNa6mfevBM3BM7aeSyNvoWxUPwhYOH90SF+IIdjufjWV8zoCKGabWnx3
	A67r7IRcN4/4lEaUvTO2St64RDc6HCs4shnQk+BkM75Mcmq4RrsEmAFE/ZEIGBhVjpjR
	s/GA+Pls8DI2pN0M3lsyFNeSfuqEggEoyM7U0E+XduN0+YaVjgA4aSYSw733sbo5LGDG
	L2Vw==
X-Received: by 10.152.30.41 with SMTP id p9mr10422934lah.26.1398522848336;
	Sat, 26 Apr 2014 07:34:08 -0700 (PDT)
Received: from localhost.localdomain (89-253-118-72.customers.ownit.se.
	[89.253.118.72])
	by mx.google.com with ESMTPSA id q4sm11892416lbl.14.2014.04.26.07.34.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 26 Apr 2014 07:34:07 -0700 (PDT)
Sender: Jacob Kroon <jacob.kroon@gmail.com>
From: Jacob Kroon <jacob.kroon@mikrodidakt.se>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 26 Apr 2014 16:32:18 +0200
Message-Id: <1398522738-8979-1-git-send-email-jacob.kroon@mikrodidakt.se>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH] fetch2: Cleanup file checksum generation
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
X-List-Received-Date: Sat, 26 Apr 2014 14:34:11 -0000

Cleanup the fix done in f9416e76e272ba3249abff099f6f3a47fe82e03e.

Instead of adding continue statements we can just move the last
statements into the final else-clause.

Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
---
 lib/bb/fetch2/__init__.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 5a03a0e..bc4e8fd 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -985,15 +985,12 @@ def get_file_checksums(filelist, pn):
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


