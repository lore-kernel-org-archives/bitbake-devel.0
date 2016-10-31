Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id 5384671A8D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 16:40:45 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id n85so79021620pfi.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3Y7BQzq3l45+Rkdr4hE1aH4SlmgMAZMaKKxqseLLJrk=;
	b=PXUYxIdvlT4SA+Mqkh4ZTT8XA3/OF8+r80/bu4VdaytKG0AkU82+TerCFUVnQzLsnd
	ekoDDo9jWBj7t6otzjcio5yw12xHknMhTTjfJwRDDfMbt5w7ax3FwclBwBk2r1FqyPb9
	YqDk2Cd5OmngJ+eAad5gdRU8A29pYde9FedH7B935/zKpefmuYuFQnGgS8zxe95F2Mir
	v1sHir2bSQ9mC/P8vfQRheqJjOHMv8BzHPaaqg4zESs6Q8YREpoRdYA7XAMltSL3NSXF
	SlYk6prHuxA2nKGLNjksOpJBst6UydHpDLq0VcfE3tyzXSOyK3fjoN+aXT6iHAr29T2b
	Bz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3Y7BQzq3l45+Rkdr4hE1aH4SlmgMAZMaKKxqseLLJrk=;
	b=J7F6BtJNhfeu7Guqqo9/zHI78Ei6WBPeo1mIrm3EWl0+VCUZ7XQa1+rgFBTaZaViJC
	JdYcDXXTsuE2uvGleu+ZZj4+9FAvVcAwtx32LBo6qAAKa7ZGPd6UR7y7CZ705JDqetFT
	LfPoKNLj/LQw6Tk7RCGb9Kp9qBlD9c1UFL8uGiv0AHUvWAiMiGzhpw9AirKuHOg3hwyH
	dS5zCiyZ5rDVwGO21ALbJnJLI+Zd5c9jMlaSRMHEP350hQWjoyhQ9cXoP63gk9uKPYZ3
	vw/6vQtxIPfN+YBe2KF2fioBT0auJRag347V4cb3kjP7do7YGG+G1elwhRXLNkZIZt9o
	pBcA==
X-Gm-Message-State: ABUngvfWm7uDyhp7goNi/lbPRsVFcbGxYSoc0038z4d4bZag2tJxjUNxocv6qz8qVPrzb5lr
X-Received: by 10.98.147.78 with SMTP id b75mr50523746pfe.167.1477932047404;
	Mon, 31 Oct 2016 09:40:47 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	j192sm36718494pfc.60.2016.10.31.09.40.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 31 Oct 2016 09:40:47 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Oct 2016 16:40:37 +0000
Message-Id: <1477932040-10112-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
References: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 1/4] toaster: use current directory if BUILDDIR is not set
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
X-List-Received-Date: Mon, 31 Oct 2016 16:40:46 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

If BUILDDIR environment variable is not set signal_runbuilds function
throws TypeError as os.getenv('BUILDDIR') returns None:

ERROR: unsupported operand type(s) for +=: 'NoneType' and 'str'
Traceback (most recent call last):
  File "bitbake/lib/bb/ui/toasterui.py", line
391, in main
    buildinfohelper.update_build_information(event, errors, warnings,
taskfailures)
  File "bitbake/lib/bb/ui/buildinfohelper.py",
line 1184, in update_build_information
    self.internal_state['build'], errors, warnings, taskfailures)
  File "bitbake/lib/bb/ui/buildinfohelper.py",
line 238, in update_build_stats_and_outcome
    signal_runbuilds()
  File "bitbake/lib/toaster/orm/models.py", line
1746, in signal_runbuilds
    '.runbuilds.pid')) as pidf:
  File "/usr/lib64/python3.4/posixpath.py", line 82, in join
    path += b
TypeError: unsupported operand type(s) for +=: 'NoneType' and 'str'

Used os.getenv('BUILDIR', '.') to make it always return meaningful
directory path. Current directory '.' will be used if BUILDDIR is
not set.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 9a4db1e..4f8510c 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1742,7 +1742,7 @@ def invalidate_cache(**kwargs):
 def signal_runbuilds():
     """Send SIGUSR1 to runbuilds process"""
     try:
-        with open(os.path.join(os.getenv('BUILDDIR'),
+        with open(os.path.join(os.getenv('BUILDDIR', '.'),
                                '.runbuilds.pid')) as pidf:
             os.kill(int(pidf.read()), SIGUSR1)
     except FileNotFoundError:
-- 
2.7.4


