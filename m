Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02672CCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 12:15:47 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.16477.1760962537895549141
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Oct 2025 05:15:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RqKxROUz;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87a092251eeso98725376d6.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Oct 2025 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760962537; x=1761567337; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+DV4vmk/RHKnmtsRh/NsZ4IoUEjGfxJRORMCtNjbds=;
        b=RqKxROUzfEuWWpPe0zfaEXOUeO1Rmfd924SSYbbPl+PQAmX0vrxKzbzJ2tfk+sg84i
         Muk6VkC4d3zyqqYWY6Uw55jlTStBx+2OXdpmPAHQbPAlyUbQKmUbQGpPa65sSyHW+hli
         BPWgLcm+R0rXfYCsYqukV89RhK4JmusPb8LuegLpZ/vbV0rbEUpNoqcAJltAjtk3wUpi
         pJUiGSKED97htQ2Rac/gXWQv5YCFqpfmH+rfzxYNSfgGgdgbisFe0nh3ictr9l6RWHyT
         CTI7tVmD39GzpyK3QpxJsARF+ysKL6XApKKX1Bex726+Kv67BN2eE6Qwko90wMRq3bKx
         UWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962537; x=1761567337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+DV4vmk/RHKnmtsRh/NsZ4IoUEjGfxJRORMCtNjbds=;
        b=G54R1plN+KAmwKTe4w58ZZKkw4F7TUkagU8CNoLMAiPH0GtwK1cIrOAEkVahaLuRpo
         WEhf/IBfkIWx9jHTqWsLDmcY0Xhkf1AxhU+HMP/Sa2nZHLjWO1zcz/L2dTrPpptcUH73
         Ss45Xroq4Vh1eSpeS60jXtO01Ca7a2oDB61hDbBaZlXysPBVL7sfPrF0dcfhoVA4VQLT
         /kpknBeuaBLoq76Hgc9UoKxV0l2M3eCGj9NxrPVWUcNnG2mVuAywAgsWQijJBqQeyr+p
         AIwBljUR56VwpWeqYDPogMw4HlaUgoIY5FDqyaxT7Z+JwjJul06zG/utLYXcjQ5eXxJV
         WPwg==
X-Gm-Message-State: AOJu0Ywy2NqRfcZeWUTJHBT8Hg96uuqtPQK473gqIRSbukcj88s944f2
	s5Th/mtdWOemWoc/VLgdPaLxvfLDFNZeYbKdp7jk3Ysd3MOcIDe7Z86C20VIY2j4u3mrOGYdo4k
	WmhHCN+DszVZ1LNjGWM6DA14c2Yu9mRs=
X-Gm-Gg: ASbGncv9dlsA7I+B0cRvyAMoisd0Vvqjj0CGMemGBpd/N9TDnleuKcYFaQoS+RsJi/9
	OLxzjYE82MmaqE8rXf9OcVWJ7c5Vd2hL6jj04N+2Fqzp0hgnVHeVAPUqVPyOs3Re+A7qMVVnU8x
	A1PVcICkeaFAri3mXU8m9C0D+PJEc92G4DZi9HstUBWVfYrbKaUnpC0JOUEqD//15EU8jXQJJlz
	sUBdIjkAwKzXRAQZ+/L+Q10dMmZvD+ARpTKWBiO7RxMfLYnoKqxc+0oNksCuNeSzRT1ihoJtIFN
	2xboQDVpJgUHAwAruh/w7joYoPLSG6eIOlM7AOg8oR4sl2PKNxvgeRYm0OFNGqINJ1uZI4rHPky
	whCNhe4d77Yilr0P7qOvGuZJwPSjY
X-Google-Smtp-Source: AGHT+IGKWpAKXpG63HUQefuJsi+YKgcoVGTk0pXbBsTUIIS9tw+Lb3w5fqVIYSRgfl3w2zPrrpqEBiOImSmvOusoTwA=
X-Received: by 2002:ac8:5f93:0:b0:4d3:7e:d6ca with SMTP id d75a77b69052e-4e890e04180mr210428881cf.17.1760962536698;
 Mon, 20 Oct 2025 05:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251017231444.374436-1-yoann.congal@smile.fr> <CAMSfU+7miM_1uRnh8X0w1QP+gbrL-M+a==h0=sG=EYxYZfiPkA@mail.gmail.com>
In-Reply-To: <CAMSfU+7miM_1uRnh8X0w1QP+gbrL-M+a==h0=sG=EYxYZfiPkA@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 20 Oct 2025 14:15:25 +0200
X-Gm-Features: AS18NWBkvCuuGM8cDis-pvW-VkgDiKdncczRcNQNLHoMBGJxn-G_st2INLcN2LA
Message-ID: <CANNYZj_3xbjhVessD0=zK9E3cfhMPkwaRM92wk0sg1KOm=CUJg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 0/5] Bitbake-setup configuration schema
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Oct 2025 12:15:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18196

On Sun, 19 Oct 2025 at 23:06, Yoann Congal via lists.openembedded.org
<yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
>
> Le sam. 18 oct. 2025 =C3=A0 01:15, Yoann Congal <yoann.congal@smile.fr> a=
 =C3=A9crit :
>>
>> This series focuses on adding a JSON-schema for the bitbake-setup
>> configuration format. I still have some doubt about how strict I should
>> make the schema (hence this RFC).
>>
>> Also I tested by adding a validation step to the bitbake-setup
>> selftest but it has non-stdlib dependcies (also a RFC about how to
>> handle that).
>
>
> Mathieu tested this on AB (thanks!), as expected, it failed on "ModuleNot=
FoundError: No module named 'jsonschema'" [0]
>
> Thinking about it, a less intrusive test could be to reproduce the layers=
 schema test [1]: building the jsonschema dependency with OE-Core and use i=
t to validate the schema & default-registry.
> But, this approach has one drawback : it can not be used to validate the =
configs used inside bitbake-setup selftests (which can't depend on oe-core)=
. And IMHO, this is where the new config elements will appear.
>
> Finally, given where we are in the release cycle, "less intrusive" is key=
. So, I think I will send a patch series with this and go from there.
>
> [0]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/2=
576/steps/12/logs/stdio
> [1]: https://git.yoctoproject.org/poky/tree/meta/lib/oeqa/selftest/cases/=
bblayers.py

Thanks for working on this. I'd suggest you simply extend the
oe-selftest (and the schema file!) already in core, where a rich
testing environment can be much more easily provided. Just validate
the existing standard config files in bitbake repo for a start.

One change to bitbake repo itself is that the config used by
bitbake-selftest could be in a separate file, rather than embedded in
the test itself, and then that could be validated too.

Alex

