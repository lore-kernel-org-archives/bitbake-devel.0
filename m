Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C858CF9C6F
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 07:49:41 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.31301.1727077776447436854
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 00:49:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZO08GXsy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-378f600e090so2247110f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 00:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727077775; x=1727682575; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E625K1C8OVFx0TwxEpKExrqKwMSjhljoEELEutxSXwo=;
        b=ZO08GXsyU7EP8IDfRhnETZPFe+jIfCpVe8srBk6dyEkglzTUZpLVoFYtFGc6RjH2rb
         rIgD955GtXxhGqOpt+OqiTm4XCRlIpKBqsl27NjDStA9YJKwJMOcU4IMKX0lCW4O/lZc
         wYc847S7KSJXMzbpc4fOra6YfnMH5JycCVTr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727077775; x=1727682575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E625K1C8OVFx0TwxEpKExrqKwMSjhljoEELEutxSXwo=;
        b=uEsMjddG4RvawC9j2s7eLCzhsuXu69qc8t1EjexG4FOgS3t/+zuV2+hxuVVKZ+aO9g
         Rez9FpvI32E4fAgH+v5TaXdvwk2gN7GkWbikzhmMn66G5GtPeYV+GPAhLd6o7O08zjNf
         /CDs5e7dGCZbtb3kf7mHCruprhCWEtFh1Gyk2os8Mzx5qqU4ncRlcI+rMek6MJUTTWo+
         FutqKhhAcDvlvkii7sTY5dHfTwTjOvC6VgrGz1yRuwMHlUwt/pYbae5LPVEkk+rWE4kZ
         KfuQ9h4h8NypWBsxdoryunMZkAwBkg7CxPtfduGLjvvR/dIhFjTyjscHkkp1hfSyYiiu
         iu/Q==
X-Gm-Message-State: AOJu0Yx29qMm+nAbLm5uJ/0pHmtcZNJ+/rkAUyKXKYwLYFXW8ZB/apVM
	rv9vspefvSb/8DjSYrcXaQd8Wfw+gkBZfactnS8IEShNLoKenNrd3qJbuahs6mM=
X-Google-Smtp-Source: AGHT+IE5JqXd5op2ME4DfyDISZaoxCz3/5wT/S1RPuiwFaospWqLhkV7wFXXoUXx1jpyAdVYAuAihg==
X-Received: by 2002:adf:ed4a:0:b0:36d:2941:d534 with SMTP id ffacd0b85a97d-37a4319e01dmr5471570f8f.36.1727077774743;
        Mon, 23 Sep 2024 00:49:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:b1b3:35a4:9ef3:cb84? ([2001:8b0:aba:5f3c:b1b3:35a4:9ef3:cb84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm23682144f8f.116.2024.09.23.00.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 00:49:34 -0700 (PDT)
Message-ID: <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Konrad Weihmann <kweihmann@outlook.com>, Martin Jansa
	 <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Sep 2024 08:49:33 +0100
In-Reply-To: <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
References: 
	<GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
	 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
	 <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
	 <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
	 <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 07:49:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16587

On Mon, 2024-09-23 at 09:30 +0200, Konrad Weihmann wrote:
>=20
>=20
> On 22.09.24 11:27, Martin Jansa wrote:
> > What about using precompiled re only in cases where the old "in" is
> > triggered already?
>=20
> Also acceptable for me - anything that makes the check less opaque.
>=20
> @Richard please let me know how we could proceed from here.
>=20
> My personal take, after digging into all the side effects, would be to=
=20
> remove the check and treat all "old syntax" overrides as merely "typos",=
=20
> hence letting them slip into the datasmart store, but adding a=20
> (potentially warning level) note that a certain operation is using the=
=20
> old syntax and therefore not being applicable in the current context.
> (unless ofc there is some code path that does some bad things to the=20
> store when using the old syntax, which haven't come across after looking=
=20
> at the code)

Old syntax won't hurt the store, the challenge is again performance.
Iterating the datastore for a search is one of the slowest things we
can do. That was why the check was put on entry rather than exit.

My original reply was intending to suggest the patch be tweaked to
improve performance along the lines Martin suggested (or otherwise).=20

In python if you have:

"if A and B and C:"

C isn't evaluated unless A and B are true so there should be some way
to keep performance and improve the tests.

I did even wonder about dropping those tests at this point, not sure if
we're ready to do that or not yet...

Cheers,

Richard

