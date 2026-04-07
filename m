Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B6FF5132
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 18:30:47 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88375.1775586646145360026
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 11:30:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Qkxehpt4;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89fc349b5c2so52503606d6.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 11:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775586645; cv=none;
        d=google.com; s=arc-20240605;
        b=W3Gg4pHTU0Qe5kf2a9KVoWnGYXQK+L7o8EMhnFJ0s6tlO2nd9u9Ji6HGV23/cxoj7w
         SdR05SeAZ9fWaWkF6sn85tuHk9HAs7FtUXr0q8/O0uXVL7S2AeypSdR/nIMQsBrn4y0i
         pYrirycrKW26NRnTCLGAMdQ5NI79wMtxdGfzuKOP+zSOyB7pEiFuI9m1eOG5RcleqiuB
         T0MYh1KjwMY1oV2QyaANCUm4rp7+iVEvvdKuNU1VPrTZwhu9qthrwLjVBIDgA3q65aLd
         RKFXdVEzCHg/KHRl+Y7pls5uY0meS71YcFOkSIMJIobT0PpaI7VYOBWj+Qk/vH3/iCoy
         n7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=OPsaMjBWSLVWOhQrqAHhWAwJePeTo6Co4Yt62CHiBmg=;
        fh=z79r7devTYIWKIIJnNEQrp8fu91t3iK8WPc0gYxDyHM=;
        b=k+ysejfEcX8lcRmi8l0J+DNeh1wheoav+g3XExMSLnQDg7UCkhuzpOIUOSOScCfKph
         3jRax1JK9DDksHIwdRAqXJpPXF8fzJxJC7M03Mcy5aqF2OviBjXzUhimnpgG41jqOpYt
         RSWP4JqgFHifr5x29OV2FMFYUTewW/elbeg5t5zFfrTd/+ToEOrCZFEV9OFagSUOpkXL
         9wNKUQQ/shqtHM4QN9edGUEB9wDKhCwlwd9MYTprG9xJQpE6ziVE6YMObaU/kHjnjzwE
         iF2MMbNrB+jHmpPpXRjqq+lPMBBjb8HVNSs3NLg0XAsO53jtB7kUnCKxrjd+DNfMJQG2
         CoZg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775586645; x=1776191445; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPsaMjBWSLVWOhQrqAHhWAwJePeTo6Co4Yt62CHiBmg=;
        b=Qkxehpt4YwahrVdjnECKo39QXCbk301M98XMbczVS+FXVXGWEsMOcfd+D/0XarQGK9
         ktnChWwlo05XCsDmapdCBWfdJTar08KdEdzQF6GGj5SBTEpYw3t46kFdSc0DhU9dZIM/
         3DKxMDZLQAmDJcRLJNgRR940bzTCXEO/fX/RMrm9pS7KKy1BQ8Bg9eFCHqkaIWICKQ+Z
         QZDou23x6Qm4vzi+mxVSxBe2+RXIIE7qowhnHFZ9q8GVQZ631b9x3Rg4yHMRf/J0GjO+
         EiSG//rJ/nJ15Hgz/cM9y+EAmw69Vn1a8lInNpz6STwN3A4l8aHhZxfPXxsEiZz51F4K
         OoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586645; x=1776191445;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPsaMjBWSLVWOhQrqAHhWAwJePeTo6Co4Yt62CHiBmg=;
        b=Z3jA4MbtaYL9NLCM0dz3C09xjtRB3mXEQSjt2BcwxW5Bq09VQqlWBHmOIqjlRT3Ltt
         0Gwfm1quFAbG/2SsBHddacZTJmnOSCUZcXp+FKx2yrenbxCbK3hCyVtp6pzO30rZ0Ae3
         q+CETe6ZyvQJ+Sjo+kyWeONHh5Elw/U15OGsze6mSszb6oHyXrGaJxMrST5aA0fVDGWw
         hEKZNEmFqhEkgcWAFaqQPNHDSZzWhpOpyK7IwO+CNevDBJA6qX7EqmvN+Oe50h77PgMs
         jeTnBqL+xuQ2dPk5iHVORq9KdUIhuqQzJAkIym2Aw9Q36KmzXwOqBAfw34ycIoM8wRIv
         oBrw==
X-Gm-Message-State: AOJu0YxTRj2SVYhtb3Z6nA6ZBBjGUsmc5J3BTlHr6ty2iGBwiQqFYGLl
	n16XUqBX0phoX5eIpRhSsI0OP2NvToNUbec77A8bvloiUSGfcx6BXN7FB6cwZElPuAPudGuNf00
	rEcCxdrsaMh39MkVij2M7fCkfNC2Lpug=
X-Gm-Gg: AeBDieudh5cJiy3WM2XH5DTegnEG0b8gjr4StmjB4oUB1IqixEuujWNQbHEgQV4/sgK
	MXzy6jXY5HaNYYTFGqMko+yS6IPZl2D7bu+fdXEnQeQs6q+5njocSTx3qrN0/XuMZ6Iy6d5UiAl
	ToQjsQFI1zz7urCyv7IGOnf5fFoncNmEFi4TFL6+LSlfiNaErGUinD3Ze3iH/ck6rdmPf5gadYa
	tmHcb0IFq4DKSYj/jm/WfYDR0B6wszLPhjw9YY6vM0Njlpss5aeVOQaQzGGlN43SxiBx2TnZ5DA
	nXfnP1YA+pT91RNGeU8tT2RHih6cPqXrUqypCf6qdE44x7e2U0of
X-Received: by 2002:a05:6214:dcd:b0:89c:7d48:de10 with SMTP id
 6a1803df08f44-8a7025b8327mr299225586d6.20.1775586644880; Tue, 07 Apr 2026
 11:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260406202430.1856836-1-adrian.freihofer@siemens.com> <20260406202430.1856836-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260406202430.1856836-2-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 7 Apr 2026 20:30:33 +0200
X-Gm-Features: AQROBzCrFwHaLXOuBUpbTVIPxSIn_-mwmZDsvd6QUMl8GWvwLcr-Z6GnLWGsCII
Message-ID: <CANNYZj-K5KWN9Z9CDZnQyU34bVT+8rkH0uEcfg=FXeOWfm9XHw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/4] bitbake-setup: update vscode
 workspace always
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 18:30:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19351

On Mon, 6 Apr 2026 at 22:24, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
>      logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
> +    if update:
> +        workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
> +        if os.path.exists(workspace_file):
> +            bitbake_builddir = os.path.join(setupdir, "build")
> +            configure_vscode(setupdir, layerdir, bitbake_builddir, os.path.join(bitbake_builddir, "init-build-env"))

Will this do the update quietly or inform the user that vscode
workspace is being synced with local changes even though no
configuration updates have been detected?

Perhaps this should be its own command rather, something like
'update-vscode-workspace' ?

Alex

