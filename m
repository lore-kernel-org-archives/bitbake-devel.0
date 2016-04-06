Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 348DB7710D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:34 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id l6so73379240wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=DVeCJn/oFap5LgF4HXjDXJkLeB67OPBUvPpTSkCzSzQ=;
	b=xMw+AWd+szvJtl+b9uj8FL+/Qj1phFIyxacmoYpjf7/fP0Jw6plNzlFqlK4h6jNsT4
	8sG8DwRBXE1/PPDTzggS/QbV/jGXEAq5tjBzFNBFEPrbePaRxk/hUsb8E3/zqqM39Tqf
	r6hxMi2u3D1jCo88gOnGBMlSxN8MNDUNZpB/NnhXxwx0dw1ZEZJmCzsyI7KPL04L3fnS
	QmLof4+j6xD36oBvAuj6SxM5fR4RABhc/TAda/PfDT76YW+dJMpgR/Jk0GA/0zSvGx9n
	9UqOVRuZ2GAmnyKIasJMGyDzk53fm/OiW3btnx89Bd7dEXwcTfTP2LjJ7Rk+4jbUdY6E
	BXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=DVeCJn/oFap5LgF4HXjDXJkLeB67OPBUvPpTSkCzSzQ=;
	b=bSo3oVRgsg1msdtA4pn6Az9CfOyMPKkEXBKswKc8VZuCnb8PSIIZ2aJpyTrTq2LEDf
	edr8aXOey4+zNCLKhw5A4GfAloySGw9QkPJ9TDCzk+wTuc/04UyWbxJqFeneWWmiNO5Z
	wHSk5iTcuswVMRvEIo33NOxZRcIpCqOJF/ESs3d7AlmTUX6kUc3brbDnHHYh+GZEwskk
	mcDQK0611JxvlDTFJbmD7mpv2+IVeDZEi8sG9Lx9aITz/XAVOCPLUFyWRojK9MYGBeJq
	hZeD17CeWDYZW9qdqeHgKXBnc80aE4MnuiBK7ynViaCcvWCBW3TNZ2oHOg4w6bwNYrIB
	pndw==
X-Gm-Message-State: AD7BkJKqeIaLK8hN5H4W2mY1nYZfY+WpB20+UOXFxpycPsnUfTed9uMP2NGgS0QoqPY0zN6l
X-Received: by 10.28.234.137 with SMTP id g9mr17965644wmi.78.1459961254735;
	Wed, 06 Apr 2016 09:47:34 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.33
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:33 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:39 +0100
Message-Id: <de32d79526670bb43eef7674dad19c988ee2a886.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 29/38] toaster: models Exclude the CANCELLED builds from get_number_of_builds
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:34 -0000

Don't count CANCELLED builds when returning the number of builds.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index dfa69a3..68c3072 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -197,7 +197,10 @@ class Project(models.Model):
     def get_number_of_builds(self):
         """Return the number of builds which have ended"""
 
-        return self.build_set.filter(~Q(outcome=Build.IN_PROGRESS)).count()
+        return self.build_set.exclude(
+            Q(outcome=Build.IN_PROGRESS) |
+            Q(outcome=Build.CANCELLED)
+        ).count()
 
     def get_last_build_id(self):
         try:
-- 
2.1.4


