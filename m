Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1SwM7z-00066b-0e
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Aug 2012 01:45:27 +0200
Received: by weyr6 with SMTP id r6so4341857wey.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Jul 2012 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
	bh=dt32FvGclJ548tjT+UeEo9cTtGyeGwP/2Q7znrtWklc=;
	b=Wtl/Pe6/qdfychUhPn9F2ExOEhROEGyBI8tGiUE0kTz11xk+6UbRLwrIDy4h+JOGwe
	JLv6Z8K+oIfzJ9qpovWXHth2qZsy/bY/I2Te3qxdJSMFzFs1WtOt8Qsc91IWZeWSUxKP
	JQnVnSvNIp7XfxMszKD3iF9ectnEEzwTUmiLXGMz9EJZcLDnDHaC+8gW7NC0IRkIeCOd
	NszIy1lv0PcmVSMYtb6TN8e5rLKAzqIZIn88t+HZHv/xCDieY+JHPyxJ7DZvlHZdMVFF
	gIEyfUPY9iBw+CyFBou+HYEdFJF3rAKt0JEHXiziMPrEjQzw1rLmqHJcnzl9yORGccah
	Fa7Q==
Received: by 10.216.138.200 with SMTP id a50mr7898237wej.155.1343777629566;
	Tue, 31 Jul 2012 16:33:49 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id ex20sm3960827wid.7.2012.07.31.16.33.47
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 31 Jul 2012 16:33:48 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Aug 2012 01:33:41 +0200
Message-Id: <1343777621-27958-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.8.6
In-Reply-To: <1343732491-12072-1-git-send-email-Martin.Jansa@gmail.com>
References: <1343732491-12072-1-git-send-email-Martin.Jansa@gmail.com>
Subject: [PATCHv2] fetch2: print checksums when they are different then expected
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
X-List-Received-Date: Tue, 31 Jul 2012 23:45:27 -0000

* in form which can be copied into a recipe without modification
* like oe-classic did since:
  http://git.openembedded.org/openembedded/commit/?id=68abc465559a68e9201c9525be3c4acc6297eaed
* it shows them in right form when they are missing completely, but in
  more verbose form when different
* it needs to print that only when checksums were requested, e.g.
  fetching from sstate mirror sets both md5mismatch and sha256mismatch,
  but your checksums shouldn't be shown

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/__init__.py |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fa963be..31602fe 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -342,11 +342,17 @@ def verify_checksum(u, ud, d):
     # We want to alert the user if a checksum is defined in the recipe but
     # it does not match.
     msg = ""
+    mismatch = False
     if md5mismatch and ud.md5_expected:
         msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'md5', md5data, ud.md5_expected)
+        mismatch = True;
 
     if sha256mismatch and ud.sha256_expected:
         msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected)
+        mismatch = True;
+
+    if mismatch:
+        msg = msg + '\nYour checksums:\nSRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
 
     if len(msg):
         raise ChecksumError('Checksum mismatch!%s' % msg, u)
-- 
1.7.8.6



