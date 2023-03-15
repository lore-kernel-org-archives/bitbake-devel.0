Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC18C61DA4
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 15:50:21 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.12116.1678895414834868452
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 08:50:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=WcJlzrWA;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id r27so24851511lfe.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678895413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuL5FY0uWt0dbnDeBYz6+cen42LiMUWMloJPHg52J3M=;
        b=WcJlzrWA2bQ3ais7PMkT63H8YDGZzpOobYDtZxB3lWKR8sJg1/tVtWo04gSReRK6ng
         1JKrbBp6TF/PQA46lUiR5V7nB3I+YdAeAd4yCs5bmbOOFg24+sdNW4ovWaLRhUOa2mG0
         XnQIO1iQTS2xXTzHRQbAtTZ4bpj0cy1TiqBNByJMYf9qKMITWC2lk90mkxeRiZn1N160
         9xtot/X4Cpzq5mbQlpUlJQGA4+HnfKz0/QyOlQiKkPd02u0Mc5ft/RIJ8lXUl17C6MjT
         cacDN9m54IDR/8hrHoorSMPHJpGLdAUbpQmwa64Avn8R3YX0JAX17xqT0YNw8Id3f8vt
         Qi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuL5FY0uWt0dbnDeBYz6+cen42LiMUWMloJPHg52J3M=;
        b=1RtFZC/xOD8/Rvv97A5xk1uWgqOBH6UuSJYSChRjliCz3HcKa2b/y3d+BAUabNXXHm
         +xaXHJtOHRbdPz6XIFW/4Ehy7u0FRKJFPXLaQqrBYN9dgQxaKsGwYUvwuP+QHdf475cw
         bpIDt561+F49WY/E4RTqYfiorHi0e1zSqH492zzUFWo/qlwMJtrmk5YnoMuJnW9biZ+j
         5neNzNYJYq18xd5waxL1gEljvYS15/NvjXCsO4r4L8Soxc0fc+bpIduAXnmgQB9vCNp7
         ZaK1rhxec8GR+TDaxKVvw5QHs5P5GqP0yYIef5vspcgjV/3DUUCUcKsbBiuNw4ZtL+jc
         cqsQ==
X-Gm-Message-State: AO0yUKV3SIxZmd/nc5dQEBCJ8U+lrifb9i3fcoe5A1CU/fUiKNOaJTgt
	FLqSdt7M717uLz6/FQbD6Rov3IeSi4nlxpgBxMk=
X-Google-Smtp-Source: AK7set8mrbzFMk8X1rrzTvUIys6Eks8Wsis4ojSaEdQSiU8wMMLTHcwPszoPgCiDDx0460n2w2IwXUupbokJmSpCPJk=
X-Received: by 2002:ac2:43a9:0:b0:4e8:9988:f8ab with SMTP id
 t9-20020ac243a9000000b004e89988f8abmr115421lfl.11.1678895412908; Wed, 15 Mar
 2023 08:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230315131513.50635-1-frederic.martinsons@gmail.com> <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
In-Reply-To: <CAO5Uq5SC+x8khm5+g-ro9=H0obf1EoxpDMcjOcpPfbvtEJSK5w@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 15 Mar 2023 16:50:01 +0100
Message-ID: <CANNYZj9Vontf0wPV672yLwSvNZ_6__Fp8y0P1WJXnGVJcZqBWg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Add checksum capability for crate fetcher
To: Alex Kiernan <alex.kiernan@gmail.com>
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>, bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 15:50:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14567

On Wed, 15 Mar 2023 at 16:03, Alex Kiernan <alex.kiernan@gmail.com> wrote:
> I really don't think this is the right direction, at least not by
> default. If a crate is your primary build artefact then this is
> useful:
>
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=15012
>
> But doing this for all the dependency crates we're just repeating
> what's in the Cargo.lock which should always be part of the primary
> artefact.

Maybe cargo will verify (some) items against Cargo.lock. Maybe it
won't. Upstream cargo isn't something we develop, and it may add and
remove various exceptions and special cases.

Anyway, we cannot actually trust cargo (unlike, say, git), and we need
to do our own checks, and keep the checksums in files external to the
source tree. This will free us from worrying about whether cargo
protects us from supply chain attacks properly or not.

Alex

