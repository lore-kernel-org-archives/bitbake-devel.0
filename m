Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id 98462607A5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Dec 2015 12:27:58 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id c201so73275569wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Dec 2015 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=0+VfHZwsy9sbfEr1T16JUbt4+2qid7V4hvXH/V3N8nM=;
	b=0QRTLZqLsZzflMP3NWCzjoBrHez4n7gD2tDfJIr51ohVImiWsuWoXZ9UeVwHynwfFg
	sEy9aq4Ehwc/Zn5Y7NUgUxR5YeGKPJjdk9J3nsHH2iad0LNIGuKeLeEmY3F5ecq7r5zk
	26Iss6aN55Qbw3GmgB2IzqbGj2osdero6G+HKEOHT+izxs/gxJfFwRkSov0mqfDvJNbv
	CjUjuGQJ4nkNf/9egH6wjCqo2Ikw1xA6eiZyzNW6kGOapmd4jRY9WV2Trq/z9uAcGVYP
	fCnTjYjHmAVQwLRy1n9dfyTB+fXWRX8KXn48vwUw7kA44YrN8nukPgeAB/ZtPTqE02lI
	uaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=0+VfHZwsy9sbfEr1T16JUbt4+2qid7V4hvXH/V3N8nM=;
	b=Fz93OdQoUHhc5cYAMyj8m0t87nfkPh52BWbhhJeBvVGru1bahU50GP+lIIHZ1xJ91K
	ZJ5nyvF2UhdRJSRO4F/lO3iOm1x4kCabn60100joHxgDXJzIt2UE09fVsUjREWD8jjNL
	kMyp5cYAcefrKT1BHgbURWtZb64StRgyrQkeYIeSnPyoPHVmdKpal7ei7xKHQ7xpxDRz
	3l3UP0LbcFUbdtmBCINn/E6lrfE89xETSxdm8slcqA9W3nlmrIHxnTdVhi2AcyPkwpCQ
	0UQY4jIWavAVhSDXHquUEk027q9Y8UO9hymUx4Y98CAiMP70kwAyL1LDyJBzftgDcp1t
	bUrQ==
X-Gm-Message-State: ALoCoQnCVRlzpIOCXqrqbDyn/+4vVdekUj6FXWqYZ6cXxldljco7EJiB2zb55te82uj3236DEktZpeRM39MTxc1W9RM/jHi4Ww==
X-Received: by 10.28.60.84 with SMTP id j81mr5295743wma.15.1449836878342;
	Fri, 11 Dec 2015 04:27:58 -0800 (PST)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by smtp.gmail.com with ESMTPSA id
	l7sm16808728wjx.14.2015.12.11.04.27.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 11 Dec 2015 04:27:57 -0800 (PST)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Dec 2015 12:27:54 +0000
Message-Id: <1449836874-17390-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] cooker: use in instead of count
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
X-List-Received-Date: Fri, 11 Dec 2015 12:28:00 -0000

No point counting all instances when we just want to know if there's any or not.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/cooker.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4df8881..d39c64b 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -1072,7 +1072,7 @@ class BBCooker:
 
         for pfn in self.recipecache.pkg_fn:
             inherits = self.recipecache.inherits.get(pfn, None)
-            if inherits and inherits.count(klass) > 0:
+            if inherits and klass in inherits:
                 pkg_list.append(self.recipecache.pkg_fn[pfn])
 
         return pkg_list
-- 
2.1.4


