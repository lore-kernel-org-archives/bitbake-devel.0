Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A2C021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 15:06:51 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.7882.1740582403371705633
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 07:06:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=N0TwfieJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43994ef3872so43397255e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 07:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740582402; x=1741187202; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1c0rTSY2aj0xMNUd7KK65o6sXKpcNCd5+EwHfyEFKD0=;
        b=N0TwfieJMAfx9awix5nBi2XjfptmRvc4egrM6jUYvaFMEWuTmZbg1yULizi5SiLMrq
         nSlQfvVFVXEQGJFOa0+xevJwz6pM1H3E0KjfJuN+rh7XsFZIk8p7xESmL+WnWMnQ1pmY
         tTXrjFzhvvFwD/59XUMjLSwHnQ8aZPOpvYzHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582402; x=1741187202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1c0rTSY2aj0xMNUd7KK65o6sXKpcNCd5+EwHfyEFKD0=;
        b=TptBhyA5eUBZRjwjgYtMEoIkHu1g3Rx2m5d8LlN/ihe6buRXF8T9l1pC+FwQ3RAPxF
         i3IaX0H5q/GQzbcvgd05xIFKts18w4/2KM7dV9MBDhxhEEKcCdsZHwUnQJ7oDEix8GIH
         yT1tPjAwa1jpUag1lJUBjXx6TYVdoMPcz8fJhtIuYlK+ZuSMd3WRmHZxBGXLu3PhG5cr
         kgYw2iMNCl4KUe6Aips7SBU2y6sBhoHzjZC0LPYFE2hR9Ks5I44Jdp/C3HlWkD0XjLxS
         ookWWFlrw09hhvUIGrJKkV4pksye5ot201mXGNND+XNFENFrAX+6Xrb+Aju8BE/z8ieJ
         O4Og==
X-Gm-Message-State: AOJu0YztxgGIYvbRXyT5m+GwK2QEBgK6e/b+MtLlNkQ+9jrQ9p2ujlnv
	o0zqkMOL8ayffOpFBPlG8YeyyWDgi9joG6gxtyaTilJz0VLnyuGvzPDr0xoXp9YTjDutxH91Wr8
	w
X-Gm-Gg: ASbGncu3F+tT+ly6aK6xURrGEBcl701jBfbw/MXCPCEkcdsD1VgM9epMUTpbGLPlMRd
	v9Dlyz1FCNoIVy6jS26UUmRAMbM3FNHQXlQoYxjbFgjbh/qD+3LIGYFBy0q+9xx1RiMO6LRFdLY
	NRVoyDMQevREhv9xL0DJMyFK1vL9LWKd8OSAzPmB08rZa3OG/Pu5bsVPuvWNB8myV8Dkog1cSxK
	eKQHqIjQDtbowRznh1HXaBtMSM5bfOlAD/TDpKJHkCc8d+roxABdAwtnJWULSYaBZpKs3cJmOn1
	UIp35rFiJhBYtOuNBZsiHjNrK3zGViKx6dPZqW1YxtpMM8rE3SV769AoiOA5BkAlfn6w4mNC3RK
	P7zCn1HmPwNwA8fs=
X-Google-Smtp-Source: AGHT+IFij5ohX5DDmZy01voRk6HvQncoYthqETJ3ECNMR1aORhMeN2jxQw5gUQuzCRRpirxsmESxVQ==
X-Received: by 2002:a05:600c:5124:b0:439:89e9:4eff with SMTP id 5b1f17b1804b1-43ab0f30d66mr75359155e9.10.1740582401171;
        Wed, 26 Feb 2025 07:06:41 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:5bde:6c25:9c05:f012? ([2001:8b0:aba:5f3c:5bde:6c25:9c05:f012])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b9d1sm25151995e9.8.2025.02.26.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:06:40 -0800 (PST)
Message-ID: <e9c8adcbe4d8f324755df1107eac6a3bc7f7bcaf.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/cooker.py: make
 BB_HASHSERVE_UPSTREAM issues fatal, write specific error messages
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Alexander Kanavin
 <alex@linutronix.de>
Date: Wed, 26 Feb 2025 15:06:39 +0000
In-Reply-To: <CANNYZj-CJyEwaVQtowyo7ynk=mP1D6461NZACS73wcx9xKX4cQ@mail.gmail.com>
References: <20250225120947.172025-1-alex.kanavin@gmail.com>
	 <b4e76037f4fff35822a2f80888587fe6cb124953.camel@linuxfoundation.org>
	 <CANNYZj-CJyEwaVQtowyo7ynk=mP1D6461NZACS73wcx9xKX4cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Feb 2025 15:06:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17330

On Tue, 2025-02-25 at 16:51 +0100, Alexander Kanavin wrote:
> On Tue, 25 Feb 2025 at 14:46, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > I agree we should split the messages and I'm ok with making ImportError
> > fatal but I'm not sure we should change ConnectionError as it means a
> > single connection failure to an overloaded server will abort the build.
> > We've seen this problem before which is why it is a warning.
>=20
> Sure, I can tweak this.
>=20
> > We can't really reference oe-core from bitbake unfortunately either.
> > We'd probably need to link to docs at that point.
>=20
> Here I'm not sure how to rephrase. We can't mention oe-core at all? Or
> is it okay to say smth like
>=20
> "Install the missing module on the build host. If you are using
> bitbake with oe-core, you can also use buildtools" etc.
>=20
> If you can give me a canned error message that I can copy paste,
> that'd be best :D

How about:

"""
Unable to use hash equivalence server at '%s' due to missing or
incorrect python module: %s.=C2=A0

Please install the needed module on the build host, or use an
environment containing it (e.g a pip venv or OE's buildtools tarball)
or disable the BB_HASHSERVE_UPSTREAM setting.
"""


Cheers,

Richard

