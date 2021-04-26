Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.3761.1619422216549913694
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 00:30:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=ewRyLC4I;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1619422217;
  x=1650958217;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ULY+vI3sxHRxEnNy+lFgLJ3spXoizyIGKOoS+FLkLfk=;
  b=ewRyLC4IeQXieQND/gzpxNAfYHmM3JoplGDmy8KHFfSgLSj41vW8c3Dj
   cZae7U7rpkeoXsbvcua5gCkh5ddmqmk2GnZf+phrgGpWeJGVuf3cW0/e4
   bOqFCWGVR2XR4rm66x3FTsuy8RYBqVla5geKx7OiEcsYX7RqzqiTvHKV1
   0lNnuOVzsfJUB9dAqqdyGrSg+Nx2UNXGe8hr1ojkit/NaKskJPr8gtD8H
   m7dweqt7yp6AVk2qPzUAeH4uVVKBFIXg/1ztyb/+2mHrOIwLHqhYMgzRm
   mu+3OC0jrHrnpIPt9yEEXNkAmBPTpdylAKwU4LuEkl3Qg8626h7pK1e8J
   Q==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [gatesgarth][PATCH 2/2] cooker: Include all packages a recipe provides in SkippedPackage.rprovides
Date: Mon, 26 Apr 2021 09:30:03 +0200
Message-ID: <20210426073003.30489-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210426073003.30489-1-pkj@axis.com>
References: <20210426073003.30489-1-pkj@axis.com>
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7ed0b802..4b5ef07e 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
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
 
