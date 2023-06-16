Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5901EB64D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jun 2023 12:53:52 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.7621.1686920026764041862
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jun 2023 05:53:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=RUC4tHyT;
 spf=pass (domain: gmail.com, ip: 209.85.167.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f642a24555so849513e87.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686920025; x=1689512025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2y+FZCbR08n/GNQodiNiRJan3W/RbjwMFJR3VGv4Sew=;
        b=RUC4tHyTcDDqcUYbZrzjRe80HVoSNE1M5v2a40nMayoah5t7NZa3htTQ1MqosBLLP8
         JU4x5yc8w4DM6rSh0g3FXeUyiK2j9qp5iZJEvEmewwGLYF+bfM1FVXdWuppeo9Uv0G39
         T/jeo57j7FJ6827EXsqJBvBxMvecqBiZghLMqaykSj8RFcwSe3NJOd+tcKF0LI92TZ8X
         Gek5iYMUQa+50cE9jsk5jSux+rYEKF2BYGWy6souyGhe/ZB7AQ5KUkAEZU3mgAWoQfZ9
         yU2VfntoyxgUYwrjtUxSvgqO42enGTh1xufMp1JQujjVG6BrJzF5TpBfutHdZntnncsx
         W6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920025; x=1689512025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2y+FZCbR08n/GNQodiNiRJan3W/RbjwMFJR3VGv4Sew=;
        b=bEGZjgid4OMvXfcU9PicJCt9ro0T32LZRp586lL3ROLQcDP7VdRsgIisoghahZQabb
         zXLTVYx6Qb57vJk1iOIgsPUzrhn0nnZ0ils9j68Gem69blGJ0Esev0yPvrGrojFj1DqQ
         to2zG5iICwnPBFzL1Y43IL3/Ag65VYQ4qqKnTXXGTMPt52Nshi++7PpvbRLOjdi3N6J7
         AO1dWm0Py8qBAlTnOtoC/M+8ylAPWYzk+O6WMD041beVneNw1XcEEYowQHtr53+t1Dnv
         3ZsON4ke5E7FStTTjimAIZBFDcfAzFK1p2+P+GTe5X1mErdx51SmsaybRzemc+eGFt1C
         lNTA==
X-Gm-Message-State: AC+VfDwQ58I3+HLcSO9qnwJZ2LRQZj9QiRlDcxW2LpUq0LAAs8TxOu0L
	ThGKCOfNMOgfokoJumOY7kdSNvoUEeDr9O9mLlc=
X-Google-Smtp-Source: ACHHUZ7y94bryvPaHMV7FfDEFXDavAwgfiVmDfp+JJALbOwD61lKeHumsjf75wOLY4e3pm6asMCLfKWXfbsF+UY385Q=
X-Received: by 2002:a19:5f59:0:b0:4f3:afcc:e1c8 with SMTP id
 a25-20020a195f59000000b004f3afcce1c8mr1297300lfj.33.1686920024471; Fri, 16
 Jun 2023 05:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230616123651.915234-1-peter.hoyes@arm.com> <20230616123651.915234-6-peter.hoyes@arm.com>
In-Reply-To: <20230616123651.915234-6-peter.hoyes@arm.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 16 Jun 2023 14:53:33 +0200
Message-ID: <CANNYZj-5=DY7ZQYzBrp52cSyP3tA6H_Rn73FQgHrijWQqTye-g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 5/5] bitbake: Bootstrap pytest for self-tests
To: Peter Hoyes <peter.hoyes@arm.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jun 2023 12:53:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14844

On Fri, 16 Jun 2023 at 14:38, Peter Hoyes <peter.hoyes@arm.com> wrote:
>
> From: Peter Hoyes <Peter.Hoyes@arm.com>
>
> To support running the bitbake self-tests using pytest, add a
> pytest.ini This enables these tests to be run using the following
> command from the bitbake directory.
>
>   pytest
>
> For now, testpaths only includes the bitbake selftests.
>
> Add a note to the README.
>  bitbake/lib/bb/tests/conftest.py | 8 ++++++++
> diff --git a/bitbake/lib/bb/tests/conftest.py b/bitbake/lib/bb/tests/conftest.py
> new file mode 100644
> index 0000000000..59a8c6753b
> --- /dev/null
> +++ b/bitbake/lib/bb/tests/conftest.py
> @@ -0,0 +1,8 @@
> +import pathlib
> +import pytest
> +
> +BB_BIN_PATH = pathlib.Path(__file__).parents[3].resolve() / 'bin'
> +
> +@pytest.fixture(autouse=True)
> +def bitbake_path(monkeypatch):
> +    monkeypatch.setenv('PATH', str(BB_BIN_PATH), prepend=':')

The addition and purpose of this file should be explained.

Alex

