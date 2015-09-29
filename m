Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id E55F67701C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:43:57 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97502034pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=VDZ8musTT/mF5DNF/VF28UvPBl29HVngaJHYdpNucu4=;
	b=AJOy51Ry7igM4yJ9+bsrH1MFXA/2Xqv3/CRh6kcIvOI9S9ZltRO/FMwnHcWSLPEwNn
	NMiRZMHRPWthxYpuQw1Zbu86gAbab8O0m0iGSf5GmrouecaNYjM2V5nqfppx5jDvdf1V
	UWcttpfpBGwMqmSsX5/Wy6hFAzKToUr29wtAzt8aVMk77ALEyYyFnNcOGoBqEdILQRGP
	k+hO/TSLV357YX/766yzoaJ0b8eIsbxwSHGfafK77w5ms5/odICNlbhbQnos6SPKDjbh
	CGQIOoOAET/HdcMvmPy3fO15pk5CLokxlE0V3b8r6VWQnkaE81FwEkT5UynBwrPMkRgh
	ARtw==
X-Received: by 10.66.216.1 with SMTP id om1mr30969776pac.51.1443501838490;
	Mon, 28 Sep 2015 21:43:58 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.43.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:43:57 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:14 -0700
Message-Id: <b5a223ba3c6a3bb2e90412f6f24a05f807b5bb8f.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 04/22] toaster: widgets ToasterTable add logger to notify when cache hit
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
X-List-Received-Date: Tue, 29 Sep 2015 04:43:58 -0000

From: Michael Wood <michael.g.wood@intel.com>

Useful for debugging to remind you if you're hitting a cache or not

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/widgets.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index eb49692..7f96370 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -38,6 +38,9 @@ import collections
 import operator
 import re
 
+import logging
+logger = logging.getLogger("toaster")
+
 from toastergui.views import objtojson
 
 class ToasterTable(TemplateView):
@@ -264,6 +267,7 @@ class ToasterTable(TemplateView):
         data = cache.get(cache_name)
 
         if data:
+            logger.debug("Got cache data for table '%s'" % self.title)
             return data
 
         self.setup_columns(**kwargs)
-- 
1.9.1


