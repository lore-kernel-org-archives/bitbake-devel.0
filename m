Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7960C54FB3
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 07:50:53 +0000 (UTC)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
 by mx.groups.io with SMTP id smtpd.web10.44003.1748850650196815170
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Jun 2025 00:50:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VYM1s54i;
 spf=pass (domain: gmail.com, ip: 209.85.160.181, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a56cc0def0so26907581cf.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 00:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748850649; x=1749455449; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZITwH/EJkvT3N2I3EEcU4Gw17R775I0nJo7Knqmfq6I=;
        b=VYM1s54iuVGuCkPeqLZqErFhtB2PwFBfj2WnyEF751syQEYr2S523woKGv70/dzq0S
         W107WnbsqrfSKpLAP2RsIW1Hjvv8XyfjQibIwWiWAyJRTj/jkfKPu1wfvyjhp6PTD0AU
         hyX5ks94dG8AdrbttS/vOWWhWDBxXa6iCRpLMFJBHrYSsB9ztZT09uG8cPlvlcZk0IIX
         6VPdvp/OaL3/sn2sHKUysuRNluoCVms+DfzGV502HEIHveaOZKIUdifLfujPqRZPzqVH
         PTFdptihtv56icW1j4RzuBTjEVyfmICDi6c2PD38ddHzZcSeu5js6lJalWGTKVkFGxx+
         Yu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748850649; x=1749455449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZITwH/EJkvT3N2I3EEcU4Gw17R775I0nJo7Knqmfq6I=;
        b=lPzOzstUACiI1c7mD+VcZX9O/7TtgBVxCE/uzuyH10brKHQ7Bjgvk95naAE/eZyaDo
         FBU+mloqawsJRYL6j9SXrLiSz1OBl4STRbfsXKHzsUgtVlHLZz6w7cHKpebE3O3rugeX
         zRkqXQouIZ0cL3B9ROMKpz/jtzZPKYjcZgwVUsPXL7IjzEhjhv4SWoZBKocxHwTwkwQ2
         q9aEG3R3emGaeE538RawAJbJqk28S0XdfD6T3I3Cn4cj9Oe9fHd8Jc/j2yDRs8DEGDoj
         0M9nnpGCjaNpl9nqIdNarNdKBu1JXpDK/Ma1EOn/SfCkuzWfGBuAna9vj/lkncK8FLCf
         mhvw==
X-Gm-Message-State: AOJu0YyBV/YwCO4KBChOPKEDE1/O4m4VY03qjtVkJAlqldoYnV/y4Q+/
	HPWJo1uqe3R/hiBG1jE8LsFnm32MbJuGqkGmiCycfGISot/tuXlXM8bYhGKV2kJyrw1HDUIej41
	JF+B8zAJD8ihCcCcsnm9qY9mxyzANjL+Qtw==
X-Gm-Gg: ASbGncthjnFN6HzduDCGpMUy+XWLpMMqW2d3V9UmFkHLo/1042m1PRIPNJWPDMRMotU
	97CS5okZt4SEWiktPBfOqF6bo67TpifEWuIyPCb5Qsywugvj44omhnXDIpHdzAOp1gE92W7JzvT
	gThHgWfyphKk7vRpyq2sbps9Kh+jn4xK9H8nILB/EpUzkULYIiMQCkmrYrMipF3237djoF/dBr5
	8UJh69KUh/6xJCh
X-Google-Smtp-Source: AGHT+IEZmJ//VoC4QhieVqCo6yQXQn/7ZghrOaW0nteShckEiaq5WDurX1jva07yVPLYSyyxAkiAgq8Rb/16zxDwSTY=
X-Received: by 2002:a05:6214:21e9:b0:6f8:b7cd:984f with SMTP id
 6a1803df08f44-6fad914b3damr92045046d6.30.1748850638855; Mon, 02 Jun 2025
 00:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250601093555.40432-1-shen_jiamin@comp.nus.edu.sg>
In-Reply-To: <20250601093555.40432-1-shen_jiamin@comp.nus.edu.sg>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 2 Jun 2025 09:50:27 +0200
X-Gm-Features: AX0GCFukNuNTaHzzjt8hbWqJm2EYOmiVFySxg5ijkIIwirmh4Hn2q-p74aiqLm4
Message-ID: <CANNYZj9YJnSPQyqeZ4LH2pP_x9a352v8SrGB3f-dfx5jzLYU7Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake-layers: allow adding layers as
 relative paths
To: shen_jiamin@comp.nus.edu.sg
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Shen Jiamin <shen_jiamin@u.nus.edu>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 02 Jun 2025 07:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17666

On Sun, 1 Jun 2025 at 11:36, Jiamin Shen via lists.openembedded.org
<shen_jiamin=comp.nus.edu.sg@lists.openembedded.org> wrote:
> Modify the add-layer command to accept a new --relative (-r) option
> that adds specified layer directories as paths relative to TOPDIR
> instead of absolute paths.
>
> This change updates the handling of bblayers.conf to store layer
> paths in the form ${TOPDIR}/relative/path, improving portability
> and flexibility when managing layers.

Unfortunately I do not agree. Making layer paths relative to TOPDIR
(which is the build directory) means build directories always have be
in the same relative location to layers, which makes it less portable
or flexible.

Rather, there is a mechanism to replace specific paths with paths
relative to ##OEROOT## when producing a build template
(bblayers.conf.sample), and vice versa when initializing a build from
a template with oe-init-build-env, oe-setup-build, or indeed,
bitbake-setup.

Alex

