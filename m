Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id B54A9771D4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:40 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id 191so64814143wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=ipU7haFlpXv+4QB2g5kvNiLIRsJKDBGQQhp/pFn5dok=;
	b=RAGs4s50eBHfldv870qrDwtR8C5cK8cFgyOdBSD8YZoqBaUsR8vDhW5kP9pffcceik
	ROjM8L0HIaLSohetEZpDQK/+dWKVl3yU0lBL1BYLza/v0AxRXTZ0eyLlOOZ9DhVyooe2
	zN9+bvxOHXWnvBtmn5Z01bF/ZQV90B5kkQlASyMHKxZ47FLIl5wrmugUIxJVFEvy6Jph
	kbAGiFzThc0inG5NbpFlKn/3WNsKkBCAfH9X6ygWxhb2AYG+xUVdSmcQtJ7WKbDpTdy7
	/amj0CdrcBsG5yfozMDzqSx69d9uHU6lzQdWDmxJIb9ntT3GIql4IjRBmmokFP9aK6UH
	UmjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=ipU7haFlpXv+4QB2g5kvNiLIRsJKDBGQQhp/pFn5dok=;
	b=TGdMHcrN6RjzkmEaqDpIDPZGSJF8orwg+jvuyDO3GoxUfEtLXzQzpAEICsotpkcALF
	hIf1rWx4+MaS7j6JfxwxrC+sK2g5FMjlWNhbkT/aD0ONWN0kc5PuE+8SeVA4nkJkqZzv
	fJTUD5OgKzWp8t75pIYqMuCgAq5vY6zVuNVf8bTG/iG+s0OQP5o5p+dY3udjto7ozKyJ
	1FmINlYwlA3XTC0Cy/x9k1jB+XI+WeVizPoNkudLuVdqEqcvOiJ0hgjnzc88lrMCNvY8
	7TfvJ9Gk3euqYjfPoTiW2/6DC3zeJMlIGlU9ym4g8jWBH5/An/xLWQcDPX+pqzaFcHGZ
	fgVQ==
X-Gm-Message-State: AD7BkJK712rFFJcbZ+aPcV7eSIKqw4fmLm/4UBiSTFBFV0F4jWI+tbtCRuuONZnBUYTqzimO
X-Received: by 10.194.2.41 with SMTP id 9mr24268459wjr.10.1459961260599;
	Wed, 06 Apr 2016 09:47:40 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:39 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:46 +0100
Message-Id: <b6af3833febfeff595b4b5a8647ea5073822b031.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 36/38] toaster: get bitbake location from BBBASEDIR
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:40 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

It was incorrectly assumed in the current code that bitbake is in
../bitbake/bin/ directory. It's not always the case.
Using bitbake from $BBBASEDIR should be .

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index ab9cf25..7def1f3 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -320,11 +320,13 @@ class LocalhostBEController(BuildEnvironmentController):
 
         # run build with local bitbake. stop the server after the build.
         log = os.path.join(builddir, 'toaster_ui.log')
+        local_bitbake = os.path.join(os.path.dirname(os.getenv('BBBASEDIR')),
+                                     'bitbake')
         self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:-1" '
-                        '../bitbake/bin/bitbake %s -u toasterui --token="" >>%s 2>&1;'
+                        '%s %s -u toasterui --token="" >>%s 2>&1;'
                         'BITBAKE_UI="" BBSERVER=0.0.0.0:-1 %s -m)&\"' \
-                        % (brbe, bbtargets, log, bitbake)], builddir,
-                        nowait=True)
+                        % (brbe, local_bitbake, bbtargets, log, bitbake)],
+                        builddir, nowait=True)
 
         logger.debug('localhostbecontroller: Build launched, exiting. '
                      'Follow build logs at %s' % log)
-- 
2.1.4


