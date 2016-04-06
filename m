Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id CFB0F77100
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:11 +0000 (UTC)
Received: by mail-wm0-f43.google.com with SMTP id l6so73366027wml.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=HokjdbxdT0UtWgDZgzmIi8H5Fn/0kOh/qFojlAy235M=;
	b=C1Tq8VDagA8GYXX/UZn2jDfh0NIstSlaO+51fEujRkbP3DZWVbvhrfboNRms8RcNiA
	eSupCzQrL1NeZjaGGHKOLCp82dQUhsHdlAtnSLTBvBtsZdt6S7RHv38S09ScNutGE7oz
	w55XFuzB67uKzoDH5iYF/+tykNCLpjB5zFrXr7FMHXCzeFd2B5iThlFNdp7hxxxp+aY7
	DSPK0zvXkwdnc/RYgGycAd0I9/gTzJvCocbmKmDMz7DkMIdIYG5VEcoLgBSoNZnCjbMb
	In+SibbiyzaX0JHtQL0Myne8IK8Bo1hYI8YUyXABpG3C4xBBZlpJkQZa/mkh66hdZWp4
	e0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=HokjdbxdT0UtWgDZgzmIi8H5Fn/0kOh/qFojlAy235M=;
	b=QpRlLWN4F2dTbQyPEG666WfK3FuGrVHZWBxCDHG/K87nWaKSJR4J0zGfB2BfCYUO5y
	/86yJtG09aEhw6x8Sb1KnBLnPxjeQOmUXBqV1RMVN7ug05x3MOYb9EoUlGIkuehxueyQ
	yKpbLe4X1eHHBHI89aMyzMi2aSDSlTJ7kiG1YH2kbx35vbbxvfh5MpMZu8x3UFbqmUWA
	B47O8oXrP5edkqlxKjFsBZIZ/xktwEQcCfFC/JOFdRPyapQU6ppMForRzg1AANtvJIX/
	bmdOntjyU95mZFm3fBthxpWuDkvdZaMAG7dq4umlmQvtvx30nZiHLtFPCqh0HC8dcrdw
	aiAQ==
X-Gm-Message-State: AD7BkJKGICZdiNxUSqeL4teSq9h7L3fT2TFYZWe4+ui5o/BIVhVQDc4OI8oAdWWhnpNi5SJL
X-Received: by 10.194.216.40 with SMTP id on8mr33230555wjc.40.1459961231984;
	Wed, 06 Apr 2016 09:47:11 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:11 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:14 +0100
Message-Id: <e9f4661e11efc2a7e1e94c6861a83646e398350c.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 04/38] toasterui: add brbe parameter to buildinfohelper
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

In current toaster code BRBE(build request:build environment) value
is passed from toaster to buildinfohelper through the 'SetBRBE' event.

Passing it through environment variable is easier as it doesn't
involve rpc communication between toaster and bitbake server.
It also eliminates the need in running bitbake observer process.

Added parameter 'brbe' to BuildInfoHelper.__init__
Used environment variable TOASTER_BRBE to set brbe for
buildinfohelper object.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 4 ++--
 lib/bb/ui/toasterui.py       | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index c211ec6..b7b9284 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -851,7 +851,7 @@ class BuildInfoHelper(object):
     # pylint: disable=bad-continuation
     # we do not follow the python conventions for continuation indentation due to long lines here
 
-    def __init__(self, server, has_build_history = False):
+    def __init__(self, server, has_build_history = False, brbe = None):
         self.internal_state = {}
         self.internal_state['taskdata'] = {}
         self.internal_state['targets'] = []
@@ -867,7 +867,7 @@ class BuildInfoHelper(object):
 
         # this is set for Toaster-triggered builds by localhostbecontroller
         # via toasterui
-        self.brbe = None
+        self.brbe = brbe
 
         self.project = None
 
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 538a409..06a5f17 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -195,7 +195,8 @@ def main(server, eventHandler, params):
     taskfailures = []
     first = True
 
-    buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+    buildinfohelper = BuildInfoHelper(server, build_history_enabled,
+                                      os.getenv('TOASTER_BRBE'))
 
     # write our own log files into bitbake's log directory;
     # we're only interested in the path to the parent directory of
-- 
2.1.4


