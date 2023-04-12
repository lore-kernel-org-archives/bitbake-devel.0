Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B32C7619A
	for <webhook@archiver.kernel.org>; Wed, 12 Apr 2023 06:58:56 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.36824.1681282726580919062
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 23:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JoCkkZll;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so13476717wmb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681282725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlQs56gnQu7EZ2L8V7GysFjiDwwrsMV9bdrycLqCkU0=;
        b=JoCkkZllu5SphBsJJE/WwZ3RIkYUbVdB7UVZdHEuKdNbx7JydCnF7Dahih24b70X7C
         exm6I1HnhzY1E3ER2cDzGVDB5IVJ+mvpYyVORTnX9mXmUfP41yXfo8xIP2/F0SrMsWr3
         KeSfN2J7FJFvN+4TPENEHghBZlhcKiGazHF7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681282725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OlQs56gnQu7EZ2L8V7GysFjiDwwrsMV9bdrycLqCkU0=;
        b=WR3hmtTyq2sSF/qQQUfg5u7jiAKXotZOa5U002IsYeDyTz53K+cVOgtttbGWlOQse5
         TTsH2b2FMJmcWs3RaGRYKSPd0wkLep8lkjeBS+r0zn8zV922dVpRvjmnJ/wFacyr09bC
         3QqCg0B0IpD70r5LOtDSeCXVOUQOH2DI+0TU83eGJd3kzBJ71fr9UC1XQgrlOswWzxiB
         o2YDZTxiChm9r44pkNaVbTCJDLZZAgpQf1IyY5KkdyorwwxdpIS6vSPncawzIp70s2MD
         k6T0P20XeEk+Qn7x+mWnyF9gY3+RoR8riwlyaEgXfZSIJTpkiAjdwRgm7NDQAyEISY+W
         V8LQ==
X-Gm-Message-State: AAQBX9ctjID2U1K1KNmPHof2ka3EJosm0T6104op//ybhrMzZnXxMBLt
	V6BI0NFa6V3jvD1ji3HwZ3Rfzf4omgH+mk2Sn1E=
X-Google-Smtp-Source: AKy350aXmj0S4HaMBBRt9AShPuFb62ATDjmzDbWd7WOdUezhz7POWkQHgmbHqU5obF2QXV0ra2kcnA==
X-Received: by 2002:a05:600c:35c2:b0:3df:9858:c039 with SMTP id r2-20020a05600c35c200b003df9858c039mr1005005wmq.14.1681282724908;
        Tue, 11 Apr 2023 23:58:44 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9435:675c:973f:522? ([2001:8b0:aba:5f3c:9435:675c:973f:522])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b003ee2a0d49dbsm1278995wmo.25.2023.04.11.23.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 23:58:44 -0700 (PDT)
Message-ID: <58f0488487ba8c85b28472ed28895bb4c3404317.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] event: add bb.event.ParseError
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Yu, Mingli" <mingli.yu@windriver.com>, "Yu, Mingli"
	 <mingli.yu@eng.windriver.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 12 Apr 2023 07:58:43 +0100
In-Reply-To: <08ac7a35-db3d-430f-5d10-f96a90862f1e@windriver.com>
References: <20230410091900.2897894-1-mingli.yu@eng.windriver.com>
	 <bed59afa659823a6656aa978168330642648811a.camel@linuxfoundation.org>
	 <08ac7a35-db3d-430f-5d10-f96a90862f1e@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.47.3-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Apr 2023 06:58:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14696

On Wed, 2023-04-12 at 10:42 +0800, Yu, Mingli wrote:
> Hi Richard,
>=20
> On 4/12/23 00:50, Richard Purdie wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
> >=20
> > On Mon, 2023-04-10 at 17:19 +0800, Yu, Mingli wrote:
> > > From: Mingli Yu <mingli.yu@windriver.com>
> > >=20
> > > Add bb.event.ParseError to let error-report can catch this kind of er=
ror.
> > >=20
> > > Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> > > ---
> > >   lib/bb/cooker.py | 6 ++++--
> > >   lib/bb/event.py  | 8 ++++++++
> > >   2 files changed, 12 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > > index 1797a1d4..206f8ffb 100644
> > > --- a/lib/bb/cooker.py
> > > +++ b/lib/bb/cooker.py
> > > @@ -2223,7 +2223,7 @@ class CookerParser(object):
> > >=20
> > >               self.results =3D itertools.chain(self.results, self.par=
se_generator())
> > >=20
> > > -    def shutdown(self, clean=3DTrue):
> > > +    def shutdown(self, clean=3DTrue, eventmsg=3D""):
> > >           if not self.toparse:
> > >               return
> > >           if self.haveshutdown:
> > > @@ -2238,6 +2238,8 @@ class CookerParser(object):
> > >=20
> > >               bb.event.fire(event, self.cfgdata)
> > >           else:
> > > +            if eventmsg:
> > > +                bb.event.fire(bb.event.ParseError(eventmsg), self.cf=
gdata)
> > >               bb.error("Parsing halted due to errors, see error messa=
ges above")
> >=20
> > Shouldn't this always fire the event even if there is no specific error
> > message?
>=20
> There are many kinds of exception here and each exception will call=20
> shudown function, but we only catch bb.parse.ParseError exception and=20
> pass eventmsg to shudown function when it is bb.parse.ParseError. So=20
> checking eventmsg in shutdown function should be okay.
>=20
> except bb.parse.ParseError as exc:
>              self.error +=3D 1
>              logger.error(str(exc))
>              self.shutdown(clean=3DFalse, eventmsg=3Dstr(exc))
>              return False

I don't mean to call it totally unconditionally, only in the same cases
as we show the bb.error()

Cheers,

Richard

