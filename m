Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE2E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 13:27:09 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.web11.18437.1736515624034591372
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Jan 2025 05:27:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D1GeU8LC;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4678cd314b6so17260351cf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 05:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736515623; x=1737120423; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjW2ClM6rwt1hn2ltk/0GNr5NWsav3q7MLL1HtsR3xM=;
        b=D1GeU8LCjw8yiUQvB8qcwUGEdYtaLaHbV9qi6XRGa6LwLBRkJRqvx+OuxK4ApX2QfY
         RJU8w03cRYFx2l+eQZvrZJErLN+Ow0oBlvmZ4G1F4LSKQqkst+qHy5nSv8QTxkW7nSpg
         8FQU9Ezu5JxxDWQW0SFI4jkAFwJvzCh+CJfGKNHZQcPw+NgfMEgU1AWjLTWk5090iIyv
         ZhFJCVAEl+v/mFtyI6z9fnN9L1n4c8BGIHXGRb611d1QIVNTzL5tuP0PUiDANJAcVxMw
         rmLoeSmPkrp0xTZr4fiUenOPXOerf+Se+QDpj6UvUhvjsdbb1nMaZ9a7YM/bdBhvmRHs
         zQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736515623; x=1737120423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjW2ClM6rwt1hn2ltk/0GNr5NWsav3q7MLL1HtsR3xM=;
        b=OEHnyd2O4m3a+BRaqESjYNs4b3x0jWvoeKHmo37Vk3r2MJs94mKusQDRl/BeKneTTU
         kwGhZJG6/TLWlNr8PZs3QlId0l+VRbVw0dXNyKaaKwkccrRa9aK2bWLMVHZmCadjGenZ
         9Wk5ewcjiVLeWuXlIzn6YHrFxrgADUxS8T6hXzpgWach5zWSZ6PgB4Gnp3r3/MsSzrq2
         B4woKq0/fzMzNAmhli4ECPhS+X6B0chXUVEj4Kd0Ublg3uvPm5UxU79nz10jyqMs/zhL
         rrVks4HLRhB4IpITItQAJ0BbdaYUJuVCSWMNbt3wL065M0etkh7NuNgcZJEzpzfb2As6
         +lPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaoC+ZsHBxLwYNkvxyElSDdUnK21QXTDqbczbOcotuhSpEW921LRTF33/2nix48CnzzyUHIQmbo7POc4Hq@lists.openembedded.org
X-Gm-Message-State: AOJu0YxeFs/8BvshISFoV21UAl1GR5HstKS2rXP6/+Xjcq54JcxHSaGa
	xz0+ahaaByVb+vAjcxWadBGe5Zk9s1Vm68TnmjThp2YU3CBLeRtvjERLQEXhTwLuMrXfF9TpQw4
	2wh/NMZHe5GZcDKYV9V1h0Xgf5fY=
X-Gm-Gg: ASbGnctFnTS2vrfpXUMh4s9VnCb7suI5C6uyaOzR5Cg+LyBm/EOW5dela7YFOp424e9
	Z05s7sC0yP5BHyvtVYmGdSOS6D9dYwY+hS4A253AJRxyg4KjDMyDoLgaccQ1QjWxmVrghVxyA
X-Google-Smtp-Source: AGHT+IETpa3RqPySne6Ktxg0JgmUB4PyviAQKGUUSbEwpYvOyIGp39lpJ0v1MjEEtbjp47JBB1iOUlLPSyLrYYQ2K2M=
X-Received: by 2002:ac8:5848:0:b0:462:e827:c11a with SMTP id
 d75a77b69052e-46c70ffd4e3mr158578231cf.19.1736515623034; Fri, 10 Jan 2025
 05:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com> <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com> <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com>
In-Reply-To: <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 10 Jan 2025 14:26:51 +0100
X-Gm-Features: AbW1kvYbD0OefVarcszB1x3WDYchCF9UeKLlzoMJrZSflRy_eIm4RMVpjtUFG30
Message-ID: <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Jan 2025 13:27:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17005

On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
<stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
> What is your opinion regarding gitsm. Should we remove the bitbake fetche=
r and use a update task to generate a inc file with the source uris and sou=
rce revisions?

That ship has sailed. We can't remove gitsm, it has users, and they
will be very angry.

> Do you really review the changes of the inc file?
> I understand the points but I have the feeling that they are more theoret=
ically for package manager dependencies or could be solved in an other way =
(ex. caching)

But do you? I have to restate the point: a solution that can be placed
inside a layer is much more scalable and maintainable than adding code
to bitbake. That's why I'm leaning towards drawing the line at
existing fetchers that are wget/git convenience wrappers, and shifting
dependency/lockfile management to layers. It's ultimately RP's call,
but he does seek feedback :)

I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
new versions. And since you asked, no, no one looks at them, they're
auto-generated noise that we learned to block out, just as we learned
to quickly skim over recipe patch changes that are just line number
churn and similar non-functional changes.

> Even if we put all license information inside the inc file. Who should re=
view the changes ? What tooling is used to review the change (license conte=
nt)? If we blindly trust the inc file generator, the inc file is useless an=
d we can generate the information on-the-fly.

We won't blindly trust a generator. There are multiple gate-keeping
steps, some of which already work, and some should still be
implemented:

- when creating a recipe with devtool, devtool should discover all
licenses and generate appropriate recipe metadata. For classic unix-y
components this has to rely on 'guessing', but things like crates have
deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
files if I remember right). We can also propose adding such
determinism upstream if it's not currently good enough.

- when updating a recipe with devtool to a new upstream release, it
uses the file:// entries in LIC_FILES_CHKSUM to generate a diff of
previous license texts and the new ones, and writes that as a comment
into the updated recipe. The diff is reviewed by a human performing
the update, and condensed into an update to the LICENSE field (if
needed), and an explanation of what changed in the License-Update tag
in the commit message. This could be further automated if upstream has
deterministic ways to specify licenses, e.g. LICENSE =3D
"&".join(all_license_ids).

- when sending the resulting patch for review, there's a mailing list
bot (patchtest), which will check that any update in license checksums
is accompanied by an explanation in License-Update tag. There are also
humans which will check that the licensing changes are sensible.
Otherwise we do trust that submitters spot important changes in
licensing (from the diff in the previous step or by manual comparison,
if they want) and summarise them in LICENSE correctly.

- finally there are various license checks that run in recipe_qa task
and implemented in insane.bbclass. They could be extended to verify
that every dependency has a matching license entry in the recipe and
so on. Anything that can be caught by looking at the source tree and
the license metadata.

> Nevertheless I will move my implementation to oe-core and add a task to g=
enerate an inc file as starting point.

That would be much appreciated. The more I think about it the more I'm
convinced we should have it standardized in core.

Alex

