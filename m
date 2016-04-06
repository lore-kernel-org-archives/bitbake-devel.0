Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 907FF770B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:16 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id 191so64803106wmq.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=qdeEug3WJHsnq9byHvRXCCHqgEqatF9bPhcEn46zxSc=;
	b=ZExXdeWml/R80mp6T8AJVDIp9jKCiGPRWreg9ajqaryTNnSRNM6cCGwVrbcRohBVFu
	X3voWNvTNrkyWn8bNxePCUPaa4zKHZqZ2BTk3NJScaTxJJ5kPFftx7UnaUOFfnJ/h9g8
	FqaTMpnegjhfpgBXKZkkmhPJDwZIo6pwWJaDf5HV/9vGdVeubc3PP0r+3f000zWkgRNz
	zJFKb7QmwE4Ea5Bq2JZ1JWGdZLOkcvHOx2eKKiV9n0zWt/UDemxDV07n2Yp8jhhQ7vTP
	eIlWy3eJpmbF3xmFx49SMecKuXlWdtd4MFtHTIo3qlrgutrlCGciA0Tu2L40mtr+/rY/
	yPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=qdeEug3WJHsnq9byHvRXCCHqgEqatF9bPhcEn46zxSc=;
	b=c2Uhb/7JkhsKz8RCOq8nMbfrRQs4Mx/wCzyVoiW3XLH+A+GEi4AYMPgVotoPZxzbhQ
	QjGn43pkQeiDsUe54/bOF7b+AiO5Uy+PWHGMINkEv3SJB900vSIYe1bVDyR4tUCixwa9
	9Gufo9bFphr2zIchSm6hq0v+W1mQX1q36qOFnVVBzy25xPluGZeSAQn6ZRAOZd6UnIKI
	crfqR5G9rJmhGW5QgWaUsbf2Pt6mcap8+Ga+Ows3CVW0IF1b3SnRCi+tyuRmRjO5iHuu
	oAFyx0wlIQhuutHn1l/vcCnuzxQpGvVF7fuHqXRXoJgurYUDWnyHfT1iFh847N3xa62H
	06Lw==
X-Gm-Message-State: AD7BkJIdKei4NJbynQzmf32goZ7eH7Jp+wp1oz1mmr64dE9UliJRhvX5AiaJFh6L5jli5i74
X-Received: by 10.194.119.201 with SMTP id kw9mr27723794wjb.173.1459961236943; 
	Wed, 06 Apr 2016 09:47:16 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:15 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:19 +0100
Message-Id: <73343f1c932c6b824745776e6f9c8fd971a5abb4.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 09/38] toaster: remove release API
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:17 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This API is quite dangerous as it removes build directory.
It's not used anywhere and most probably will not be used in future
as toaster is going to have one build directory per project.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/bldcontrol/bbcontroller.py          | 6 ------
 lib/toaster/bldcontrol/localhostbecontroller.py | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/lib/toaster/bldcontrol/bbcontroller.py b/lib/toaster/bldcontrol/bbcontroller.py
index 535a398..2ca2661 100644
--- a/lib/toaster/bldcontrol/bbcontroller.py
+++ b/lib/toaster/bldcontrol/bbcontroller.py
@@ -163,12 +163,6 @@ class BuildEnvironmentController(object):
         """
         raise NotImplementedError("Must return the REST URL of the artifact")
 
-    def release(self):
-        """ This stops the server and releases any resources. After this point, all resources
-            are un-available for further reference
-        """
-        raise NotImplementedError("Must override BE release")
-
     def triggerBuild(self, bitbake, layers, variables, targets):
         raise NotImplementedError("Must override BE release")
 
diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index 7d6abe6..1ccdd24 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -255,12 +255,6 @@ class LocalhostBEController(BuildEnvironmentController):
     def readServerLogFile(self):
         return open(os.path.join(self.be.builddir, "toaster_server.log"), "r").read()
 
-    def release(self):
-        assert self.be.sourcedir and os.path.exists(self.be.builddir)
-        import shutil
-        shutil.rmtree(os.path.join(self.be.sourcedir, "build"))
-        assert not os.path.exists(self.be.builddir)
-
 
     def triggerBuild(self, bitbake, layers, variables, targets):
         # set up the build environment with the needed layers
-- 
2.1.4


