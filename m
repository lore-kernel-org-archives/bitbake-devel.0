Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 97B8160119
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jun 2016 21:32:31 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id v199so3359577wmv.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jun 2016 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=PLReNCDswm/WjHJiM9Q9/6GxdxyL15ZGgdE4we/ATAs=;
	b=BnbNVUPfCspLjEaqf29DjWZyVabjwdTkY1pc+5s7YF3wX3EVTFFckX61EoCbev/MLv
	L6YYXPKCV4J4wRvvFeB1VVTXtRy6VhRiZOq8RYed2mh5ePyxT/vOpzd/4js6RO+/4+4x
	LZ0xDF7wK+5lUY0HUMZ3bxBFI95ttw00yTaPxFC6PX382rHROl+T+JUUSQ8c31F4Of1i
	DM0xtkQ952JgmHu+KDpN7MUHRKVuiX+lVpywDrtTYe3q3uK0BwvJGfFoAY8BYEXzhBGF
	SnXvIDElmVQ1d3XwiZUnxVdkUSuZMfJwmkwv5WgPejSX2+6SYNbr4KgT9OJGt59wGP0+
	aSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=PLReNCDswm/WjHJiM9Q9/6GxdxyL15ZGgdE4we/ATAs=;
	b=OKKYHPiz/WhMQN9Ym/RmgCJ0Jx1RXUOFCF91by32ckZ64iZRi5rtm1guzUyo3F22Q+
	YMDG16yJnMCCRNJmCxTwzVnxjQq6j35z3eYalNhRq2+r1d2oALi3PHe9/WuAVs0xaKWn
	EdJSBq+L2bMtJWPBrSHrsBIoVD+Vhm5k4ucWrA5myVr5CD0Yoa9CQwrxv6wXDCnNj30C
	uRRKeMUwAOMTBnrr0W2Id+rxc2MZMT0uHFNXyAcE7ITpBayaonW8R6fN9D1XAPWHYPSD
	To0ri2UMQ/a16i116nTt1amiL6hS3xVa58wbmX5gOzS/fUJ0g1Ah+1HkByj6kLK+TISH
	WEmQ==
X-Gm-Message-State: ALyK8tJqagAYr+oiaxmkaO8EOBJVLALhXk9CSuy4k77oztDwp33abaTvn9eMeHWNGU+Zaj82
X-Received: by 10.195.10.131 with SMTP id ea3mr240494wjd.86.1467322351211;
	Thu, 30 Jun 2016 14:32:31 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id q71sm202538wme.17.2016.06.30.14.32.29
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 30 Jun 2016 14:32:30 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jun 2016 22:32:24 +0100
Message-Id: <1467322344-1356-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] fetch2/wget: attempt checkstatus again if it fails
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
X-List-Received-Date: Thu, 30 Jun 2016 21:32:34 -0000

Some services such as SourceForge seem to struggle to keep up under load, with
the result that over half of the autobuilder checkuri runs fail with
sourceforge.net "connection timed out".

Attempt to mitigate this by re-attempting once the network operation on failure.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index d688fd9..6cb22ae 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -104,7 +104,7 @@ class Wget(FetchMethod):
 
         return True
 
-    def checkstatus(self, fetch, ud, d):
+    def checkstatus(self, fetch, ud, d, try_again=True):
         import urllib.request, urllib.error, urllib.parse, socket, http.client
         from urllib.response import addinfourl
         from bb.fetch2 import FetchConnectionCache
@@ -278,9 +278,13 @@ class Wget(FetchMethod):
             r.get_method = lambda: "HEAD"
             opener.open(r)
         except urllib.error.URLError as e:
-            # debug for now to avoid spamming the logs in e.g. remote sstate searches
-            logger.debug(2, "checkstatus() urlopen failed: %s" % e)
-            return False
+            if try_again:
+                logger.debug(2, "checkstatus: trying again")
+                return self.checkstatus(fetch, ud, d, False)
+            else:
+                # debug for now to avoid spamming the logs in e.g. remote sstate searches
+                logger.debug(2, "checkstatus() urlopen failed: %s" % e)
+                return False
         return True
 
     def _parse_path(self, regex, s):
-- 
2.8.1


