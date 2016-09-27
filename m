Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 9C52360720
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 15:17:09 +0000 (UTC)
Received: by mail-pf0-f172.google.com with SMTP id l25so6860794pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=6nmvf6MZii506NQFsB7N7h/py4MqD/aBOs+oGAWSFmk=;
	b=xDz/mYe5UXiG2gdTbCKLC6bqxCKU9wTZvXtE5fI1rwXYr4VjS1RpWrGbQhg+ZuTbcs
	UbKDBjSYhimik1CkPzodikbvExmqQc/+2VKpIpFsg4EsGa/4i77TrYrQIoFG/nWS1OmA
	bMivlPT3Pc4vdJYg1qXchK6g5GyTQHCeSQWc1VG42M0GaBH7bSuGwCfV/0gjM/FYDUw1
	5WLOvEY+sKPnJvpJFcx3OzqHSnmvNkvuImeOhB1K70vfRsUp9hXSCvRNZopKo8a+dX6L
	ZbaQZYZQQjt7ZKyxHZMwyGeDLm35PKmf4IPgzMrtnc1U4eUq7hZ+6ayyzTl1whvg2bPK
	J2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=6nmvf6MZii506NQFsB7N7h/py4MqD/aBOs+oGAWSFmk=;
	b=KcVe3Qbg1rwe+r5LswWAtSzqH30l9KIf4IAuIAIaczeFPF7BzD3hDmAYp7yqp0xK1E
	+/RfIfEkyrkCfZdKs5EuBTFSD4kbN6xAxH8ietegJoU02lnuQTSo7o0c27JUynpnNMVG
	GI3hXRm5ZVsejQsI8+oMi+/A+Ol2CSGiqWVsWvme25ELpg6TuEVo9FVfrJQVjuNecc1t
	W47oz4YNVT+p+lFjLNrHXhWyKx5wkCRiRflYPYuzqC0gqPSgKWQXiQW4l65F/fnAS6bv
	8xMIrkUY1DIkU1c9XbM9CRfFdhtjYR1XrehMR5B8we1mRNxvRYcYdFCsHrkM8lQdUJNq
	KUEQ==
X-Gm-Message-State: AE9vXwPSopMdCa86k4KSa4jwMTER+wzhFGeQtPVVfD/pL9PLyfSpAYtVwyP/2aZOxxsrEJ4a
X-Received: by 10.98.31.10 with SMTP id f10mr49077550pff.137.1474989430849;
	Tue, 27 Sep 2016 08:17:10 -0700 (PDT)
Received: from orion.ld.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	p1sm5784876pae.12.2016.09.27.08.17.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 08:17:10 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 16:16:55 +0100
Message-Id: <1474989416-10454-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
References: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/5] toaster: fix 'Unhandled MetadataEvent' error
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
X-List-Received-Date: Tue, 27 Sep 2016 15:17:09 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

New MetadataEvent 'TaskArtifacts' causes this error.
Processing of this event will hopefully be implemented in future.
For now it should be enough to just skip it.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 569957a..2bc45b6 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -431,6 +431,10 @@ def main(server, eventHandler, params):
                     buildinfohelper.scan_sdk_artifacts(event)
                 elif event.type == "SetBRBE":
                     buildinfohelper.brbe = buildinfohelper._get_data_from_event(event)
+                elif event.type == "TaskArtifacts":
+                    # not implemented yet
+                    # see https://bugzilla.yoctoproject.org/show_bug.cgi?id=10283 for details
+                    pass
                 elif event.type == "OSErrorException":
                     logger.error(event)
                 else:
-- 
2.7.4


