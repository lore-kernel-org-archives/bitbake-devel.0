Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188F2C636E5
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 16:56:24 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.1502.1724864177246537600
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Aug 2024 09:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MBthgSpK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso61417975e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 09:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724864175; x=1725468975; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/yyQrdehR3hWcWrFr4onIMdGbW8K8iGo6rXuzrgwAlU=;
        b=MBthgSpKz2jdtgGB0NTNEL8Utf/OPxI7zX0jcGzQSVXaRPLhHOVrpq3qblAL4UGdt2
         sCs1SB5MB3uGxmfVEorVqOTk9ZmPbD+tBCiyWpzOfGY7il1ns4VnblKRAQ5ZYDqCisAS
         BmPbY43tie7tzPtJJJmJN6GGsfiC4ZmZ97dB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724864175; x=1725468975;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yyQrdehR3hWcWrFr4onIMdGbW8K8iGo6rXuzrgwAlU=;
        b=CO5DmQxO3+rZc4dNX0ULTBvLhyFcQakhAAKj59/gmh5I4voQLpartO0qhv2l70OmBl
         Z83AxFbJ67iE5dNuFq6ACW5+pKZYeiz3NcZSk5YSHyz3sn31aw4NVVTF0W/20IhvHorJ
         TGpiLQ84eAZE9dfujBfpqEfsDKDhXSNbnarKAJpRF2ybOiSMi/k6F9SrQsJ9rKlk5dVg
         iUZu4ovv/WpEVClwo4+1WNOtVE4JEsXD/zQknPNdxz2OsZpyT5TnfUHtKA6IFVLyOqAt
         rHf+qHoQ1728NrI7wwlujKqKsZhrfV1WsibxmkIoj9lblTNwzTlYvgoGCxRRnyiCfoo1
         /QUg==
X-Gm-Message-State: AOJu0Yzun5A+/h4kAMS+EERK8YcxVORL4YNyn9OrlHtLRxgkj/7Gi7X0
	2TYH+vVcpoXbIdkXJQflaWBuUKjM+fjDtltM66w1nm17nB6UcvGAlPOOfDV68Jk=
X-Google-Smtp-Source: AGHT+IGrntomZczNzqI6qGlem/HID2P1IyxaRQqMQ694hFY0et/GsGu3TBXdz/HTERwjAY1QpDR9ew==
X-Received: by 2002:a5d:4742:0:b0:371:8ca0:4d20 with SMTP id ffacd0b85a97d-3749b551184mr115160f8f.27.1724864175374;
        Wed, 28 Aug 2024 09:56:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:354e:532a:804e:264e? ([2001:8b0:aba:5f3c:354e:532a:804e:264e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749b22da7dsm249133f8f.7.2024.08.28.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:56:15 -0700 (PDT)
Message-ID: <6267990f556050c8e75fe60fafed6f5d181ad997.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] coreparser: Allow code visitor
 expressions to be declared in metadata
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Aug 2024 17:56:14 +0100
In-Reply-To: <CAJdd5GYBV11awouRqMLh4_cmfZgyMdyR+v7q=--by-foTwBnqA@mail.gmail.com>
References: <20240828120646.1458872-1-richard.purdie@linuxfoundation.org>
	 <CAJdd5GYBV11awouRqMLh4_cmfZgyMdyR+v7q=--by-foTwBnqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Aug 2024 16:56:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16526

On Wed, 2024-08-28 at 10:35 -0600, Joshua Watt wrote:
> On Wed, Aug 28, 2024 at 6:06=E2=80=AFAM Richard Purdie via
> lists.openembedded.org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
> >=20
> > Allow the metadata to define code visitor expressions which mean
> > that
> > custom dependencies can be handled in function libraries.
> >=20
> > An example is the qa.handle_error function in OE which can set
> > something
> > like:
> >=20
> > handle_error.visitorcode =3D """
> > if isinstance(args[0], ast.Constant) and isinstance(args[0].value,
> > str):
> > =C2=A0=C2=A0=C2=A0 for i in ["ERROR_QA", "WARN_QA"]:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if i not in self.contains:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self=
.contains[i] =3D set()
> > =C2=A0=C2=A0=C2=A0 self.contains[i].add(args[0].value)
> > else:
> > =C2=A0=C2=A0=C2=A0 self.warn(node.func, args[0])
> > =C2=A0=C2=A0=C2=A0 self.execs.add(name)
> > """
>=20
> Open ended code feels like it could pretty easily get us in trouble
> (plus, you have to compile it to boot, so you don't know if it's bad
> until then and have to deal with that error). Can a function be used
> instead? Something like:
>=20
> def handle_error_visitor(... some argos...)
> =C2=A0=C2=A0 ... return some thing useful
>=20
> handle_error.visitorcode =3D handle_error_visitor
>=20
> The other advantage I can see of doing this is that you can picky
> about the passed arguments and the return code to put some
> limitations (i.e define a clear API) on what you allow a visitor to
> actual do, and you don't have to worry about visitor code
> squatting/corrupting variable names, etc.

I did try that but I was struggling to get things to work, partially as
trying to get into the right scope to resolve the function names was
annoyingly tricky with the current code structure. Perhaps now I have
the above working (which wasn't as simple as it might appear), I should
perhaps revisit using a function as I was probably in the wrong place
to get it working previously...

Cheers,

Richard





