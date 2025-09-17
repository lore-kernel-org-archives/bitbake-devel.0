Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2329ECAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 22:35:57 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
 by mx.groups.io with SMTP id smtpd.web11.83.1758148551176949288
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 15:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=qkyzqiM5;
 spf=softfail (domain: sakoman.com, ip: 209.85.219.172, mailfrom: steve@sakoman.com)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-ea5c06bd2b2so338330276.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 15:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1758148550; x=1758753350; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4OPeVN+pCpXmvBnwmpDwisVZWGOxuAhN9JVcFv/Vr0=;
        b=qkyzqiM5fJVhNISe35iB8k6nm22Wf10KFrKtzbFtHbmftE9N/avCxLRNb9SaQU9Wo5
         3pcQG91UKNjpbYIwUmSUoyewAsIui0xZGbxa4ROZdnUC1YMdRHurzhu1mI5NAQRkOSH1
         mxD+n8kMdzrX02e3b8XM+6O9O8Pv01ZpKScnZiHFhC6zTxq2iSs9Z0QeqBs/4qcCS0z1
         qz9I48k26Ky6+qJ/zbuBGcvGI1Hy2kSJBejEz+z+RZ7I5KMkUnBvrCiDZpMUfIMUivwj
         OYsFUx3GEIofwF15rzQu2RsyQKobD4lDXCF+opg4mUinB/W5LHzFqV7xm43flf7YDJEy
         ds3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148550; x=1758753350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4OPeVN+pCpXmvBnwmpDwisVZWGOxuAhN9JVcFv/Vr0=;
        b=o9IeFnQehQf4sRRmT6gIMsvjneK96w20WkFoR6AbNIGOX2DVAsGTLQi01jugw6M32T
         M4nQPsLqZD0t8gcZN7xc8+pS7ClMbn+uFIcgkXzTKsP2hHwJHdNPF4XiYakOeR/YAyVD
         IdPg8m18Vf9af37dgovVgG0IH+FgbLG66Wu46miGYzxYmOFLTFAEKtMsiHffIl8c+mFL
         48YJ8VsOqg7DlBpFrrXfaSrhZG9lXTzXkYtHBRYPlcqaHU8/WPQpuVvJXD1eOOlRPxH9
         eJT3PGvKoFXonxaw0QMZu0NLGwmKWIDVMKpmYPV9Jr7WXhBey8COYvE9qe8cYrpFB+ON
         LqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnPi5ngczU5w90PHh2oEoF052rhI8cRZPTAzPCrdxnbl4S70M8Ztt+lBRU/Pi4EtEPEEbi+4Oe5hGEA1Xe@lists.openembedded.org
X-Gm-Message-State: AOJu0YyeQqpnqiV0vD37S3XSBwp2xKn1j1RfE6tS+WH9xVBkGXxK503Q
	b/B270bt2pcSsJjp3CAi2lsbe0Mf/LFTx4e0mWiZ0pwvaGUli+yjgzCjYm1z/cjVZ/mSSxGsEck
	ebpgpmc5GS9qey9CbqCiiqMz3jngrcOwtj+5dGKYjEg==
X-Gm-Gg: ASbGncsxdVlS4sPDTN1WSKvxJSbeKugJQB0A6TdhmeVOq3wOVvokUB9EE52EJMHv/52
	dM5vX2voWc70NFa0X3/jVUm4RZJMwfQr+MdcBYoUqsIEFhQaf2g0Jivnk2G6pKriiPLM1y3zxUs
	yu/HuPCWMclTJj8Tvy1pfARB+pj6eKrYTP4vsndIiO61RpO+ol0YxDOxYiQMb1X5Y5Cn0DEMQ2B
	+mGKGSQX/B5TPuStBNcYpiRF/D2xHZRY3NB/uQevyCm9YyqXB8RYuF9zg==
X-Google-Smtp-Source: AGHT+IHdKMO8iYrDgjKNhZWlUs9+bCgI8E7Y+Pmg3iW8KuRIL8aEW/X6Mu75HEM6eqyupE90OR0NM88GoxKPJOEnzPk=
X-Received: by 2002:a05:690e:2417:b0:633:a7cf:bb4a with SMTP id
 956f58d0204a3-633b07332f6mr1995092d50.23.1758148550186; Wed, 17 Sep 2025
 15:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757519577.git.steve@sakoman.com> <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
 <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
 <CAOSpxdbx6NRbf3DJdvDbVQswa839AeMbaD=Uv_5U9BJ-Qg-WRw@mail.gmail.com>
 <CA+chaQfWY40HZhEiDr9dF5UDCFmQcqjRkxNgCDXFRpTYAPMLRg@mail.gmail.com>
 <CAOSpxdaCKONLXZ-8aYWWb-jha7-P04-MGj1vSLKuZHbod=dFEA@mail.gmail.com> <5c83e6fb22b0d2b56d5a182e18fe528f68370075.camel@linuxfoundation.org>
In-Reply-To: <5c83e6fb22b0d2b56d5a182e18fe528f68370075.camel@linuxfoundation.org>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 17 Sep 2025 15:35:39 -0700
X-Gm-Features: AS18NWASgS4F-ImecCS-C6SKAIo9GU5-hx-C7-wFicL0kRaqWRSDxR6QwaqpxW4
Message-ID: <CAOSpxdZY=EUPoP_sTM++VerGyaKAL7hWdkjv5JwB=mF+_v_=Rw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Martin Jansa <martin.jansa@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 22:35:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18060

On Wed, Sep 17, 2025 at 3:34=E2=80=AFPM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2025-09-17 at 09:25 -0700, Steve Sakoman wrote:
> > On Wed, Sep 17, 2025 at 7:05=E2=80=AFAM Martin Jansa <martin.jansa@gmai=
l.com> wrote:
> > >
> > > I've sent the v2 of all 4 related changes to use 2.12.4 and 2.8.13.
> > >
> > > I've also noticed that the sanity check for bitbake version is
> > > executed too late after the utils.py is already failing with:
> > > ERROR: Unable to parse oe-core/meta/lib/oe/utils.py
> > > Traceback (most recent call last):
> > >   File "oe-core/meta/lib/oe/utils.py", line 11, in <module>
> > >     from bb import multiprocessing
> > > ImportError: cannot import name 'multiprocessing' from 'bb'
> > > (bitbake/lib/bb/__init__.py)
> > >
> > > To avoid this issue I recommend to leave "lib/oe/utils: use
> > > multiprocessing from bb" commit in oe-core scarthgap and walnascar fo=
r
> > > some future batch and now merge just the bitbake version bump in
> > > bitbake and the requirement for newer bitbake in oe-core, that way
> > > people will hopefully update both before it gets really mandatory.
> >
> > I'll be doing the final walnascar build at the end of next week, so we
> > either need to have this sorted by early next week, or just decide to
> > leave things as they are with walnascar since it is going end of life.
> >
> > I'll pull the patches from scarthgap till we sort the proper version
> > numbering and we can then stage them as you suggest.
>
> I've pushed what I think makes sense, hopefully that gets things unblocke=
d.

It does.  Thanks!

Steve

>
> Cheers,
>
> Richard

