Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0449C28B2E
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 12:29:00 +0000 (UTC)
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
 by mx.groups.io with SMTP id smtpd.web11.7715.1741696134953408767
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Mar 2025 05:28:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IThC6mtf;
 spf=pass (domain: gmail.com, ip: 209.85.160.195, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-476a1acf61eso3273151cf.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696134; x=1742300934; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nihKPuU9Z/d3ElxfbumAqsEhLIscub/PPlBnPIGs/Kw=;
        b=IThC6mtfwRKFeoH58xl4p2aiTQzpgFyCI2DYk3Te5SroBExN7xanvwkIzKp4zxk41/
         Nd67rHuUn6OyeU9Y9Og9a/KCU4ODlE0btkY5ry45z+tnT+OW85M9OU0Z3aRAy5O+UaqW
         Y9qu9rEn1RMUy9DxCC+Yk/H2ucWqy/dtw7FpfoMcZvhR+Q0yNeKxHBebWOSBEtASYarF
         7QTfskogIaZ/IShCqv6lfExfe6sqKX+zfM38xyoMloCEHgqJWPVsFGuvBA0KRyQrp2Q4
         ZIr8fyIyeNxjRq1QZ0QhL90S78HbtyoSvTtYTuo6kT1Vx/soI8i/Nf3xBQ9IO3YNtt7x
         Zrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696134; x=1742300934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nihKPuU9Z/d3ElxfbumAqsEhLIscub/PPlBnPIGs/Kw=;
        b=P35qsGwtej48iJMrm3I69+gqpzZFQ+QcbHJlOlFmKC4e7XHJg33waAcz10DLNPE/IG
         lTnnVWQhDSvc0woddYift/noc7h123sbJJPKNnFmtZVF4MicItPW9XqnncEXJnr9t3mL
         MhmXGzIwyV5VuRyTiOodopVI/PTil8yzsJ21NvGe/fXOS84ieGyS14FR+O1f173kIlxp
         u8tMdyRjAvf5XNjdEDyF2BTAPeczTlvC+Je0POKvW2ADsZiWvbII0NYQtT/atrPB91Pr
         LAoCG+3HbFreV1CKtH0TTnRSvBNQsZKOF0+rSR9dJ7PqokuGUqOwdkjq0V2sT0QwJX7q
         0MtA==
X-Gm-Message-State: AOJu0YwkXYvWqEJNQODTNOTccPmL2/SP1vT/Sse6rzVTIqEPOu6cdYFl
	Z60NFTqfqe8fnSwslkvaO4PvzSXSRwBk4N8Qq82BdMcLBbUsBpDmNLZYUydq
X-Gm-Gg: ASbGncuVqPxxUW4tncdR6/UqxK+Cf7ebAeaBz1hX6JYcjapsc1KBYsmSBZxDI3BIUEl
	C0J1sKjoQPAsp6PaKQuHQl3RoOS+B/0To5tXSW/RRZyraTnATgxGMaqeDd3VEMH5hVLQpbQqoHq
	oXlW6iVKT4/6DTY4LyPDlvkuPDxzKkI+Wlo99MH67X6zxLuil0+9O2bRNi51QbeXqC08sXVJ5HU
	qCh0XUn5iMv/tEHj704CvJuCJdav3ym29f+j5j316q4pnm0zot39Qf+JNvNJkFFUvrjiKFhyMe0
	OulI0cXcAW/9G4EwzlByCYA0+b0LmxQfzDp/YF2+algZRQxug1gubQqN8rFsi3V0KhA2gD41eNQ
	RmpLr9qcpooALudzJZhagvHFJkNYqw6Z03lwDndfApg==
X-Google-Smtp-Source: AGHT+IHYyxrzkrYcQwJPPxdLsiRKhIZ0/aGkxT/Lgrl3+U+hCRIFD5nxoUQO554D5eXP/9CUJ8k2Hw==
X-Received: by 2002:a05:622a:3ca:b0:472:3d:d317 with SMTP id d75a77b69052e-4769951291fmr46106941cf.28.1741696133735;
        Tue, 11 Mar 2025 05:28:53 -0700 (PDT)
Received: from 6543eb6661e0.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476905e344esm23876391cf.46.2025.03.11.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:28:53 -0700 (PDT)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>
Subject: [bitbake][styhead][2.10][PATCH v1 0/2] NPM Fetcher Private Registry Authentication Support 
Date: Tue, 11 Mar 2025 12:28:59 +0000
Message-Id: <20250311122901.13820-1-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 12:29:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17429

This patch backports support for use of an .npmrc file within the NPM fetcher
via the BB_USE_HOME_NPMRC variable (introduced on master with commit 5fa6137b6).

This commit does not introduce any regression due to "BB_USE_HOME_NPMRC" gating
the use of this functionality - since no one was using the variable before, a
majority of the code introduced in this patch will be bypassed when using the NPM
fetcher. So while this technically is "new" functionality being backported, in order
for it to be used, the user will need to "opt-in" via the use of the new bitbake
variable (thus it should be safe to backport).

If this patch is accepted, I will also submit a patch to 2.8 in order to get this
into scarthgap upstream.

Mailing List Discussions for Patch Submission on Master:
   - v1: https://lists.openembedded.org/g/bitbake-devel/topic/110839321
   - v2: https://lists.openembedded.org/g/bitbake-devel/topic/111289667
   - v3: https://lists.openembedded.org/g/bitbake-devel/topic/111395041
   - v4: https://lists.openembedded.org/g/bitbake-devel/topic/111424927
   - v5 (accepted): https://lists.openembedded.org/g/bitbake-devel/topic/111433461

Eric Meyers (2):
  fetch2/npm: Adding npmrc support for private registry authentication
  doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC

 .../bitbake-user-manual-ref-variables.rst         |  6 ++++++
 lib/bb/fetch2/npm.py                              | 15 +++++++++++++++
 2 files changed, 21 insertions(+)


