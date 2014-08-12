Return-Path: <armccurdy@gmail.com>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
	[209.85.192.181])
	by mail.openembedded.org (Postfix) with ESMTP id EB04961585
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Aug 2014 23:41:55 +0000 (UTC)
Received: by mail-pd0-f181.google.com with SMTP id g10so13433659pdj.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Aug 2014 16:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=qKkawLxVdqIXV7+R8GbH3uI8MYm1R5yCq0dhpZWTJLI=;
	b=MA8FTlfw/bjFFAjqHjY1RN8rhqNVPrrAi1o14f/UUV6iCQUJ0GSyHjdNMOQpoeRWm3
	FYtj9rZWbrMKS5wp6CnDZsTz5JqLJIF71cKCGDhg0lkDdetEMuY+n8DSHRYZqJJ2w9yC
	IsdxY1v5QZ/wjduPdThca0uYIrPSOHlE59Njf8luGrxJVsa/kKiUVqm27SmD4shaNUBW
	8gYzw4HGQJRfR66jkuS0LV3Qrvu2kXlnkNz/Pef9Oh/5+X+s7DsEwHO22NtqsZzgdbh2
	zrOoG9576hc4JNS7viB7zvK4JkTpqDdEffgcXFfZ0QttJ0iSA3RqkqDxwO0hv5B3CWRm
	0rtw==
X-Received: by 10.68.125.202 with SMTP id ms10mr712766pbb.71.1407886916806;
	Tue, 12 Aug 2014 16:41:56 -0700 (PDT)
Received: from localhost.localdomain (c-73-162-180-210.hsd1.ca.comcast.net.
	[73.162.180.210])
	by mx.google.com with ESMTPSA id og3sm114829pbc.48.2014.08.12.16.41.55
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 12 Aug 2014 16:41:56 -0700 (PDT)
From: Andre McCurdy <armccurdy@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Aug 2014 16:41:48 -0700
Message-Id: <1407886908-6918-1-git-send-email-armccurdy@gmail.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] fetch2/local.py: fix first line indent of search path debug output
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
X-List-Received-Date: Tue, 12 Aug 2014 23:41:58 -0000

Make OE do_unpack logs slightly prettier.

Signed-off-by: Andre McCurdy <armccurdy@gmail.com>
---
 lib/bb/fetch2/local.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 5c4e42a..6fa188f 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -56,7 +56,7 @@ class Local(FetchMethod):
         if path[0] != "/":
             filespath = data.getVar('FILESPATH', d, True)
             if filespath:
-                logger.debug(2, "Searching for %s in paths:    \n%s" % (path, "\n    ".join(filespath.split(":"))))
+                logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
                 newpath = bb.utils.which(filespath, path)
             if not newpath:
                 filesdir = data.getVar('FILESDIR', d, True)
-- 
1.8.1.2


