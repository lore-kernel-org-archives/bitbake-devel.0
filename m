Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id EC5FF73CB8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 18:20:49 +0000 (UTC)
Received: by wgdm6 with SMTP id m6so28637800wgd.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 11:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=cwiKPhNlntOKUY2o38cvB08RQIJPYXKua44ljZK0oGU=;
	b=mvO7Pub9tJ/DkOaXGz1xNqBpfhpJ+v1wM5Xukj9uKEz4HL+BsXt6WHl3LT/q0rOi8X
	zW8jLSNznck0yTUmllXD7Q/v0JUbmkpbpss32KrQKQIRiuGo9lZdDdDViE0njGXzu94f
	YCEeqr0QqWLaAF1GO3mlGuN3Lker1zZ3M3pItPGND47VoUk6aFS/MCgSr8uj3sDXWImw
	o/FUEzL+AzUZco4xMiEiqlYFQIsxXP5QNCH9own0S6k8G20W8L5Wf2e8SGoocydB5uiL
	9lbZldbC9ZufT2IQjvI/lrtB4NJl2JgbDgoC8J65SjP6qB+7GVrzGIeELLN9pj6WyZHi
	g4Ew==
X-Gm-Message-State: ALoCoQnTTn1S74SbQV4Byss4QE8qBW86yxST+DRVsbX9R/rJ33tB1kKVj47PCDh/w2P9V1fXN2jy
X-Received: by 10.180.11.144 with SMTP id q16mr7902579wib.28.1427826050293;
	Tue, 31 Mar 2015 11:20:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	o10sm21993990wiy.18.2015.03.31.11.20.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 31 Mar 2015 11:20:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 35CFC561EB9; Tue, 31 Mar 2015 15:07:31 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Mar 2015 15:07:29 +0100
Message-Id: <164c84ff793a4c27085056a53feafed01ca0a92c.1427810520.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
References: <4b553dbeff7c7bc536669e7fee7d52f962259ebe.1427810520.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1427810520.git.alexandru.damian@intel.com>
References: <cover.1427810520.git.alexandru.damian@intel.com>
Subject: [PATCH 3/4] toastergui: add ext4 option for IMAGE_FSTYPES
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
X-List-Received-Date: Tue, 31 Mar 2015 18:20:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds "ext4" as a selectable option in IMAGE_FSTYPES,
to keep in sync with the OE-Core capabilities.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 48c65d8..be59c83 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -3045,7 +3045,7 @@ if toastermain.settings.MANAGED:
 
         vars_fstypes  = {
             'btrfs','cpio','cpio.gz','cpio.lz4','cpio.lzma','cpio.xz','cramfs',
-            'elf','ext2','ext2.bz2','ext2.gz','ext2.lzma', 'ext3','ext3.gz','hddimg',
+            'elf','ext2','ext2.bz2','ext2.gz','ext2.lzma', 'ext4', 'ext4.gz', 'ext3','ext3.gz','hddimg',
             'iso','jffs2','jffs2.sum','squashfs','squashfs-lzo','squashfs-xz','tar.bz2',
             'tar.lz4','tar.xz','tartar.gz','ubi','ubifs','vmdk'
         }
-- 
1.9.1


