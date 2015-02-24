Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id E307A71633
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 17:21:09 +0000 (UTC)
Received: by pdjz10 with SMTP id z10so34828207pdj.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Feb 2015 09:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=va+S/lMrHzCv5NLRF6rjp7X1TCSQ9ATWvLii6isaWu4=;
	b=AyakrRUV9nZg6DuO29gOubchCfOVEN6bt+UcFBCbqVhS6Bgbb21EYt8VP9Grs9VpBs
	2gYDu4cFjn5GKoCPdTTRqtOVbUWzRFpyaqvixsabZBk/D4pNbrysktLj7Ymoa1JYUje/
	HJ3dFwtSbZ+Ag4QdSae8peRVapezeVNsG8bYqACdZOhoKBtmU0bjfwbOC6AsI+asMiGx
	JZIhEijZ7QutbDIyt+mEWkKGmYhiDv7djIhAeLseA5HuQ8Yx6/rhyg1A98pp3YiJrjQ5
	7R3AeaSx14kct6TXSZB5igxHMRHTwNdtvnFgJ7TXcY9l4SFeCb4yLza7iNew/uVs1grk
	DHpg==
X-Gm-Message-State: ALoCoQlRNg+ezxVoc2xK61deB0+DMfL9ARHjdM53xloPuI6wqEGaMp08PV6cB6Lvpx2AsFUCE0Ur
X-Received: by 10.66.65.138 with SMTP id x10mr29574791pas.152.1424798471276;
	Tue, 24 Feb 2015 09:21:11 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	tn2sm38760105pbc.15.2015.02.24.09.21.09
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 24 Feb 2015 09:21:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A1406561ABB; Tue, 24 Feb 2015 17:21:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:21:00 +0000
Message-Id: <04cf7d5f5e5b75d901a3f989056523d126d09964.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
References: <50c0fc6c7d6afead28271d2f2501f025eb0b160e.1424798369.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424798369.git.alexandru.damian@intel.com>
References: <cover.1424798369.git.alexandru.damian@intel.com>
Subject: [PATCH 12/12] toasterui: fix ETA calculation
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
X-List-Received-Date: Tue, 24 Feb 2015 17:21:11 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch fixes the ETA calculation.

[YOCTO 7349]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 01ad16e..d2b579f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -194,7 +194,7 @@ class Build(models.Model):
         eta = timezone.now()
         completeper = self.completeper()
         if self.completeper() > 0:
-            eta += ((eta - self.started_on)*100)/completeper
+            eta += ((eta - self.started_on)*(100-completeper))/completeper
         return eta
 
 
-- 
1.9.1


