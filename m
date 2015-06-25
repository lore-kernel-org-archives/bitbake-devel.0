Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 929CF758E8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 10:34:59 +0000 (UTC)
Received: by wgck11 with SMTP id k11so58822172wgc.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jun 2015 03:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=4+IrW/MjQ9vqWJ5P8VmJT5Oj2XpFhv80Y+aSsa1yVA4=;
	b=f/57JmVQOQbV5hCyVPjpjLZ04dTbmHJcpGu476RshxJDy7G+bSYEqiqnlQ/NmJ8IV4
	BDUlmzHlmTft2pqm3UO5aLPS7slCMAf0n9lJOIOiPHcQtWt40l3BAwZUjO0vaMDMUoQf
	eXaYgZNAtQf1ZPdJE+1Rf0Kw2GxPaQRD2CGuEYT2gE2rOnoeMMs43X8nDbL2JIYUtZOq
	2hKrwArartkFwM7roAfVxNrGs9AHAkCGscsajgGU1Mpa0jlK5Xlhehp7guZWBTe4WO7+
	w2pcIY7bxcsjrFsgrdBmWS9tSir8R3dEpYTrHm/lwqKGGyZvMOGHPYeyPfs9ZqFzYY0k
	ASXQ==
X-Gm-Message-State: ALoCoQnPDxm+K9NnmJ//fysMJUxR8XHZaD1xMEQhCGORVr32dcdHhySGBXsG50Ajg4Zrcyajeb8y
X-Received: by 10.180.76.8 with SMTP id g8mr4349582wiw.79.1435228500346;
	Thu, 25 Jun 2015 03:35:00 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id jy6sm40155078wjc.4.2015.06.25.03.34.59
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Jun 2015 03:34:59 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id DF8B1562A87; Thu, 25 Jun 2015 11:34:01 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Jun 2015 11:33:54 +0100
Message-Id: <330692e4e2e4dea59f70caa03001905ffff4860a.1435228176.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
References: <77d3f7c6cdc7f06807024896369f8f8ae94263fc.1435228176.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1435228175.git.alexandru.damian@intel.com>
References: <cover.1435228175.git.alexandru.damian@intel.com>
Subject: [PATCH 17/23] toaster: Enable toastertable cache
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
X-List-Received-Date: Thu, 25 Jun 2015 10:34:59 -0000

From: Michael Wood <michael.g.wood@intel.com>

Enable the cache and fix warning on the toastertable cache which happens
on the memcache backend "CacheKeyWarning: Cache key contains characters that
will cause errors if used with memcached"

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/widgets.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index f5a1b3e..e257c70 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -36,6 +36,7 @@ import types
 import json
 import collections
 import operator
+import re
 
 from toastergui.views import objtojson
 
@@ -251,10 +252,12 @@ class ToasterTable(TemplateView):
         for key, val in kwargs.iteritems():
             cache_name = cache_name + str(key) + str(val)
 
+        # No special chars allowed in the cache name
+        cache_name = re.sub(r'[^A-Za-z0-9]', "", cache_name)
         data = cache.get(cache_name)
 
-        #if data:
-        #    return data
+        if data:
+            return data
 
         self.setup_columns(**kwargs)
 
-- 
1.9.1


