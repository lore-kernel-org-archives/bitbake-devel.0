Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
	[209.85.210.179])
	by mail.openembedded.org (Postfix) with ESMTP id 06AB57F88A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:49 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id i23so3148474pfo.2
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=bi7RuMP+Bnsa8jazFTu3FId2GX6ThWlRUnZE3+EHWgY=;
	b=DNdgSFBA28etg0xsj0DCPWEIkzren/fTgJV8hRr1GZH87brbKmvLnDS1ziRjGHBK4t
	mWksAlfKm6eg3aAOzz4afpLibJYAj6yATzIRHapmFpd1q3v36m49EZ4B+8Oki71PX82K
	cOgca4/MN6tZXIUFLsuuc3AzfFgYOtMyRPjVI0HPtjG1cdQyEE9auyWd5HBVbZHPpFe5
	UPxMaUYMksX5w/zI5AaFjhwv4oBRkXBJGQaXhgJwtYOF+YH1ChzhvI50EqMs0xFMScTu
	Ci9q5reno5nQg9/d9dybM00ALpl9xX8mwFn9oSx+55wqzZX4P1XOzRmeRIcaXx4sg/VS
	RmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=bi7RuMP+Bnsa8jazFTu3FId2GX6ThWlRUnZE3+EHWgY=;
	b=mwOUSv+eSFx7wfS3lzilkEZV10wPwx0KfXEtHeU3r4E25EIZ7auzwPqFy6j6wPYmO7
	HCULYdAopi3W03YFBJyU2DSWUh+ZITGr0bUuPlaEMV5MABcLfuVHfV3AgUs3uunlo5S/
	PDn2XdEO/eHi1hsah91+7EpOQoHe1dP0jke/bPuuXVDraHlQdw+mt9NAQe6NiqCkFUCW
	l/E+Pyhp2bJtv5aMCJR2Vq2Jcus7xz0FIvdTCfxmrLrgSZj3sbUZA/HzUbLiLBUAwLPl
	BGK6Cdw32vGOzUTlVtjbm7LGQe7QzjN3EQwSJr1/ULS+SfIQS8pf7c6f8DaXlFOiiXbv
	N8HA==
X-Gm-Message-State: APjAAAUqza1MG/s6vbeFr3E5LBYc80YTac9BcHXCXcwLI0bVinUxAQdU
	/w2uPgXyYlou19odjRl58yAcJgPAD5E=
X-Google-Smtp-Source: APXvYqyBhWSFy85ZPD3zU8H/mCXkejis+MPm//Q4kFlsh6VQKYBNAsg6GtlfUzzfRwHwgWZRnTM/cQ==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr30013464pgt.145.1577076650958;
	Sun, 22 Dec 2019 20:50:50 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.50
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:50 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:29 -0800
Message-Id: <c42d00ff293d0538cad1b84c108bf7f5f49d4d84.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 05/18] siggen: Avoid taskhash mismatch errors for nostamp tasks when dependencies rehash
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:50 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

An example:

NOTE: recipe binutils-cross-testsuite-2.32.0-r0: task do_check: Started
ERROR: Taskhash mismatch b074da4334aff8aa06572e7a8725c941fa6b08de4ce714a65a90c0c0b680abea versus 17375278daed609a7129769b74a1336a37bdef14b534ae85189ccc033a9f2db4 for /home/pokybuild/yocto-worker/qemux86-64/build/meta/recipes-devtools/binutils/binutils-cross-testsuite_2.32.bb:do_check
NOTE: recipe binutils-cross-testsuite-2.32.0-r0: task do_check: Succeeded

Is caused by a rehash in a dependency happening somewhere earlier in the build
and the taint being reset.

Change the code so that nostamp taints are preserved to avoid the issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 61624a3fc38e8546e01356d5ce7a09f21e7094ab)
---
 lib/bb/siggen.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index edf1010..de85326 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -232,10 +232,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
         taskdep = dataCache.task_deps[fn]
         if 'nostamp' in taskdep and task in taskdep['nostamp']:
             # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
-            import uuid
-            taint = str(uuid.uuid4())
-            data = data + taint
-            self.taints[tid] = "nostamp:" + taint
+            if tid in self.taints and self.taints[tid].startswith("nostamp:"):
+                # Don't reset taint value upon every call
+                data = data + self.taints[tid][8:]
+            else:
+                import uuid
+                taint = str(uuid.uuid4())
+                data = data + taint
+                self.taints[tid] = "nostamp:" + taint
 
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:
-- 
2.7.4


