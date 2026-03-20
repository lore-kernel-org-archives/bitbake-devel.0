Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4C5108B905
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 11:47:59 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10695.1774007269279591815
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 04:47:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=E33utKu6;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50b2ebca625so13214371cf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 04:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774007268; cv=none;
        d=google.com; s=arc-20240605;
        b=MXVAU8dBDkt8Yp4hEZi1jtGfW3Gan2qkCVfxkv0OM+x+wa2eZlf16plPzVO0w8qOCh
         GpEbMSyxyyFLYLdmqjilZlrSdRA4j058cJkkVY7uAiqzX1nEJ1L4UnahLzmorsY7zG3C
         vPiunTzkyOXV4s6dcqz8858IKGXM5Q0nywf5wwVblZQYowoLvAigpayxAcgfVjLa5fM3
         p081UEGi+6cafBUvy7/6wYwbXrNeptCSnj3im7T0Bb2lq4hCHEM5M5kcLY83U553O+O+
         hyXULtMRH7P0LUZ8WZsDR8XOJvjUoCyRxknmPGQaBOss6elOGoQF+V7+uOz52hhDafw3
         1zHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q6oQKuUEpgiBNGiA7CoH4ektJVivZILX1tX7TtU+UNY=;
        fh=SobPDfAWzo+V9tnHp7GjHTu9qugMUrlwv3tik3POFWU=;
        b=AbIUPE8Gpv0G8B3RW+g9oezu2bhL/HbkyUvR4pbNU8wY9TpTo53faxp78XqjB0fWGC
         7HIYavqu1P4bg4zkqDJSh3gHc5I1yy56U5VVBdwZhdVA89r0WPkecCpQ+rRP4wLrJtXi
         MD73jFzGt0MUKt6hwmYVrF5ZoehzYjs3xObBdILyzH0Dt5CILJrie1KiQaOYIHeUar07
         C2vS71WX8HdYL8puDMxEf7ARGp3Aiozrk/WNxa44K+E8W1RG97SL+299G7WBSwYuZNua
         1AKDIMXDZregVlBrsv/uK3KPJRPw3KiP2ed45ZrW//1vVKTlnlIpLiqVN2BMkrcVdmoo
         5SuA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774007268; x=1774612068; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6oQKuUEpgiBNGiA7CoH4ektJVivZILX1tX7TtU+UNY=;
        b=E33utKu6mHM6y3Ir9FCOKAwEAgYeXkMy9nbLGxOg8Ec/O4GhTYrpxc6v/Qnq3p0mSw
         LJBH1fYUhpB1BuGkGo6TZSXv7bA8o4C5NdJR23USdEsewCkkI7KSTRE5FCEpmGPCk/sg
         +BwvAm0U/5krUf3/rmBr+iwBmpbt4qMIZffBwtCg+cuJ3UF5E48+2cC0ZJRLWaHCh8gj
         mZnMetEL04PZs2ITdOxJ/Kxr6zHTegQa8UkWAWgWQjfkRUFfC351hJNi+Ng5gMmxNPQU
         cJ9hhPuaCpljXhceHQ0l1k2MNKjIEycfe7PqenERl6H6FEEtp6x156IkAFpex/kVJXnA
         WiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774007268; x=1774612068;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6oQKuUEpgiBNGiA7CoH4ektJVivZILX1tX7TtU+UNY=;
        b=ZxLJsqh5aP2r+pPWNfoMkjM/zGTEyPInnb0UzM5optLRStYexzdBHqtQf+w5BtTS3Y
         xSTinm9sHSAb/UJkCMaxsG6J38yZihH2zVIayzILxG4tHbu9fhM7IE5X2sFchBm2vvtE
         x8q7FhIK9Kmf5qGHSjiMFXi/cq8Hmyu7j+qVA7fULWzOBP+6GthLGKiPT9GgKc+/mvoM
         Qvz/sW8+lEkNU0BcozvpQJxGTbbqG6+5ETpCloEJdR96jkg4KCW2EYGoxEB9eQn1/V9S
         p830njvFgHE69DEP5IqV4dts5dAA/Q1j+hjubSB+gGSLcyDrZV1hPIMyqCRpgb6QoNyy
         r8nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPEh9g5ljp/H4OJaA6yrygd4TQ8JtnM3J6XnFBihODBuIBpzv1DY2b3+MSKH5d2ocwjXfCuMSEVY04QIoT@lists.openembedded.org
X-Gm-Message-State: AOJu0YxD6im/gNYXrrt3h/Nr7opGYSIo700eZOZSiGWRsZ+EmiDPVvO/
	twppHQiBEnF9KBGqUtdq2I+vzgFII1lFFi+tsqvFWqMgTOgojXRcLzlbE3w3w1fqQVlu3apebUS
	EbVDTKOvFyRvmXw7aRzHSQHA1xENRP5M=
X-Gm-Gg: ATEYQzyFExvd2c9ybxZ4yByBz9MtkGI02i4opEX75NIh6pw4lLGgUi/kmnkZyapzJBz
	F9EiYjKBSsxZwRXSPyDMYbll1N59OszJo9RFV4Ow+YcI6yX/nbC4KwzCrjwunx2WjtWGUdxnkdq
	aWM8FVpFQ+vxwDPhtrLXGd8LbVUMt4w05q7tehOWZwmZ/fv2ZLS96RSGHgtDtb1mRPgaAZB8ZxN
	EAdss/WpLMeOBjLotUBhCytTkLpTIoILOYjMnQLs6xUSGPXqu+/uf+HHHlScWoFhlIpW4Wr0Bmu
	KuSutS6MbRbjpjK45Udee+x4OTZwchypLXOT/31R2w==
X-Received: by 2002:ac8:5a8e:0:b0:4f7:a06d:c4df with SMTP id
 d75a77b69052e-50b2476b69amr88691041cf.33.1774007268020; Fri, 20 Mar 2026
 04:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <189E3DDB9FE2B7C7.1764087@lists.openembedded.org>
 <e551779604af9981640c070e5b9d07cb68f813fd.camel@linuxfoundation.org>
 <CANNYZj-dY7PfmJDe7W4KjbRp-WL2iLVBXo3MnLk3OmJ1+QtGsQ@mail.gmail.com>
 <c16464d67528ac1bf90a466eb96b695da1471159.camel@linuxfoundation.org> <10dc9e4874cf39b81d8b749793c8bb9044140ae9.camel@gmail.com>
In-Reply-To: <10dc9e4874cf39b81d8b749793c8bb9044140ae9.camel@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 20 Mar 2026 12:47:36 +0100
X-Gm-Features: AaiRm53KcS5pBOxdTQbMsl_arBoLlpK_1Y1VnaCwXRt-bAbSeLobRjhjkL4XVLg
Message-ID: <CANNYZj_FgKB8jnmdDBwPiWC1bQ_jS5nx8o5nJ5nQko6C3JsRjA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: Add an 'update' unpack mode to
 the fetchers (git only for now)
To: adrian.freihofer@gmail.com
Cc: richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 11:47:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19187

On Fri, 20 Mar 2026 at 00:55, <adrian.freihofer@gmail.com> wrote:
> Here is my branch which tries to solve this (with --untracked-files=no
> so far):
> https://git.openembedded.org/bitbake-contrib/log/?h=adrianf/bitbake-setup-init-vscode
>
> I guess the rebase with untracked files should be properly handled and
> tested on the git fetcher level already.
>
> Handling corner cases for bb.fetch2.UnpackError at the bitbake-setup
> level is complex, and accidental file deletion remains a concern.
> However, we should pursue an implementation that supports automatic
> rebasing with untracked files, which are commonplace. Backup-based
> approaches are cumbersome and should be a last resort.
>
> I tried to achieve this by adding many test cases, at least.

The additional test cases are very useful but we should tread
carefully with adding bitbake-setup update logic (e.g. in your
patchset it first tries non-destrictuive unpack, then in case of
fetcher errors falls back to backup+clean unpack, not giving users a
chance to resolve conflicts - I am not sure users are going to like
that).

Let's first not try to handle UnpackErrors at all, and implement
simple support for unpack_update(). Users would resolve the conflicts
and run bitbake-setup update again.

Alex

