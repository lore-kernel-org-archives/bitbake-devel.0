Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id C84C371ABB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 11:20:35 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id a197so110285057wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 03:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=++1PJ8r+wITaaHEeyEkTm6dmWBo29e+zrJEaB90DKAw=;
	b=apPk6atOWUky5rQeIsxl44M515QGDY9SDiRRQUXmABhg326wB+AxnXVxWcAbs7xANx
	1UfTRFxngJ636vAt4MmcSrmPmLENA4lCv+Apruy6RZGw4lsZAaBHnAlNdnJ5iTPBii89
	dqpTvbY7uBH+IERnSYKPJc3MODEs/H5SgEGQTwYA4+OFiTu3kVBiQRq1plYC7s+POkaf
	Z4qkSioq+Cpst1hCW5PHMVnwfkq8160Ps+HJepkaqoZxQc0pz392F6HaIwWsGjBpAdv0
	VxQ16BWmDju9X3fZf08uw2EXqVHfc55b/ixYAZaro227aXFgekKTM+ovldx5QChUQRS2
	2Guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=++1PJ8r+wITaaHEeyEkTm6dmWBo29e+zrJEaB90DKAw=;
	b=juhT6nDPzu1U3oQnwGnWczdiWxe96Pddp9oIV9GrBQCyxSaScSrD1MeFLIeNeUbWbs
	rdAmWoYcL8G3OvBK4EmScH7fOZRD0COAXo2yJhUft817JbFzw2Vk9qmeGIFteizAosoA
	VSgl7vKEvU/61vVWrEAlazxegvrOFHdKv5AisC+e/V9oPe2Iak1sMlfXsVLgKFRXm5q4
	DePme+xaVlvnX44nUJa3CoGMTqHmQqqd7s380S9DGCH+iRGQrePYYZbtFEMZzBOdibCG
	gl3h7MScGGLhA7Om/iMZPUY1o7kpwrybZFJxhLWYogKgQsVSKf8KUJbGrsEF8nYY6neC
	xNyQ==
X-Gm-Message-State: AKaTC00sK9PfGzVZdRBoxm9QPCSVauOy4pV4fkJ9FT3LSfTkaS1Y+3Hj7z3NMuBVz9MwRWLf
X-Received: by 10.28.212.131 with SMTP id l125mr1725026wmg.117.1479986436546; 
	Thu, 24 Nov 2016 03:20:36 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
	by smtp.gmail.com with ESMTPSA id
	g184sm7696900wme.23.2016.11.24.03.20.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 24 Nov 2016 03:20:36 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 11:20:06 +0000
Message-Id: <1479986406-4657-16-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
References: <1479986406-4657-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 15/15] toaster: buildinfohelper Clarify log message for build history
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
X-List-Received-Date: Thu, 24 Nov 2016 11:20:36 -0000

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 63c779e..5ed150d 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -381,8 +381,8 @@ class ORMWrapper(object):
                 local_path=layer_version_information['local_path'],
             )
 
-            logger.info("created new historical layer version %d",
-                        layer_copy.pk)
+            logger.debug("Created new layer version %s for build history",
+                         layer_copy.layer.name)
 
             self.layer_version_built.append(layer_copy)
 
-- 
2.7.4


