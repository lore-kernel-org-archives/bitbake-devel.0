Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B3CD37AC
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 07:13:51 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8262.1778224425005144523
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 00:13:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=p50oI6Gr;
 spf=pass (domain: smile.fr, ip: 209.85.128.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48e56c1bf5dso10242245e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778224423; x=1778829223; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z45C/w4/gVfyej+gvXcV/NidZMw0z3zx15EB5+J6FOQ=;
        b=p50oI6GrsMoxmBiFezq6B/oVFm/OvpffiteGYdWWs66mXSA6JBTri2CRl8dhmW5P4c
         FHFATQBHGkiTcF4rbKSeAJw3HBWVcMXzLeyP7FiD+AzgbH2QEempwkmEMSjvBW+eq6so
         bPDyYpt8emLXEeoMRr/kMgNIDgtJsf/5Kt0Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778224423; x=1778829223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z45C/w4/gVfyej+gvXcV/NidZMw0z3zx15EB5+J6FOQ=;
        b=KJmovQoDo9+J4EasXY5IReLBz6tbbIpYa1adRY9j3XKvjuvNLtCAal6eiJIb9YDUKT
         hKO5plebwfn6pN2Bke2q6UHJp/5U0ZMSjnV81uY74WTXfsW2NSYoKdIZUxL6kucE0QF/
         9gGetQQUMFB1NckfrUwENGOHZ/zuAGb1Rcau6/FgbWKbZcjprNlMLl+6gS/Pf65iTbd0
         qzttJ0nVUlU1yW+sjgiRCnNBqDS+ww2uSwZX4WvegHynJNS/gotOW6oO/KIWC6cDQ33J
         WRVJvkh2UwyfvSfEIcJ4ZpVH5nZhz7hLJt2OFDDsnM5G+9JOCsijsZlJcGqCJGgYSdlr
         yq2g==
X-Gm-Message-State: AOJu0Yx55FJvvSX7nA/zHJgQkvRiH4qH/rimEmu7kAn3FT6S6Dcveg5+
	F1XMvnHlM+7nmqDlA7VvX1y+jiwKXiS2vYjoz0G7e+yuElJ732pq4z7PkNCfAq56d5G7gx7nQwg
	BEncTFqM=
X-Gm-Gg: AeBDieuW/hvUNrq/Jb0gkiRY7RBQgBL9ddDUOpbiq1uqkKnrnOmyWYiNE0Z34V/lcOL
	GQwXHOutoWjQNOrexfnyTGnsXFYL7f1uZy7wewAgnwVRw7BDJbudFdPIyF9xC0YYFzPvoxRLIIv
	qCY/ngBTwQxYys1nKA48awhmSklp5sa/2J7+9Vo5Vueu39aCcz1748ikBCgFnjY/ULRSN+BylaL
	zPj6MjH2MbsU8akmIlnA1EbxGsEHtFM/Fol3l7z+n3pT8nuLs+43pOOhlTjZuexjngB2PEFR/U9
	vtxpChFdJjpSa9YRyArojssj9O5KCZ8clF21Pviv/oDJVSR4en1H1AOG1gq10NhYl2G4lZvxULF
	uZ5A3/6dbAxURfcB20GRfdxBE9gi3fdvSLWzf9o1adD3LBTO97H6lmbEHCEjZq8RKdPL/du4iEI
	mCz0u1lViDGd7KuwLANuOYrQhwFE0WgNBxxsxMGwjSOTh58WCThiyPb8fa9MLgwfUfY2Qwxfh63
	XEhLoxMkdyAHPsx0r9bXFRStjulgRiWZFCvOQ==
X-Received: by 2002:a05:600c:8b08:b0:488:a977:8de with SMTP id 5b1f17b1804b1-48e51f32757mr194190625e9.16.1778224422894;
        Fri, 08 May 2026 00:13:42 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68edcc3asm26363195e9.6.2026.05.08.00.13.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:13:42 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 2/3] fetch/wget: in upstream version checks, match versioned directories exactly
Date: Fri,  8 May 2026 09:13:20 +0200
Message-ID: <91d8f8c29107728c8974a7b66d5b78af46b362bc.1778197991.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1778197991.git.yoann.congal@smile.fr>
References: <cover.1778197991.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 07:13:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19476

From: Alexander Kanavin <alex@linutronix.de>

This change is in code that iterates over a html page, picking
out links to versioned subdirectories to check further for new versions.

Without the ^ and $ guards, there would be sub-string matches. This results in
querying the server multiple times for the same directory (for example,
perl check where the page contains multiple references to 5.0/something-unrelated)
or querying the server for directory that doesn't exist (nasm check, where
existence of 3.02rcX directories would result in querying the server for non-existing 3.02).

I have confirmed that the overall oe-core version check returns same results as before, with
less network churn and nasm version check working properly again.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 4af5f6a65a63bd92021d5eaa9d9ecc14f7397823)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ca4959ab5..6ac4306c0 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -539,7 +539,7 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile(r"(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))")
+        dirver_regex = re.compile(r"^(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])*(\d+))$")
         s = dirver_regex.search(dirver)
         if s:
             version_dir[1] = s.group('ver')

