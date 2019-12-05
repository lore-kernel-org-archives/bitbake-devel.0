Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id BFC306C149
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Dec 2019 15:29:10 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id c14so4117518wrn.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 05 Dec 2019 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KFeifF8dGoi2qsj8ueTpc/UTaqYXpt+hjWhgSbNFBck=;
	b=XwODFZhQXOnUVioPQlM3WrPj85O3HJJLmy0EmE0sjOZRUkkHNJQ5T434hDZHOq/Es9
	SnxxJIF2IKEvtyY3vdrD2qPsSWR0weXFzpMq5pRF+hcIhxJxFF0Yv8EjWY08j+IdyOEU
	oZnLLqm3FPxn+gC0sQFHtMegRAG8Uo35DI26U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KFeifF8dGoi2qsj8ueTpc/UTaqYXpt+hjWhgSbNFBck=;
	b=opDWwQQzREWz6XNhe17jgYTXNIAP7AQAQ6+MC1DDKt3kagr0xaowBRprT6nI2usUae
	g0VWjXLOTz3RQsUdkSwciQy8uq59AZGVYEzv0ySGV3F1hrJmdWG7pAx8iaN5GWjDCRSQ
	aKZpupJ+2bYm6+OsoV/ngHVG9hjqpZDmU3GoSaS0PpGahXbQlAmB8nzv3NsY+8L3iGrJ
	xVfcV49zZaAV3cXG+V/RUOQPQ7ryb5CCpMYCHCkvUe1TRkruuMGld1CVMbmYRTp12zoD
	ewvWDtZGnfhQ6jMWLfdv5vDkF8sk26X3MRJJWtutdrmCIRBtV9/i2VxpMGGdXKwq1RGx
	ewUg==
X-Gm-Message-State: APjAAAXKiK+VxBC0EuAdpq4tO5C08iVEj53bIK4okqEnzW4dNDnCTOO0
	9FKoTeMfBx32gzigsrNTUceXRW3JZWI=
X-Google-Smtp-Source: APXvYqwIFOs3W90usogjqAyXxZ/CSAmV0y21ds8iq65Ep9hLKrclbbnO2IdJt3GrxAURnRgHVOCexQ==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr11010517wru.119.1575559751076; 
	Thu, 05 Dec 2019 07:29:11 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a7sm13147004wrr.50.2019.12.05.07.29.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 05 Dec 2019 07:29:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  5 Dec 2019 15:29:09 +0000
Message-Id: <20191205152909.30943-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] siggen: Avoid taskhash mismatch errors for nostamp tasks when dependencies rehash
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
X-List-Received-Date: Thu, 05 Dec 2019 15:29:11 -0000
Content-Transfer-Encoding: 8bit

An example:

NOTE: recipe binutils-cross-testsuite-2.32.0-r0: task do_check: Started
ERROR: Taskhash mismatch b074da4334aff8aa06572e7a8725c941fa6b08de4ce714a65a90c0c0b680abea versus 17375278daed609a7129769b74a1336a37bdef14b534ae85189ccc033a9f2db4 for /home/pokybuild/yocto-worker/qemux86-64/build/meta/recipes-devtools/binutils/binutils-cross-testsuite_2.32.bb:do_check
NOTE: recipe binutils-cross-testsuite-2.32.0-r0: task do_check: Succeeded

Is caused by a rehash in a dependency happening somewhere earlier in the build
and the taint being reset.

Change the code so that nostamp taints are preserved to avoid the issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index edf10105f9..de85326872 100644
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
2.20.1


