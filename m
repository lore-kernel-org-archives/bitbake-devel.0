Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE639108B90F
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:02:59 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10967.1774008176638796586
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 05:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=J/KCOfK1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.181, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so18932211fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774008175; x=1774612975; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mRlf+gLpy+GbTQOEjAJkPHj3tipsEaYLEjuMwkolB/k=;
        b=J/KCOfK1NN5kTAJIZ5QKYW0mQo1LdFlfFGq5jmzhaVvmFyIVjvv4ABMtopbztAYdqC
         hBhCucIj5eH6wGkCmMCGekoazP4qpzjT2j8+lepaSmuPF49Yii17nXpZq6EhZLP0dSOi
         eJKgWSSnqves0riU9Z2LPBf329MO5tGF+iW1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008175; x=1774612975;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRlf+gLpy+GbTQOEjAJkPHj3tipsEaYLEjuMwkolB/k=;
        b=SxQKtbayeqacI6auFztL9ts+/rJpE66bZXxWpzWkkvsCtqKLDi8hhm4iZX6GUnse0P
         Db8yVNaKMcw1Go2Fd+vyxiSlhTQKw443cL6Ck005Sgw3o5hE+gdm+7e3QegMAqGaWDi4
         vwFGP93FsoeBt/n7Lkg1c/mVYg/1d99SFYiYzuvlh+ulXzfmUleSzLtoM7mREA/deonS
         Ac6CuqDpRq7uOMqONCiJnUj66Y6Qw+5kXBMn9Zwz9H0dXxtRf+crQKdPLDHOsMoxWKd6
         ElHA20CCsU6DvPBzmVClx9OTg/punazn+B2exH8Q5PcgCSBOGrUsQ7iv2WtADC0B9PGP
         u9CA==
X-Gm-Message-State: AOJu0Ywo+XnyC2HiTA2hCibdW+X7EJ6Gp8qpFe6JbNnou7kdGKo5wO5f
	TsJz/HrjmzhXrNuyNpUA3AhA0dnzOpnMKKNnhtva0Ca4thBo8fICnbxZhoFrwo7WxY8=
X-Gm-Gg: ATEYQzwJmr7TEQUegDxF2hD5Esbc+mKsf9xPZPk1U+sibUXWcTi1NPlmfyjxmhMGFCi
	qfPu40i6Qx0jSaxODzuAZdNKAkKA2N0od2gfBDWtl17ZjxT/m9CYZLhlnSugsGRJVgFSBchSXCp
	CWr5dCQ+JQDMGDX6EGSCmRbYkUDOulQwfI7JMgRTdNFWXzB5TV37+KGbbxN9c1FToDA66gO0OGT
	KGAIWi7TxSyenSq4yVcRMUCyA+hfDhw745BT0uKlrda5Z0zSjN9UwMhkAdGPHunr4SeG09pvoqW
	t8lvJGiCBN8mZs/czRGbgWMMCeWDNCX7Q/yhHnwa+htuopthV/HXnWW7erHl+eh/um2FNd78CmF
	ScSxSFSpXJZYXUSjlsWTBzd+231v9Osixd682ZLKluut3Wq4Uz2CMkrT8nN/yFQQ1+uE8lD7SFz
	AFdIjg/PXseU8Oe4Wcl6L7TP8acg8NL11ix1DXMkGYlgYDKY5/WD5p4WPivHaZX9vQk/8V4PAn3
	aBl2l4cJwPx39GT
X-Received: by 2002:a05:651c:409a:b0:387:98:f2b4 with SMTP id 38308e7fff4ca-38bf962b834mr6336261fa.11.1774008173684;
        Fri, 20 Mar 2026 05:02:53 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:72df:cb96:568c:f7d8? ([2001:8b0:aba:5f3c:72df:cb96:568c:f7d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm6632327f8f.8.2026.03.20.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:02:52 -0700 (PDT)
Message-ID: <6aae56ff64f2f836d4647d6cd3957268abbc30b7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode
 to the fetchers (git only for now)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>, adrian.freihofer@gmail.com
Cc: bitbake-devel@lists.openembedded.org, Adrian Freihofer
	 <adrian.freihofer@siemens.com>
Date: Fri, 20 Mar 2026 12:02:52 +0000
In-Reply-To: <CANNYZj_FgKB8jnmdDBwPiWC1bQ_jS5nx8o5nJ5nQko6C3JsRjA@mail.gmail.com>
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
	 <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
	 <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com>
	 <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org>
	 <10dc9e4874cf39b81d8b749793c8bb9044140ae9.camel@gmail.com>
	 <CANNYZj_FgKB8jnmdDBwPiWC1bQ_jS5nx8o5nJ5nQko6C3JsRjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 12:02:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19190

On Fri, 2026-03-20 at 12:47 +0100, Alexander Kanavin wrote:
> On Fri, 20 Mar 2026 at 00:55, <adrian.freihofer@gmail.com> wrote:
> > Here is my branch which tries to solve this (with --untracked-
> > files=3Dno
> > so far):
> > https://git.openembedded.org/bitbake-contrib/log/?h=3Dadrianf/bitbake-s=
etup-init-vscode
> >=20
> > I guess the rebase with untracked files should be properly handled
> > and
> > tested on the git fetcher level already.
> >=20
> > Handling corner cases for bb.fetch2.UnpackError at the bitbake-
> > setup
> > level is complex, and accidental file deletion remains a concern.
> > However, we should pursue an implementation that supports automatic
> > rebasing with untracked files, which are commonplace. Backup-based
> > approaches are cumbersome and should be a last resort.
> >=20
> > I tried to achieve this by adding many test cases, at least.
>=20
> The additional test cases are very useful but we should tread
> carefully with adding bitbake-setup update logic (e.g. in your
> patchset it first tries non-destrictuive unpack, then in case of
> fetcher errors falls back to backup+clean unpack, not giving users a
> chance to resolve conflicts - I am not sure users are going to like
> that).
>=20
> Let's first not try to handle UnpackErrors at all, and implement
> simple support for unpack_update(). Users would resolve the conflicts
> and run bitbake-setup update again.

I think this is the best approach. Users are going to want to know
about conflicts and will usually have an idea of how they want to
resolve them. The point of this update mechanism is to make it easy for
the user to pull in changes but allow them to have local changes too,
since most of us will end up doing that, I know I do...

Cheers,

Richard

