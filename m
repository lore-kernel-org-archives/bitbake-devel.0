Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id A895460670
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 18:22:16 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id n3so33675899wiv.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=+FXvUYIxSiTZjZITBiruBjdXH+Gl3fnUAeiynQdHycc=;
	b=jLeEZP0+sHsEev2ywp/mHVqQDG/1DgIMsN77bt8svW7a/lad2VDCqtMnUaavyR5FMx
	olt9M1i/NlUA8IPuGo5L3JSPb+cPGBoZS2u0IskyoRQqVvvy5poVVlXIUtAORl3oJ7Ih
	piQVxAQuseI9KO1BO9RB4jHUOfEMerLIDVuswjdlv1gWObyWpMT+pK7cvhFPJQXTc8yo
	3SQy5X2OgNVH8wGSuXXs6aM26s262Z5PE2J1KbSb3+E8KpyOT7SrUucf9pRFeKCC+JwF
	FP12VUyim6g6EAMCrh6eostWUlDRJSrDWBjL9Sy9hUPQLORcjXz0nYnmQn0vqjMiCN16
	XT+Q==
X-Gm-Message-State: ALoCoQno5D2uyU+D84QdG3A5377/nq20A0nq/nrzP1bM3xuisotnxmKEZz+QPKur8XKU5eLWO2mh
X-Received: by 10.194.161.170 with SMTP id xt10mr6769625wjb.4.1421864536389;
	Wed, 21 Jan 2015 10:22:16 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id r3sm8293376wic.10.2015.01.21.10.22.15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 Jan 2015 10:22:15 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E2B7B563FBF; Wed, 21 Jan 2015 17:01:42 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2015 17:01:32 +0000
Message-Id: <5eba597f5ac09ddb57d0c5b0fe8b8923286ee5a5.1421859619.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
References: <811689481bc2a4d6361692c6a5d99bdbab8665ff.1421859619.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1421859619.git.alexandru.damian@intel.com>
References: <cover.1421859619.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 02/12] toasterui: save event backlog to build
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
X-List-Received-Date: Wed, 21 Jan 2015 18:22:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We add a call that saves any queued events to the build

[YOCTO #7021]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 9e801ac..be0de6b 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1135,6 +1135,7 @@ class BuildInfoHelper(object):
             return
 
         if 'build' in self.internal_state and 'backlog' in self.internal_state:
+            # if we have a backlog of events, do our best to save them here
             if len(self.internal_state['backlog']):
                 tempevent = self.internal_state['backlog'].pop()
                 logger.debug(1, "buildinfohelper: Saving stored event %s " % tempevent)
@@ -1164,5 +1165,11 @@ class BuildInfoHelper(object):
             self._store_build_done(errorcode)
 
         if 'backlog' in self.internal_state:
-            for event in self.internal_state['backlog']:
-                   logger.error("Unsaved log: %s", event.msg)
+            if 'build' in self.internal_state:
+                # we save missed events in the database for the current build
+                tempevent = self.internal_state['backlog'].pop()
+                self.store_log_event(tempevent)
+            else:
+                # we have no build, and we still have events; something amazingly wrong happend
+                for event in self.internal_state['backlog']:
+                   logger.error("UNSAVED log: %s", event.msg)
-- 
1.9.1


