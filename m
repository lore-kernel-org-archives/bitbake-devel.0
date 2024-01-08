Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2C1C47079
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 13:33:05 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web10.6595.1704720775189630099
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 05:32:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KV3ZDx+U;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.219.174, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so659090276.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 05:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704720774; x=1705325574; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCdp3xs8hKOuMYKLNr51oYowKDZRe5V4yle3/m8c6ng=;
        b=KV3ZDx+UbA5aXWys3NnM8s8krVAjZo3CsEz4hgwlByYlcJbe/GFfEWT6R21ASk2QZY
         YX3ORQ5tTS3HbzZf6sR1aAOZCl+H6a3phbAiwarj2Tum1D81ORWuBsEHtxcwX19Ao8sG
         22ouHaQcQ1yF8bOdoj2W0L1bgxCxTOMUIFyvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720774; x=1705325574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCdp3xs8hKOuMYKLNr51oYowKDZRe5V4yle3/m8c6ng=;
        b=OmDMEQNUWuxVop6rsd6Kh9abUfKLRQyNkvdBSJtoG+dVypI36nTs2EVfhpsdHjRehn
         xrKyFVnJ0my3kIh0d2phQRyG+Obm/fXQovGdO/4Vd3dyhlxTxAzSr3GjMndjrTtO6O9i
         UCa9fal6Vfr4nQnbz+PM0N1D0cWX8DmFX+IJN9EWPPvXF998BGlfNua2hXhjR97UT3/0
         2LDiTCHbhvFZMpioaONBSxizIlOYHgBj6ONwPZwy33Q4fvlF/EkH1cNmNdI7kWWPgott
         NO5A/LJGBTpHcNbzQlTFzRvwRYfvTxaX9HB3AKgbfk1SX3ehJ08lk7GlHv7r/lKRBNJ4
         f5Sg==
X-Gm-Message-State: AOJu0YxnFdHlLz2TGqOAis4FMQQTs1x7tM5RLgiOn5Z56zjRRuvobE/R
	CG/vYpH8O2Lf1La0fel1HFXJ+3dGAkDuq3KzyBD4Q5zIAVk=
X-Google-Smtp-Source: AGHT+IHpiRlcwiH4ltVM+m/O8glHD5259RYdgf7euMDKgh7b9BKWVRjPr7C8WjJyJYDlArghvA7KQw==
X-Received: by 2002:a05:6902:1005:b0:dbd:59cf:4fc6 with SMTP id w5-20020a056902100500b00dbd59cf4fc6mr1086138ybt.23.1704720774418;
        Mon, 08 Jan 2024 05:32:54 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:b276:a503:5054:9b01? ([2001:8b0:aba:5f3c:b276:a503:5054:9b01])
        by smtp.gmail.com with ESMTPSA id u17-20020a25ab11000000b00dbed7110107sm1510112ybi.12.2024.01.08.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:32:54 -0800 (PST)
Message-ID: <5461f08d3c4e37e49c775e26fac8784fbc4ffaf8.camel@linuxfoundation.org>
Subject: Re: [Toaster] [PATCH 1/3] toaster/test: Bug-fix on
 TestProjectConfigTab::test_image_recipe_show_rows
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	toaster@lists.yoctoproject.org
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Jan 2024 13:32:51 +0000
In-Reply-To: <20240105142218.542729-1-alassane.yattara@savoirfairelinux.com>
References: <20240105142218.542729-1-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 13:33:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15749

Hi Alassane,

On Fri, 2024-01-05 at 15:22 +0100, Alassane Yattara wrote:
> Check some rows are visible in table instead of compare table row to
> row_to_show, because recipe image table sometime doesn't display full ava=
iblable
> images
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/functional/test_project_page_tab_config.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, I've merged this series and run more tests. It is definitely
improving, in the run of seven there was one failed build (4 tests):

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/132/step=
s/11/logs/stdio

FAILED ../bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py::=
TestNewCustomImagePage::test_new_duplicates_non_image_recipe
FAILED ../bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py::=
TestNewCustomImagePage::test_new_duplicates_other_project_image
FAILED ../bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py::=
TestNewCustomImagePage::test_new_duplicates_project_image
FAILED ../bitbake/lib/toaster/tests/browser/test_new_custom_image_page.py::=
TestNewCustomImagePage::test_new_image

and in a separate batch of 5 runs, there was also one failed build:

https://autobuilder.yoctoproject.org/typhoon/#/builders/161/builds/124

FAILED ../bitbake/lib/toaster/tests/browser/test_builddashboard_page.py::Te=
stBuildDashboardPage::test_criticals_show_as_errors

which is much better than the previous failure rates.

Cheers,

Richard




