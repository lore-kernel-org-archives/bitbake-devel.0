Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
	[209.85.216.45])
	by mail.openembedded.org (Postfix) with ESMTP id B50797FC9D
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:26:53 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id m13so7970562pjb.2
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=yJENfPE4I8gLB+2D2ASqpt9NY2UteBRBavTqjS3xgl4=;
	b=jld5QoO9J/OCDBdLxBnSqPMDT9xQm9hTvQQC8VZpYLI1JzLWeZnDzvqVPw70U1XM4I
	3v0H/c6SpkTMfDIHIzUE+0Ws+bLCNYnKVt5dC9wcm4sRgPC6tS7ov5XWT9u0HWxDVspV
	Zjc9jqQdnLQMROY7ESP0J0SODd7pM2b070Ns67fMzuCCEp8pLJpHAJvkhewpBHbgcMRh
	rFQAbEaZljSlxTKizFIaZt+KiY/8lCRiarznX5HXbtHJF3hCSBFVgVYUYXZsxelo6Vrx
	ev4q8CsDs0Twn8V5PNFdErVaLd3TCGbFCP3a0hPRmMlsdbuxB1fa3xeOw3a/Lh+TwlfA
	urvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=yJENfPE4I8gLB+2D2ASqpt9NY2UteBRBavTqjS3xgl4=;
	b=k6CxdKs2yP0tt68IeLMlb+kJyKfpAgR+GXFpdh+o6oQDENBENEZZY3DCvDHCOBmqsi
	EyiPaoomdnhAZ14BFsIMZVTsfE9hgBt+J2Js0JLOxYQY7HoqGSXwuw6qAyKlN1GJNvHg
	u6kdwEnS3hhjVPzejDnIaAQ4rRcvNRwdkBFfv9CiY3etCe5m5CSV0JL6RFvRTZtBv1eT
	QJ+RSgpWe1waQC1IwE4YBHUgJekLDaz3Kp+tQ0dcdvVH3SOgi28UrIrbu//uhu+65NDp
	DrTYsdE7KYZSbqaM+IQ2B0eTWMxF7xs95vgebQaAo8zfb1pEpKZAEPxl0R99OwkJf3EW
	d0GA==
X-Gm-Message-State: APjAAAXer1axHvX8xZymg7aGFQ2L02Mh+N2KkPorFIswMnWn5AmPjEKL
	KcaMSlMFyYA6/x1PTS5fnvHf7RVP
X-Google-Smtp-Source: APXvYqwa+haZLJH3U9TsertVrWiyPO+mk6cGbzdhRr/YCowKhu/cy/v9Jr4Rus6C4wkljlF2aVLYsQ==
X-Received: by 2002:a17:90a:cb8c:: with SMTP id
	a12mr44603077pju.71.1578328014729; 
	Mon, 06 Jan 2020 08:26:54 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.26.53
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:26:54 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:26 -0800
Message-Id: <c42d00ff293d0538cad1b84c108bf7f5f49d4d84.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 05/25] siggen: Avoid taskhash mismatch errors for nostamp tasks when dependencies rehash
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
X-List-Received-Date: Mon, 06 Jan 2020 16:26:53 -0000

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
index edf10105..de853268 100644
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
2.17.1


