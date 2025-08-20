Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E69CA0EF8
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 22:34:05 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.2715.1755729236744862427
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Aug 2025 15:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ax2EUbsd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso264454f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 15:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755729235; x=1756334035; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9RLhp7apUyPp8DEn3g0hq2Y8K9RlA+0EqTRhGGxhPos=;
        b=ax2EUbsdMJGrER+k6RR5BzlyDCU/5NjDL/lKe6S9txMgeZE0Q3PlBHast9CMpdcz96
         O5WdF6IcFwBJRxFEd8FbfDkJghbsVdRRt8mO8yF5K3uJvgKSysZr2FDkpcaFbj3vagOd
         UdYJH7dTwzOkAfev5gvysYc8LaSjlXxEd+UXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755729235; x=1756334035;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9RLhp7apUyPp8DEn3g0hq2Y8K9RlA+0EqTRhGGxhPos=;
        b=HDVR/OLlAFYmkbJbt94MEfDVKN7ZwnlYBnXdwnIJZFTpAzBMjLZxOeDH/x9CMaB3NU
         thirV7llMh7JbYKmwFE/dZeFudjwYgU4Qmp/RDdSi6o86Knu69Bn2RfaoBhQO7m+6TcK
         cKESR0WynUdKPycwLtPMOxV8cI5/650czdkpDzwCn9yE7FLjd/e2TQ8RZ8vuRoM7pjO2
         1xs96ivqlF4Sj4oXeRA8g/WJlWZl1P+u4vi9ElBUd2k8b3iVhSGZ7gt1Tx7+mPw6mfm5
         qUoZtcVNMrhqUAoFccPij5v5QKipFlo521E5pN6yGEc8KGnphvSnD6zqPdKETSYQvotw
         1tYA==
X-Gm-Message-State: AOJu0YwJW/JDpNR+ouZVzHVhKmhYJ5V5s77B4ejRu0Qdd/+EwjnGQJGB
	ErDnUktA3yCXJVzxsw75U9bWQkOo+w2wolUVjHjG8lGJYnLhuwiB3PZYMoCKBqIPNPU=
X-Gm-Gg: ASbGncvxJHqD9Dln2WGydW2CuIpzf+VIsM/Mqio2c0/gSnmt0t9e08ziOH2zxY/lchf
	XDZXXHNZqxLwAKp/R07lHrzen94t+Wv7W7+ftDSsd2H3SQ9lTPib5jgFWPVreTGmLIUOWZk6f45
	hyBSs/a8/4nZnKps8PvHL6/Cr5L1qbcRmM2FdW0TugdSmX9436Do6h70E7vRMvwTms6yzgXlBts
	cGgbZ+Xb9/UDovhx6JylE/M7RJ6irjXTrIOFFcAJ5fwvujfbHFyjyz8jgQmD2Cfkf7bs5RruULz
	DQcEc74aH+yBsU9LRxNDn6jKV5L5iXoaL9XSTK/5R3rx7Kx5uRcaP1pD+oVKS/zoNnINJJrAJUE
	u4PIi1YbCqUlo+rYbGXQy6CKOiqwDCJ0hjUhRIqXs42HcrjkoJt/MBUC6aukTtUospynyK16EII
	DLtjJNLGeozG0=
X-Google-Smtp-Source: AGHT+IEfzCzAgyk1QHJ14ErG/Uxl+JO3EYOJ56RnhSaVQxiCGtTNz41ycpVIrGG2LBxhjUzpRIGT4g==
X-Received: by 2002:a05:6000:2883:b0:3b8:f864:9a19 with SMTP id ffacd0b85a97d-3c4b0826d4bmr93024f8f.22.1755729235119;
        Wed, 20 Aug 2025 15:33:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2407:63e0:8092:e22c? ([2001:8b0:aba:5f3c:2407:63e0:8092:e22c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db6b4e2sm1066945e9.18.2025.08.20.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:33:54 -0700 (PDT)
Message-ID: <3216445584018ee9b8f2b49ff5554624a69c604b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial
 implementation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Scott Murray <scott.murray@konsulko.com>, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Tim Orling
 <tim.orling@konsulko.com>
Date: Wed, 20 Aug 2025 23:33:53 +0100
In-Reply-To: <8db52408-8867-0b10-bc23-114ea02bdd66@konsulko.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
	 <9b00442e9c0eed12c491b98704bc34fd9f78c48b.camel@linuxfoundation.org>
	 <CANNYZj_1k7_pzh3wkn53aVGM1+ioDsqmAGTYgr7AwswYv2pQMw@mail.gmail.com>
	 <0a06fda681c8b5d94cbccc000e661451c1c49251.camel@linuxfoundation.org>
	 <6e562ea3-ea7e-7e27-54ef-5fabc05888b5@konsulko.com>
	 <CANNYZj8y-VCKnzUD2OLihbt4KtYPqdBK4zE3-5mQE84844fYjw@mail.gmail.com>
	 <647b238c-cf12-eb7b-d243-038854180192@konsulko.com>
	 <CANNYZj_RWrJxXx6+WZ_px_EWOd9+Wr1TgUEHgGg3rspY5wEECw@mail.gmail.com>
	 <8db52408-8867-0b10-bc23-114ea02bdd66@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Aug 2025 22:34:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17900

On Wed, 2025-08-20 at 16:49 -0400, Scott Murray wrote:
> On Wed, 20 Aug 2025, Alexander Kanavin wrote:
>=20
> > On Wed, 20 Aug 2025 at 22:15, Scott Murray <scott.murray@konsulko.com> =
wrote:
> > > Sure, but my point is that's what I'll be doing every time I set up
> > > any project (and maybe reconfiguring it?), so effectively for me the
> > > default behavior is not useful.=C2=A0 I doubt I am alone in doing all=
 my
> > > development work on a different disk than where /home is on my dev
> > > and build machines.
> >=20
> > Then there's the option of setting BITBAKE_SETUP_TOP_DIR in environment=
.
>=20
> I'll not bother pressing this further since you seem set on the current
> design, but my original concern that I pointed out was that I'll always
> having to configure that, and likely document doing the need to do so for
> users of any project I may want to use bitbake-setup for.=C2=A0 The defau=
lt
> behaviors of other tools in this space do not require that.

You'd always have to configure it because you want no external
interference in builds even if that was limited to sstate/sstate
mirrors/dl_dir? Or you don't believe dl_dir/sstate can be shared
between builds/projects?

I do understand your point but I also suspect there is some level of
common user setting we should start trying to take account of. If that
means adding some sanity check mechanism to only allow certain
variables from site.conf, that is something we can look at.

Cheers,

Richard

