Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F76CAC5AA
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:07:30 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.52896.1758550047810803639
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 07:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=asIxP8gm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ece1102998so2777180f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758550046; x=1759154846; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khnOU8k0G14YuPTU9nbl2qcjl6euyAHmXouZXOBoy0c=;
        b=asIxP8gmG+AOupSJdPxjpwoBTb4+thJ9i/oRekRSX4R1566u9xnW/sPCqOeV9r0fbd
         /35ObgxTEQuXrFsAH+6lEdLAdxF6mVgHcYzJxfLbWwpaIdSaBnd8CoMQ6bDXr/GzWz6+
         XzzB0pIGoo7dyhZzRZvT2STIcr2+2SRYoNGiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550046; x=1759154846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khnOU8k0G14YuPTU9nbl2qcjl6euyAHmXouZXOBoy0c=;
        b=EiMRROs8mrYziY53i12KJzPVH8sWHzuKPI4QSFhTgMjeWGxdwWe1BwlhXhnYgXnX0L
         7oNVOp0MJjINdXypJePGlN4GG96OjiHbwlI+1hlIz1/ZF1FmwtCur3FZmKqEI0zQkfvO
         piNd/Oyx1MT4cGp3A5I2N2HXYSgmATjRmAT0dVDQLNVSKY7YXojQcaA8/Qb7cu45VccR
         qQ1umWR+mxiphR3n4E1BxkLCWH6Bga1kPNyNY6PG+8B0Fux/1oatpJ4sFybAUMJyonOu
         kVP7btXyLe5e4roL/14RUdtSzmsjRj0VDQmvoEnxBx+3u3S7EC6WmarjYTqEWCp3uVCM
         153w==
X-Gm-Message-State: AOJu0YzNBRQPk/2kzLKOsY17CvvJK1SXakzylZUa+ecYrJe3LC31bn8k
	jQMnxBU08ln+iLYC/506zgjXTzmrX4fHpLyPGMyML8HtxoTUILvJ7Z5Y2mtIzk9eiYHpQB81TUp
	FEYNZ
X-Gm-Gg: ASbGncsw3Yjxbbmk1FDpaKue+k9GKb9GrkRoPj0a57utIpusFWRxoOuBPCkHKMinLvy
	3oMiNnIX/6lrWprP+2NOQRmvYr0+wqToJ65ZlIiboXoUIlQ3/ZHkuoTTkUYL6EwlmjRyFD+xwGQ
	Ahpcqe5lNlaeQ4fM0CnayFsf752dhBX/st41V7hRvzizdZ0bEhnaRdkNT8/VflV/PmDU/GjPCYh
	75VRSFaU90G3WBe8NkEeQ3VnRfpMAOod1RJSHeQIR2z1ZZXAbblqHjpNHmoME7xCKWSnGqRaJTI
	k1mieebbTTNzyLCT+vPX18h6SggE7ZbFmeD/tvB1ZauYRFc785m5rdzDGe4ZcN0SVch65mpKCYL
	4GPXdFf2slcvAPSlqVRr78cNd5x8U2Taa9V+ZlbYtAMUfypItOss=
X-Google-Smtp-Source: AGHT+IHbAO6yCgfifkLC3mce6fapJEvji2SQjczEUZynZP57vI/y7x6IfNHm1CQfAbL6t5elhGDrlA==
X-Received: by 2002:a05:6000:2681:b0:400:1bbb:d257 with SMTP id ffacd0b85a97d-4001bbbd440mr2250179f8f.26.1758550045778;
        Mon, 22 Sep 2025 07:07:25 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2639:6647:8a82:45d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7107sm20939516f8f.30.2025.09.22.07.07.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:07:24 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/3] bitbake-setup: Switch to internal default registry files
Date: Mon, 22 Sep 2025 15:07:21 +0100
Message-ID: <20250922140721.2266610-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
References: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 14:07:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18072

Switch the url to be the default internal registry rather than a private
repo which was intended for testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b07bf2eb7c8..7067cbd4fc9 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -19,7 +19,7 @@ import datetime
 import glob
 import subprocess
 
-default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
+default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
 bindir = os.path.abspath(os.path.dirname(__file__))
 sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]

