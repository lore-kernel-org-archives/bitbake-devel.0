Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
	[209.85.221.46])
	by mail.openembedded.org (Postfix) with ESMTP id B81E87F02A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:37 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id f9so4180672wre.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=5Hz3MgGL7Pt/gD6qvpKArblljkwMR1qf5JCeRBOgPz4=;
	b=cwJWn5j5O/YMOm4P9CIO18ezxN2KsNMotjhi9vsGPTrgPz/+arEjyxeZ3O2EOTQJRP
	+js2mrgPE9JPJACF28TfTQdg5RVkTNl4iwmeJRliYfnLyHKj0Y1X2SPkNRelLpQbRTD9
	dqP0+OqQymc/wexulQIBKwD5kly9QMhlIs/BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=5Hz3MgGL7Pt/gD6qvpKArblljkwMR1qf5JCeRBOgPz4=;
	b=TQePq1h4ZdEdTOxFlRZfRd4whaZ81I3PwLHbVm5MSepe29fIoKSgSj2KhJeFeq1ev7
	tSiEF3rIWNOiMYYdcXf+BzeuCeYpNCfMqu+44VKJ788uBDpEi8ailrkV96jlJ8dDtn/y
	+UqC0orQK1Gfe9oloBFd3ZHa7JtdfitKn9jBJlrZG5wBDGSR+bXnFRymVWVaFI15C1eW
	xr9mVjH2p8e9LxRHk4xSPf4Bk8fZS9LE+M4Q9DvArxOVSQXLbQpVigl2qkhyFegRatOK
	Ith1G4LsnJhW2SyQAuyo3j5BZyGQToVaakpIxkyTWuBhuUbVZywT7nQW/gJK9jPh6ueg
	pGpw==
X-Gm-Message-State: APjAAAWTTZUxJFb4iPYEKd7S/Nux7uhLpim//2uM4WBmHmfVdhSF5hyN
	ny+XEaBFhusqM6mN1MiTfSwZqt+Tu68=
X-Google-Smtp-Source: APXvYqynWXrA+hsLO/WR6DUtc+FGGGJF4knvaS0eLvaqNuF/VuqghZWQ9+ASutebPqPUmTUzrUlmsw==
X-Received: by 2002:adf:db0b:: with SMTP id s11mr237123wri.7.1562802878419;
	Wed, 10 Jul 2019 16:54:38 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.37
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:37 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:12 +0100
Message-Id: <20190710235420.23825-18-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 18/26] runqueue: Code simplification
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:37 -0000
Content-Transfer-Encoding: 8bit

Simplfy some looping code which no longer has any purpose.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 05bc9f9488..13e90e709a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2363,10 +2363,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     # Sanity check all dependencies could be changed to setscene task references
     for taskcounter, tid in enumerate(rqdata.runtaskentries):
         if tid in rqdata.runq_setscene_tids:
-            deps = set()
-            for dep in sq_revdeps_new[tid]:
-                deps.add(dep)
-            sq_revdeps_squash[tid] = deps
+            sq_revdeps_squash[tid] = set(sq_revdeps_new[tid])
         elif len(sq_revdeps_new[tid]) != 0:
             bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
         rqdata.init_progress_reporter.update(taskcounter)
-- 
2.20.1


