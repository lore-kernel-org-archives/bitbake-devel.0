Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5650CA0FED
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 10:20:10 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.14126.1757499605604463563
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 03:20:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XeZVePfb;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70dfa0a9701so74540896d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757499605; x=1758104405; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MbbSeEH68OHgUooKT5a3KeCqzAsOGhRfss2l9FHEa+Q=;
        b=XeZVePfbx3MBbjSwd+qalBuvG5OLrLyoBGTfjjKZ350MfnrJaBn3drCTQwhfIaEOHX
         P4tqA0fPHzOy+W5dkhpTeMsvKxryZaqj25kUikjfIlONdI1N2NQ8oD3cLOPnqPv5NRIU
         MizAA3yfCio4PKBWlE0I+7ul/xtQT0ycF/CazSlqZe2r7vFEyRD8uqsUKw0FpxB7AN/o
         zaULEpayMGfhivITehWbphnPHRYaINUvEwqxtgTarNC7YrC7zrY7V/WWJgbkvpBORGD6
         YnwpSXI6+IT32ozkbRIMZoc7lPrcB1vkylU/MZNyevfLoHEVNQ59R3QKwgN7tu8yiByc
         wwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499605; x=1758104405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbbSeEH68OHgUooKT5a3KeCqzAsOGhRfss2l9FHEa+Q=;
        b=ofMt2Hylo8SEKBFMthwAEVIuVhP0BdOkDJEJdHYjVAwg8e23BXJv77iIy7wtiwVP9Q
         J90ghFNJw33SPEdRVfZgQ8h3BpaLQDjwapf0hMpW4+0xd7AZJvL7b6lxq/+TEy9AtyfU
         MLzVxHBFHczILElum67M2tyMowMPNvzs3q0JKl3+/PyJR7MbwJ8QY5Fycy+oz28axFCj
         CCtfb8p4bCeZbYYCTlfzkMBCgA86GOxQ2E6EXQuKXOcFMgl3WFqv2WZ/5y7rkH2Sp0xj
         xd+yfun4qtwYbamYetL4s0suKXXJDXbFnBJkqN9alyJbHiV8ostmJy8KLYn7C498iQjj
         EkxA==
X-Gm-Message-State: AOJu0YxsuApYA+tW9r9edajip1HcHudZn94HgLrq6/c5BJqHpVScxWz0
	iX33DTZRAdx81qVKozvRqk5T84A3/7Fd2SMTu887utey9Q0maz6l1E4Q60jiGfWEXiWHwMDMH3V
	qYZmAiRuYsydw2rtEjPXa54MvLgFvavE=
X-Gm-Gg: ASbGnctUf7ShT4drnHs3x2fkubXYLtp4t9qQnCvQBvjt89j+OvwGae7CZ4bF4oxnZsc
	WY5FZd5FXUrMVCNl816OtCF6w8MiiHohIGk2obkz880yD+B5+qIYWAeufYe9Kr+fQWJN2TiVkBq
	APXpoAI7ojRbvm1ZXlKJeDhSiOg2bMDxL/WuemLPY20Njw1sMJmd0foDFB7qUIivynVVe4zigy2
	5VQhAKNew/vmshKqi9eDpGPjzaMinbFDImIYlaHFFiDaRoKMHj5M63OFY4SeFpDSYzYWyPase8b
	OnZUZXBUYnKznq0iqMUq9o62zSC934mVk4Inv8lS/zohQpuCGJA=
X-Google-Smtp-Source: AGHT+IGtde2KTwSuiwuBE4w2MRP2c+Bfi+urA8hvp8KMf6+bfds1WxuX1Upaqk4Xaz9U85LMbKaUqPPSvWei/oej2MU=
X-Received: by 2002:a05:6214:2a88:b0:729:c429:105c with SMTP id
 6a1803df08f44-739322f923cmr173734616d6.25.1757499604466; Wed, 10 Sep 2025
 03:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250908123437.1728264-1-alex.kanavin@gmail.com> <dd91f763f6d54bf3fd48215cfad51c2d0b0cfb56.camel@pbarker.dev>
In-Reply-To: <dd91f763f6d54bf3fd48215cfad51c2d0b0cfb56.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 10 Sep 2025 12:19:53 +0200
X-Gm-Features: AS18NWB1-k-wi8FmJE7ZUlN0MSglVJLPSMguu8CXr1QPb1R5eKMkb8etgxqrsDM
Message-ID: <CANNYZj-OUXMsyiSNxM=dcoLyXsS8ioSuVBkW+amUm=Uc3GeVoA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bitbake-setup: add the initial implementation
To: Paul Barker <paul@pbarker.dev>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 10:20:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17994

On Wed, 10 Sept 2025 at 11:35, Paul Barker <paul@pbarker.dev> wrote:

> I've added a few thoughts after testing this out.

Thanks for the feedback :)

> > 3. To check if the build configuration needs to be updated, run:
> >
> > ===
> > $ bin/bitbake-setup status
> > ...
> > Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed.
>
> This example doesn't work without a `--build-dir` argument.

You have skipped point 2, which explicitly tells that it does work if
you take the step prescribed :)

> > 4. If the configuration has changed, you can bring it in sync with:
> >
> > $ bin/bitbake-setup update
>
> As above, the `--build-dir` argument is needed in this example.

Same.

> > This commit includes fixes by
> > Ryan Eatmon <reatmon@ti.com> https://github.com/kanavin/bitbake/pull/1
> > Gyorgy Sarvari <skandigraun@gmail.com> https://github.com/kanavin/bitbake/pull/2
> > Johannes Schneider <johannes.schneider@leica-geosystems.com> https://github.com/kanavin/bitbake/pull/3
>
> The commit message is missing a Signed-off-by line.

Yes, not sure how that got lost. Probably accidentally deleted when
adding these lines.

> We should support entries with 'path' set to an already checked out
> layer directory and no 'git-remote' key. This would allow people to use
> bitbake-setup to manage the build directories for layers which they
> maintain without having to push all changes up to a remote repository in
> order to test them.

I'm not sure I understand the scenario. You can use bitbake-setup to
clone a layer, and do local work on it, we just need to make sure
bitbake-setup will not overwrite the changes on 'update'.

But if you really really want to refer to an externally managed layer,
you don't need an entry for it in the sources section at all. Entries
in 'bb-layers' are relative paths as well, and that can be set to
anywhere on your local disk. Or the code can be tweaked to recognize
and support absolute paths.

> We can add that in a follow-up commit though, so there's no need for
> this to hold up the initial merge.
>
> > +    init_script = os.path.join(bitbake_builddir, "init-build-env")
> > +    shell = os.path.basename(os.environ.get("SHELL","bash"))
> > +    fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
> > +    if fragments:
> > +        bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
>
> We can't trust that SHELL will be posix-compliant and able to run the
> init-build-env script. Perhaps we should just use 'sh'?

I guess so, yes.

> Both of the commands which use this ('status' and 'update') take no
> other arguments. I would prefer to use
>
>   ./bin/bitbake-setup status path/to/build/dir
>
> Instead of
>
>   ./bin/bitbake-setup status --build-dir path/to/build/dir

See above; if you're in bitbake environment then you do not need to
say anything except 'status'. I do not like positional arguments
because they're not self-descriptive and become ambiguous when not all
of them are mandatory.

Alex

