Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2B9C282EC
	for <webhook@archiver.kernel.org>; Sat,  8 Mar 2025 20:18:35 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.2891.1741465110289846909
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 Mar 2025 12:18:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SXlpUE6s;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-391342fc148so1048802f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 Mar 2025 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741465109; x=1742069909; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNLAuijKLweu582VNllpJZk+ureezTllKc0Mv4OBNPg=;
        b=SXlpUE6scqyFD4B/1858FbflPjlFM2zY8lRlSyIS2GLpRIdV3/kzcBp7Q3Qfn7+4/D
         lUCpjn0NVouMLVts2ftPTHBHwZ2W6BinNecjfjcGpSMuDJTga6l1LhKLS8DeQIPCD3dS
         2WRIpp3/04kAK+aoEPhuPxhKxtz0auPSLWxQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465109; x=1742069909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNLAuijKLweu582VNllpJZk+ureezTllKc0Mv4OBNPg=;
        b=ZSPwqYGkzuG0fefCGCyuWBj0hZOzl6RNJBNkccXROFRrTsQ+StgArIa/+TlQZcqqDU
         itzXEKqbe8rO2tT4qHm99cdDB+hcXQmlHzd7lieQdHsnTts3NpzCz1vzo6hjT8LWc0vz
         7V/cLPK6+YOiN/rxUnUOgosO94qdlsaX5mgsdMQl/mkkvqx5nvGDfJMZRl6KpJ07K0Co
         hM9qf+brrVoNLkZYHeetPJPRo2CVowS1E0DzVkam3vT5o8jFKgzJkGk4Q24xn1Bpd8cf
         oqDr/q/wUUf+blN92mPNYmE96IOSfwY+L7euARiDxnw1923gmMVGYUTsbNi/epK5RXvN
         9lGg==
X-Gm-Message-State: AOJu0Yxt0JqSmKEMByImMM7a9zVWezqc4HEQPZGXff+CQ63MIvIxGaAz
	6HYHp4Kmb0URnX+qIA3CG2/GeRaqGY0TFeXTeui9QmpmleSEriC6UQCVbt8X6yQ=
X-Gm-Gg: ASbGncv3j0A+XJd8MausAl0CCYkiAsAPZXnO6bT65S+oUxmQo2wamoMDcqYPV1gA4F0
	lAnNWLkEUfrwsYP8NtOeg/Fv1ETHjuj6u58t6/oFA3l3P+h1vTyyjdMTKHP+bLLyUxJVMyVzlUt
	pn4vh8D1qF8JUufzmo69ABrJEr3qtmy168qKkx58saLakR+uJXkQzg1JOdIlj1ETOa3Wni1eSMo
	BBHjzrxllcLXnl3mvIKfpKDrQwoeOB3/Am2a3e3ZAgA0o7usv+keDBMjJuq+RMmkaTdaYMGwdDL
	bXD/rmo+vWDLEkc/uHgou1uPNfq+WW2/ZKEUyYFxyJK9p570GEpi5dgrG1/MXiYsAINyr/1Qkwo
	sYccRrF94FELo2FMW8Ke96oF4kxdrR6Xnkg==
X-Google-Smtp-Source: AGHT+IGr/2IsGG7WYjksa3FYanqDUpmHwdP9DlfFHYdv7PZaKjmr1dTo9QUtF+2/pCItVMpQiyVPQw==
X-Received: by 2002:a05:6000:1849:b0:391:3fd2:610f with SMTP id ffacd0b85a97d-3913fd26306mr1512588f8f.13.1741465108620;
        Sat, 08 Mar 2025 12:18:28 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1adb:4ff6:dee8:845c? ([2001:8b0:aba:5f3c:1adb:4ff6:dee8:845c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f4fsm9674395f8f.77.2025.03.08.12.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:18:26 -0800 (PST)
Message-ID: <294e2747cb4578238bf4f955d36c546ed983154d.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v5 2/2] doc:
 bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: eric.meyers15310@gmail.com, Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Eric Meyers
 <eric.meyers@arthrex.com>,  Geoff Parker <geoffrey.parker@arthrex.com>
Date: Sat, 08 Mar 2025 20:18:26 +0000
In-Reply-To: <CA+cKJ+EsE0K6zm0AavqHEVRfGNx-y_AAr_1JOe-VMfmoUu9icQ@mail.gmail.com>
References: <20250228130137.400-1-eric.meyers@arthrex.com>
	 <20250228130137.400-3-eric.meyers@arthrex.com>
	 <CAB=6tBRU3+bKeNsbNpiHChBpeXbjR7Or3rOVT66-5K81OgZK2Q@mail.gmail.com>
	 <CA+cKJ+GOjzvBoHrFr_Y634cOUJTrD1VC8864CfDKkRJp_ey2gQ@mail.gmail.com>
	 <CAB=6tBRm_rJ2QeCdZhSNgTaZZ94DsyQX27MnAeLu9tiPnin2gQ@mail.gmail.com>
	 <CA+cKJ+EsE0K6zm0AavqHEVRfGNx-y_AAr_1JOe-VMfmoUu9icQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 08 Mar 2025 20:18:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17417

On Sat, 2025-03-08 at 08:16 -0600, Eric Meyers via
lists.openembedded.org wrote:
>=20
>=20
> On Fri, Mar 7, 2025 at 12:56=E2=80=AFPM Chuck Wolber <chuckwolber@gmail.c=
om>
> wrote:
> > On Fri, Mar 7, 2025 at 9:17=E2=80=AFAM Eric Meyers
> > <eric.meyers15310@gmail.com> wrote:
> > >=20
> > > Apologies if this isn't the correct process (this is my first
> > > time submitting a patch), but what's needed to merge this patch
> > > into master-next, then master?
> > >=20
> > >=20
> >=20
> >=20
> > For now, probably nothing, but it never hurts to do what you did
> > and ask. The
> > bitbake repo maintainers watch this list.
> >=20
> > Your patches show up in patchwork here:
> > https://patchwork.yoctoproject.org/project/bitbake/list/
> > Just search for your name.
> >=20
> > Also, have you reviewed the contribution docs?
> >=20
> > https://docs.yoctoproject.org/dev/contributor-guide/submit-changes.html
> >=20
> >=20
> > ..Ch:W..
> >=20
> >=20
>=20
>=20
> Yes, I have reviewed those, they are what helped me out with
> initially submitting the patch, I just wanted to poke this thread
> since the guidance was 2-3 days until it makes it into master-next.
>=20
> Anyways, I see the commits have been applied now:
>=20
> =C2=A0 =C2=A0 -
> https://github.com/openembedded/bitbake/commit/177395a4dee1b51380e61ffa88=
89588f81740bc0
> =C2=A0 =C2=A0 -
> =C2=A0https://github.com/openembedded/bitbake/commit/23f3f16cf211f9a9db89=
1
> 4eeb82ccf131ac21b22
>=20
> Thanks a ton! I will submit another patch for backporting this to the
> scarthgap version of bitbake (2.8) in the coming days.=C2=A0

They're in master-next, they haven't merged until they're in master.

If you're looking at 2.8, they'll need to be backported to 2.10 first
as per the stable release policies. One of the policies related to not
backporting new features, this one is a bit borderline in that regard.

Cheers,

Richard

