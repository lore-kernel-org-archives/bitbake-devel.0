Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 20C2877040
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:24:22 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so22107632pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3032qbJRPUVI40cgfEtDt6qv0OEXezTFsuCu66G9F7U=;
	b=tsdUwcfDdmH/HyGiDckcbDQl5AkshIe0iLDfgJwZMufJqdjVMdR24weS6WNpuo8ZVn
	OYhy4ZSGiObT1Udx3rZuq1AA5WvejB/plHadVI943eBhJ6vvQMLnRs8AgvscwgEbs4gT
	mmadh/DHbW9hAM6DZ4RpDG7oDGc/DNxginpaHOe2EFF4MgDq+fl9qegrL9HgAQnJ8O7R
	RUuNm1O+bBsbTsOMTpgyeIVnW0DTk1++Wss4YRhRQN7Xm01/SZIRMEusHMEeLMJfmAbF
	jbdRinIQJW9ZMnX7GvMyBoPp7NgOCMwcerFAPDvKl5S+LBRmQVjuYPa+Qsu1S8gT/nob
	U31A==
X-Received: by 10.66.145.195 with SMTP id sw3mr61724693pab.72.1441239862572;
	Wed, 02 Sep 2015 17:24:22 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	kw3sm22972308pbc.30.2015.09.02.17.24.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:24:22 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:25:07 -0700
Message-Id: <c474f47a4d9b69729936d70aa5d9b98c02e52da5.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1441239229.git.avery.brian@gmail.com>
References: <cover.1441239229.git.avery.brian@gmail.com>
Subject: [PATCH 1/6] toaster: Make 0021 migration compatible with MySQL
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
X-List-Received-Date: Thu, 03 Sep 2015 00:24:22 -0000

From: Elliot Smith <elliot.smith@intel.com>

Two issues prevent this migration from working correctly
with a MySQL back-end:

1. MySQL won't allow a default value to be set for an
AutoField, which is what the migration tries to do
for project_id ("ValueError: The database backend does not accept
0 as a value for AutoField.")

2. When migrations are applied to a MySQL back-end, Django
(via South) attempts a dry run of the migration first: it
applies the forward migration then rolls it back. However, this
migration raises an exception on roll back, which causes the
whole series of migrations to fail.

This commit fixes both issues.

[YOCTO #7932]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 ...hg_field_build_project__chg_field_project_bitbake_version__chg_.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py b/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
index 924a5c4..a62ddb7 100644
--- a/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
+++ b/lib/toaster/orm/migrations/0021_auto__chg_field_build_project__chg_field_project_bitbake_version__chg_.py
@@ -7,10 +7,12 @@ from django.db import models
 
 class Migration(SchemaMigration):
 
+    no_dry_run = True
+
     def forwards(self, orm):
 
         # Changing field 'Build.project'
-        db.alter_column(u'orm_build', 'project_id', self.gf('django.db.models.fields.related.ForeignKey')(default=0, to=orm['orm.Project']))
+        db.alter_column(u'orm_build', 'project_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.Project']))
 
         # Changing field 'Project.bitbake_version'
         db.alter_column(u'orm_project', 'bitbake_version_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['orm.BitbakeVersion'], null=True))
-- 
1.9.1


