Return-Path: <patrick.ohly@intel.com>
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com
	[209.85.223.176])
	by mail.openembedded.org (Postfix) with ESMTP id 2C19E719E8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Nov 2016 07:21:19 +0000 (UTC)
Received: by mail-io0-f176.google.com with SMTP id a124so65404913ioe.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2016 23:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=0bg+5v7fGbyBlQkrgpcgNRFJ5ECliys8jElYIJoyNJY=;
	b=mgHOeeSlWHJvX1+GsmQSerAuO4tuc4dnHQVEUL6Ht5+nS3MPuOLMzZtpz9NtL4xQ3U
	o/VBJrKEzT6/EdlRxnP0x/ILLC1yvny/JZycXyXX1Idoe3Kjxgtk7jpkERVJXEtQLHhS
	PJPQp+lbjdDaiHu0EHO/CKlAeSC/ChfhtEuoI/syZVxZgREDPnFqC4x0w9ECP0nkGLJq
	yChyh8ZAr9GMDrpCUCQzOFWw99SJmlIfTkylDqip4oMp/kMlqmImSCe7GAxxIKWHs8oV
	RJF5FJs2T6KgwdWs+83ztuLLbGxcqvphBSFJ+bJp5oehto3zAzOiLswtpzW3kNuWfYCY
	2S4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=0bg+5v7fGbyBlQkrgpcgNRFJ5ECliys8jElYIJoyNJY=;
	b=NZtxHG/ShSvMb8WPhqLf7YRMbhd4M8CQmxZmOc8xqRI1vOK01YCtdK2ERSTHH0AstR
	qyyW4VpJtHdwfgeIuqKY9EL8Vr0LJc6VYlFvopdmyLZMBW8IBhoZPVYjNZy5u46nvWhB
	YDu0rFo8wZ3KFVjKW8VwYGfGaKJBA/VTlklHKT2lYqCjkZU4UmFcCpiwCA5oxdzFJmIN
	2aHBTDrvxXeiJnHXtVkJamSy9e7OqiF+6TwKVY05FiiXuiqiRcw3JYIR0r4gFDzQAbUS
	TzwaiHy/t3y9nC87DR+KlBC5F2diCJhdcdIaZysxslZZX+q3oYGyR0A+5SKXopiVRqT6
	NMlg==
X-Gm-Message-State: AKaTC02VaqvlBxNONoZYcOxuwNHIr8ZbR66yIl05Uwsj97QrbtqNMzg6EgnUSzo/NvilDyNf
X-Received: by 10.36.159.193 with SMTP id c184mr790604ite.72.1479972081071;
	Wed, 23 Nov 2016 23:21:21 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8D6D7.dip0.t-ipconnect.de.
	[93.232.214.215]) by smtp.gmail.com with ESMTPSA id
	e68sm12948226ioj.39.2016.11.23.23.21.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Nov 2016 23:21:20 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Nov 2016 08:21:12 +0100
Message-Id: <1479972072-2045-1-git-send-email-patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] qemuboot.bbclass: do not hook into do_rootfs
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
X-List-Received-Date: Thu, 24 Nov 2016 07:21:20 -0000

Writing qemuboot.conf in write_qemuboot_conf() does not modify the
rootfs and thus conceptually shouldn't be executed as part of rootfs
creation.

Running it as separate task is cleaner and fixes the problem of
missing qemuboot.conf files for meta-swupd virtual images; those
images replace do_rootfs and ROOTFS_POSTPROCESS_COMMANDs don't run at
all.

The task gets added such that it runs roughly at the same time as
before. Probably it doesn't actually need to depend on do_rootfs, but
this way we don't write a useless qemuboot.conf in cases where
do_rootfs fails.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 meta/classes/qemuboot.bbclass | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta/classes/qemuboot.bbclass b/meta/classes/qemuboot.bbclass
index 39df3ad..8b1d4d0 100644
--- a/meta/classes/qemuboot.bbclass
+++ b/meta/classes/qemuboot.bbclass
@@ -42,7 +42,7 @@ QB_DEFAULT_FSTYPE ?= "ext4"
 QB_OPT_APPEND ?= "-show-cursor"
 
 # Create qemuboot.conf
-ROOTFS_POSTPROCESS_COMMAND += "write_qemuboot_conf; "
+addtask do_write_qemuboot_conf after do_rootfs before do_image
 
 def qemuboot_vars(d):
     build_vars = ['MACHINE', 'TUNE_ARCH', 'DEPLOY_DIR_IMAGE',
@@ -51,8 +51,8 @@ def qemuboot_vars(d):
                 'STAGING_DIR_HOST']
     return build_vars + [k for k in d.keys() if k.startswith('QB_')]
 
-write_qemuboot_conf[vardeps] += "${@' '.join(qemuboot_vars(d))}"
-python write_qemuboot_conf() {
+do_write_qemuboot_conf[vardeps] += "${@' '.join(qemuboot_vars(d))}"
+python do_write_qemuboot_conf() {
     import configparser
 
     qemuboot = "%s/%s.qemuboot.conf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.getVar('IMAGE_NAME', True))
-- 
2.1.4


