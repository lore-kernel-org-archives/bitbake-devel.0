Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 066AB731DB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 10:30:39 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP; 30 Aug 2016 03:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,255,1470726000"; 
   d="scan'208";a="2650865"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2016 03:30:40 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 0C7C96A4080;
	Tue, 30 Aug 2016 03:30:19 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2016 13:30:28 +0300
Message-Id: <1472553028-3404-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Cc: Alexander Egorenkov <Alexander.Egorenkov@vector.com>
Subject: [krogoth][PATCH] toaster: Increase maximum length of file path of build artifact
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
X-List-Received-Date: Tue, 30 Aug 2016 10:30:42 -0000

From: Alexander Egorenkov <Alexander.Egorenkov@vector.com>

The default maximum length of the file path for a build artifact on
Krogoth Toaster is 100 characters (Django default for FilePathField).
This value makes it impossible to download build artifacts because
default file paths are quite long and therefore are being truncated
by Toaster.

Example of a long file path which does not work on my machine:
/var/www/toaster/poky/build-toaster-2/tmp/deploy/sdk/poky-glibc-x86_64-core-image-sato-cortexa8hf-neon-toolchain-2.1.1.sh

To fix this problem i increased the size of 'file_name' column
of the corresponding MySQL table to 255 characters.

Signed-off-by: Alexander.Egorenkov <Alexander.Egorenkov@vector.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/toaster/orm/migrations/0001_initial.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/orm/migrations/0001_initial.py b/bitbake/lib/toaster/orm/migrations/0001_initial.py
index 760462f..0c780a9 100644
--- a/bitbake/lib/toaster/orm/migrations/0001_initial.py
+++ b/bitbake/lib/toaster/orm/migrations/0001_initial.py
@@ -52,7 +52,7 @@ class Migration(migrations.Migration):
             name='BuildArtifact',
             fields=[
                 ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
-                ('file_name', models.FilePathField()),
+                ('file_name', models.FilePathField(max_length=255)),
                 ('file_size', models.IntegerField()),
                 ('build', models.ForeignKey(to='orm.Build')),
             ],
-- 
2.1.4


