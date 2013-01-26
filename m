Received: from mail-ia0-f170.google.com ([209.85.210.170])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TyuKD-0005mE-Ic
	for bitbake-devel@lists.openembedded.org;
	Sat, 26 Jan 2013 02:12:53 +0100
Received: by mail-ia0-f170.google.com with SMTP id k20so1572592iak.15
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2013 16:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=kVeHDRWVV81sF+4v1AqJ2gMdU2u3mRJytvw1B8Ucuqg=;
	b=Klemtt+YmtaB/hZdZTcmhtxTBiDGQ097zMM5kiwe7f/uXaeqC59xuRzEevvW8C3wzJ
	DRkuyZHGAfbVpAfBpN7Ki04azItCw9tY3o0maSlujyh3VWsejJ7/I8a/z8IfWrM9Agir
	DVcW0p9hUSwXxsxvXC28htEUgcWSz7y0elk2VCNc7GTJe8F7iwGhWYbnCXwvUFE8Qywn
	yxfLnIxrI83xusdkTJYPRkYquHB76V9LTPY+4YyGQ4+DVrU/wIicudp5LHEEz9bsoUgj
	iBnJBy1ggHtOap7QfkENMlz+4fKTIu8KcLIxkQ5qKwPa1+kCDkAWIdpCEh5lWVKgXjqn
	/J/w==
X-Received: by 10.50.202.3 with SMTP id ke3mr220615igc.49.1359161836407;
	Fri, 25 Jan 2013 16:57:16 -0800 (PST)
Received: from precise64.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPS id ua8sm324192igb.12.2013.01.25.16.57.14
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 25 Jan 2013 16:57:15 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2013 17:56:30 -0700
Message-Id: <1359161790-4482-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.8.0.3
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] tinfoil: support other fds, enable color support
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
X-List-Received-Date: Sat, 26 Jan 2013 01:12:53 -0000

From: Christopher Larson <chris_larson@mentor.com>

Rather than only handling sys.stdout, also support any arbitrary file object,
and enable color for the formatter if that file is a tty.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/tinfoil.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 73d8fe9..cb53f3e 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -29,15 +29,17 @@ from bb.cooker import state
 import bb.fetch2
 
 class Tinfoil:
-    def __init__(self):
+    def __init__(self, output=sys.stdout):
         # Needed to avoid deprecation warnings with python 2.6
         warnings.filterwarnings("ignore", category=DeprecationWarning)
 
         # Set up logging
         self.logger = logging.getLogger('BitBake')
-        console = logging.StreamHandler(sys.stdout)
-        format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+        console = logging.StreamHandler(output)
         bb.msg.addDefaultlogFilter(console)
+        format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+        if output.isatty():
+            format.enable_color()
         console.setFormatter(format)
         self.logger.addHandler(console)
 
-- 
1.8.0.3



