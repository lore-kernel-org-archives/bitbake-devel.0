Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 3040B739AB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 10:25:37 +0000 (UTC)
Received: by pdnc3 with SMTP id c3so105084981pdn.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 03:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UZf4r25LUstdul95TI7Gh6/DlRAshX3ItHl61WlKvHY=;
	b=iCUkFDZPpJ1KVrmjtj6J6kRBWmmLleAe6KL/KmwpdbExEz4GSSF8SNQ5eid1cJdsNv
	LhvslzrKbpOC53S1L3CgH4ldk/wUO9b+qIiijgG9+FR9y926YpwSBOontWzHQkAOE+gn
	+1kOfwE8b29xouuYkQF0/NqNEuL8y0xptWBaSbzSIdXpMAlR/OFlCpIqsKbFRM0N4XTT
	95lNGLClvcm0wkt/vDDc2qqQmzZq9ti+jB013TL7bEF8gr4xxysABKR8snht2fXimrb4
	gu2Y7Ph5VOuMLgCREimcW1/QCUx1cm7A2Voq0DMepfjEs75Lv1EziEjRDHokejrpbMit
	3kFg==
X-Gm-Message-State: ALoCoQn+GLdWFNZAffTbaFUH+nvsZ0TcEpso4UcS+Zb1MurA7ngA8KpeiTC3bawWVs9E+Y4WR7SH
X-Received: by 10.70.53.40 with SMTP id y8mr156400852pdo.61.1426847138935;
	Fri, 20 Mar 2015 03:25:38 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id s17sm7335993pdn.87.2015.03.20.03.25.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 03:25:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id B412C564294; Fri, 20 Mar 2015 10:25:32 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Mar 2015 10:25:24 +0000
Message-Id: <423762ea578de4b9a6b587365e398b8ef8fa0db1.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
References: <dae2559f8e6d87d54939bc73f4044916df29d93c.1426598797.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426598797.git.alexandru.damian@intel.com>
References: <cover.1426598797.git.alexandru.damian@intel.com>
Subject: [PATCH 07/14] toasterui: fix error message parameter
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
X-List-Received-Date: Fri, 20 Mar 2015 10:25:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Fix the error message parameter.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index b511abe..06a4490 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -890,7 +890,7 @@ class BuildInfoHelper(object):
                             file_path__endswith = recipe_information['file_path'],
                             name = recipename)
             except Recipe.DoesNotExist:
-                logger.error("Could not find recipe for recipe_information %s name %s" % (pformat(recipe_information), name))
+                logger.error("Could not find recipe for recipe_information %s name %s" % (pformat(recipe_information), recipename))
                 raise
 
             task_information = {}
-- 
1.9.1


