Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B116EE9A75C
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 10:02:15 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16358.1774346527402699230
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Mar 2026 03:02:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=rYocsO7e;
 spf=pass (domain: gmail.com, ip: 209.85.222.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-950b801b75fso1325527241.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 03:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774346526; cv=none;
        d=google.com; s=arc-20240605;
        b=bH+EMU46V6hFBnAB2jKnEIiVTC2EsO2lWXdRDnczrKo2OocKbU0/zA4zXFv36sAyDh
         wpyIVUy8parl7d8raLznYqQ6ggT/bH7Xz9eyckmASSGpG/w3aU3JEyX/9xO2e1q4fsIV
         a0BgtLAgU903QVkwDlwG+Lvkp+oTDVDZCTk6PXFvKfXKzWJF2EAvgnM/fn234XGVntTc
         /YUSIYBOG1jJVeJzCfoirEA8mK5h6P8oLGgwT6Fp3N5LCCWLUtWy8bM0EdNN3Xa2eyGf
         J2o2RU2HhL6+G1Ing+ePY42qmSLnPjnoznyhlTP1gNcfKAD9p77mK0uCOPcYStAzihOA
         CRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sNkayc5WW9LUUjaUCuR7LDJXlN3Ig1oC8H38Os5z1BY=;
        fh=QpFsERMIO2vEQ8DmeUbvV18kFt0Ljkq4lnm01aFduCg=;
        b=Pj33m8rpkGj/EOE+D/LIAAuwgkA4og7Z6h35rO2C3CggyFZdbVNPy+b3L+HLcjUHgZ
         TjwFR2sCtGjwu1I2NUrhWu7s4JtSiVMI2/wQX54NdZqORTAfWnoCCLB39Qzf6gsktPOU
         MW+ZE8CLeG7slIcBfVgsifzCkXph6DUefDR0aTrBvFNPHL78jiieaS9RoXXV6zX/c9rf
         mzrSAbWzWPL010NsN4EJo/U6s6yWel3W+wKTUvAkJkaEuMFxE806JzJ7jyt4nUNHFUmB
         BDR9zco3o6DkQiZMxDFt+AkbQQVi6nqbG7P2V0IcvUWmARMVRffJ8ACv1puBvEd7CC8y
         sLYw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774346526; x=1774951326; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNkayc5WW9LUUjaUCuR7LDJXlN3Ig1oC8H38Os5z1BY=;
        b=rYocsO7efNM7BX4JFUv7Bytw9fvuKfos9G3ObzewGy6BEbeW2+FdWKzFpBwQX+MUp3
         SwXw/49f6I6TY7eCqtgTMJdyQoEHz9mdf2wy3VE4a+86S4ugs/nAEhTu4FyagVt4jhxz
         JwaiRalk9IyXEoSSZKICgM8dEgCha81/CeDU1kKx/kkZF8l19XtKeu4A5nMqyaEhJBei
         PVcSZk8npuxhYSmyVBKIGvuCKSfTj16+h+mGmxBYar9AzpBqrW0XzMFMEFJ5W1rwV95q
         QYV+ensjbdsY4CTg4KrdpKxT2oe2aTLzo6qX548ppVBXlN75FsTxliVXHz6F4GKy/nZi
         00DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774346526; x=1774951326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNkayc5WW9LUUjaUCuR7LDJXlN3Ig1oC8H38Os5z1BY=;
        b=VO50dAKx8UynbfG/zqj1JYlK6snKJRw+HPERY0U6Z+U6GMt2M3k4JP8Uhg3RnkZpsz
         25UIVU6HHButFCilg0nijPR5drp7yyDNkHV9F7Kxztg7+GmcJr/Z7PmFc7YdDbOPliWY
         bS7/ZEzLwuDdgiyqEa2CsPPnQjRZtG9aDdhF0uJLPQqtpLRehMLA7433Z5FyyJG1xqVZ
         ONIdEn9SrbsvEA/xyZ+o3HeIOHlKpgXEsxrynFZ0fgvBcrEFNvHGvTbxcBZAKyNDw0ah
         QwD22Yt6gUbeLrw9sYlwKpDFwYhAhp2Z5JYMW59cxMhqhPyELhcVTMtGmhcg7uYfvNxZ
         YE7Q==
X-Gm-Message-State: AOJu0YwjIOCGUTuq+WMrMzaFMNKRZuJxnN5Otp4burEO0PCAV1yVs1sV
	fKgVyMgmdSu0oJHx4S6H68yrcF268gKJF7gfOiV+JYlrcE/riEGyIjZ2/hTCV8QGcFL7mUsyTVj
	DcUtK1VQB0t/J+0mTetrq3CJChGRf8z4=
X-Gm-Gg: ATEYQzwVWcKniclEhGGaDE+HUIwzGXRq60HutKa4NF9aQGa8/ZpnVb9oCxPB/AeLDHF
	NjpBe/U8I5vFKj+hyowEak8BeW7P6mgX/45cHbAHHx+FopdYtPAFKctOf/itGuhg4vkdnasLsFl
	Pn0VpbgvmqS6mkhQ07+uJv+DKo+1Myf/hAGXb36X0WOiKvy6aqj3fIpSXhfVQp48E7CHTAlsWRu
	xlh2hkGtbSkyt01iYXsZtDE0FS4kiYJjflHzYtMqIvQwLuxUvJWCwIf+gF6RBbDobQ29CmAEr/8
	2RDZgn/QtrD0SVkV2/mUYpnjUX6sbR+5JfSWMUTS/Q==
X-Received: by 2002:a05:6102:3f92:b0:5ff:efdc:e225 with SMTP id
 ada2fe7eead31-602aea9296fmr6699467137.3.1774346526414; Tue, 24 Mar 2026
 03:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260320094407.4169544-1-zhangfei.gao@linaro.org> <CABQgh9E7kLETKA8obFb5uAYGSy4T9LhYqpzNKUxBEpbEL+o5QQ@mail.gmail.com>
In-Reply-To: <CABQgh9E7kLETKA8obFb5uAYGSy4T9LhYqpzNKUxBEpbEL+o5QQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 24 Mar 2026 11:01:55 +0100
X-Gm-Features: AQROBzCqZ8G6DEvmE2gLSG09aDt9EpWbDIoNR-faL0Hbg3yDOrkP74IC2g-qffI
Message-ID: <CANNYZj_ToWTnueF4yLWbmLNw-uBC7g72L8UkhMJ_x0AtZcWKiw@mail.gmail.com>
Subject: Re: [PATCH] bitbake-setup: make DL_DIR in site.conf overridable by env
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Christopher Obbard <christopher.obbard@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Mar 2026 10:02:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19215

On Tue, 24 Mar 2026 at 10:51, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Would you mind take a look.

This patch is okay. We didn't get to it yet in reviews. Contributors
are notified only when something is unclear or needs to be changed,
otherwise the process is entirely silent.

Alex

