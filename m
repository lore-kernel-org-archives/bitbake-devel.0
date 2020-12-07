Received: from smtp2.axis.com (smtp2.axis.com [])
 by mx.groups.io with SMTP id smtpd.web12.1496.1607377161300151649
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Dec 2020 13:39:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=FKHs7nGU;
 spf=fail (domain: axis.com, ip: <nil>, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=axis.com; q=dns/txt; s=axis-central1; t=1607377163;
  x=1638913163;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=90z22c9+nQCUUIctu5vtW8gYzvRx+3ZDrnSnZLcUAt8=;
  b=FKHs7nGUpBC9BgDm9UMV+VOqdustQYGoYYP3MgoXxmgLLdYxK9UAih0q
   fMHklTK0qQlSlMf69wldl0ZnUpFRCLgFtJGAbjXqbzKZGaZ2qErV23lHz
   80oSEJSN9SK1bZFmqXhTxIvFJ8kz7bZRA1ywmdo9AGqPi90cotbtJS7MQ
   CT9HSUfI34+ryRO6n/eWGftelQYIaSy1OG3UVHDear2C0jJhTUaEieL5I
   /3WkS1aH9C1oP9wqkdXhOsIzjgSPIdk/ypX2htBb2a1YI2zvr+y3Dq/ru
   gGDlWeWLSQbm/m+ksLliAkbnyIv9kndQIvz0bonKKxbS1zOJxVwyMyRDr
   g==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/2] cooker: Include all packages a recipe provides in SkippedPackage.rprovides
Date: Mon, 7 Dec 2020 22:38:51 +0100
Message-ID: <20201207213851.3485-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201207213851.3485-1-pkj@axis.com>
References: <20201207213851.3485-1-pkj@axis.com>
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The provided packages by a skipped recipe are supposed to be listed in
SkippedPackage.rprovides, which is used when generating a meaningful
error message when a build fails because of a skipped package.
Previously this variable only contained the contents of ${RPROVIDES}.
However, most recipes don't define RPROVIDES, they define
RPROVIDES_<pkg> for each package they provide. Additionally, the recipe
provides the packages in PACKAGES without them being included in
${RPROVIDES}.

Before this change, having a runtime dependency on a skipped non-recipe
package would result in a build error stating that the build failed
because the package was skipped, but without providing any reason for
why it was skipped.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1f4cc1e96d..83cfee7fb4 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -73,7 +73,9 @@ class SkippedPackage:
             self.pn = info.pn
             self.skipreason = info.skipreason
             self.provides = info.provides
-            self.rprovides = info.rprovides
+            self.rprovides = info.packages + info.rprovides
+            for package in info.packages:
+                self.rprovides += info.rprovides_pkg[package]
         elif reason:
             self.skipreason = reason
 
