Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 9BF2075CB2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jul 2015 16:58:30 +0000 (UTC)
Received: by wiar9 with SMTP id r9so107386228wia.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Jul 2015 09:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=kiuAMo3R9tdH/pmQkQBlOyI0utlQL1InukBaFn84INk=;
	b=gpmd+aqaI5gVfBSaHiBzpeDzuey7DIH6vR6dvt5GBiZzCurQYzS96yEzRriUaCm9GW
	tDr1nwNgo6/izUeiZxzSiBMw+jPFy8vpBO0jVElNFIkvY03szBOafwUDHRXXNowL8jeV
	UxG9rkQFJ8Wh9kdxVtFultS8JuZxbV+JDqkq8I6P93/pCVMO6cAhKTJ144ws/pfGbsOP
	oLjJ3cfZBXKrbDhm2t8h/RYWTHdcU4YyE6fflXF7UKJlEA9993BAL/a3SH41ewRxq6Tb
	GPNBmO0QsYWtYn2tFZQkG9gJfJMERJpWzmA9c5gR76evG7zkZZ3Y2gG6LZE54NPVeM0J
	ebMw==
X-Gm-Message-State: ALoCoQkaaX7hqaZkWKfI+Xidbt1iEQgxyX3MGGRXMFQ9vNQ3cWGkZX3cvHFEvIqCsXl3b+RAxFbk
X-Received: by 10.194.77.97 with SMTP id r1mr56702477wjw.98.1435856310319;
	Thu, 02 Jul 2015 09:58:30 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka7sm9007084wjc.36.2015.07.02.09.58.29
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Jul 2015 09:58:29 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Jul 2015 17:58:15 +0100
Message-Id: <1435856296-12531-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
References: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/5] bitbake: toaster: runbuilds Fix incorrect variable name
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
X-List-Received-Date: Thu, 02 Jul 2015 16:58:32 -0000

The recent refactoring moved this enum value to BuildRequests table
rather than Build.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 33cc94e..e3a1fdb 100644
--- a/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/bitbake/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -130,7 +130,7 @@ class Command(NoArgsCommand):
         # update all BuildRequests without a build created
         for br in BuildRequest.objects.filter(build = None):
             br.build = Build.objects.create(project = br.project, completed_on = br.updated, started_on = br.created)
-            br.build.outcome = Build.REQ_FAILED
+            br.build.outcome = BuildRequest.REQ_FAILED
             try:
                 br.build.machine = br.brvariable_set.get(name='MACHINE').value
             except BRVariable.DoesNotExist:
-- 
2.1.4


