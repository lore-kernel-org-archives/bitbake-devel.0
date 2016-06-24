Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 167FD6067C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 15:26:02 +0000 (UTC)
Received: by mail-pf0-f172.google.com with SMTP id h14so40292765pfe.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2016 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=JcVtkB78POZjC4JClG09/MWBwJRf6i/XYdQGd7AULjE=;
	b=evzFgISISo4UJUUORl+2t8aXb4nVFfLk7DSlHB5IY2uCx4ScEe1fk2fWKQoTGdtvjB
	fyAw3HThz0BUCKFlOb8QOxX1YUueVR6HpqP48ElVRjL6te4KVPzgzILJkrh0Ft79zshx
	Vum7bYaH0XZkojwG8NmN09EkP+u26HNpAC1OUqbrVxhK3ttZdSUWussqbz2wAdyqoQtU
	isn3IybprmbsY4vZacC8JydzNtD/6opZ+gcNEj9GFCYizVd9jMpww4Pju8aSifpdpBym
	JoNz2JkytE0pTO43LRV+i4M44SnA/p37kHdn8NAx7lwhTfkS9ybeq0IB4x1EahFalZ42
	wfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=JcVtkB78POZjC4JClG09/MWBwJRf6i/XYdQGd7AULjE=;
	b=T7jYeuCSbmCZt6v/okbA4Fr5A1wgUtza6vLUbXQxgcTh3T4ngfOQIMjHGZm8RJJ5hG
	7oulcJV+RPw4xyv07yW7nCzt6ecV1gKHC4Rns1qykc4Mr9ZpAURVmsboqTzFeLNPm78P
	F6j5uUt0UtNq5bAiWRuBHhPTR+rHsxAPVhAsPwuSIdwCMw3ZPf9MVawJE8heQ62JLMtL
	PK7HII7rLLGgKj9o5T+SnIHsHBRQdF6ybPAD/lSRxz4hImy2SVvmcdfAHwCsME4rqYnB
	YkGGanNogG+V0xfkfiKFVHneQJu5xxBmjGQCUJ/SHDZimR3TWPdKpW89yK/gMu7iJfrq
	eh9g==
X-Gm-Message-State: ALyK8tJXbhHmddbNiy3En5PyoboQk58Zpnhzx5xiCYO+vi88cJmlCnNFOtV9MEQs3kDvSl0H
X-Received: by 10.98.71.155 with SMTP id p27mr8495868pfi.132.1466781962706;
	Fri, 24 Jun 2016 08:26:02 -0700 (PDT)
Received: from orion.ger.corp.intel.com ([192.55.54.45])
	by smtp.gmail.com with ESMTPSA id w67sm939643pfw.41.2016.06.24.08.26.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 24 Jun 2016 08:26:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Jun 2016 16:25:53 +0100
Message-Id: <1466781954-16044-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/2] toaster: remove SSTATE_MIRRORS from blacklists in views
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
X-List-Received-Date: Fri, 24 Jun 2016 15:26:07 -0000

From: Sujith H <sujith.h@gmail.com>

Remove SSTATE_MIRRORS variable from blacklists in views.py
This helps user to point mirrors using SSTATE_MIRRORS with
toaster.

[#YOCTO 9598]

Signed-off-by: Sujith H <sujith.h@gmail.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/views.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 28ff67b..c40273c 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1533,11 +1533,16 @@ if True:
     def xhr_configvaredit(request, pid):
         try:
             prj = Project.objects.get(id = pid)
+            # There are cases where user can add variables which hold values
+            # like http://, file:/// etc. In such case a simple split(":")
+            # would fail. One example is SSTATE_MIRRORS variable. So we use
+            # max_split var to handle them.
+            max_split = 1
             # add conf variables
             if 'configvarAdd' in request.POST:
                 t=request.POST['configvarAdd'].strip()
                 if ":" in t:
-                    variable, value = t.split(":")
+                    variable, value = t.split(":", max_split)
                 else:
                     variable = t
                     value = ""
@@ -1547,7 +1552,7 @@ if True:
             if 'configvarChange' in request.POST:
                 t=request.POST['configvarChange'].strip()
                 if ":" in t:
-                    variable, value = t.split(":")
+                    variable, value = t.split(":", max_split)
                 else:
                     variable = t
                     value = ""
@@ -2210,7 +2215,7 @@ if True:
         vars_blacklist  = {
             'PARALLEL_MAKE','BB_NUMBER_THREADS',
             'BB_DISKMON_DIRS','BB_NUMBER_THREADS','CVS_PROXY_HOST','CVS_PROXY_PORT',
-            'PARALLEL_MAKE','SSTATE_MIRRORS','TMPDIR',
+            'PARALLEL_MAKE','TMPDIR',
             'all_proxy','ftp_proxy','http_proxy ','https_proxy'
             }
 
-- 
2.7.4


