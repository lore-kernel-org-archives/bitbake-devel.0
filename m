Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF3E706F6
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 09:00:28 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.11685.1695286826230626391
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 02:00:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WNgUzTJV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40413ccdd4cso12102355e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695286824; x=1695891624; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tq8ygGPo6Snvi90pqso3BW/h+95re1UjUvshYsHpmZM=;
        b=WNgUzTJVi6cWNV8FXVdTpO0fihjsqIBuNgArXRnOjxn3FLxEB5L6+vOfZEgd0XJ3oy
         hKICc1Nng1bNwtr+zwwWrXkF0KdJ/6Xxz+okXSKkl2nc0VBozW8j77CFTszB7dAs0tar
         nYpFiAlB09k/4q8xOJHQdkcUZWtXyh1stUSs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695286824; x=1695891624;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tq8ygGPo6Snvi90pqso3BW/h+95re1UjUvshYsHpmZM=;
        b=tCmjd1qXyA4rcWOqdxA0JdkpEI8SHcNL2gNI/+WBLFhzXibpqBlyX5A/zM1o9CWoLZ
         SEzMh0CRCsJjv10cI+0Ri5eeWg+nHqXqt3r+yENHJZ54Bk39pMt4tH+KVZuM8kElVYmK
         OFPWk3Q4LBDZ38755IUfDfpHBs9A3Ani8HRwQZ0vtbWqR9DsYpsNYWnTZeHIxvAZ8jpA
         C5Ua5MEiwgggmf8lnq9dCMjVgyg/4uCFeAb09EIqBZpLn3GgpQElvLsC3CcEBiqPSo20
         ePe5tLumoSH0YGTyPqy09U+KeHzGANiiETS8zv7dYhvFEq1zKOSEk0/NV4/r93qjAQt+
         2AoQ==
X-Gm-Message-State: AOJu0YwgaGH1xqmMcY/DIhqRuGKEeQumbEQB/DbcEHos6iy2xkKxui9b
	PjJaans72dff/ili7Eq0UgogCQ==
X-Google-Smtp-Source: AGHT+IGsEfY7gOuF5vM5fChADUH3nf1GdAs3gfkVh861LYaJWznbnaxH1gc6qMJn2PQmDG6oaBfxdA==
X-Received: by 2002:a05:600c:c2:b0:402:f8e3:93 with SMTP id u2-20020a05600c00c200b00402f8e30093mr3907370wmm.10.1695286824541;
        Thu, 21 Sep 2023 02:00:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a109:22f2:cbec:fa4e? ([2001:8b0:aba:5f3c:a109:22f2:cbec:fa4e])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b00404719b05b5sm1301870wmj.27.2023.09.21.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:00:24 -0700 (PDT)
Message-ID: <8e4a6e545b3b2bbe9fc0a053b42521a84ded31da.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
	 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 21 Sep 2023 10:00:23 +0100
In-Reply-To: <d15cebdfe85ce07df53132f3e20861ee@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
	 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
	 <517df01859172566e88a239658c601be@pianon.eu>
	 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
	 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
	 <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
	 <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
	 <97ecac758fd3b771e56e32e0a6c095d0900629a3.camel@linuxfoundation.org>
	 <bfff73a5d575b2a62fb14782e71e9207@pianon.eu>
	 <3b9ec69856ec79e4ec9856d72395b3cbd36e58b2.camel@linuxfoundation.org>
	 <d15cebdfe85ce07df53132f3e20861ee@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 09:00:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15100

On Thu, 2023-09-21 at 08:39 +0200, Alberto Pianon wrote:
> On 2023-09-20 21:20, Richard Purdie wrote:
> > On Wed, 2023-09-20 at 21:02 +0200, Alberto Pianon wrote:
> > > On 2023-09-20 20:39, Richard Purdie wrote:
> > >=20
> > > > > > Again, you'd get the git unpack events for this?
> > > > >=20
> > > > > This method passes git submodule's url, name, relative checkout p=
ath
> > > > > and
> > > > > revision to the tracer: where do you suggest to collect the same
> > > > > information? Should the tracer autonomously parse all .gitmodules
> > > > > files
> > > > > again and use git commands to reconstruct the same information?
> > > >=20
> > > > No, you shouldn't need to parse those. Isn't this information inclu=
ded
> > > > in the ud that is being passed to git unpack in the line immediatel=
y
> > > > below? That will be seen via the git unpack call the tracer will se=
e?
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > >           Git.unpack(self, ud, destdir, d)
> > >=20
> > > Partly. The missing piece of information is the checkout path. If you
> > > search for
> > > 'modpath' in gitsm.py you see that that parameter is passed to=20
> > > multiple
> > > functions but never used (apart from module updates) nor stored=20
> > > anywhere
> > > (or am I missing something?)
> >=20
> > "unpack path" is pretty much the thing you're having to instrument the
> > other fetchers for so if that is the only extra information being
> > logged in gitsm, that brings it into line with all the other fetchers
> > and we have a consistent API.
> >=20
> > What worried me more was an unbalanced API where some fetchers had to
> > have extra special handling. If the tracer API is consistent with just
> > the unpack/checkout path needing logging/tracing, that is much clearer
> > and consistent and a sign the API is right.
>=20
> Unpack path of git submodules (including nested ones) - stored in=20
> ud.destdir -corresponds to their bareclone path (like in=20
> <workdir>/git/.git/modules/<parent-module-name>/<module-name>) and not=
=20
> to the checkout path, which is not even calculated by gitsm. The=20
> bareclone path is of no use for the tracer, and in any case it's not=20
> consistent with what other fetchers return as unpack dir to the tracer=
=20
> (which should be the folder with where unpacked files are found).
>=20
> IIUC, in case of git submodules (nested or not), gitsm fetcher just=20
> bareclones them but it does not check them out; all generated subodules=
=20
> urls/urldata have the bareclone parameter set and no information about=
=20
> the checkout path; ud.destdir is set to the bareclone path. Only at the=
=20
> end, when all submodules (including nested ones) have been barecloned,=
=20
> gitsm calls 'git submodule update --recursive --no-fetch' only once, to=
=20
> check out submodules into <workdir>/git/<module-path>,=20
> <workdir>/git/<parent-module-path>/<module-path> etc.
>=20
> So I would apply for an exception here :)
> Calculating submodule checkout paths (also for nested submodules) and=20
> adding them to urldata would require adding just a couple of lines in=20
> gitsm.py and would do no harm, I hope... This would be much better than=
=20
> passing the modpath parameter to the tracer with a special hook: the=20
> tracer could just collect the checkout path from urldata and no=20
> fetcher-specific hooks would be required. In other words, we would solve=
=20
> the only problem that's still left (the others should be solved by using=
=20
> sessions as you suggested).
>=20
> What do you think?

That sounds reasonable.

My concerns are as I previously mentioned, encoding unpack specific
data into urldata which is effectively invalid after unpack and the
naming "destdir".

Cheers,

Richard

