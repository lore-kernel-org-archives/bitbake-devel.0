Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F78C021B3
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 17:35:56 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.29241.1740159352070379127
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Feb 2025 09:35:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cdm/HBzt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso16916125e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740159350; x=1740764150; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tzbnsdL6Q6YROVTgXfw3zOYVW+UPvrBST9CIiF345Fo=;
        b=cdm/HBztiBZGqnMy0gznK8sErPrTBPfATY9VrvT4vPJvPL2Zm5a72i8DFF1zVK3gqL
         gYc+h4Nix0BwuVgFomZUp//j+4rno8X/pLTawtqi/tqZdQEApOYSWp9Ia421Ond45Biw
         kY/Ukyi5qqGVa9LyDXI+O1PxhPd4i4T904F3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159350; x=1740764150;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzbnsdL6Q6YROVTgXfw3zOYVW+UPvrBST9CIiF345Fo=;
        b=nlXo5RqYX5ooShc7Hd26ux4+WycVheWaLlYbfJ0ak3dRzjEJolSfAS4DqAo6hwseuM
         NQskZEfbUtZe6sV8j8nfIAu1sgZtaC/yQhVm3ak3+GrJ6IMFSZOszuvPDrjdEGeVaWC/
         8pLTcmOa4EnXyvQU01G8O7AFy9M/iyz8duUDWba7iJ8rYZ6sJgJIESTQV+dOrpIB1bZ5
         ULK3dv8fa/HUspOe2iaUKKxrHi73eQ57bVm04vFpRL/sh0PMaptx1U9lmCOX2t2Yiwq5
         4tiE7wenfFbLHtPm3/BQhDohabUwrSnWtCDnL8qm+xUvRuD9CabtsyOEFr3ZX5jSuXrw
         0dyA==
X-Forwarded-Encrypted: i=1; AJvYcCWcYipgnOO/4nU9OsBVzKFpgI/mgwcFUzWNrLqTqu7mfQ2CFO6oim5mG933QAdEw/KrIHP+B9tnvgnWtcNE@lists.openembedded.org
X-Gm-Message-State: AOJu0Ywor9H8IgfJWhVxlEM1zixVYdbrla54eEq4AeN1+DWc/VsCTjnE
	QYXtIEPf0w6qHLgrCWfP0En9jGHWrBW0uKvFsTTp0osGUD5CE984ZrdGxI0Y0BU=
X-Gm-Gg: ASbGncufj9tzs2pYkIG0oDsnzL6/2LfZWp5lQtWt8YG01/UMuc4L9i7LSDgFRo+pOzC
	gc0WjHUbhoK6ZjU4ZJRuMGWO3qUCkRzMVv/rm+uzS57KIHWZ8uUEyWxt6gbBoo5f4pse6UOyJqA
	QZT6QL0Ozi3QmUVh8KHH2PI1OU96qwOGP5DIkW1IQaJAk0N7c3yMBt6wRAobxb/IUa0M2f1D+K1
	OVzeugu82lvuY9oagYJkSqQeqjs3uoJ/q3mUOOn+mrVqHNaq/9ryACZonJ+Rl08zZO2Mok9jwuh
	Ngunp3Bql2g5pLT7euklqKBZFuGFY0r4PjFpH73viOdV9RjJaX62oJAtV1DNywW9yrOxDia3L3g
	X19gN2i5E+nZYYoY=
X-Google-Smtp-Source: AGHT+IG6CHIOdzWrvDjYrl0tzm1KPfs4MUNygBtxkFXDiomAW907a+PNK0V3iiqoW1CMQJdquUEp0g==
X-Received: by 2002:a5d:64e5:0:b0:38d:e3fd:1990 with SMTP id ffacd0b85a97d-38f6e4b223bmr4156408f8f.0.1740159350357;
        Fri, 21 Feb 2025 09:35:50 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f9ef:7e20:7d31:1dea? ([2001:8b0:aba:5f3c:f9ef:7e20:7d31:1dea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5d8bsm23959451f8f.70.2025.02.21.09.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:35:49 -0800 (PST)
Message-ID: <dacf5517be51d32bb2de98b43e91f60c4b525cb5.camel@linuxfoundation.org>
Subject: Re: [PATCH v3 1/4] fetch2/git: Add support for fast initial shallow
 fetch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Koch, Stefan" <stefan-koch@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "Sudler, Simon" <simon.sudler@siemens.com>, "Kiszka, Jan"	
 <jan.kiszka@siemens.com>, "alex.kanavin@gmail.com" <alex.kanavin@gmail.com>
Date: Fri, 21 Feb 2025 17:35:48 +0000
In-Reply-To: <828c48b7b23582c488ea6a995f79899de1c29a5c.camel@siemens.com>
References: <20250220172706.3850722-1-stefan-koch@siemens.com>
		 <4b9fe64e0fd32de42dfa605be5e3e76b8dd01a58.camel@linuxfoundation.org>
		 <bad4317dc354af35db542247fd5c75071f20da85.camel@siemens.com>
		 <a7dd432e5603a8623a4d06628cc7c36a8eb0a40c.camel@linuxfoundation.org>
		 <63564006bb0c2045fb19d727e6c6c922f382d9e3.camel@siemens.com>
		 <9082e1118f69c59eafbdffd0d41fe118799a2edf.camel@linuxfoundation.org>
	 <828c48b7b23582c488ea6a995f79899de1c29a5c.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Feb 2025 17:35:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17291

On Fri, 2025-02-21 at 17:31 +0000, Koch, Stefan wrote:
> On Fri, 2025-02-21 at 17:22 +0000, Richard Purdie wrote:
> > On Fri, 2025-02-21 at 17:18 +0000, Koch, Stefan wrote:
> > > On Fri, 2025-02-21 at 17:11 +0000, Richard Purdie wrote:
> > >=20
> > >=20
> > > My current v4 implementation does it automatically in failure
> > > case.
> > > Because the disabled server side issue is possible at end users
> > > but
> > > not
> > > BB CI/CD (there only 20.04)
> >=20
> > Ok, automatic fallback sounds ok as long as it doesn't complicate
> > the
> > code too much. I'm not sure we want to have a variable for it
> > though,
> > I
> > don't like users needing to care about setting such things from a
> > usability standpoint.
>=20
> Sent already v4, but it would possible to
> a) make BB_GIT_SHALLOW_SKIP_FAST an undocumented feature

This is surprisingly hard to do since someone generally finds it and
assumes it is a bug in the documentation. There were a lot of these
filed just in the last week.

As soon as you list them somewhere, someone asks they be documented.

> b) only using ud.shallow_skip_fast for that internally (but is it
> possible to specify shallow_skip_fast=3D1 via SRC_URI?)
> c) using not `ud` at all

A parameter in the SRC_URI url could be a possibility but it also has
the same issue as a), people then will ask it be documented. People
also expect options to be tested and so on. I'm really torn on exposing
it at all for that reason...

I appreciate it sounds simple but I also see all these requests for
docs, testing and so on :/


Cheers,

Richard



