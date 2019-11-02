Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail.openembedded.org (Postfix) with ESMTP id 2DA7374813
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  2 Nov 2019 18:06:00 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id c12so8007206wml.4
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 02 Nov 2019 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=QTUuDZR01a2eUjZbODVeksbjNAglkA3VCyV8RTf+OFk=;
	b=UrJwe1wo3J/LORWTgmSzLPzswjlCQjk/3K6HEQao/2br8A8XenJ8ranRLZwFycPm0p
	FYmdprQZEacoCXIzh08KQbiI1tjNdjfKa27BHx8JYWehE+dW/Z/vzqIU4HBLJHwrEVro
	6GVD/tQDIddaPsAdBkMBdh2H1mGntBmJW82JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=QTUuDZR01a2eUjZbODVeksbjNAglkA3VCyV8RTf+OFk=;
	b=pSzk7BN3hg++dLQT+KpD5IBibn8ITKGY3eRXeSCOCI9qEsKWHfdyJYmEowRUAaaYr7
	MstFtjsY4cYjhdnZJxOaH8TbO/xTgFyysBdat/EZSGxaFKD0pCb1llf8dfQgftfg8eOd
	7wvskiXZQ11/fuBqdzKGviqZMsoQ8Yh4w6mX4ZD6qYgYDA5A7yQukmp5nbqD6tFnlJeo
	4LE6jSxu0VIDnJdhcQHDxQHONZnEkBLPSVKbcVVijL26Pug3KVyBCG/4Vef6cpZdhURO
	hfJuoVtQv5FEA7mS3drNk80cQl7KM+nbgK+eApnGfhi2ehTXCzj8rhg1b07+a+JU2DKo
	g7AA==
X-Gm-Message-State: APjAAAULJpUeDL8c9uIRo9pSF/OtzSLNh0DrfaVYoYQ17A3aeqHqGMDQ
	R3EXaRiGfAHx7VKA+ZMDnox++zLXBEWFHA==
X-Google-Smtp-Source: APXvYqy1xZjJDRulWZUUC45wulUeuCozNpTdDFn/cGDy68fZMNsuKZtuFZ8pg5EWpMcqR8gGV7uFRA==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr10992384wmj.91.1572717960559; 
	Sat, 02 Nov 2019 11:06:00 -0700 (PDT)
Received: from hex.int.rpsys.net ([176.12.107.140])
	by smtp.gmail.com with ESMTPSA id
	y128sm11433729wmg.10.2019.11.02.11.05.59
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 02 Nov 2019 11:05:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Nov 2019 18:05:58 +0000
Message-Id: <20191102180558.5116-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] fetch2: Ensure cached url data is matched to a datastore
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
X-List-Received-Date: Sat, 02 Nov 2019 18:06:00 -0000
Content-Transfer-Encoding: 8bit

There was a weird error in OE-Core where "devtool modify virtual/kernel"
was showing basehash mismatch errors. This was due to SRCPV sometimes being:
AUTOINC+b867b78b50_47b80ef7bd and sometimes AUTOINC+b867b78b50_255a750d28.

The latter hash comes from KBRANCH and meant sometimes the correct branch
was seen, sometimes it was not. The issue was complicated by the execution
using a remote datastore over tinfoil.

The problem turns out to be a fetcher caching error. If the datastore
changes, the cached url data may not be valid.

We therefore ensure we match cached url data against the datastore that
generated it, which appears to fix this issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1f5f8f1f14..07de6c2693 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1593,7 +1593,7 @@ class Fetch(object):
         fn = d.getVar('FILE')
         mc = d.getVar('__BBMULTICONFIG') or ""
         if cache and fn and mc + fn in urldata_cache:
-            self.ud = urldata_cache[mc + fn]
+            self.ud = urldata_cache[mc + fn + str(id(d))]
 
         for url in urls:
             if url not in self.ud:
@@ -1605,7 +1605,7 @@ class Fetch(object):
                         pass
 
         if fn and cache:
-            urldata_cache[mc + fn] = self.ud
+            urldata_cache[mc + fn + str(id(d))] = self.ud
 
     def localpath(self, url):
         if url not in self.urls:
-- 
2.20.1


