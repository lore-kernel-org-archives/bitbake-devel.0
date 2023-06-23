Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CADEB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 09:21:54 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.38161.1687512107979757819
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jun 2023 02:21:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=LKRPcREE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3112902f785so1542411f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jun 2023 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687512106; x=1690104106;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DmN7LODmiHOCRvW9SJZjXcQrGIxxca5K0IWPYm5eMoo=;
        b=LKRPcREEBmNhFRgc5SP9M/CuyVQQSD42nMDCPMLQtye+W2rVf/cesXu7iICbAbs/iJ
         uR1A3Mp3Yf/gN52yiWr9fRCbiVphzP9A3IHtGC1Jq1nRizpU+EpTXZaiLmShq6TQe1gw
         iHZWpWZcQ8jyNpD9Kmi6Zcmf3AoLaehc1+BY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687512106; x=1690104106;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmN7LODmiHOCRvW9SJZjXcQrGIxxca5K0IWPYm5eMoo=;
        b=Xv12vL7JfX5n9xOOc5wpnySP3VX7jepDrGKFeKplPwYtILUBv6CgBDT+fE00mF/35D
         btoExfJmI0r7aWp2dSEKjc+BoxAAjBgIWi6mwoBSDHxMSJrEQbUomRbKATX4y00tcspg
         xhtA7SwUcEfZrBzMcfcUbRLyWJj2ZR7yYe2VtWJL9yfqI5kCEf5bSJ7v9dJezSdjFGcp
         yUultR7P+l6dlS4L/9jOl5bY1SICjbYPcUiFdOPRzT6q21C5u/FzYa8ye37CYZSVxgFD
         W2w71sdxdk5sLWdALS3GSwNdoLeBwUMtpFvIl3CvfxlNkLCigHXfdO3JhzJII2XF1IAY
         UKcg==
X-Gm-Message-State: AC+VfDzzoUtHvEGX6gAjNEE4C6408uBQTwgL5uZkLgv14HUvmrBlIhLF
	oSM74qSOOu6qPNYecWUypMfLxQ==
X-Google-Smtp-Source: ACHHUZ5isQn7bTXBUXrfk3DJyQO3pEEkp8sr6cG3D0OR0yI8gS5zmnWJoG/pxnv97noQLjRsjoJelw==
X-Received: by 2002:a05:6000:923:b0:312:7d4d:f1c0 with SMTP id cx3-20020a056000092300b003127d4df1c0mr9611218wrb.32.1687512106294;
        Fri, 23 Jun 2023 02:21:46 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:aeb7:8756:e8c1:1c97? ([2001:8b0:aba:5f3c:aeb7:8756:e8c1:1c97])
        by smtp.gmail.com with ESMTPSA id p7-20020a056000018700b003095bd71159sm9095337wrx.7.2023.06.23.02.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 02:21:45 -0700 (PDT)
Message-ID: <9ff2cb26e2d63ba10255d665d44524ea7181f2d9.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Support packaging
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Wu Zhenyu <wuzhenyu@ustc.edu>, bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Date: Fri, 23 Jun 2023 10:21:45 +0100
In-Reply-To: <z5kafm2tlrwgx3fe7ayv4gf46yr2hn27kw77uj4cmdc4z4nrmz@et7mvmr7e4qs>
References: 
	<gu3erz2kuwv6e4nijjwavi2pci2ohlfcoaornwyicfsufgii7p@wsazr62z42tf>
	 <243f996ab30e88244b73c0d6eb6c7d00e7766ac5.camel@linuxfoundation.org>
	 <z5kafm2tlrwgx3fe7ayv4gf46yr2hn27kw77uj4cmdc4z4nrmz@et7mvmr7e4qs>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jun 2023 09:21:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14857

On Fri, 2023-06-23 at 17:13 +0800, Wu Zhenyu wrote:
> Hi, I create a language server for bitbake in <https://github.com/Freed-W=
u/bitbake-language-server>.
> It really need bitbake as a python package to provide the full functions.
> Now I have to use <https://aur.archlinux.org/packages/python-bitbake> as =
a dependency.
> Can you rethink again about packaging it in PYPI?

A language server sounds really interesting and I'll have to take a
look. If we add it to PYPI, who is going to deal with the usability
issues I mentioned, the documentation problem and the resulting support
where people mismatch bitbake versions?

There are some specific issues we'd need to solve if we were to put
bitbake on PYPI and I'm not seeing any help or solutions being offered
to that :(. I'm burning out with the project as things stand, I don't
really want to create new issues.

Cheers,

Richard



