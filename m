Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D60BC636D4
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 12:17:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.5124.1676636233304029356
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Feb 2023 04:17:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=exrtN/5b;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id z12-20020a1c4c0c000000b003e21e018039so2298437wmf.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 04:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qwjIEHwZV+4sID+H8F3yihgvQintkBhONwelsXKFig=;
        b=exrtN/5bsMl5KvXXNutmNAo5bLYJaFXvzmbfhfvQbpbOhrvOkeYigKNwd/5J8guszB
         2Dwmk2H95X/6hAf/O4yeV8R/rpZiWN0x4HD42XVdDUo/7K7FAyhYQzzNE1YXrWAVxMRj
         sbgKEQSP5sz9dUDsCyyGs/gbh0Eip7dhAh3ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+qwjIEHwZV+4sID+H8F3yihgvQintkBhONwelsXKFig=;
        b=h6rOrw3eSlEWe6kzftsFgNwBY80f+iJlcMEZcKmB4Gp6i1IP0+QfgTzLvfc8nH7UEo
         OpCvGefOA3L328J5/50W0tvXhEWmSgCCmQF7k5CeXIhNBw7mg2eBwQGDzPc7GYY8DT0b
         AmQ6a9UaT+5ijXYWUejrV7GMWN+kwLUPaA1JP5oNm8oU72G5g7AYZY/D8gYfThBnVmF9
         UfURukVR5vkNrsmVSjrN+xpdW0FHuahN+4pb8WODWyA3RTRY3fvetD/3tMHi7X8YXuHs
         5LlvnqLJ9HpdC1vWUP9KVCSent0/lZNxYClABOxC0kGkqlywAF50MXqpKak5CIQ9MJUC
         7Tag==
X-Gm-Message-State: AO0yUKVVdNE9SD2frCuwmXazSgh518cLJ44MM5pjI9xXXxgzs76Xxwz3
	seJmnNZd/Ekg8b5UxVAxmEKygQ==
X-Google-Smtp-Source: AK7set+GOcCksvYvfBm08zRsmLnPkmo3qoSYT7mKdJ4v+tsgr1dJLGvqD/ArWTKoBuAky0MFa35ncw==
X-Received: by 2002:a05:600c:4b1e:b0:3df:ee64:4814 with SMTP id i30-20020a05600c4b1e00b003dfee644814mr7391187wmp.20.1676636231409;
        Fri, 17 Feb 2023 04:17:11 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab? ([2001:8b0:aba:5f3c:33b5:dd6c:d0ba:e1ab])
        by smtp.gmail.com with ESMTPSA id s10-20020a7bc38a000000b003dc1a525f22sm4697205wmj.25.2023.02.17.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 04:17:11 -0800 (PST)
Message-ID: <284f2d153a21689fee82f913cd075b6b6d5622d6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC][PATCH] ast.py: catch SyntaxError from
 imported modules as well
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <Martin.Jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 17 Feb 2023 12:17:10 +0000
In-Reply-To: <20230215153523.2099173-1-Martin.Jansa@gmail.com>
References: <1744089666E6B90B.5898@lists.openembedded.org>
	 <20230215153523.2099173-1-Martin.Jansa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Feb 2023 12:17:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14449

On Wed, 2023-02-15 at 16:35 +0100, Martin Jansa wrote:
> * before addpylib directive possible syntax error resulted in output like=
 this:
>   $ echo "def foo()" >> oe-core/meta/lib/oe/qa.py
>   $ bitbake -k zlib-native
>   ERROR: Unable to parse Var <OE_IMPORTED[:=3D]>
>   Traceback (most recent call last):
>     File "Var <OE_IMPORTED[:=3D]>", line 1, in <module>
>     File "oe-core/meta/classes-global/base.bbclass", line 35, in oe_impor=
t(d=3D<bb.data_smart.DataSmart object at 0x7fa09b142790>):
>                    # Make a python object accessible from the metadata
>       >            bb.utils._context[toimport.split(".", 1)[0]] =3D __imp=
ort__(toimport)
>                except AttributeError as e:
>   bb.data_smart.ExpansionError: Failure expanding variable OE_IMPORTED[:=
=3D], expression was ${@oe_import(d)} which triggered exception SyntaxError=
: expected ':' (qa.py, line 222)
>   The variable dependency chain for the failure is: OE_IMPORTED[:=3D]
>=20
> * now it wasn't showing any output at all when there was syntax error
> * show error and name of the module which failed to be imported
>   $ bitbake -k zlib-native
>   ERROR: Error importing OE module qa: invalid syntax (qa.py, line 229)
>=20
> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>  lib/bb/parse/ast.py | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Thanks for reporting this. I looked into it a bit and in the end I've
sent a different patch which should fix this and a number of other
possible errors more generically.

I still don't know where the original errors are disappearing to though
:(.

Cheers,

Richard

