Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EBDFF5139
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 19:58:23 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.90752.1775591896260228761
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 12:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CKI2OZoN;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d0deb7ad5so4860871f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775591895; x=1776196695; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=51MKlCBpHHn1EE7XfrQiTKHCwS1qbEpVvEcYbIdPJoo=;
        b=CKI2OZoNvLcnXz1g5MGl7e/w9BTUbZwo5XlBAcer6N03YzE+D7QYGKRQpj5jgVTKVp
         vGkuf3wK73egHXmIM843CR/RXaNJkOlM+5YXsi0bS6LthO9H8RQFOSuT8ozAGIPAvi2M
         kvDakdXhGNbVHLkibN7jW/ERgdNbSpfzIv7uwY6M3AjEJ6T63HrNjL9eTCSxxlxvTUNs
         zZvVV6ivGq42OdQNKu6Fe4m1w/l8IW487LoToW+Ez0keKnKcHr8SLeXxDWoefxroiz1a
         mU/np2EyRPDG4sDJv/DEo8o+kfUz71B03qhTVTgsAlqSkv+CKMEvnL11b7jGAWcKOVBy
         skGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775591895; x=1776196695;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51MKlCBpHHn1EE7XfrQiTKHCwS1qbEpVvEcYbIdPJoo=;
        b=BaaqgxgH2G0Xu4BM7Cm8pDW2qswtX/qQYSOhT7EQ3ppcphH1vETi45zZvXUdUA1My+
         uRgO9gkbc/WiREgMro7zztUAGooe7jCCfXqvy3EeHZ/LwCYrj8rJizga0qRj7SM7aSPF
         tq+QwRDJQUw4nlX9mt4bpWHPGUkiC7djkP6cH/zI2wdB4SR17QxhQpvZMz0yT1AJdv/d
         vwpuYiVZT/NQG8pTvBm6UZ8DDfPo4LRN0zuF2qCxqDogy/buY5sjipKazNC4cTgH3HJ7
         ZqXSTrVR9XzXGKLAzJamnSIlUkxk9vmBmyDqW0f+A85UqV2GqjgIDSh+vtnw4KkXheSJ
         PI7Q==
X-Gm-Message-State: AOJu0YxaMTFXZNA7pMMMz6vWFbFZRXCB0gcLzUZg5ddjG4it+rkdmWbY
	6ciqXP4Q9zkDNJ0ie2wIDtvRLzqUad539edE3YRplHDukjXFOCH/eMAH
X-Gm-Gg: AeBDiesYSvxQGmxSSoLi5CIvGw10JnAJq84OZBKZHxawagVkqC3hZbKfBajmqIuL2sw
	pGI9KeEZ0wHUUv+jXEvHm5nEpN3yU6iUzhhSCJDmA4MDyAZrpSHFKnPaRjMG2GbiSH4LuqWtG+9
	BQBGndylEXqmVYprr6QFQF7qyKqlWgLTLFAk9wHpHErysNjLbr8LZQrmwIrW4rCF3rewkiHC2Wb
	AxMQXuHHom3MzfiC9DU/fDL4KUFNXcngkeDwhu3SF5ASIt/uGwgWb2wJETgdnof02Mqu/kfBeTu
	3iSu7H0eyulxEAooTl4ppaHnIeS4X6uPiDQ8eiPoU3xLTNm82GhGEO+K5nbktGBe7Qb0n5SgAIn
	cP4ONTO8agVvknDH/5x+MGZ+Zv0Wi4dUcfPVmMElv0vh6LnyS3sdfUEXtiDZKARekKtsrsqqBac
	Gfew7ubou0O0OQjuGIwSGlHl5Hvyqtbwboq8kItqs7Cl7bjnPlxdQLyz4cFGc3rCsFrZUTkB7s
X-Received: by 2002:a05:6000:208a:b0:43b:9c73:2933 with SMTP id ffacd0b85a97d-43d2927f938mr23861083f8f.15.1775591894390;
        Tue, 07 Apr 2026 12:58:14 -0700 (PDT)
Received: from ?IPv6:2a02:169:59a6:0:55c4:f628:91f3:4287? ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c54bdsm53614172f8f.16.2026.04.07.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 12:58:13 -0700 (PDT)
Message-ID: <6d97488e80b23b08ce5bea25650891f07ff2a9a1.camel@gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: update vscode
 workspace always
From: adrian.freihofer@gmail.com
To: alex.kanavin@gmail.com, adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Date: Tue, 07 Apr 2026 21:58:12 +0200
In-Reply-To: <CANNYZj-K5KWN9Z9CDZnQyU34bVT+8rkH0uEcfg=FXeOWfm9XHw@mail.gmail.com>
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com>
	 <20260406202430.1856836-2-adrian.freihofer@siemens.com>
	 <CANNYZj-K5KWN9Z9CDZnQyU34bVT+8rkH0uEcfg=FXeOWfm9XHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 19:58:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19353

On Tue, 2026-04-07 at 20:30 +0200, Alexander Kanavin via
lists.openembedded.org wrote:
> On Mon, 6 Apr 2026 at 22:24, Adrian Freihofer via
> lists.openembedded.org
> <adrian.freihofer=3Dsiemens.com@lists.openembedded.org> wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0 logger.plain("\nConfiguration in {} has not
> > changed.".format(setupdir))
> > +=C2=A0=C2=A0=C2=A0 if update:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 workspace_file =3D os.path.=
join(setupdir, "bitbake.code-
> > workspace")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if os.path.exists(workspace=
_file):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bit=
bake_builddir =3D os.path.join(setupdir, "build")
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 con=
figure_vscode(setupdir, layerdir, bitbake_builddir,
> > os.path.join(bitbake_builddir, "init-build-env"))
>=20
> Will this do the update quietly or inform the user that vscode
> workspace is being synced with local changes even though no
> configuration updates have been detected?

The configure_vscode function preserves user-customized VSCode
configurations and it enforces essential settings required for proper
functionality.=C2=A0That means, executing configure_vscode should not harm
and hence it should be fine to just run it always (when "which code" is
true).

Having this as a separate command looks like more complicated for the
user. Expecting that the user always does something like

  bitbake-setup update
  bitbake-setup update-vscode-workspace

would be inconvenient. Most probably the user would just not run the
second command and end up with an inconsistent environment which can be
very annoying.

Or do you mean a separate command in addition to calling the
configure_vscode function in init and update? That would then lead to
the question when the user should run bitbake-setup update-vscode-
workspace. After init? After update? Or just if update does nothing but
the VSCode configuration needs an update?
Having only bitbake-setup update to update what ever might needs an
update, looks at least simple to me. But I agree, a separate command
could work as well.

Maybe this patch is not very important if bitbake-setup itself does not
change anymore. Might be that I thought this should be improved when
working on bitbake-setup itself, which is a very special use case.

Thanks for the quick feedback
Adrian

>=20
> Perhaps this should be its own command rather, something like
> 'update-vscode-workspace' ?
>=20
> Alex
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19351):
> https://lists.openembedded.org/g/bitbake-devel/message/19351
> Mute This Topic: https://lists.openembedded.org/mt/118697281/4454582
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:
> https://lists.openembedded.org/g/bitbake-devel/unsub=C2=A0[adrian.freihof=
er@gmail.com
> ]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

