Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06243C04FF1
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 19:21:00 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.5008.1695237653081058046
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 12:20:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=StRngGN9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4018af103bcso639775e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695237651; x=1695842451; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jHXvbJz/ZlNVTmMKQJotGCE2BVFbIEeZealeIb+XZxs=;
        b=StRngGN9RKvtNssVe9ViY9HaU/bJTMWjLUdFqCMG6Vwhp0j6pg42P+ze+ry/dkNtyv
         JQwwqdRLTxqrVNHEQjnfg3TKMy+m5S+dR4QpLzPAZwZVx5scZ5aaAk1nKLw1eH3H/IK9
         OIYAqzb8xdU65vue8HDowDaQ4qv9t9ooRxNWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237651; x=1695842451;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHXvbJz/ZlNVTmMKQJotGCE2BVFbIEeZealeIb+XZxs=;
        b=R1WpkxrS8ylTmBYkati2tUC6yhGcxJh/w3JqJbzcfjQN0PWcDBsK4d9BwiwnfbdKlH
         mKyqCHu0iP6irQapRgwyyh2lZwxKVIqbpbCIKk4QRvPJrC/TZWk9Ii4Stke8I10/HJdL
         8eR/VwfGYCHI5pZq4vQ+q32YoTLRkslZ697tKE3HRK3auEYzgF3J6g7Io/Jcv3BaVC90
         Nk7IYf/w9D4ANbQ45JBx2pd3G25B9v1mbmZJ/0BB/nkx89TzgTpSemxK+wzYOvvF+gkd
         d6t0iDWmrCV1f3KX9D8NfH+Eey+Prj387gBVpOTmuk+8i5PpHarK14zAth5OhLnKmhcr
         sQvg==
X-Gm-Message-State: AOJu0YwB0bOredg/6iiFjQguT/3yTRB7DL9OM69tnQhWxz+9/gKYOCkD
	CJ+ScbsSMQotTW1vYBnnxyrM+g==
X-Google-Smtp-Source: AGHT+IGdVUaf4pBD42W20YHe00aWGcmfZKV0hXSGZklmrk0G311Uqs+R7SPltHcBgnxzac0WTgQQNQ==
X-Received: by 2002:a05:600c:5118:b0:405:1f8e:1b55 with SMTP id o24-20020a05600c511800b004051f8e1b55mr2768556wms.1.1695237651459;
        Wed, 20 Sep 2023 12:20:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:34a6:a1c2:97a:851d? ([2001:8b0:aba:5f3c:34a6:a1c2:97a:851d])
        by smtp.gmail.com with ESMTPSA id y21-20020a05600c20d500b00403c8dde953sm2728357wmm.22.2023.09.20.12.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:20:50 -0700 (PDT)
Message-ID: <3b9ec69856ec79e4ec9856d72395b3cbd36e58b2.camel@linuxfoundation.org>
Subject: Re: initial idea for hooks needed for source tracing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alberto Pianon <alberto@pianon.eu>
Cc: Bitbake Devel <bitbake-devel@lists.openembedded.org>, 'Carlo Piana'
	 <carlo@piana.eu>, Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 20 Sep 2023 20:20:50 +0100
In-Reply-To: <bfff73a5d575b2a62fb14782e71e9207@pianon.eu>
References: <7f5d05fe554d232c300b2604addc452a@pianon.eu>
	 <fa1abc9099171f8fb26c60fd29bc4dfd15376f8a.camel@linuxfoundation.org>
	 <517df01859172566e88a239658c601be@pianon.eu>
	 <bda639e462aa9f7bfd4a04e17d953e23b99ca2b0.camel@linuxfoundation.org>
	 <6d0c953729ea7602ee09cc9238513c1b@pianon.eu>
	 <8a899d6d88c1d493d48c3a495a9671b13df6a408.camel@linuxfoundation.org>
	 <15196a1c207f89bfc8894f155b05cbde@pianon.eu>
	 <97ecac758fd3b771e56e32e0a6c095d0900629a3.camel@linuxfoundation.org>
	 <bfff73a5d575b2a62fb14782e71e9207@pianon.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 19:21:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15095

On Wed, 2023-09-20 at 21:02 +0200, Alberto Pianon wrote:
> On 2023-09-20 20:39, Richard Purdie wrote:
>=20
> > > > Again, you'd get the git unpack events for this?
> > >=20
> > > This method passes git submodule's url, name, relative checkout path=
=20
> > > and
> > > revision to the tracer: where do you suggest to collect the same
> > > information? Should the tracer autonomously parse all .gitmodules=20
> > > files
> > > again and use git commands to reconstruct the same information?
> >=20
> > No, you shouldn't need to parse those. Isn't this information included
> > in the ud that is being passed to git unpack in the line immediately
> > below? That will be seen via the git unpack call the tracer will see?
> >=20
> > >=20
> > > >=20
> > > > >           Git.unpack(self, ud, destdir, d)
>=20
> Partly. The missing piece of information is the checkout path. If you=20
> search for
> 'modpath' in gitsm.py you see that that parameter is passed to multiple
> functions but never used (apart from module updates) nor stored anywhere
> (or am I missing something?)

"unpack path" is pretty much the thing you're having to instrument the
other fetchers for so if that is the only extra information being
logged in gitsm, that brings it into line with all the other fetchers
and we have a consistent API.

What worried me more was an unbalanced API where some fetchers had to
have extra special handling. If the tracer API is consistent with just
the unpack/checkout path needing logging/tracing, that is much clearer
and consistent and a sign the API is right.

> > >=20
> > > I can reduce internal module additions by externally
> > > recalculating/re-collecting npm/git module information, even if this
> > > will
> > > cause the same data/files to be processed twice.
> > > If you tell me, I'll do that :)
> > > Do you have any other solution in mind?
> >=20
> > I think you can get the data from the ud that gets passed into the
> > recursive calls. You shouldn't need to parse files, that isn't my
> > intent. I'm not convinced we need the fetcher specific hooks though,
> > probably just some basic state tracing in the tracer.
>=20
> I will try to use sessions for that, and I will tell you the results.
>=20
> The gitsm checkout dir issue remains, though.

Sounds good, I've commented on that above.

Cheers,

Richard

