Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CFBD3EE68
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 13:46:39 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37636.1769089598163351915
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 05:46:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W20bU5mE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d256c2e6so928997f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 05:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769089596; x=1769694396; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlAJn78jjG/sPRFaMYk0AvQEX2zoy36kJh8JSJiKmgw=;
        b=W20bU5mEKC+qF8mh8zVoH3CdQBTPJnj6Q7ulkLzx7TFrVf4DT/vISHoF4vWxIwqo0i
         qTlJ+2MgeXU0MLerpkRbnGNzShhP/0w6Rr3kJt7LN/XaTiWkCwNlkkWSk6A6pexxS+y1
         TGTUgtC+wqQXPN74hFwX1nEqKgSyQd0HfU108=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089596; x=1769694396;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlAJn78jjG/sPRFaMYk0AvQEX2zoy36kJh8JSJiKmgw=;
        b=NNa42//VseNv6F16GMcD6KIxtHHpScEx+4XmsdxYEj4Pj/jBlBL44+eDAPOdJqJZeM
         eOQnSqFoyfKEljgP2hnUfIRHkYGa7wdzeHByBOpjT4g/JDh7baQybcIR/mYbX8YF3Oj0
         vZSz6GrixRrYg0pG2/llFtxCyg7ShZNi/o/iWZbe6iO9igRNbdFGiyC30EcC2KHIZvVi
         N4E7/eW/yCPcS9fh6jgbN9fJ4elYOHzlNoH+rQF+sClibNBhVHLuLQT+Gis7apYhspO1
         6YfeTwJWPgRJshWf/joJRGi4GWkBkDy4dVpcnw6fzhxenm+DyrFuPYtJrctDNTYkjX7j
         jlOQ==
X-Gm-Message-State: AOJu0YxLMG1QcXD+XAmAA/PXUuzFUgbKh5PZF+thVzB7izrYCKyh2nbI
	LsRn8CieAUQEm4Sd/I80ddq87yN84AjRzMnezR83EfnaERI0O/MZrxR807GdtDJm/54=
X-Gm-Gg: AZuq6aLkW9JgrQMjZRCgG2NygUAftFr6TyP6y0llzn9F+6tL8ajHzUlNDp2QsnzBAsD
	LBwoYj1tehxynEvkSx8fFlgA5YfYRdxy4dX4AiydC2EpOgU9mvXo2ybUc5VnC4KdsXkMxf5YucA
	BkDsgyfHSw8CVhrEpUwfQqcmUT/arGmGgm/Lkikgi22cz99MKKxf0ZqqoZpEwr+mWH2t+q8z60k
	1Fg+xHSC/ZM7gYO4rGfjNTuYznL3Bv9Hh9DfJk42NNnZ8zNEJ1qbIZAvp62ThL1GfagkFdOIMXU
	qaiWFZZrli2FfMBq/TgL6sWUkA0HigHL7pVXlmOUbyUE/MScsOTXNXsh3WpJCI02b9ItmsqRS8h
	7ohah0bsQVjlz4qQVh2akObI3YrgB5xGTAiUrM7MqWoGfxuucdU4jBGvf2H93J2pJaiFchod3bR
	lbg1LQAceCbyr2ZjiF75To+j0OqXRgSNBON8KKuch+oAHTTy7Qx2AygO9BH6rkhux9SEaEpj4+0
	gA=
X-Received: by 2002:a05:6000:2486:b0:432:dfea:1fa8 with SMTP id ffacd0b85a97d-4358ff300f1mr14136588f8f.45.1769089596388;
        Thu, 22 Jan 2026 05:46:36 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245? ([2001:8b0:aba:5f3c:8ce7:5a61:b9e8:a245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm45833846f8f.36.2026.01.22.05.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 05:46:35 -0800 (PST)
Message-ID: <c8c0bbab870d11aa2e4d867709343615594b32a2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/npm/npmsw: Disable npm and
 npmsw fetchers due to security concerns
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Marta Rybczynska <rybczynska@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Jan 2026 13:46:35 +0000
In-Reply-To: <CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com>
References: <20260122080922.1695912-1-richard.purdie@linuxfoundation.org>
	 <CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 13:46:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18845

On Thu, 2026-01-22 at 14:01 +0100, Marta Rybczynska wrote:
> On Thu, Jan 22, 2026 at 9:09=E2=80=AFAM Richard Purdie via lists.openembe=
dded.org <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrot=
e:
> >=20
> > index 2f9599ee9e2..322c7b331e5 100644
> > --- a/lib/bb/fetch2/npmsw.py
> > +++ b/lib/bb/fetch2/npmsw.py
> > @@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):
> > =C2=A0 =C2=A0 =C2=A0def supports(self, ud, d):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"""Check if a given url can be fetche=
d with npmsw"""
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ud.type in ["npmsw"]
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ud.type in ["npmsw"]:
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 from bb.parse import SkipRec=
ipe
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise SkipRecipe("The npmsw =
fetcher has been disabled due to security issues and there is maintainer to=
 address them")
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return False
> >=20
> > =C2=A0 =C2=A0 =C2=A0def urldata_init(self, ud, d):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"""Init npmsw specific variables with=
in url data"""
> >=20
> >=20
>=20
>=20
> I think there's still a missing word in the error message: "and there is"=
 -> "and until there is".

Well spotted, I lost one of the tweaks to the patch when I updated it to fi=
x the import issue. I've added it "no" back so it reads:

raise SkipRecipe("The npmsw fetcher has been disabled due to security issue=
s and there is no maintainer to address them")

Cheers,

Richard

