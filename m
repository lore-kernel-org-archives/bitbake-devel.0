Return-Path: <marciohenriques84@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5E6FF8873
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 12:39:03 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19567.1777552733422476982
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2026 05:38:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=H9/QpSrg;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: marciohenriques84@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso805176f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777552732; x=1778157532; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fm0sznUCinLSvkcne7Jlr9vCozCsSPdMt956UJsEUXM=;
        b=H9/QpSrgmU/088Sdmc8HlyBpuZLUfyC26uuYew8QLzFsb0tE6ayWL6RXJob5q0VKc2
         YeHWH6+JYORl7XWaUa7+ryzNOmx3aDh9JZNHnSO7UwuhWta0QHiHXZk3J0Y5fEsbOvW2
         gFEki4VCvhWT6MMqzo8B+frZu6HyKNKQUsM3z0DGGGmM7dwmLgv+/9vdNVj/H0gMgyM7
         m7wxV3DbZKXNvEW4uVbjf6dzN2LKseq05ivtaJ6CETtHeN3WE7x0RTd55FZiakRsPYMT
         oe4Y7F/oPRqbyH+I2FmaUhCFh3oMSpjtX1iWD0vtAJO+i88l5dyQ0iA4JIJteyksH3z7
         PO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777552732; x=1778157532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fm0sznUCinLSvkcne7Jlr9vCozCsSPdMt956UJsEUXM=;
        b=hEgc+fcHObHLdq8Cx0uzVvew50DD7ZwkL9sfRKHGbHryFUPKEnzMRADmLTBVGM0kk8
         Ov89v7c9Locew34AGvFjQS+Gi22rOkMTZPL/VUg3DkyF25E6xL6XEtknxCvxExdDTMT4
         /78Z8JTHm0TM+s/4AyfRBlHYi8JuKmGDQm/G3ltOJw6UwdpTDva4HvvfTChftyBapebP
         TH3YiM6hwRx9ywnD6xstQNdU1iR4toY2oRqjczs6QSObCXdCocRc2BVVtFhxpln/rZHC
         AGcRki5Ha+WSR5rAmpF02B+DgMmUmA3fAi4Q3o6EwqB4XD8TZlwDk9qj5pIY3PIOS4Dt
         Xokg==
X-Gm-Message-State: AOJu0YyFZ6hF5T4exSNX3R2Qdu/aahph9Ef4bREg0GdH+L9OYU0Yb8G9
	eb6uWVb0v6adQkVE12mqz5RBRoAJHGuHAY+FfHdavtMueMSXVs7I5JwQ4l0pIKHR
X-Gm-Gg: AeBDievcCb6RIv7Q16QejtjwpBIgXrr4wp3weL6IaN0bkJVhdaKNrbnCXOWYet/Bq2/
	Uujp5Gsv75tAoPnUqf5quDJiBIp8br+E2dUvoUDB2zAsE2zLUOkvNdeD+eD5TJs3un2OmXVmelg
	kLGpxqUFtzKrUNqHK19EJEt4/VXEpMIK9gsygUvwoHmVrCE4jYHYeAX0nqvqh/mGWWzdNejt2OM
	qx6Z0prla0spOGYvZLHswZO6gBe62WYO1b2daqLIgSaPRr1YSiDENnTOU8sluolZDLqO4nAMqUq
	oT38asWpQladcJsSiAiHFQBcwnPlDb+hYO/Mc8Q5WWlp1zm/whUMaKooPdT+E+i4i5Xq4ePwh9I
	RDsq6CCpIslHlj5NkWIx+r/UfscnyOpxRj/dJjXxxqhcvGM7dpciazXdRAsyd7Vy3FAs5ma9jkh
	CTQt5ZUofHtVRGcVwKfAGNif/QUGBnuZEE7Mx+3/1n4Y6bKgGZFBhRnKUEPRcr43+lgKBVf0DPn
	cmCRUbqyF2cr9KyL+vDGpC04yYX5pTS9MavJAVIA+XCYzZz+KYPPDsq
X-Received: by 2002:a05:6000:b8e:b0:449:cfea:ca91 with SMTP id ffacd0b85a97d-449cfeacad4mr1513809f8f.37.1777552731387;
        Thu, 30 Apr 2026 05:38:51 -0700 (PDT)
Received: from PT-PF3LTRXS.critical.pt ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b4216675sm12966638f8f.11.2026.04.30.05.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 05:38:50 -0700 (PDT)
From: Marcio Henriques <marciohenriques84@gmail.com>
X-Google-Original-From: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: Marcio Henriques <marcio.henriques@ctw.bmwgroup.com>
Subject: [PATCH 0/1] Subject: [RFC PATCH] bitbake: fetch2/git: add switch to disable fast shallow path
Date: Thu, 30 Apr 2026 13:38:43 +0100
Message-ID: <20260430123847.25046-1-marcio.henriques@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Apr 2026 12:39:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19420

Hi all,

This is an RFC for a small behavior change in the Git fetcher shallow flow.

Problem statement:

Our CI setup uses a hybrid strategy combining both a full local git clone and shallow tarballs.

The full bare clone in DL_DIR/git2/ is the primary working copy. It is kept up to date across builds so that each CI run only needs to fetch the delta of new commits rather than re-cloning from scratch. This is used to bump revisions.

Shallow tarballs serve as fallback artifacts for cases where an upstream revision has disappeared (e.g. due to a force push or a deleted branch). They also allow DL_DIR to be cleaned up at any time, since all previously integrated revisions remain available as shallow tarballs and can be used to restore a working state without fetching the full upstream history.

The problem is that enabling BB_GIT_SHALLOW also silently activates a fast shallow path that, when no local clone exists, clones directly from upstream into a temporary directory and produces a shallow tarball — completely bypassing creation of a persistent full clone in DL_DIR/git2/.

Proposed change:
Introduce a new configuration variable, BB_GIT_SHALLOW_SKIP_FAST.
When set, shallow mode remains fully functional (tarballs are still generated and used as fallback) but the fetcher always goes through the regular clone/update path first, ensuring DL_DIR/git2/ is created and kept current. Subsequent builds fetch only the delta.

Why RFC:
I want feedback on:
1. Variable naming and scope.
2. Whether this behavior should remain opt-in.
3. Any concerns about interaction with existing shallow tarball workflows.

Compatibility:
Default behavior is unchanged unless BB_GIT_SHALLOW_SKIP_FAST is explicitly set to 1.

Expected benefits:
1. Better CI network efficiency for repeated builds.
2. Keep shallow tarballs as fallback artifacts rather than primary source.
3. More consistent use of local mirror/clone state in DL_DIR.

Configuration example:
BB_GIT_SHALLOW = "1"
BB_GIT_SHALLOW_SKIP_FAST = "1"

Thanks for feedback.

Best regards,
Marcio Henriques

Marcio Henriques (1):
  bitbake: add BB_GIT_SHALLOW_SKIP_FAST to disable fast shallow mode

 .../bitbake-user-manual-ref-variables.rst     | 19 +++++++++++++++++++
 lib/bb/fetch2/git.py                          |  4 +++-
 2 files changed, 22 insertions(+), 1 deletion(-)


