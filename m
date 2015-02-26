Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f181.google.com (mail-we0-f181.google.com
	[74.125.82.181])
	by mail.openembedded.org (Postfix) with ESMTP id 7017C733AE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 21:42:13 +0000 (UTC)
Received: by wesx3 with SMTP id x3so15051436wes.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 13:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=0oOpWoo/JejT9km2kSVFqFKspShnu1Vf37wodVwYOhw=;
	b=gm4n1GK0/CVFy0UGE2gJNffAF6zy+6fwSqBP/MN1pg3tgdddyL/ghtGkyHiWJuBOsE
	E4r3e9acMas1dFubaYBO06HmuhKqdP3dLfC5S82CyEtuZy/5puf23dWUI24sOx/KdXDy
	qyx192+ZwDEEqSky8EKmFFpo4Xf9XdgkiECoAzP4YucItQPQZXT9YM8T5ankwbPKJuNI
	eyr1MQXPR6Vb0wAsUO+R+dAdfdjIMKI5jYg6rWXKw33f8bHkqEDcYdzMJ7GYyAZzapbJ
	+xxQc49aEMIi0I3Ye9knVx4oTWyG/qCAIfxr/VR0su80fMBMvIdCBHc8znin029Ka7Hf
	KL/w==
X-Gm-Message-State: ALoCoQlDw+biH8vYidlq9TZLfCquc4iP7J8mJPg9VT34XZe6tSEZQ6uWTZh4Q7ha85mMikAZtgwn
X-Received: by 10.181.11.136 with SMTP id ei8mr276309wid.10.1424986934983;
	Thu, 26 Feb 2015 13:42:14 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l4sm37802wiw.9.2015.02.26.13.42.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 13:42:13 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id C1F655616BC; Thu, 26 Feb 2015 21:42:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 26 Feb 2015 21:41:57 +0000
Message-Id: <cd722f63873b7ccbcd7474dee4384bd9a5e9bca1.1424986746.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
References: <21cb6ea0acdaec4a3aa133790a17c7055b9a1348.1424986746.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424986746.git.alexandru.damian@intel.com>
References: <cover.1424986746.git.alexandru.damian@intel.com>
Subject: [PATCH 4/8] toaster: order layers with same priority
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
X-List-Received-Date: Thu, 26 Feb 2015 21:42:14 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

When we have multiple layers with the same priority, we
need to order them by date, newest first. The layer version
ID is a complete ordering by recent-ness, so it is suitable.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 03efac4..4fa9f81 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -994,7 +994,7 @@ class Layer_Version(models.Model):
             query |= Q(projectlayer__project=project)
 
         return sorted(
-                Layer_Version.objects.filter(layer__name = self.layer.name).filter(query).select_related('layer_source', 'layer'),
+                Layer_Version.objects.filter(layer__name = self.layer.name).filter(query).select_related('layer_source', 'layer').order_by("-id"),
                 key = lambda x: _get_ls_priority(x.layer_source),
                 reverse = True)
 
-- 
1.9.1


