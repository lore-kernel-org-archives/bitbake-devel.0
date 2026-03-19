Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281111091933
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 23:55:57 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2093.1773964552951411653
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 16:55:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AS1XwYHF;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4856cd3f1ffso15176305e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 16:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773964551; x=1774569351; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0tQWubwewT0767LUz29rRtJJc0XXxyx/cNAl5z2HsZ0=;
        b=AS1XwYHFCxzioY4JemB5hQlXLa0wOs8FzSlb2Wq/HAH5b2fdA2FuM+fJa/a8JwgfDq
         RBGBku3gCx7Piyp4RjY0KdJ9tA2zZyTK2Ipi+LbJ8vHaZwNPUJYsFiTBXcSAjeOhDLND
         8YFu7APmRXvgM8jHBpY9U+SiUCdDI9sB2UqMdwJuqnArx8DCm6QjREjMmwktkkDcEL/x
         0xDQLd9aRe6K+6UPcb2fJhZ9T6+wHMvCo+fmfndwMDilNn9T6l5Ww607DEyfjH5xhDm1
         /SZoadv7x+S7v6HOsTEBGSr9B1o81GTwpPeW9LsqwWfIUiqW8MkCULm5UDs2vwEFpxQK
         v3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964551; x=1774569351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tQWubwewT0767LUz29rRtJJc0XXxyx/cNAl5z2HsZ0=;
        b=YXzm2GFxu677c4KhJKg2gB8/QV3AQ9AiWwIXBYi/udmnji2hV+cGSPIdQ7pNWUU0Sp
         tMczfeyGbTrlSLWPSdVnX9LoOxHDjatZ1doNiD+zipsbsEKlgAB+pp1EqrZLQJgxBQ+B
         ahu7QavDRofaaMVDm6OfdlkrQYS+rfQBI/F+8XZpqQD+Kq8s5X3zkGsbHWsYsAOA+oTc
         vM853Fp72bcE45UyMia9Ip9utL/g45QeiWY9jIIOHmfyZNu3+v/ZTCT4RnlbzD7EBZNV
         YNmUDC/xLm3qDc/wQsf/dcE4zDSz6KVcai6u/DgB/njp59Ibyrjcr5Llx0WuO7aIjlcx
         aWQQ==
X-Gm-Message-State: AOJu0YxkSBIDhirW7qHwp5rwB1/V/UjqI58z4Z5ffIp5ssQvmEOBWVkJ
	eJfSuLHCYk/RdVVWoJpQkru4Oz1+fRKZx38f5TDWpyKgwLAHJHmTo3YQ+Uacsw==
X-Gm-Gg: ATEYQzzAKRqqqhup8z01YOBEg0hzVqEJAX38t+3+e80vujWgbFDh8qcdNaG4n7dpwck
	LIJGDNQyXyL9gAyHkiuHS5swKFMS0YXA8kXKU14mD2j0pcSHJJykgXU5SqzY/0a4efA2ufQcNLA
	03lz18jhaIX5qrxVy6CCwyGRMf1WnyiREU2gZgowptBHJZV7kCZJOHFZIv1m91MjTnNrV6VcaHO
	u5di+hovNaNF9ogHJ7tAm9AwrUClyAclwWpzqYgwfA30MApoZD9ap2S6d/CnaTzgFAttZVIfkVR
	vtgPnprdcRLSgwGQoDC8L2SSSp779RRzFMR/nGwdfveA36vW5W3EamSZJtNqL0NmMjRsWl6D2KS
	ReGjGammqjuZgYTcLt2/sXj0VOZn64v3AoIAFuwQhOk1wiJU+Gv5yS6xN4AuylHs91eT4/2AxW7
	hO8/+5eGbdFcQ28n3h8J0M857ROvvAzKotuf6TsnOQ+LZQGG8NfbpSTfMQK08UMDrsBSQi7Wch
X-Received: by 2002:a05:600c:c167:b0:486:fb5c:3b20 with SMTP id 5b1f17b1804b1-486fedc39e5mr14937245e9.13.1773964551013;
        Thu, 19 Mar 2026 16:55:51 -0700 (PDT)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1561b8sm6592005e9.1.2026.03.19.16.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 16:55:50 -0700 (PDT)
Message-ID: <10dc9e4874cf39b81d8b749793c8bb9044140ae9.camel@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode
 to the fetchers (git only for now)
From: adrian.freihofer@gmail.com
To: richard.purdie@linuxfoundation.org, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Adrian Freihofer
	 <adrian.freihofer@siemens.com>
Date: Fri, 20 Mar 2026 00:55:50 +0100
In-Reply-To: <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org>
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
		 <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
		 <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com>
	 <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 23:55:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19178

On Thu, 2026-03-19 at 22:02 +0000, Richard Purdie via
lists.openembedded.org wrote:
> On Thu, 2026-03-19 at 22:24 +0100, Alexander Kanavin wrote:
> > On Thu, 19 Mar 2026 at 22:05, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > There is a bit of a debate on this line between Adrian and
> > > myself.
> > > Should we use:
> > >=20
> > > git status --porcelain
> > >=20
> > > or
> > >=20
> > > git status --untracked-files=3Dno --porcelain
> > >=20
> > > ?
> > >=20
> > > The difference is untracked files. The rebase will abort if an
> > > untracked file is changed by the changes involved in the rebase
> > > so it
> > > will allow untracked files to be untouched and should be safe.
> > >=20
> > > I had thought we should exercise caution but perhaps that is
> > > ok...
> > >=20
> > > Any other opinions?
> >=20
> > Yes, actually :) The bitbake-setup patch I posted pre-empts this
> > check
> > entirely, by first stashing away everything uncommitted, including
> > untracked files, with a warning to the user. I want to minimize
> > various aborts and errors on updates which will cause them to
> > half-complete and leave the checkouts in an inconsistent state. I'd
> > rather stash it, make that clear, and have the user handle the
> > un-stashing and any needed conflict resolution after the fact.
>=20
> I was looking at your patch and I'm not 100% convinced about this.
> Personally, if I have things lying around the tree I've forgotten
> about, I'd prefer it to just error out and make me fix it, then allow
> the rebase to happen.
>=20
> Stashing it make it "disappear" and would probably confuse me more if
> I
> miss the message about it doing that...
>=20

Here is my branch which tries to solve this (with --untracked-files=3Dno
so far):
https://git.openembedded.org/bitbake-contrib/log/?h=3Dadrianf/bitbake-setup=
-init-vscode

I guess the rebase with untracked files should be properly handled and
tested on the git fetcher level already.

Handling corner cases for bb.fetch2.UnpackError at the bitbake-setup
level is complex, and accidental file deletion remains a concern.
However, we should pursue an implementation that supports automatic
rebasing with untracked files, which are commonplace. Backup-based
approaches are cumbersome and should be a last resort.

I tried to achieve this by adding many test cases, at least.

Regards,
Adrian


> Cheers,
>=20
> Richard
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19177):
> https://lists.openembedded.org/g/bitbake-devel/message/19177
> Mute This Topic: https://lists.openembedded.org/mt/118398869/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

