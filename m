Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
	[74.125.82.176])
	by mail.openembedded.org (Postfix) with ESMTP id 3F96D72C83
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 14:27:38 +0000 (UTC)
Received: by mail-we0-f176.google.com with SMTP id w62so15199988wes.7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Jan 2015 06:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=nmcSj14wI/kuNRa8Fm2PL6KFvscec85DiD7HPT7C3CU=;
	b=XNIOAon5gmzcIF0kKp8GmIcraBRpnhbzgR3A+NX8xmm+vczNaHiJSFExTz26LPBrLp
	sNQQO5g07WEz7M3U5BQQtAd43vAYfx9TvFV1HlluaiwDkFIeGu1YPIRcO424uspv5mci
	DZKfP0n89jsZwdUmcZy1FbsYBiwpwJlggil9/K6NMKNI9Stl/+L/V/xSXghN/dNMakJ4
	5NqI6cNugciVC4gVxHUSHwOMKrbuwD0PTfF5RrruDrQ6skRfLYFHSWzr+399K3Ihy8bq
	s2+9wMDhB1jd7x1mBRrwnCsLOc83lYmBw5yoKy7a7NNQjQ0pavVg9dR1QNj8E4a0gBZ8
	P1jg==
X-Gm-Message-State: ALoCoQnhiSRPeRIimZPe9tQY/Lm6Uk9Hdy522RVN+R1WjIXFjBsIneNqQk5yovBpYpArKPq3zE32
X-Received: by 10.180.206.19 with SMTP id lk19mr6398127wic.83.1422368859212;
	Tue, 27 Jan 2015 06:27:39 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ku8sm2035361wjb.23.2015.01.27.06.27.36
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Jan 2015 06:27:37 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B4F86562722; Tue, 27 Jan 2015 14:27:36 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Jan 2015 14:27:34 +0000
Message-Id: <b11e8bd626e0212ee72914529c3d92d1dd718674.1422368757.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
References: <49d56fcbbf6b7d0c0c589b93182e4c73071b3fcf.1422368757.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422368757.git.alexandru.damian@intel.com>
References: <cover.1422368757.git.alexandru.damian@intel.com>
Cc: Alexandru Damian <alexandru.damian@intel.com>
Subject: [PATCH 13/14] toasterui: do not filter images by extension
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
X-List-Received-Date: Tue, 27 Jan 2015 14:27:39 -0000

From: Alexandru Damian <alexandru.damian@intel.com>

ToasterUI filters build artifacts by extension in order
to determine if a build artifact is an image or not.

Using IMAGE_FSTYPES for this purpose is not correct as
the varible value holding image extensions is just a coincidence.

So we just look if the filename contains the "rootfs" magic
string, which is a pretty good approximation.

[YOCTO #7213]

Signed-off-by: Alexandru Damian <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index be0de6b..4e2d4a7 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -770,7 +770,7 @@ class BuildInfoHelper(object):
             if t.is_image == True:
                 output_files = list(evdata.viewkeys())
                 for output in output_files:
-                    if t.target in output and output.split('.rootfs.')[1] in image_fstypes:
+                    if t.target in output and 'rootfs' in output and not output.endswith(".manifest"):
                         self.orm_wrapper.save_target_image_file_information(t, output, evdata[output])
 
     def update_artifact_image_file(self, event):
-- 
1.9.1


