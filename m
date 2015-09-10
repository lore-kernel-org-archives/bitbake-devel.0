Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
	[209.85.220.48])
	by mail.openembedded.org (Postfix) with ESMTP id 284F37422C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:04:27 +0000 (UTC)
Received: by padhk3 with SMTP id hk3so47947429pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=nkENIXt04davVluEXgB02MwVJR6wpaJKUrAgOg7v2Ao=;
	b=JS7vp/7IgSKUHRlBqa1f3g5VsIYYJuCCz9JXqcurjOMRLk3eHHDAqRbwCByI3XtzZ3
	GL3stCBrqMURTnO7IKC8w6pgxL8uY9zZY+Mjn+s2SyQn+AbIullqBo3tZcMrXevItCnc
	GRMEGfZoxL6KoZmUXsSbOrBbLso+dqbcDlXukPxoDeF8Z449AEieGU85Cz964vHdW0z9
	6SunDCLJCQ56DvAS7LCkftgyzaruhz/lh6FTo9LpwVwS97xK7FDo9z8PcM4muWjDhcO8
	B0XMv4LLPyJIu6Qrtjp7rbN04LJldyM7Tk2raAuj36jXOE1jHoXSHs2f3YjhZ/xnjNQf
	Pkwg==
X-Received: by 10.66.253.201 with SMTP id ac9mr76879175pad.69.1441904668470;
	Thu, 10 Sep 2015 10:04:28 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	by1sm13099494pab.6.2015.09.10.10.04.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Sep 2015 10:04:27 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Sep 2015 10:05:18 -0700
Message-Id: <80aa1ea82e65eafe0005dbb6770b3176f07c3d18.1441904599.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
References: <1390b2ab0a882e6f11ef295ada26edcf226ba8dc.1441904599.git.avery.brian@gmail.com>
In-Reply-To: <cover.1441904599.git.avery.brian@gmail.com>
References: <cover.1441904599.git.avery.brian@gmail.com>
Subject: [PATCH 4/5] toaster: Fix date range pickers on the project builds page
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
X-List-Received-Date: Thu, 10 Sep 2015 17:04:28 -0000

From: Elliot Smith <elliot.smith@intel.com>

These were referring to the old HTML elements with ids
"date_from_created" and "date_from_updated", but their
ids have changed to "date_from_started_on" and
"date_from_completed_on". This meant that they weren't
functional.

This fixes the references.

Modified from an original patch by David Reyna
<david.reyna@windriver.com>.

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/templates/projectbuilds.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/projectbuilds.html b/lib/toaster/toastergui/templates/projectbuilds.html
index df809de..27cfcd7 100644
--- a/lib/toaster/toastergui/templates/projectbuilds.html
+++ b/lib/toaster/toastergui/templates/projectbuilds.html
@@ -16,8 +16,8 @@
 <script>
     // initialize the date range controls
     $(document).ready(function () {
-        date_init('created','{{last_date_from}}','{{last_date_to}}','{{dateMin_started_on}}','{{dateMax_started_on}}','{{daterange_selected}}');
-        date_init('updated','{{last_date_from}}','{{last_date_to}}','{{dateMin_completed_on}}','{{dateMax_completed_on}}','{{daterange_selected}}');
+        date_init('started_on','{{last_date_from}}','{{last_date_to}}','{{dateMin_started_on}}','{{dateMax_started_on}}','{{daterange_selected}}');
+        date_init('completed_on','{{last_date_from}}','{{last_date_to}}','{{dateMin_completed_on}}','{{dateMax_completed_on}}','{{daterange_selected}}');
     });
 </script>
 
-- 
1.9.1


