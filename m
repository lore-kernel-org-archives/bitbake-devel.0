Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D76CCDB47E
	for <webhook@archiver.kernel.org>; Fri, 13 Oct 2023 10:57:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.35791.1697194660172647754
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Oct 2023 03:57:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KNUmBGzz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-405497850dbso20366275e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697194658; x=1697799458; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JqvhiTYJLdR7yF+08CRXiC7C7G32aI6U5/u7ENkAOhc=;
        b=KNUmBGzzZ9REcqfbWDDrcceuFuAYiHJaAJ+MPIFxlRANqd9pjRD2UfaitiizF0NK4B
         2YPsDlmmTZo5ouZDXDimlbQdFOo41634sHOleQ+Dm1f0rEG94ldfbnfxVibYe7QDcIj+
         qMhUgSXg28kAXF7SOPuWsflwTny+rS6mUqPM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194658; x=1697799458;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqvhiTYJLdR7yF+08CRXiC7C7G32aI6U5/u7ENkAOhc=;
        b=PjLd7rhVrM9X6hnaX5sYimywObvJ/2Npj8KSllQwSnElRzHJbOvE8BIfH/OcJf7oQQ
         +XoD22iT0cAkGCNXkg4EG4OLpnhYIQKch1RjikhZO7RlFn6Epd136XVhPU9xwXeIhkJC
         kKFpnowWDln6VeAAIbse/Zepe+9GArcZ78JJjet2HBeoZk9724nKKe1PP5hf0dXgixAO
         zCoDhDkqSAn2PzY8B44Ze5O48M16uXidfaAgFulDklRoGF8zLo3UWMTl7WtbdUswy8hs
         rxPBkVHv5OorfoDZWUIxXaha3vcEfjYOiNJVY11Msx31xSZEB/g913Yx+QK5dXl+XG4k
         wuag==
X-Gm-Message-State: AOJu0Yw8L6FkJFl9rIDpEhminwtllYXWKhuZBEzpetfALZCr/IInDXXK
	jsO8QoY5Kip0B8jyaJ94F9okwA==
X-Google-Smtp-Source: AGHT+IHf4V3ZigvFmXhi0L5hcnO79a+lWJ9Qrh1ftChlEm9B07exgsHrBblnbQ5n1N8g3Vw3678dbg==
X-Received: by 2002:a1c:6a17:0:b0:401:db82:3edf with SMTP id f23-20020a1c6a17000000b00401db823edfmr22927677wmc.39.1697194658578;
        Fri, 13 Oct 2023 03:57:38 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2c2a:1925:586b:5a77? ([2001:8b0:aba:5f3c:2c2a:1925:586b:5a77])
        by smtp.gmail.com with ESMTPSA id x8-20020adfcc08000000b003296bb21c77sm19905982wrh.80.2023.10.13.03.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:57:38 -0700 (PDT)
Message-ID: <fba1e4f303947c1701a2375321e6302a7d10a753.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] Fix disk space monitoring on cephfs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jan Luebbe <jlu@pengutronix.de>, Marta Rybczynska
 <rybczynska@gmail.com>,  Samantha Jalabert
 <samantha.jalabert@syslinbit.com>, bitbake-devel@lists.openembedded.org
Cc: Enrico =?ISO-8859-1?Q?J=F6rns?= <ejo@pengutronix.de>, Steve Sakoman
	 <steve@sakoman.com>
Date: Fri, 13 Oct 2023 11:57:37 +0100
In-Reply-To: <fa678fac78b8a5ca915b24bb22ae2ff9f8b8f546.camel@pengutronix.de>
References: <20230824081110.2851830-1-samantha.jalabert@syslinbit.com>
	 <CAApg2=R2Opk75OqLRcLXBkaHv9WVFAXbnxS9t-PPi5AMywFwGw@mail.gmail.com>
	 <fa678fac78b8a5ca915b24bb22ae2ff9f8b8f546.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Oct 2023 10:57:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15240

On Fri, 2023-10-13 at 10:22 +0200, Jan Luebbe wrote:
> On Thu, 2023-08-24 at 11:42 +0200, Marta Rybczynska wrote:
> > On Thu, Aug 24, 2023 at 10:11=E2=80=AFAM Samantha Jalabert <samantha.ja=
labert@syslinbit.com> wrote:
> > > Error occured while running bitbake on cephfs:
> > >=20
> > > WARNING: The free inode of path is running low (-0.001K left)
> > > ERROR: Immediately halt since the disk space monitor action is "HALT"=
!
> >=20
> > This was our small Ceph issue I've mentioned during the call on Tuesday=
.
>=20
> We stumbled across this as well. Would this qualify for backporting? It c=
herry-
> picks cleanly to mickledore, kirkstone and dunfell.

I'd say yes. I've copied Steve.

Cheers,

Richard

