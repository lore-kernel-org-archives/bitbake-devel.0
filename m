Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B5C9830E
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 16:11:16 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1521.1790179866672073337
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 09:11:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WD3ogrvK;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.141, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso7812685e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790179865; x=1790784665; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WmaeTOaK+85TyCVB8527ubTpv/qUY7QOHSurAMdlfOg=;
        b=WD3ogrvKJrOwscXedLicPfAwjbkBF2om+GuLngXY80ySEz5fPpH5aW9F6/DX5ag4td
         9tiLol5Oepgn9jYxltYlz3lGL5yeGKzEI+m9RIMdwWuNZc0piQHmJLnt0Z+5UdSI1UWk
         IQzGl2qLX7pmlMjhjWYoYE78KaFlMW20LPDzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179865; x=1790784665;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmaeTOaK+85TyCVB8527ubTpv/qUY7QOHSurAMdlfOg=;
        b=F61OzGfgpIoxkbdIMdgWcEXEW59M8mBewCLFRu3Dye7E286dbVwnhA1MiRVYjdpB6L
         vLSm1IRpH5ynpx4hIZnjBqAUuZbUVA4AZqcHjwrN7JNGxqsJWNbpPh6tdnNdVgd1rA4C
         nhbHoqpxKEzWuJgYOhL6F7yc2J8B9Rjr01hd8OEb6u8XFUmD8iFqGO2Jh76XqKEiWEXT
         9P18EZ1HROuq9VYrxhhPyFcpYshIHsRNp8dIUuVpqcjvLoej3UWa/i8wCf7t2tQtU6sO
         f4yH5h+m3892+XIa49E37xjOANsc8wqzJElsLmO0MQbVimPNIauGe/VJ2dePqlU9w1tF
         askw==
X-Forwarded-Encrypted: i=1; AKwUvBxoTz4C5LvjnkuKIZLvfWlU+uXDXp1e41Pp9HhDkqg3k37inxTv2/nNZvMDyKIE5JDLF3YEgkuvuxrKNs54@lists.openembedded.org
X-Gm-Message-State: AFuF++k0Ad9kJ5g7Fm8I19pQAoPUq18qSqtQ+7eUkaEFSjBCR1dGT4un
	vLkysfq/tZx/eUwn7MlYDYhBYtIqAU7YkEZiUA8ATdVSFKe/aPlFsh67Xbxrq8NlnJs=
X-Gm-Gg: AYBFou19RBiCO1aVlwgA7640Xla0VnipFKlJWM/BR0RByvZJ243wc3uJStu9XMAXVvg
	9WUu0h1H1z9/eR0j8abSjFjazsPUXJ1IkFTebxjBwdnKVmlnXJP99WxBRKVnnn66AFEFtrlSlW2
	1uJlB+EMVqon4Sq1iXW1BQNlz9XOrtKfsjn5gBDsVDUX61AgpnJu0KuFCn7ENZoQKkkArICNXgu
	tJnEC2UVZuRoZIg1/HuPbeSCII7J5ikWYEE0F9xGP3Gt1Ic53p/afaUu/Er9svkdXJcdNVxYqSA
	M0nuucqeu3hQ+yqBqNccFpDGBDk1bQUiOgySD7vJqxDi2bGAadAOtfCjAkKNLRS/yIFnElu5y5B
	KpTmwFOg215prpWnbc2VvgL/xjIfgh89kQ57m1Jt6u6wJSyzMOVQttQO6tJTavJmJ5hn1MEaVIA
	TYoUCII3SXLSUe3UtQhe/qXnrq9/e1fNOaj2qgVTcJWsRTpnH8sjmaGfnlm/D3cIN3ft9eR+MM1
	y8RwkQUh03DfU59eTvi+85pcgS518dv+BesqvmFEDd4s2mx3XUTyvOoiGRXl0A=
X-Received: by 2002:a05:600c:4f16:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49fe5946e2cmr2594715e9.7.1790179864828;
        Wed, 23 Sep 2026 09:11:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:36fd:f492:2703:247a? ([2001:8b0:aba:5f3c:36fd:f492:2703:247a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889337sm8153856f8f.34.2026.09.23.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:11:04 -0700 (PDT)
Message-ID: <a93729d70f21488844f69b17d34eb6b57faef7d6.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH v3 0/5] bitbake: Add basic landlock support
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: david.nystrom@est.tech, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, bruce.ashfield@gmail.com, 
	mattias.jernberg@axis.com, peter.kjellerstedt@axis.com
Date: Wed, 23 Sep 2026 17:11:03 +0100
In-Reply-To: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
References: <20260914-landlock_try2-v3-0-4ea504789675@est.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 16:11:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20244

On Mon, 2026-09-14 at 20:42 +0200, David Nystr=C3=B6m via lists.yoctoprojec=
t.org wrote:
> When current implementation runs in an unprivileged docker container,
> basic networking will be allowed by default in all steps, ignoring the
> network varflags intention.
> Introduce support for landlock blocking of bind and connect, providing
> basic support for blocking TCP.
> UDP is corrently beeing worked on upstream, but not yet supported.
>=20
> Landlock requires PR_SET_NO_NEW_PRIVS for unpriv usage,=20
> which is also attempted. devshell and related are already tagged=20
> with network varflag and can sudo at will.
>=20
> This changes the default task behaviour to set no_new_privs, and=20
> the 'network' varflag to exclude no_new_privs, which is needed
> in a few places, like do_testimage.
>=20
> syscall ABI is asm-generic, 6.7+ for all archs except alpha.
> On alpha, we leak 2 fd:s in the childs context before graceful exit,
> which is cleaned up at child termination.
> x32, MIPS(except LoongSoon) will fail gracefully.
> Don't have an alpha target, so this is not tested, evaluated via=20
> static analysis only.
>=20
> Adding Bruce to CC, due to fusermount usage in vrunner.
> There might be fallout in other sublayers as well,=20
> give me a CC and I'll try to help out.
>=20
> Adding Peter and Mattias for awareness, since they seem to be=20
> users of enable_loopback_networking

We discussed this in the review call and decided to take the first
patches but not to add in the varflag. We'll see if anyone reports
issues with that and keep the option of the varflag in mind if anyone
does. We suspect most can probably just use the network flag and
keeping the code simpler is always preferred if we can.

Thanks again for the patches.

Cheers,

Richard

