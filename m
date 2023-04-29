Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C210C77B61
	for <webhook@archiver.kernel.org>; Sat, 29 Apr 2023 01:23:42 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.38136.1682731418685462572
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Apr 2023 18:23:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=XscrUgiW;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682731418;
  x=1714267418;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ROBYYnnYP9LJTAT3bUWiA5Sh3c9HEBFRQKx/ypUYPBM=;
  b=XscrUgiW5FHv3czkyS1hOSRQhqwCaKBVmR7Uz/+qturXN/OtbiakGxTm
   kTH1/8GGxo0auAF5vwKrOguFyaRZcR43RJqAZ1evjkyxCsstcApj4fj/f
   sYorPF/8L+9AgL+c2tFZfInUoopi/ElayJbvr3+ns1BqkQK2Sm+L3+mCq
   WPtHSCbYRQ6duD1LiXBtNMnI7f3EgRqxBIbkTPwHWKFO1aHmSRMn7EoJL
   x+3UosnlD4gwZD2s4GzsWo6KxVvNDeTyAnaX/U00w+lJIQel9RHKGEPOD
   Kp+uRz7L9+WiXGDhXJ/sq7wA8C5DSjPJzSZHLylc+QvFw3YSCarGOgQgK
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [master][mickledore][PATCH 1/2] fetch2/crate: Simplify extraction of crate names and versions from URIs
Date: Sat, 29 Apr 2023 03:23:28 +0200
Message-ID: <20230429012329.1799116-1-pkj@axis.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Apr 2023 01:23:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14759

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

@Steve Sakoman: Since this is a clean up patch, I will leave it up to
you to decide if you want to take it for Mickledore once it makes it
into master.

 bitbake/lib/bb/fetch2/crate.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/crate.py b/bitbake/lib/bb/fetch2/crate.py
index a7021e5b36..2b8b6bc7a1 100644
--- a/bitbake/lib/bb/fetch2/crate.py
+++ b/bitbake/lib/bb/fetch2/crate.py
@@ -59,11 +59,11 @@ class Crate(Wget):
         # version is expected to be the last token
         # but ignore possible url parameters which will be used
         # by the top fetcher class
-        version, _, _ = parts[len(parts) -1].partition(";")
+        version = parts[-1].split(";")[0]
         # second to last field is name
-        name = parts[len(parts) - 2]
+        name = parts[-2]
         # host (this is to allow custom crate registries to be specified
-        host = '/'.join(parts[2:len(parts) - 2])
+        host = '/'.join(parts[2:-2])
 
         # if using upstream just fix it up nicely
         if host == 'crates.io':

