Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456AAC02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 14:19:39 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.11611.1737123569555113064
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 06:19:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OqKmhB93;
 spf=pass (domain: gmail.com, ip: 209.85.222.176, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f0afda3fso210914285a.2;
        Fri, 17 Jan 2025 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737123568; x=1737728368; darn=lists.openembedded.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IhWgXmM7V5v7/kH2MWAooS0yRl5eEw5syxDwHhzu9TU=;
        b=OqKmhB934njjw4s0I+ZofKcTkZ70AXMuhygmy30sWhisJYV5B7Z6mZqRfItWjPoGth
         TBrCVOHRltYvSaPVcKN3+SryorYfysC1b4V4wjiESHwpuuuSnlffwQD/z7UFllq3vgQR
         EVd4h4ksJmzwk1I238Gw24DfqDNGHX7oja/ScBGJTSSlZtmZ2XwgsVGyXRXyjSdUR878
         1mNzWfBOXxwddopYKtR/udj5oLV8+9X9148RDOBaY25Zcsc876P8T9xSG4/ZvR2Di4su
         ftL3UoxXjm3+r9Fu7PIJwf8ub2tHO+VMkU7LgX4g1QKBMOZh3QJBY5fUrfmZFB/Gv5oq
         GDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123568; x=1737728368;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IhWgXmM7V5v7/kH2MWAooS0yRl5eEw5syxDwHhzu9TU=;
        b=GoxpQmtziQn4DoChfNj+wu/p6GTuz1jbsT5SRVIBMbnprRcmjznDmbEjib6fyGxsNm
         V4hWhNVlb0FExK3y3yebfiBploTaiGvbZImLGOH80kTgdM+AtZZdq4kcmeycBBefV85r
         qq/HkDEIf4lGHFTXAoZvhq1fZjDdJA5ALTI7i3ywJrwvEgwl5Ysq+P4e8r8heLJot6zL
         xmPa9xdOJ5PVNEDutamxLZcBjWlAyzhBh9dHBbEs6PVFpg/Kghag7IxmAXLhq164YMPA
         9ut6D5sIpeOC2bTT4uoP4UdmAJdoq40uBQIBxPR6YOf1GjRjAaNuLFkRDg1s5qeWFYRB
         JlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJNFwQUqIEEZiE32Qn87PsngAeSYl0RfDGtjZ2VqLQ4m/4jbFQsZwwnZmdWEfyu5WI8ktuQchRV6ku8SurYtSETCnNNbPHqhwp@lists.openembedded.org
X-Gm-Message-State: AOJu0YwWfGKWMJmmLxmOszLMetM9LkfusEF6PqV+DkZqmvLn6KEm+afC
	fwX8QGrthvo1EjS7xgC163T1TV07yvDCZ/vRBrM8ucnnLBxd7GptIyjghPc2e/+VGqzcSJ8D2n8
	Dpwy2fqzqgrtBx7r3W24HStGaMv29ZKLz
X-Gm-Gg: ASbGnct5/+S68MXtM2xXEgmACHQuzIVcyrpkqhfHMtY20azNhIjQ4ch5UqO0hIhJaXo
	cvYpR6oTgglJcwnRcT52KYSmPU25WFOq41/y5niCHuX35ZDuGBqQkcwb3BjhPnBrnD8gDWfh5
X-Google-Smtp-Source: AGHT+IESdxwIewHFNkKzmBCfx/Wh8KKqGUzP4bylR+A/5ZLeuUqlPkt2FfvtZ+d8uvTzNklTwFj9X/3cQsnHmqM254o=
X-Received: by 2002:a05:6214:5404:b0:6d8:a754:9647 with SMTP id
 6a1803df08f44-6e1b217d4a4mr50054996d6.17.1737123568647; Fri, 17 Jan 2025
 06:19:28 -0800 (PST)
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 17 Jan 2025 15:19:17 +0100
X-Gm-Features: AbW1kvaSA5pjlvLXeJ8L0frKEORhx0hpc1t4e_OAThQFkdOVBhfgFH_lrQSiWUQ
Message-ID: <CANNYZj9KBw9-1sB86f_xqeYuE3rLpT1Dt2sDYbjjNC==EdBJeg@mail.gmail.com>
Subject: bitbake-setup, where we're at?
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Yocto-mailing-list <yocto@lists.yoctoproject.org>, 
	openembedded-architecture <openembedded-architecture@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 14:19:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17035

Hello all,

I've posted the latest iteration of the RFC bitbake-setup prototype;
the major change in this one is that it is now testable with
bitbake-selftest:

https://patchwork.yoctoproject.org/project/bitbake/list/?series=30849

I'd even say it's no longer a proof of concept, and is, in theory,
suitable for production work. If the subject of reproducible,
end-to-end yocto build setups (with a single command, against a single
config file) is interesting to you, then get it and play with it.

Now is the time where we can still easily make breaking revisions to
it; once bitbake-setup lands in master and starts gaining users,
making any changes becomes much, much harder. Implementing things from
intuition, experience, and personal preferences is okay; getting real
feedback is much better.

Thanks,
Alex

