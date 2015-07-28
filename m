Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 368BA76312
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 14:24:41 +0000 (UTC)
Received: by wicgb10 with SMTP id gb10so159253373wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Jul 2015 07:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wXdZzHraxG+bNDoJ3yTa2PlRlO0Tdh1D2z8b7VqPOWQ=;
	b=gMmir7XoDF+DmMFsDNRWCZW277oKOUE0GAqrL9DSSqhqj8mHRIHUvpYU+1/ouOn7vF
	T/8D0BEidXSa1bV6w8Pf1EmnzT4zJS5jYWQry8ZO5724VcgmHv+0wLnOIysLOB0ohLke
	1blpf/Y5X3pcE70QHW4+/kFld4rIntrA6dAmmnKiaRju8MXI6BBm87UT9GxsoE8wvzrl
	98Q6T5/jMoyd0XsffrgOSPfdZBxz8I8U2g3BDmPiTiyMtPi9MZGtkcqweLyu2klPrxH7
	0h0YMtLvknYHt8AvsTVSOPFpJJWWhc4Acg4S1Hlrt3AdyRx9+XupZvg4heHnlxBoop3u
	7q/Q==
X-Gm-Message-State: ALoCoQm0/bFDcllyKA803/KdoTmILjeClGbmEsI6zIcLpoykLzo9v9KWee7U67ObYq4R8FdC9Dc7
X-Received: by 10.180.20.198 with SMTP id p6mr7438746wie.38.1438093481963;
	Tue, 28 Jul 2015 07:24:41 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gt10sm19283940wib.20.2015.07.28.07.24.40
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 Jul 2015 07:24:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 62B53561D3D; Tue, 28 Jul 2015 15:24:46 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Jul 2015 15:24:42 +0100
Message-Id: <6e136e703c963508cd6b3e6b01dfe845700874ec.1438093379.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
References: <964caf5c2f9ce47f17d85d9bcfa2321f8e9ab6fb.1438093379.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1438093379.git.alexandru.damian@intel.com>
References: <cover.1438093379.git.alexandru.damian@intel.com>
Subject: [PATCH 3/6] bitbake: toaster: Fix usage of wrong variables
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
X-List-Received-Date: Tue, 28 Jul 2015 14:24:43 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Replaced nonexistent variable 'be' with self in
models.py/BuildEnvironment methods.

Fixed typo: BuildRequest.TYPE_LOCAL -> BuildEnvironment.TYPE_LOCAL

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldcontrol/models.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/bldcontrol/models.py b/lib/toaster/bldcontrol/models.py
index 6f40866..b61de58 100644
--- a/lib/toaster/bldcontrol/models.py
+++ b/lib/toaster/bldcontrol/models.py
@@ -70,19 +70,19 @@ class BuildEnvironment(models.Model):
                 return "binary/octet-stream"
             except ImportError:
                 return "binary/octet-stream"
-        raise Exception("FIXME: artifact type not implemented for build environment type %s" % be.get_betype_display())
+        raise Exception("FIXME: artifact type not implemented for build environment type %s" % self.get_betype_display())
 
 
     def get_artifact(self, path):
         if self.betype == BuildEnvironment.TYPE_LOCAL:
             return open(path, "r")
-        raise Exception("FIXME: artifact download not implemented for build environment type %s" % be.get_betype_display())
+        raise Exception("FIXME: artifact download not implemented for build environment type %s" % self.get_betype_display())
 
     def has_artifact(self, path):
         import os
-        if self.betype == BuildRequest.TYPE_LOCAL:
+        if self.betype == BuildEnvironment.TYPE_LOCAL:
             return os.path.exists(path)
-        raise Exception("FIXME: has artifact not implemented for build environment type %s" % be.get_betype_display())
+        raise Exception("FIXME: has artifact not implemented for build environment type %s" % self.get_betype_display())
 
 # a BuildRequest is a request that the scheduler will build using a BuildEnvironment
 # the build request queue is the table itself, ordered by state
-- 
1.9.1


