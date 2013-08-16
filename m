Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id 072536B772
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2013 09:21:06 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id hi8so696795wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2013 02:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=er7rPEbdfrq/AQKaG0OcR/Jc16LiOIk89Q3PMsmjWLk=;
	b=eaY4SBA7rxgAy9s1ylEHlg4n3s2ZD0CoAgeL2u30bWMwA1qglf4yl+jRZLHfG6EomS
	IZYe2kSz8hxPu/kKu/ZOo7jqXJMM114fGIWT5L366w6fNdrm2yMYWkUmKNlHsGetIYs2
	Z+it236EgPVnhenIiWIFOh4X0fuhse25R+CDOwtyPF/2XzvPEJyYDKggeAfF1N7KNvQ5
	SEucmQP/zjG2pqv37iwC7s+ewdpIHSDuNUSsoYqbM/dzSG60ni820ZymVMtpBgy7j1ro
	cgz9rCdTouTTh3MC3e8up5zNNSnwzIO9o/hc7oodOi/E98P/9+stlOFWjb9ztKXFcUA1
	9scA==
X-Gm-Message-State: ALoCoQm0KVsHDmjCqvUfLCee3IhFzgd6+0WQI9yvOzskbWUBVrZyGW6FOI1tWZaUroS/BGgWDwhu
X-Received: by 10.195.18.39 with SMTP id gj7mr68792wjd.53.1376644866757;
	Fri, 16 Aug 2013 02:21:06 -0700 (PDT)
Received: from localhost.localdomain (gau06-1-78-243-126-63.fbx.proxad.net.
	[78.243.126.63])
	by mx.google.com with ESMTPSA id bt8sm789126wib.8.1969.12.31.16.00.00
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 16 Aug 2013 02:21:05 -0700 (PDT)
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2013 11:20:59 +0200
Message-Id: <1376644859-11034-1-git-send-email-nicolas.dechesne@linaro.org>
X-Mailer: git-send-email 1.8.1.2
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>, patches@linaro.org
Subject: [RFC PATCH] build.py: create symlink for run.do_xxx scripts
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
X-List-Received-Date: Fri, 16 Aug 2013 09:21:07 -0000

The 'courtesy' symlink for log.do_xxx are quite useful when debugging, so
with this commit, we now get similar 'courtesy' symlink for run.do_xxx
scripts.

We only create symlink for tasks, not individual functions.

The symlink is create right before the actual runfile is created, indeed
we cannot create the symlink right after running the task since a failure
or execption can happen, in which case the symlink wouldn't be created,
and symlink are particularely useful when the task failed!

Another option would be create the symlink after the runfile is created,
and before the script is executed, but that means we need to duplicate the
code in case of Shell vs Python task.

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 lib/bb/build.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index d91ff53..0977ea7 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -190,6 +190,20 @@ def exec_func(func, d, dirs = None):
     runfile = os.path.join(tempdir, runfn)
     bb.utils.mkdirhier(os.path.dirname(runfile))
 
+    # Setup the courtesy link to the runfn, only for tasks
+    # we create the link 'just' before the run script is created
+    # if we create it after, and if the run script fails, then the
+    # link won't be created as an exception would be fired.
+    if task == func:
+        runlink = os.path.join(tempdir, 'run.{0}'.format(task))
+        if runlink:
+            bb.utils.remove(runlink)
+
+            try:
+                os.symlink(runfn, runlink)
+            except OSError:
+                pass
+
     with bb.utils.fileslocked(lockfiles):
         if ispython:
             exec_func_python(func, d, runfile, cwd=adir)
-- 
1.8.1.2


