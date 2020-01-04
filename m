Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
	[209.85.216.68])
	by mail.openembedded.org (Postfix) with ESMTP id 6D9337F898
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:18 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id j11so5245588pjs.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=yJENfPE4I8gLB+2D2ASqpt9NY2UteBRBavTqjS3xgl4=;
	b=XvY0Ucm4M+Ls1Mvn8Nj96GLffg6G+WseXAPHAXLG5OZGDZp2LdwrU/B3m/RCy7NNrC
	964iqDlDYDg7/thH6RDYJQSLkbfnmJTQ+W1fHC6kX7xY3txn+kDyprM4C2KJq3la8JTz
	xBh00SuRDjgv1g9ePUUoUhUbXUwOswC25phDx/xpA5Jfep53brogTX2IsJQSPJdsiWLE
	7qvhFGJlO9mTOVFXWxbQYl4ifejgw21kuVbuJAI1cTZnhBKkYnXjW/DGc+1eY/QjQbo8
	DkUbnQJDcAPe9Zlw7ZhqYQit6X3RCmiRgH5ryQKlrRNgZDwhYd+oyY6eYtDol0fSjZhN
	GY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=yJENfPE4I8gLB+2D2ASqpt9NY2UteBRBavTqjS3xgl4=;
	b=uBpcdRD2uGdgEORgHmHYYgaCbxKT5pgTS+EHGCix7oIHvTICecw5S0kdIh4JLh7vkS
	xPBaSJS8le57FzkS4yhffmxRzIgQ/G8URN9a5iBkE5WWxRtYPcZ0xu/+Bee8iji+jdKT
	wMm2qBxHITCPMe+fmv+Voi6gR+Pk2+yPF5XHb9ZLWP17WEQL70UITt8LocWsWcH1e+mX
	chVPsQdsU0FG/W6hb+QrjIpqvsc6V3Jg0HYZxnuTgmKFCEUk3sJ9tESLz2B/97fyqZVl
	q4rxBJ5gqK2xZbqV2LmaP2iRIgI899iHdXKUDb/WOOALH4HnNQh5ZznbMzM4rNxsEKkA
	Ey2Q==
X-Gm-Message-State: APjAAAUoxuAf4XvQ2E7Nf3Gsw0p0RDqOncDtCdOcZQ+sK5VBDAMmUOoK
	D8xwLF76UDoU06gzD4/SAMAlQlJ/MoU=
X-Google-Smtp-Source: APXvYqxIogIyJOiGfzUB6K4y1yLcmb71w0svcXdypmLNPmgd11xXcNuF5X2OJh0zcg0zFXejsx72DQ==
X-Received: by 2002:a17:90a:25cb:: with SMTP id
	k69mr30659735pje.121.1578104599302; 
	Fri, 03 Jan 2020 18:23:19 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:18 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:50 -0800
Message-Id: <c42d00ff293d0538cad1b84c108bf7f5f49d4d84.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 05/25] siggen: Avoid taskhash mismatch errors for nostamp tasks when dependencies rehash
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:18 -0000

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


