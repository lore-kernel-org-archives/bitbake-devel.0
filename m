Received: from mga14.intel.com (mga14.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.55.1616596422209368700
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Mar 2021 07:33:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: D4o7+Ex1+5VR4ijw/UelHJjjROfPO4ycMG7O6g+J/wqwj4I0YFrxDUiXvlu5Yu3I5Fm0Oxn+wc
 nEnDhJ3UUqJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190132808"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="190132808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:42 -0700
IronPort-SDR: J4lpT5+Km+ErAkuKeaJ/jmW1ABVI4ZCN2BLqEoH5FkTW0ugx+Jtkb0PYS0NzFCKLjilNirIVy5
 PQKHtkC1sOOA==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="514213823"
Received: from alianabi-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.167.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:41 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 1/3] runqueue: Fix task execution corruption issue
Date: Wed, 24 Mar 2021 22:33:05 +0800
Message-Id: <5a9e0e20f8acde52ecafce2055b1941ca77e3ca8.1616596112.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616596112.git.anuj.mittal@intel.com>
References: <cover.1616596112.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen occasional issues where linux-yocto:do_compile_kernelmodules would
run without do_shared_workdir running before it. do_shared_workdir is an
setscene task but never has an sstate object generated so it will always
rerun. This should not happen since compile_kernemodules should only
execute if a setscene that depends on it didn't run and that should trigger
do_shared_workdir not to be marked as covered.

The issue is that build-appliance-image:do_package is one of the tasks which
covers linux-yocto:do_compile_kernelmodules but it is also a noexec task
and has a dependecy on pseudo-native:do_populate_sysroot.

In the problem case, pseudo-native:do_populate_sysroot is unavailable but
marked as covered since it is noexec. The "harddeps" code then also marks it
as notcovered. No task should ever be both covered and notcovered and this
is where the problems come from.

The solution is for the harddeps code only to to fail tasks if they've not
already been handled in some way. The code is assuming code couldn't have
handled revdeps at this point but we now have clear evidence they can.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f66556bbb38449789ceea2fd105e9f68df7fb660)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 28bdadb45..e22ca72ce 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2430,6 +2430,9 @@ class RunQueueExecute:
 
         for dep in sorted(self.sqdata.sq_deps[task]):
             if fail and task in self.sqdata.sq_harddeps and dep in self.sqdata.sq_harddeps[task]:
+                if dep in self.scenequeue_covered or dep in self.scenequeue_notcovered:
+                    # dependency could be already processed, e.g. noexec setscene task
+                    continue
                 logger.debug(2, "%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
-- 
2.30.2

