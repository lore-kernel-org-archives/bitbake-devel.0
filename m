Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 11D24760B0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:57 +0000 (UTC)
Received: by mail-pf0-f182.google.com with SMTP id h186so65154650pfg.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=H7QzFFTtwCLRJcqOluT/QvRaV97n/QDQ+CD86fNhRtc=;
	b=TpMl+wpvF0en9mtwFHf4hz9i4qhSpEvPnHAW7ZuX1xQ3LXuKiL1slEAxpOH0myY8P/
	NLlGRbX8ZECtOvc3t8ifKuRQWuecosC74fsYWLAAXyzff+UoStf2nYkoJeRZ2odf3Mga
	7Ca7BKBaDr3q6ylcVS/OMfLMRHW9wGsn4bjW2EuxAIbRFm7R+vCerbAoAyqsesMvqbiF
	AwC+ytLTJP7rgSOKM1303Z7gRRqDZrgQ0Yux+8O8kaTrkmDNStYiCY9mXjdkQip9IJuM
	97f9DbGxcPDinNmXRx+hVpo26iDN4jXbKL12yOL25oAbOcpyyp7zU+aG+JbnnM2CziwN
	fW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=H7QzFFTtwCLRJcqOluT/QvRaV97n/QDQ+CD86fNhRtc=;
	b=a/qoLkzMeKDhdLqaT4hQZI7TJUr/haKo9kaih2AzlLj37ZIi3VNnWbm/1suKOeCM3n
	fEjghf0+h/X+RLYh2Zm493pWr8Ro0LWtMlJkuOxQ4dXmT23bCTRxMMCzQWPNgemuJOoo
	dq3Gr+HTc0m/KMLpaQD3VVIs+QsLTXy+rUcAwBSHIuMg5apC4+an9/xHdCKD/t9ljnzq
	d+FLD8DEArH3f/dsUvud0nlQIVRuRyEDAvFida5YE78a4foMCpGTqVX93IsrE7x9t0pJ
	6OEG4nxV7Xjo+a0wB8P+FqGV84kPFMOF+FkatWIM05farDnQhdbodlMBaiXKGXF68vDs
	okkg==
X-Gm-Message-State: AE9vXwOohsFM2yCCafJoXMs/yNVEMZs7rBKWcEHI+DWgu8va0Qs5TXtVk/Njv99P6cGM8JBz
X-Received: by 10.98.206.129 with SMTP id y123mr64096961pfg.7.1473085798066;
	Mon, 05 Sep 2016 07:29:58 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:57 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:29 +0100
Message-Id: <1473085772-17878-9-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 08/11] toaster: orm Update IMAGE_FSTYPES values
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:57 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

This patch fixes a typo in one of the IMAGE_FSTYPES values listed in
Toaster. It also updates the hardcoded list of values to match the
latest list in meta/classes/image_types.bbclass

[YOCTO #9447]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3aeb4e2..8ee0c87 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -876,9 +876,10 @@ class Target_Image_File(models.Model):
     SUFFIXES = {
         'btrfs', 'cpio', 'cpio.gz', 'cpio.lz4', 'cpio.lzma', 'cpio.xz',
         'cramfs', 'elf', 'ext2', 'ext2.bz2', 'ext2.gz', 'ext2.lzma', 'ext4',
-        'ext4.gz', 'ext3', 'ext3.gz', 'hddimg', 'iso', 'jffs2', 'jffs2.sum',
-        'squashfs', 'squashfs-lzo', 'squashfs-xz', 'tar.bz2', 'tar.lz4',
-        'tar.xz', 'tartar.gz', 'ubi', 'ubifs', 'vmdk'
+        'ext4.gz', 'ext3', 'ext3.gz', 'hdddirect', 'hddimg', 'iso', 'jffs2',
+        'jffs2.sum', 'multiubi', 'qcow2', 'squashfs', 'squashfs-lzo',
+        'squashfs-xz', 'tar', 'tar.bz2', 'tar.gz', 'tar.lz4', 'tar.xz', 'ubi',
+        'ubifs', 'vdi', 'vmdk', 'wic', 'wic.bz2', 'wic.gz', 'wic.lzma'
     }
 
     target = models.ForeignKey(Target)
-- 
2.7.4


