Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
	[74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 46E206EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:14 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id w61so5135138wes.32
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=v8Bo/HwPaUtKvdGrNiOZxef1I3JxEXv1Dmd/INeqrDg=;
	b=RG2x/vZpB4mEZ8j4g8KvzjbE3RHaf+leRZG62ScV3r9R8AV+NZALMG/xwUqi7XRMXu
	NSsOw3vDO4XGkRCsVUYbCeLScXVH34Y+L2nTwyEUE+r0aubkH3RF6TaikFtvxFuXzf89
	Nm27bghPilAW1W5pYOgASJx6rhZE+O6oXLFgH9pePQVeWa6BS7wQ7ZUiVIKASLjqJxMi
	WZ5/dKg9e7MoEmHoxtdRXL2lR7n6FafpWsm5Ka+Iv8jVXkjTPHhC1IGDdqnU1HKyMKV2
	hNWz1d6rh+84ZgxHeRYV8Ww3UwI7xvOrdelNlmppYrUywU/zkqA7LYaNEncQnC0/7Vch
	oG8Q==
X-Gm-Message-State: ALoCoQneYqq2GP+E0r0a9JR+gRhRVy7Gt6cHRM5odY0evnpyMHfWqgQdS97Kbo6F1m+gVGodyfuO
X-Received: by 10.180.73.141 with SMTP id l13mr13701701wiv.60.1396284434682;
	Mon, 31 Mar 2014 09:47:14 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id pm5sm448984wjc.11.2014.03.31.09.47.13
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:13 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 0DC21560360; Mon, 31 Mar 2014 17:47:15 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:04 +0100
Message-Id: <077d851ea2a2dd41cabe62b7aef60daa222ea18c.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
References: <2eb6aba6ca24b899b4afe03cb21460d4238e19ed.1396284354.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396284354.git.alexandru.damian@intel.com>
References: <cover.1396284354.git.alexandru.damian@intel.com>
Subject: [PATCH 04/14] toaster: use deploy_dir var to obtain the license.manifest path
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:17 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

[YOCTO #6051]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 0a15579..f448c84 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -629,7 +629,7 @@ class BuildInfoHelper(object):
 
 
     def store_license_manifest_path(self, event):
-        deploy_dir = event.data['deploy_dir_image']
+        deploy_dir = event.data['deploy_dir']
         image_name =  event.data['image_name']
         path = deploy_dir + "/licenses/" + image_name + "/"
         for target in self.internal_state['targets']:
-- 
1.9.1


