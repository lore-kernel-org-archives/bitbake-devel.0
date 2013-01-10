Received: from mail-ee0-f41.google.com ([74.125.83.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martiert@gmail.com>) id 1TtE1K-0006X7-Rf
	for bitbake-devel@lists.openembedded.org;
	Thu, 10 Jan 2013 10:02:17 +0100
Received: by mail-ee0-f41.google.com with SMTP id d41so130502eek.14
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Jan 2013 00:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=/ti4mJkHMsLC7NnU8g2/miCDniUN9jAm3VX920hX9/k=;
	b=Y9HWrnnhY5VUjxiBjhPe3iqeC6tRxaWxcRHYLV4otOjfrjzakQ9zEGutyP7FDQ2/VP
	B6CNix/DiYW9NxWAd8yf4qjiMYF70AEVlOJDuZxm9SKiGlYrc1iJiLHxvRXRG2qFcvoN
	icN+/0CZA3zVdv4rNQaOvoKSyiTcfPkqynbXXv4dhnLwdR7h/ufApacn6I9xM1jP6491
	/BSvYqVXhmKp+yga0cdtkwVThauq+kMBqKl/4b37P5dijK+F3C0DgvJ4nS4tH8Mj6hqY
	m6LjJ4p4viiPlnEDgeqALUSE8j3gFh99x8Jp553ruXO95WZwJLLnKWpfryVQeeAeXJ/E
	qeyA==
X-Received: by 10.14.194.4 with SMTP id l4mr190722857een.42.1357807601845;
	Thu, 10 Jan 2013 00:46:41 -0800 (PST)
Received: from dhcp-10-54-86-82.cisco.com (64-103-25-233.cisco.com.
	[64.103.25.233])
	by mx.google.com with ESMTPS id w3sm1827373eel.17.2013.01.10.00.46.40
	(version=TLSv1 cipher=RC4-SHA bits=128/128);
	Thu, 10 Jan 2013 00:46:40 -0800 (PST)
From: Martin Ertsaas <martiert@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Jan 2013 09:46:36 +0100
Message-Id: <1357807596-31587-1-git-send-email-martiert@gmail.com>
X-Mailer: git-send-email 1.7.10.2 (Apple Git-33)
Subject: [PATCH] utils.py: Use shutil.rmtree if the path we wish to remove is a directory.
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
X-List-Received-Date: Thu, 10 Jan 2013 09:03:16 -0000

On mac, os.unlink does not remove directories, and we therefor have
to explicitly use shutil.rmtree if the path is a directory.
---
 lib/bb/utils.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index cef0fdd..8b6d3f5 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -561,7 +561,10 @@ def remove(path, recurse=False):
     import os, errno, shutil, glob
     for name in glob.glob(path):
         try:
-            os.unlink(name)
+            if os.path.isdir(name):
+                shutil.rmtree(name)
+            else:
+                os.unlink(name)
         except OSError as exc:
             if recurse and exc.errno == errno.EISDIR:
                 shutil.rmtree(name)
-- 
1.7.10.2 (Apple Git-33)



