Return-Path: <ross.burton@intel.com>
Received: from mail-wr0-f179.google.com (mail-wr0-f179.google.com
	[209.85.128.179])
	by mail.openembedded.org (Postfix) with ESMTP id 788AF77CFB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 13:34:19 +0000 (UTC)
Received: by mail-wr0-f179.google.com with SMTP id k6so55416330wre.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 06:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=5d40UEBevCUiP5u26K2iYxWidrWZoAoNrf4QeesEmn0=;
	b=cie4FK3KztOKSQLexv5g9Aa1rVBHlgtsFWLItmT/B47RNUXPPmn5cz7rl/1c6ANvn1
	snv30cLAzDRCo6w/JSm5HCm88g6tdG6lIwaEpwtEerWxVeJaoLM11Q5C5yIQ0gjyUAK9
	zistoYtXIcJB6oJQCTlIvY/r3qZ3Wb8f3zntB4QOTsAXWcWCCyKCGpCAfLj854CfZqRr
	0pGWLn/e35OdR2Cr07A39cHFbPE/F7Omio5yFDQ79/QclM56AbpRmyrhyLH2AlH8pt0B
	hLrxeUh7gwhbSsmcBOwgzNhN5pKrH78pOjN0v1p/J8cQzTejBbsYV5qF4OXKDaJG8Eat
	Pj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=5d40UEBevCUiP5u26K2iYxWidrWZoAoNrf4QeesEmn0=;
	b=CI+qPFTjJSEffdFHRBnPz1vRWc/eIGESDh2Sb7dhiskSN8qFYyLKPZZZPvHeGZ4E0w
	rL96PpSG0z6w4qljYQeKYzYx41weTK156PZ7U20iCvU9UYUEqG5IqkHbQWAkhmsRdWDm
	++52bn6vkFQEWJUbIjIERAcnixNZmEjtKgXvkBSbp6Wsg4LiU69bwMMXcCQa02cVWTWf
	VVaiYUJLp0U3rn4LxePKDc0yXsTOCxd1NDRmKE+eMyZLs4EvLCJLyLiH0Fgu0VxYn3em
	cyDGys4yCNdVZGE5OsCOJlRZ0C3qiXspc1n5P8oMIUlCX6UwXgx9GqROknObYRZSUPNp
	wF8A==
X-Gm-Message-State: AFeK/H1t6fBEHSzulLgPBYyjl/9yBw43N6kPQ7/l0CpLjwsCObeP81iNcMrRq5yttZI5U/W3
X-Received: by 10.28.168.150 with SMTP id r144mr427992wme.43.1490880859937;
	Thu, 30 Mar 2017 06:34:19 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	b66sm1273848wrd.29.2017.03.30.06.34.19
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 30 Mar 2017 06:34:19 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Mar 2017 14:34:17 +0100
Message-Id: <1490880857-31771-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] bb/utils: extend which() so it can look for just executables
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
X-List-Received-Date: Thu, 30 Mar 2017 13:34:19 -0000

Normally bb.utils.which() is used by the unpack code to find a file in a variety
of places, but it is useful as a slightly more powerful version of os.which().

Support this by allowing it to only return matches which are executable files,
instead of just the first filename that matches.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index d6bcfa3..077fddc 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -899,11 +899,20 @@ def copyfile(src, dest, newmtime = None, sstat = None):
         newmtime = sstat[stat.ST_MTIME]
     return newmtime
 
-def which(path, item, direction = 0, history = False):
+def which(path, item, direction = 0, history = False, executable=False):
     """
-    Locate a file in a PATH
+    Locate `item` in the list of paths `path` (colon separated string like $PATH).
+    If `direction` is non-zero then the list is reversed.
+    If `history` is True then the list of candidates also returned as result,history.
+    If `executable` is True then the candidate has to be an executable file,
+    otherwise the candidate simply has to exist.
     """
 
+    if executable:
+        is_candidate = lambda p: os.path.isfile(p) and os.access(p, os.X_OK)
+    else:
+        is_candidate = lambda p: os.path.exists(p)
+
     hist = []
     paths = (path or "").split(':')
     if direction != 0:
@@ -912,7 +921,7 @@ def which(path, item, direction = 0, history = False):
     for p in paths:
         next = os.path.join(p, item)
         hist.append(next)
-        if os.path.exists(next):
+        if is_candidate(next):
             if not os.path.isabs(next):
                 next = os.path.abspath(next)
             if history:
-- 
2.8.1


