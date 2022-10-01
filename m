Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF6EC433F5
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 23:01:59 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web12.2710.1664665317713418735
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Oct 2022 16:01:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MSrPYZyJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id bk15so11842604wrb.13
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Oct 2022 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=/rkjDlKWzu8iz+DH0FtqitvniuQxp7d4GkssD737VZs=;
        b=MSrPYZyJqEUkt7jM/KQwT4eba21B0IATWGdE1tYP6e9wrH9ICOGiNs6PcpNtSDsJIo
         KJgQDLq2UfpD0PDxvQ5hR411ujlYNndwzpX+2HgpX3O0UUmm8Noopggq/tuyUvvQlO9u
         Fo9kAmmMZEcvOJ8jqDfP5ruvuQwFj5ARzd0zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/rkjDlKWzu8iz+DH0FtqitvniuQxp7d4GkssD737VZs=;
        b=DJI49F7cOdz6VUG+MD0VYxO/k/qGO4lFiZk9Ktk1R5hdJIsgokxeko+H9J/I+PaPLR
         0iMxbOlH5rsSPMBV6l4CISczTampk9DFHfbMKUbjZLAnJlfpAhpmE7Alv6+L5RkOP5bu
         wbBwvaK0WGbNeiMyHxSHS+nulpgBblJwGs4w8u7ZRkfcFrp4qAVJnsYNJVS1ux3WfR70
         U7z8ezRkkp33KU3NzP8L/RAtwo8CcVvSl0i41Z1SssHF4CV+AH9szfHErQF3zRXJjeSU
         pHeF7iJLdjKtGSiUmwVdLo4gsefb6iy4IQK8uw2KtMtRJr+qLn9ctG85b/jju/PlkReK
         LuBw==
X-Gm-Message-State: ACrzQf1ZEoUqQrR3Hm+2ynGfJz4OD2TQtesWdnmZMIolUE+RcoVWfCNO
	2ZeWmYD3csKPvIKbXzFTCqKj4g==
X-Google-Smtp-Source: 
 AMsMyM4mCdJuCrDjkMt202SWyp0rV+lOLrWZZZ0oy6++VKPPo3EMuc6XiREToZySt/3vEDyGUK6HzQ==
X-Received: by 2002:a05:6000:912:b0:229:9bc1:27ed with SMTP id
 bz18-20020a056000091200b002299bc127edmr9046897wrb.546.1664665315754;
        Sat, 01 Oct 2022 16:01:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1131:b96f:c56:50fa?
 ([2001:8b0:aba:5f3c:1131:b96f:c56:50fa])
        by smtp.gmail.com with ESMTPSA id
 bx27-20020a5d5b1b000000b0022e0fc4527bsm4309572wrb.67.2022.10.01.16.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 16:01:54 -0700 (PDT)
Message-ID: 
 <9cb6f8f622cfcc8a9fc68846acceb89734889ef2.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ross Burton <ross.burton@arm.com>, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: Nicholas Jackson <Nicholas.Jackson@zii.aero>,
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Sun, 02 Oct 2022 00:01:52 +0100
In-Reply-To: <EE055CF5-FB7C-436B-A526-3A05FE023513@arm.com>
References: 
	<BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
	 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <CANNYZj9ETtBH1mY3x3G2Fe4Fjyni7zkRMcA9UsYtpBcTznUQDg@mail.gmail.com>
	 <BYAPR12MB2710778AF2346FD1E8FAD51AF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <1719BDC7DCD0DABC.17026@lists.openembedded.org>
	 <CANNYZj95vsnNLd97LzL7ix=JC9HCReJo7VNa80EymiSRYNgRiQ@mail.gmail.com>
	 <BYAPR12MB27105A444B6963892070AE56F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
	 <CANNYZj9RuBP-btf5ATGx7pTqiP=-bzeHttY2GM=A9t+HQLo=5A@mail.gmail.com>
	 <EE055CF5-FB7C-436B-A526-3A05FE023513@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Oct 2022 23:01:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14011

On Sat, 2022-10-01 at 19:57 +0000, Ross Burton wrote:
> On 30 Sep 2022, at 22:36, Alexander Kanavin via
> lists.openembedded.org
> <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
> >=20
> > Thanks, I've reproduced this too using plain python3 and .netrc
> > with tweaked permissions (e.g. run python as regular user, set
> > .netrc ownership to root). I am not sure why fetching sstate items
> > happens under pseudo, or whether the fix is correct, but the issue
> > is real.
>=20
> My hunch response would be that setscene tasks shouldn=E2=80=99t be faker=
oot


Since the setscene tasks replicate things like do_package whch need to
preserve fileownership, they very much need fakeroot.

> or at least the fetch should drop that power.

The fetcher does run commands with PSEUDO_DISABLED=3D1 set, the issue is
that we're using library functions here. I'm not sure we can drop the
power within a library funciton call so easily.

Cheers,

Richard




