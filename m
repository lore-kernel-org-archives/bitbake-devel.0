Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 341D2763C0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 14:24:33 +0000 (UTC)
Received: by wibxm9 with SMTP id xm9so159804743wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 07:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=xZdb2SRl0NAL22Gg8QVZKHjOp3KYsdwo14Rk1Ec8LQo=;
	b=RXNnn+F2PnSy9PkUQmBRwYTgV0Q3idfoN4h7Or6q1Pv1Mi6yDem2mw1gVc8B3FgDTV
	6SE9h3WGlARbpwt37BWBaL+PDAcC7I1qUTMi8d3joUVn5luirdq8XkdOU4EvCZcR0Zmm
	DLA6PTEoTcOPvSxyr6mTRn45Ug+Wtx2PJHtvD7Yp3JjudXg3XNLXBpOtH75/L28KvrXP
	PJgtO7fM5yjOzLpYQ7s6dRbN/k46xOejXnNdBT4xWWTvCbhuvTV9owzCs+KNc/gp1fMN
	LfXLmZEShNsxMckaNIZ1sopZiYXwVFwqQTGACYaNV3L88tymOZkV7yYgLqsNfw9gkKNL
	NVBA==
X-Gm-Message-State: ALoCoQnDCthy6sH7siZbxogxHDnm+4sJmm4f3ulduHZMKEYvYV/RZrI378jLACUxsrotgc5agK+g
X-Received: by 10.180.95.197 with SMTP id dm5mr33494747wib.93.1438093473548;
	Tue, 28 Jul 2015 07:24:33 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	fz16sm19295064wic.3.2015.07.28.07.24.32
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Jul 2015 07:24:32 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5DB95561BBB; Tue, 28 Jul 2015 15:24:46 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 15:24:40 +0100
Message-Id: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1438093379.git.alexandru.damian@intel.com>
References: <cover.1438093379.git.alexandru.damian@intel.com>
Subject: [PATCH 1/6] bitbake: toastergui: Toastertables don't replace dash in cache key
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
X-List-Received-Date: Tue, 28 Jul 2015 14:24:34 -0000

From: Michael Wood <michael.g.wood@intel.com>

The dash character was being stripped from the cache key when we sanitise
it for the memcache backend. This meant that we were getting a false hit
on the cache and returning non descending results which are indicated by
the dash prefix on the field name.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/widgets.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/widgets.py b/lib/toaster/toastergui/widgets.py
index 5f6b47b..0885402 100644
--- a/lib/toaster/toastergui/widgets.py
+++ b/lib/toaster/toastergui/widgets.py
@@ -252,8 +252,8 @@ class ToasterTable(TemplateView):
         for key, val in kwargs.iteritems():
             cache_name = cache_name + str(key) + str(val)
 
-        # No special chars allowed in the cache name
-        cache_name = re.sub(r'[^A-Za-z0-9]', "", cache_name)
+        # No special chars allowed in the cache name apart from dash
+        cache_name = re.sub(r'[^A-Za-z0-9-]', "", cache_name)
         data = cache.get(cache_name)
 
         if data:
-- 
1.9.1


