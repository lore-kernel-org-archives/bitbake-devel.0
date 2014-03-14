Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 448C56F7E4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:02 +0000 (UTC)
Received: by mail-wi0-f174.google.com with SMTP id d1so5732764wiv.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=pgoEyqsHP7Pi+QPQOzxZAx1rgNL8bou09BNR889W77M=;
	b=IGwJQ3cU3MU+nlCCKF67hvQ8sNLTnwod/TzhdSussYcob8AfWDKZ1hMieW226tetc5
	6kmoF9ta2r/q6goTN6KvwCsYTPJ6f9dksqJyC7ZLoAapCaXPBx1PTFU3hZUCVtxuje6E
	Pnz2UoXFzr3s7cIX3683EGAPzIVJQaF/RU67cnyghsnXWoKoUEYTQkHTuDYQYMbUkPiq
	vyAcmstvdICYfOCfyqMUCOA3e2MN+t/hz3yiNLUWjKdpkUaQveHQC6MihstfaqPLQYyS
	DxO7CNtqe+YJf4I/diuqOcui72UklKwfzj3TeUNo4Cit8mqG4k24T1Hrm1BebT4H7eUY
	2qwA==
X-Gm-Message-State: ALoCoQkFFBvX0Rl8ZLMLJN7fwPfmfUMLhXCAodm5WNeXu/1Bo7k+3MUVQhNVZeCxis6eJV26x2ke
X-Received: by 10.180.87.162 with SMTP id az2mr7218651wib.23.1394819943498;
	Fri, 14 Mar 2014 10:59:03 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id i7sm36755988wib.1.2014.03.14.10.59.01
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:02 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 078D6560592; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:42 +0000
Message-Id: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 01/19] toaster: fix target file inode type information
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:03 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patches fixes the inode type saved when writing the
target file list information.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 8f091e8..b5e75d9 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -235,11 +235,11 @@ class ORMWrapper(object):
             path = d[4].lstrip(".")
             parent_path = "/".join(path.split("/")[:len(path.split("/")) - 1])
             inodetype = Target_File.ITYPE_REGULAR
-            if permission.startswith('b'):
+            if d[0].startswith('b'):
                 inodetype = Target_File.ITYPE_BLOCK
-            if permission.startswith('c'):
+            if d[0].startswith('c'):
                 inodetype = Target_File.ITYPE_CHARACTER
-            if permission.startswith('p'):
+            if d[0].startswith('p'):
                 inodetype = Target_File.ITYPE_FIFO
 
             tf_obj = Target_File.objects.create(
@@ -286,7 +286,7 @@ class ORMWrapper(object):
                         target = target_obj,
                         path = path,
                         size = size,
-                        inodetype = Target_File.ITYPE_REGULAR,
+                        inodetype = Target_File.ITYPE_SYMLINK,
                         permission = permission,
                         owner = user,
                         group = group,
-- 
1.8.3.2


