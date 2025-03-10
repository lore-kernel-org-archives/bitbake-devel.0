Return-Path: <c137.marques@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B026EC282EC
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 14:02:37 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.38667.1741615350572658040
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Mar 2025 07:02:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A8gkBY9F;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: c137.marques@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2269075f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741615349; x=1742220149; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljIO/XCRVEjbB8WYloTCUC69pQR+n7YNLuZLcuehoiU=;
        b=A8gkBY9Fc2QVx0LoDyCwisUdxLt6p7fqT/jN9cOPoXnOspDSSRUGF70BQimcvAm/XV
         BHh2z8BYnQ+IlAVI7CAI4TfGj+/aDs8NN+fQ4rTJpfIoUSA4N9t8pe+m5QtNwO1ujKJ4
         6pjZIrhf5abCwrxvqtDfXq+kTW60INqlhKabkwoXekHxifQhDSAU3Km2CV5zNtesSpQ2
         GAqw5eNxt5WFXAUAntHJmAFlM/VwSasp7HXR1MFVCSnKdcaQhn5JTt7ivr2yjuMZWd8B
         +SfC40/bD4rO3S21Dwb1TVJPWjn6SGwJhpBzBZeOP5E6uceH08p9K3i6j2P1JOPGurHe
         /IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615349; x=1742220149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljIO/XCRVEjbB8WYloTCUC69pQR+n7YNLuZLcuehoiU=;
        b=Vl0rgv1SZ/PjIGnEcpsFXvINBDmLTofJNjAiRy8efU61yFzhlDKzfIcLbW4Lm8aEWZ
         dqSlM0s9Y1zDYhFTIkmdpQmPgW4y8eWb4T1KadZayWReHrq5as7bWg4j2Q0azampodUv
         j7TXF45zbcG3hbmXeQsf3CGfLRFrhlGHv7BLFkXQpB9YoiXORjK5YG7e2aF8m1LpjUT5
         t3LrMNKrRjWt5wMVHhXUYNVielBd9SigJ98BacQpcH/hAtRkKq5oS2Df+fTitAdWf4XS
         YEKaYqKCCgxXFeH93LcDAAvGTMn+5ij0OcMcVVdyspe83drZ/O1lmo4YWMvYyvKTembQ
         RhYw==
X-Gm-Message-State: AOJu0Yy00qZPQPzkRpJclP6nMtcGMO9O10N4kf6JEqcJnmmDYQhe23IG
	kuy9S4DLwBFJgBLzCT15JZJZxBCdtY4Fpbn13YuGr2ykfYs7O/WSiC/erA==
X-Gm-Gg: ASbGncuBxunqA6YWdka0U/iRE6LVV9JCAgliFqVQeDzo07Ke+44HquU6eW+cvDbBKuo
	+wQB7abh3ltyD+1flgciPgQKjuCNTNurePGYypDce/coi7cRwyfGfApWXCE8hcBHjiYNQT+6wYm
	EbT6j3DJTPQH32dBrRl6GsuzS6ZcFvRF++sEM91mBlPC31iD52JZsJUj1scUMCrZ86Z8P9fDkcU
	pCeFT1cGMbu77pmEtg8ThlKksiXNq9j4mfuydf/uCCbShJ+7/1wHr/s2RTA+3TgkQeCiSQ5+T4d
	zOsJYJGH+tiLbNnJfehghoQ/ZB2+wEcehIv6ctaDx+icYFW37HJV1xrnxjr2W+Z49FnJky6Iimb
	2fTSf05AWZVdasv7LyfEubzY=
X-Google-Smtp-Source: AGHT+IFJ20xHaGAmxaAzKeFbJ+LvNy+gBTJn/s3WBrK1lajMaBVGV36xFg7uNUT8Kq9m7xpe1uTk7Q==
X-Received: by 2002:a05:6000:188c:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-39132db782cmr8831555f8f.46.1741615346808;
        Mon, 10 Mar 2025 07:02:26 -0700 (PDT)
Received: from ctw-bre-003.bmw.criticaltechworks.com ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm15138668f8f.65.2025.03.10.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:02:26 -0700 (PDT)
From: Alexandre Marques <c137.marques@gmail.com>
X-Google-Original-From: Alexandre Marques <alexandre.marques@ctw.bmwgroup.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexandre Marques <alexandre.marques@ctw.bmwgroup.com>
Subject: [PATCH 0/1] hashserv: Add `gc-mark-stream` command for batch hash marking
Date: Mon, 10 Mar 2025 14:01:18 +0000
Message-Id: <20250310140118.2649050-1-alexandre.marques@ctw.bmwgroup.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 14:02:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17420

This comes in the sequence of [1]. And it proposes a new garbage collection
command to improve the efficiency of marking several hash equivalence database
entries.

A new poky/script using this command will also be added, so that
developers can use it and to server as a reference on how this new
command is meant to be used.

Since the hash equivalence server API is also changed, and as of now there
isn't a convenient way to check the API version or which commands are
available.

The new client command assumes a connection error to the server means
the server does not support "bulk" marking in stream mode, and falls back
to sequentially marking each input its given.

1 - https://lists.openembedded.org/g/bitbake-devel/topic/clarification_on_cleaning_up/111382632a

Alexandre Marques (1):
  hashserv: Add `gc-mark-stream` command for batch hash marking

 bin/bitbake-hashclient | 30 ++++++++++++++++++++++++++++++
 lib/hashserv/client.py | 22 ++++++++++++++++++++++
 lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++
 lib/hashserv/tests.py  | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

-- 
2.25.1


