Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 8740273204
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:41 +0000 (UTC)
Received: by mail-pa0-f54.google.com with SMTP id cm16so14822341pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=785G6TjrkiXOhEW5+yBtJdmqzMSG35CYPIBqOaAv/WE=;
	b=CNgEJF+HyfqkK7dqMxkmaQH71STY4017Fm4sJUnOJfjqkGyTCJo/bxfeITaErstwiD
	ez/KTbzMRB703hfYvULsWVy43tyd75sLusAE0gzSi4zUZPAt5QqmYiLHxRCfXaK/+soi
	jDuZpLiG/w05ZjH4POhPgIHDZwjs7Vbk8SH0RULffFdCzSrUncDx+Iwq9sdUr3n7qeoE
	7iar9wWO6LjoRslFr8FhX2kJ3ebS3hDa+4IsnJSWXgvM6KR1ne+uVucCOWjYrk+qcYdu
	ij7gjNB0hr2V2plvyv8UjF7VxRHgW0cut9FBRZuZrbwr+fc8kqhWjBKMggOz7rS7PAPf
	Oh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=785G6TjrkiXOhEW5+yBtJdmqzMSG35CYPIBqOaAv/WE=;
	b=eQD7J10l4dYgJgLcJH9PCZ5fj840zvcAMm1iGtL6HKam6TFZajxRfS3BZHWiq0R0n8
	xMd2WvaKSBLXAFc3AvhzuM3w8td0E150waMotvSsbXuEQX0qIt0DU6PeoQp/Cbm8DLFE
	mORgCOC0RE+EILynh/9EqkHrtxjpTpTcVoWTAozXAlJ8+GrUeX639Akll5kVYKf5TI9U
	vrSK7Ham63/f3Lsxgc6YL5Jv0CvSuUeruaAoI0PjDKwSyAmlRevWtqrPKMHbi4NrwZCK
	2LMNI6HYJ5vZbq0jjibTCr76Zz2OTLu7jgobouyj9lChea4dlUkRUDGOuG11Syka92dq
	HUjA==
X-Gm-Message-State: AE9vXwOmOyBxP+un+wKnV7pbfNINj8SVv2GX8TXus48IvsxroBZR6kWkWarwMY7DOJ6uQdhi
X-Received: by 10.66.193.65 with SMTP id hm1mr64999384pac.12.1473085782090;
	Mon, 05 Sep 2016 07:29:42 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:41 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:22 +0100
Message-Id: <1473085772-17878-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
References: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 01/11] toaster: tasks Remove recipe version from defaults
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:41 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

The 'Recipe version' column should not be part of the set of columns
shown by default in the tasks table. Set the hidden property for that
column to 'True' so that it doesn't show when you load that table
for the first time.

[YOCTO #10179]

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/buildtables.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/buildtables.py b/lib/toaster/toastergui/buildtables.py
index b6485e6..dd0a690 100644
--- a/lib/toaster/toastergui/buildtables.py
+++ b/lib/toaster/toastergui/buildtables.py
@@ -482,7 +482,8 @@ class BuildTasksTable(BuildTablesMixin):
                         orderable=True)
 
         self.add_column(title="Recipe version",
-                        field_name='recipe__version')
+                        field_name='recipe__version',
+                        hidden=True)
 
         self.add_column(title="Executed",
                         static_data_name="task_executed",
-- 
2.7.4


