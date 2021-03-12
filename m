Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.3596.1615519226617343685
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 19:20:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=V9uRMMDm;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1615519227;
  x=1647055227;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MJwoabNU5kXe8l6MiM589WVxXJKsGuaHdz+N6gpIYBE=;
  b=V9uRMMDmekMObmatUc6sdh6FmQTYY4Uod9KGR7XosqV0JU82kOGyfx+S
   XgIkFXN4yDyE8OUbvPDLaDnGGaUu3DCKdCdA6tseQeex9ZbM8Vx6sDH+x
   RQD4RbiWJIzFhzEXSfiORPQ98Vzx9N2266WZ/jMIt3ZcvvhYE2JKtSAGJ
   +9oxBRqdDWyDNaCtonTdwx9R7+DgPULZ7nfKdhhkXm1xcCYPm+QZBTwbd
   6BZ6OBdt1QBGUO3hZ0aRaBdR06OymdDqbD4r/m0hnw1uo9cImi9lsSVfP
   l/dlEvBuIH7f8S5AsGpnggZoOQpBHoRKEgjAdyup1/r8ruN0kNiAKN6VA
   A==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/2] license.bbclass: Improve parsing time when INCOMPATIBLE_LICENSES is big
Date: Fri, 12 Mar 2021 04:20:21 +0100
Message-ID: <20210312032022.7783-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The commit 08cbf1748 (licenses: Update INCOMPATIBLE_LICENSE for
'or-later' handling) increased the parsing time considerably if there
are many licenses in INCOMPATIBLE_LICENSE. Reorganize the code to get
almost all the time back.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 meta/classes/license.bbclass | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/meta/classes/license.bbclass b/meta/classes/license.bbclass
index bcea0b3cb5..f7978e266b 100644
--- a/meta/classes/license.bbclass
+++ b/meta/classes/license.bbclass
@@ -282,16 +282,15 @@ def expand_wildcard_licenses(d, wildcard_licenses):
     """
     import fnmatch
 
-    # Assume if we're passed "GPLv3" or "*GPLv3" it means -or-later as well
-    for lic in wildcard_licenses[:]:
-        if not lic.endswith(("-or-later", "-only", "*")):
-            wildcard_licenses.append(lic + "+")
-
     licenses = wildcard_licenses[:]
     spdxmapkeys = d.getVarFlags('SPDXLICENSEMAP').keys()
     for wld_lic in wildcard_licenses:
         spdxflags = fnmatch.filter(spdxmapkeys, wld_lic)
         licenses += [d.getVarFlag('SPDXLICENSEMAP', flag) for flag in spdxflags]
+        # Assume if we're passed "GPLv3" or "*GPLv3" it means -or-later as well
+        if not wld_lic.endswith(("-or-later", "-only", "*", "+")):
+            spdxflags = fnmatch.filter(spdxmapkeys, wld_lic + "+")
+            licenses += [d.getVarFlag('SPDXLICENSEMAP', flag) for flag in spdxflags]
 
     spdx_lics = d.getVar('AVAILABLE_LICENSES').split()
     for wld_lic in wildcard_licenses:
