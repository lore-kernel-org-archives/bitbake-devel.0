Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
	by mail.openembedded.org (Postfix) with ESMTP id 5D2C677143
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:40 +0000 (UTC)
Received: by mail-wm0-f48.google.com with SMTP id 191so64814510wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=HX71yUGTdPKsy9CKMItJ72qxbtbE+zr2f14ZBbZH3T0=;
	b=Hkr9/UI6sJwQrKOGhbPSNWDv5aNDq9GM6sUYMammlumL1jg6P/vbLoo36Csse2w6+h
	8Dq8PiAe8GiUytNYEVMVSguejK9DC90iDFlXtzBMm6UEj20uCoT1yFs0k3X/Ke+OLP9o
	yLIi2qRmQ027KEk1e7gFNXwj/c973j2rpnYBN3AA1+bHS3K0MRYEQIgs15RmrEUWgzeI
	hEwas904O+qjTZrxjPz/AgCdOqMq9b0gc1eMM8LsBSu0QOneq1Jt1bAnaJclhcgvqnZq
	m1iOQsfD4pkPIbFGRwgnV+aVlZliRYZe5WwMFPJ/nElvUiBUE/0P/ZXXCMKvxsjN7B0K
	cPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HX71yUGTdPKsy9CKMItJ72qxbtbE+zr2f14ZBbZH3T0=;
	b=eGCsZRnuL+C6g2Zw1k8lQM/ehg7+p3ftqF2qJae4GGsi9VcrrBfNwCYHDFie0NCy6X
	jlsCz4b9syBsjAs10n6Cyzt6GaXtqimeizWB2hnF5G3WGFRKj48iAGc540FdDo/2X7jy
	FhTwC74dRvf581iubnTKR6DcDOXetLa57J7S/ATCM2E5ie8K7sQyY5BfSl0JpInmM08S
	JcwwmaLr3cTK7dfBQCHJMtK8xK5OKO7H13Kg8Bah6MMnZFFCXoE0j9OLbo5wtfwOVjpy
	7eCsLWdowEYAfjFn0oauH2uWXZz06qsfHYk/MYiC6Rmb7M5HGgCo6i2vVGhCg9WBlczQ
	kgBw==
X-Gm-Message-State: AD7BkJLyX6yyb9hhjx2hGcO5jSOAYgUYiSYYOI8pztA73ms5Hb5b04bdavmxlxWEU03KObyp
X-Received: by 10.28.172.132 with SMTP id v126mr25302635wme.28.1459961261362; 
	Wed, 06 Apr 2016 09:47:41 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:40 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:47 +0100
Message-Id: <fd0aff91bd9ab79d74c566aa95699927a4973353.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 37/38] buildinfohelper: fix KeyError
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:41 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

When bitbake doesn't need to build anything it still sends
ImagePkgList event with empty 'pkgdata', 'imgdata' and 'filedata'
fields. This causes crash in buildinfohelper code as it's assumed
that above mentioned fields always have data keyed by build target:

ERROR: u'core-image-minimal'
Traceback (most recent call last):
  File "toasterui.py", line 423, in main
    buildinfohelper.store_target_package_data(event)
  File "buildinfohelper.py", line 1218, in store_target_package_data
    imgdata = BuildInfoHelper._get_data_from_event(event)['imgdata'][target.target]
KeyError: u'core-image-minimal'

Fixed this by using dict.get method with empty dictionary as default
return value instead of trying to get value without checking if target
key is in the data.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 0ce36b0..93456c3 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1233,8 +1233,8 @@ class BuildInfoHelper(object):
         for target in self.internal_state['targets']:
             if target.is_image:
                 pkgdata = BuildInfoHelper._get_data_from_event(event)['pkgdata']
-                imgdata = BuildInfoHelper._get_data_from_event(event)['imgdata'][target.target]
-                filedata = BuildInfoHelper._get_data_from_event(event)['filedata'][target.target]
+                imgdata = BuildInfoHelper._get_data_from_event(event)['imgdata'].get(target.target, {})
+                filedata = BuildInfoHelper._get_data_from_event(event)['filedata'].get(target.target, {})
 
                 try:
                     self.orm_wrapper.save_target_package_information(self.internal_state['build'], target, imgdata, pkgdata, self.internal_state['recipes'], built_package=True)
-- 
2.1.4


