Return-Path: <bbnpreetsingh@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A04C61DE8
	for <webhook@archiver.kernel.org>; Sun, 30 Aug 2026 21:55:18 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17229.1788126909513490898
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 30 Aug 2026 14:55:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=MC4ZsESI;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: bbnpreetsingh@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85339ed040aso2361174b3a.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 14:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788126909; x=1788731709; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92E8kCCpmBxScevPyTAihoWNS1Pd46VoxObe0h27Zfk=;
        b=MC4ZsESIYZASWkiddhn2D43yZnmuno8FQZRfmlmHuGG5cXaIqEY8s5wg0Sr69wfkbR
         2RcnnzM8QeSxCkDl3c6Z6em95HD7snEeePptevPeU0Bh5Fq8uEANZ7Iw0E/gwO5QjA/f
         6m988Q1pHRWxX7fOBGOoswOh4XdTMa/XUA8gdV9t2d4SgD12sz30E4uPMH8ckjWAqVVQ
         25DGsy6/wZSiys4Bttd7lZ2061+PMDrIMCrFdBf2ApqNye6NSGy/BJxChkPX3SNhaZFs
         c9db/DXB23wxqw4uf7P8jYCPKIrX5Dif0lZb9pA5e+NB0rH/EJHTeqmReOcs4+wg9uY4
         28HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788126909; x=1788731709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92E8kCCpmBxScevPyTAihoWNS1Pd46VoxObe0h27Zfk=;
        b=Qrq1C3JBT74ZbpnfhX78dIDggWLpVfZ9YKrk4NihdKcYr5SEDgBzGkehMW443yr07T
         3Y7djQ9GX2NX/rOQokMCt+K3WJHhFL4vgZH1DwajH2KTeMnPp0LIEC4zG8vy6lXUNSRo
         Ze+TQHiGllUAeVqpLMli/8JNDYydHvtP4DG9FhC6ahJ3WE8rGHLlhbm3eTUZmnetSz71
         ufb5R8szLeI+KtgYDi4+am/d/IDYSqMMe5JRyaWhRKQV+S51Sos+iD5DaTYQe7e0y4ms
         jC+9C+1UeqemgNCVC037SNceuTcw+8bm8ZtaqVVU4JZVpt4BCIHNSM5gnNSajyZzSUnS
         T+Ug==
X-Gm-Message-State: AFuF++lg5FdzchUxEabvLvQcvSOLZ3wxAqqQsiRKB2aI8Odq/ApIKybW
	H/UXIMb4XgzdI68pU4pyQk58YqZxvFG/aySX1WeJ6ZsKiswEOBVOh38I3u0kGPRGlxE=
X-Gm-Gg: AR+sD10YF4jDmFmJvBKRgZ9cw3JjeCGht4YJRyccZnqKXUukucKtQIN+y5AEQRJWvBR
	NAikRxAmbJLishbupCqVnvcD+JGwuWXNxGeKM/2cI8Bg39Ct7g6t9xekokRv/zAA0mohqOE0bsW
	bv57s19tj6UPeov3SuzXkhpOptDixduz9LhEfWFmeVdakLePyGL++LxuTG76DpYXOHjoxsuskeQ
	IHIcE3GFsJYoCw+v3zRqcuY727mIAAkBP/gzcsffGzpIWLwU8f7o8BuxkmqfkwymSpRTOYi+iiH
	YrTfULBMFUnu3td6kV2AQ9IaCSJdxJwsOymEb//MpNA1O7E6FOyTs6WvaTlJcEKFCmTj4sLz1Sq
	thVzy/fbEZvVyqkxNAgBvlXOLmOlMG9yjPPSpfhU1pKeZ2Ih4mZsZpAA/+cuTqPKnmp4kQYJqp5
	7JDQr0Kl8JII2l5qbxqiJa/iaY/aFdIJxB/slAEuKRw1cDonVgH8KaWxuZmRS0
X-Received: by 2002:a05:6a00:6c99:b0:857:7384:b5f8 with SMTP id d2e1a72fcca58-85aa76cfd8amr36562b3a.20.1788126908779;
        Sun, 30 Aug 2026 14:55:08 -0700 (PDT)
Received: from ydev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f341dd18sm3139375a12.14.2026.08.30.14.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 14:55:08 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: Re: [PATCH] prserv: add --status to list running servers
Date: Sun, 30 Aug 2026 21:55:06 +0000
Message-ID: <20260830215506.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824045011.7-1-bbnpreetsingh@gmail.com>
References: <20260824045011.7-1-bbnpreetsingh@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 30 Aug 2026 21:55:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20129

Hi,

A gentle ping on this one. bitbake master has moved since the send
(now 18cca50ba); I've checked the patch still applies cleanly, so no
rebase is needed. Happy to rebase and resend if that's more convenient.

Thanks,
Baban

