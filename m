Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE3E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 11:12:19 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.15952.1736507536380285197
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 03:12:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HmPD1/UC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f664af5so22432735e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736507534; x=1737112334; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RTDVnAD4nXIVwlF7HTkw2wzUaxJNZ/vq9pfyqHtN5LQ=;
        b=HmPD1/UCvw6KwLn68hMq5X+fXw2OVHG15JkMDoGqlpwcAR784DtqYoKtMrn5YO0pnt
         6R6/+AabeKmXrye8xCSDH7jmDJuyMZd5cRXIq2hrm2Qhbf6xVwJV0c41Qm86ExAsPFUh
         Lh3iMKr+FiMi2wrG4XVsWJjlcV3tKDABF8N/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736507534; x=1737112334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTDVnAD4nXIVwlF7HTkw2wzUaxJNZ/vq9pfyqHtN5LQ=;
        b=E7C2ef2O4MZC9BpxdqH7ykBOj6WMUo0ZpPs5aAaoDFyi5qPVg/5W67liXrjYJvBAsk
         T4CUDIbEqdNOp1AkVQ2HoZDneqB5PhIHb3g9FMtwjmLaGXQtQF3KoebaVOJdr2V2Xp0o
         ByPquOMMZ/zUyirAxbn7zDPuFfCCthuYISZ3x4yFmnFx3HsXqqTMRhZe2NxQjhuLk456
         Cozd5vGoOzH3wjiCfXUUXsBqLy/QUyX0zxw8bSgno5FPblGgUgCDCkifOjeyzllpkxTo
         5XeLC5GLCmXmJVHL2XjUyySbCaOBUvmKEZo+ISOw6cW6et/vGfVQTOUKj+N0oPsfcChk
         DobQ==
X-Gm-Message-State: AOJu0Yz2ngOq62VMp2AQyLY73cyDuJQU01S1GDw3zl+tXTP5dF79huLy
	JKRlVWGPPl7SfuLlzwZmKr8eSSzcIOYKwzMjK7I8AC0B7KSkP1fqQYNKx0feqPs=
X-Gm-Gg: ASbGncuZBu4gH++beu9Hu/R3WW08mxPsqD7xd9VP2lA21bp02eFpB3+LhbQwzgRv+/D
	qFl1FGrfIHsgOFmubDtgSvOLJX8XE6JLzmAeUXNl3AwadiuaLbOTKvWOuaNh4OEhXrX4ZYH3otj
	BJz9OBoE/Lm909rpe/ivVIvN9NetiFGx/7XGRSdMLuPrDdxpMNmx/heFkzQUtq/rOqCXhYSPiDn
	43C7WkRQz1iw+Q6RFCmD2pSE3oY8qZ//D6RGoZ5eW0oH7j0VDUOwOZ0V2TWM9nsB3DBT5FQGkao
	6jHe/J0bsS76opbB0J/spPaWQXb4mRNbCfFJ/mJrn81lcQ==
X-Google-Smtp-Source: AGHT+IFD3qbuQiU5rRydEvLRdacdr+JqcDeqnFNVaGAduUToxbofhhOlpdw3AEzOZ8rNn/eDAiSblw==
X-Received: by 2002:a05:600c:3ca4:b0:436:6460:e680 with SMTP id 5b1f17b1804b1-436e26c3331mr46314195e9.16.1736507534388;
        Fri, 10 Jan 2025 03:12:14 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d75e:67c5:40ee:6f3d? ([2001:8b0:aba:5f3c:d75e:67c5:40ee:6f3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d2dfsm4202989f8f.7.2025.01.10.03.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:12:13 -0800 (PST)
Message-ID: <c233d33d369b43a4158e544f88c3d6040537ac5e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] git-make-shallow: use stdin mode
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Nick Owens <nick.owens@eero.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jan 2025 11:12:12 +0000
In-Reply-To: <CAFQxptVVpB5ASUqo=ZJHhqEmtHwpv7yDMGCAjrem0RyzrmOaRw@mail.gmail.com>
References: <20250105021848.3048010-1-nick.owens@eero.com>
	 <d666c407c0ab5a16733869b03acd15e18bcdbfe2.camel@linuxfoundation.org>
	 <CAFQxptVVpB5ASUqo=ZJHhqEmtHwpv7yDMGCAjrem0RyzrmOaRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 11:12:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17003

On Thu, 2025-01-09 at 10:55 -0800, Nick Owens wrote:
> right. i think this is because the transaction model was only
> introduced in git 2.27 whereas ubuntu focal (20.04) only has 2.25.
> and, i think i bungled the use of the transaction commands by not
> issuing 'start'. i think dropping commit should resolve it.
>=20
> diff --git a/bitbake/bin/git-make-shallow b/bitbake/bin/git-make-
> shallow
> index d0532c5ab8..bead94a766 100755
> --- a/bitbake/bin/git-make-shallow
> +++ b/bitbake/bin/git-make-shallow
> @@ -113,8 +113,8 @@ def filter_refs(refs):
> =C2=A0 =C2=A0 =C2=A0all_refs =3D get_all_refs()
> =C2=A0 =C2=A0 =C2=A0to_remove =3D set(all_refs) - set(refs)
> =C2=A0 =C2=A0 =C2=A0if to_remove:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0check_output(['xargs', '-0', '-n', '1', 'git=
', 'update-ref',
> '-d', '--no-deref'],
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nput=3D''.join(l + '\0' for l in to_remove))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0check_output(['git', 'update-ref', '--no-der=
ef', '--stdin',
> '-z'],
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
nput=3D''.join('delete ' + l + '\0\0' for l in
> to_remove))
> =C2=A0
> =C2=A0
> =C2=A0def follow_history_intersections(revisions, refs):

Thanks for the hint, I've turned this into a patch, sent and then
merged it since this was breaking builds and there are enough other
issues atm to worry about so I wanted to get it resolved! :)

I did test it on the failing 20.04 worker and it works there now.

Cheers,

Richard

