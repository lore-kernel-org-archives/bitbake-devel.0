Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA2E7D27F
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 19:47:28 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.779.1695757643335861338
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Sep 2023 12:47:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BztKCuVL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so9222582f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695757642; x=1696362442; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDucfvwyhdrcn2FnNTe2gAy92d7YMwSIgrdgDGr0jwg=;
        b=BztKCuVLQ4vWJ86DC29e4jCHSh7i+UR3WRzDGXr1V3BV/A4nrpfB826FqaGhVfZlk1
         sIlQK79lg8tHYlOy/aGV7/jw76YwtXlDYdfORlJ/EDbqTazlC8oySLNtr4fP4i4I45oY
         /j7/fjQYfS9jdHqWwr49UTLtITTwLllApudP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757642; x=1696362442;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDucfvwyhdrcn2FnNTe2gAy92d7YMwSIgrdgDGr0jwg=;
        b=hKL2GX3B5G34HQ7ygSmzucyGv8ts8IiwK7qhjcp3ejS0qrUtNtYrKEPRk75mDpCCLH
         Z08gjOZhyqu5ezTIifGyOkc3RJtHDGvTl2gxTZ9ok2j43dHGOVaDGhHRqEGM9TY8u+hQ
         dGkgIlrb0YR47Nwhyawg1iGow7IrYrjClOGIwVRuWNxZ936DOCxgidnYqguZxpAnJrgS
         lgw2SZC67gftT6JtweGr7UJI8q/3gxlZdYaWwz6rP8UfeuR8YOv5WuCh2osszV2fqIbX
         geCOpmKPk9hcUg0fzSS6mWKmcg0W5crTFlE31oJJxLmbw6xbY0wh944dyMcP7fd5k6G0
         vJJw==
X-Gm-Message-State: AOJu0YxsOVUBE9UBkLk/TYlQSfHI3K0VBbFz1E93VUH8f6cp4eTdVJKC
	Qnf1KrJiWHjBlO04p1/yOFEzWA==
X-Google-Smtp-Source: AGHT+IGUegS6kNedULT3J12zBdn/sRo2rbOw09GVtUDvp/lA+0ItUEcrBr1bH+B2elBUc1tlSJLpoQ==
X-Received: by 2002:a5d:698c:0:b0:321:5d9f:2d9f with SMTP id g12-20020a5d698c000000b003215d9f2d9fmr9494040wru.47.1695757641692;
        Tue, 26 Sep 2023 12:47:21 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ab67:eb18:db89:ef9a? ([2001:8b0:aba:5f3c:ab67:eb18:db89:ef9a])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d424d000000b0031f729d883asm15451831wrr.42.2023.09.26.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:47:21 -0700 (PDT)
Message-ID: <ccd86ea525ab650de8b9304cefbd8ce50fcf9636.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] runqueue: Fix task execution
 dependency issue
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Gowrishankar Saminathan <gowrishankarstg@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Sep 2023 20:47:18 +0100
In-Reply-To: <CACTJJZN_8MrG5jkFF+0xfq3wQNTSpOi4cM-5VvGVxm8XDQPAOQ@mail.gmail.com>
References: <20230924203958.35361-1-gowrishankarstg@gmail.com>
	 <9fffc17ec1ff6a4248f5d9eb8cd6a7243f93d899.camel@linuxfoundation.org>
	 <CACTJJZN_8MrG5jkFF+0xfq3wQNTSpOi4cM-5VvGVxm8XDQPAOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 19:47:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15134

On Tue, 2023-09-26 at 20:29 +0530, Gowrishankar Saminathan wrote:
> Hello Richard,
>=20
> I am facing this issue in the BitBake version tagged as yocto-3.1.27
> when I used it in Yocto of the same version.=C2=A0
> Upon reviewing the master branch, it appears to have a similar
> implementation to yocto-3.1.27 regarding this issue case.
> Consequently, I believe this issue should also apply to the master
> branch.

Whilst your patch might apply, I'm not convinced it is necessary. I'd
like you to reproduce the issue with master please as I'm not sure you
will be able to.

>=20
> It would be great if the master branch already includes this fix. If
> possible, kindly provide the commit which addresses this issue.
>=20
> Thanks for reaching me out!

There were multiple patches fixing a variety of issues. Some like this
one appear to be in dunfell (3.1).

https://git.yoctoproject.org/poky/commit/bitbake?id=3D7ea37b929153e112b8d84=
3c05fab06354aa575fc

Some like this one appear not to be:

https://git.yoctoproject.org/poky/commit/bitbake?id=3D9982b2c0f2a4bf6d451b5=
32856ca6cf126985f22

and this one too:

https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/runqueue.py?id=3D5f=
dd28e37face59410da781d5d70178565e69e5e

I'd look at the changes to runqueue.py between dunfell and master as I
do suspect this is fixed there, just not the way your patch attempts
to.

Cheers,

Richard






