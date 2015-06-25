Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id EE7A6759E6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:55 +0000 (UTC)
Received: by wguu7 with SMTP id u7so58680578wgu.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Bv5s67kGfd3lLHu+1wHEXOwfs9iBukd/UM3o/V4KYfM=;
	b=cQABvx2brDL8xSDmiDkO8XpOE7P/d0nU0B04BXnJ5pOWN8TQaWzxK9q22IJFsHPtTT
	4RIkmh1A1Y4ZTJYkr3CBrHF8MxubBqDNWIzG9/3QiCdRiPePvL2b1fWj1wSvd+CkrZvk
	I/4UGuC2q76ZUExxhQocP7p1Px318BbYoXeY2DNkiYYlkArjUsWuy/Iy48UDIZKwrBuT
	SL9tXCmk+26afnEo1IGr7KkVEHSodsislFWNba6WhRy/Jr4CK8SYWcbToXDr+GNs9yF1
	U238qveGF8si3XtfpIk2JJgcM+mXqUtAd7lDZHHea1QyrN/eDDttpR4nSkwu83bE9aqm
	9w+A==
X-Gm-Message-State: ALoCoQloWYiaVXHuiD0Uzr6wMeqrSu6VjMPvg6VAbwQ65shPcSQLH9k8/SRgS88chn4hbjLq9SJD
X-Received: by 10.194.77.97 with SMTP id r1mr4721120wjw.98.1435228496501;
	Thu, 25 Jun 2015 03:34:56 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id r6sm6935007wiy.13.2015.06.25.03.34.55
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:55 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id DDDF15629A2; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:52 +0100
Message-Id: <e04807cd3135c9de96cc7f79245f329c24618b85.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 15/23] toasterui: verify variable before usage
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch verifies that BRBE is set before trying to use
it to read the checkout paths. This is needed for builds
ran outside Toaster control.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 63976b5..cce6da5 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -860,10 +860,11 @@ class BuildInfoHelper(object):
         # convert the paths from absolute to relative to either the build directory or layer checkouts
         path_prefixes = []
 
-        br_id, be_id = self.brbe.split(":")
-        from bldcontrol.models import BuildEnvironment, BuildRequest
-        be = BuildEnvironment.objects.get(pk = be_id)
-        path_prefixes.append(be.builddir)
+        if self.brbe is not None:
+            br_id, be_id = self.brbe.split(":")
+            from bldcontrol.models import BuildEnvironment, BuildRequest
+            be = BuildEnvironment.objects.get(pk = be_id)
+            path_prefixes.append(be.builddir)
 
         for layer in sorted(self.orm_wrapper.layer_version_objects, key = lambda x:len(x.local_path), reverse=True):
             path_prefixes.append(layer.local_path)
-- 
1.9.1


