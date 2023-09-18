Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC6CD13D2
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 10:02:43 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.47847.1695031357043332157
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 03:02:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QorLm4Ek;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40479f8325fso34144135e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695031355; x=1695636155; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M0bQndNyQH539LPr3F2jpmSO2SAg1CK782+kBbhLUg=;
        b=QorLm4EkJCr1a9kz0XqF2d8lnA30Wy0/WITNtsvc/1eFdLo5Gjb2GG1BffrioJ4VOy
         5pe1jkAnvjMv3mh0FqZufmgdRNON/01L9ZUakrsQTmI4I2K35jNu67rzH+3Zryj+TmyK
         HYmMFqNM8zeKxbywJhfvKlP9g7pMyofvpBpFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031355; x=1695636155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/M0bQndNyQH539LPr3F2jpmSO2SAg1CK782+kBbhLUg=;
        b=HGYr2IZnoJSJeWsaHldtfSc8y8pBW/yak4Z/iKyHQcEqvHXrMBGYNqVRBOTmsz53jN
         b9UyuWRyZSc5r2rebiN+aM4mSMDFD8ToSMKdotmlkiRM5zxLRk1oe8ICMc+oJAXIfGzO
         +FMui7MTzE794zH098k2kgfRGvPThgBfHc8SAchRTzOa9W1rSh4otV7Ct719w1fJb0Qu
         yo1V2F5CI/aZSySTq7C/IiUcMMkoCcDFRJ6VxZU81CP7qe8rgAxwjBt2m268fjNzJJ4a
         8nbRFzAVL20BCtIlFsb1NTOoadKK+hIAD+DQWKc8Yel1aVO6jrJ1uWsdM/3asK8lRisy
         PSRw==
X-Gm-Message-State: AOJu0Yx6XxON8Nc9jEPx2KkWgx9P4YD0SflFkewayZvrqcE4HdY0sPi/
	L7OBWkf7LAA6wfmFBdCvvzWxwg==
X-Google-Smtp-Source: AGHT+IEikscvzWuCQsDxjRlONShsgr0JnNfr2VR2Wge4k6Zu/mpAFYTnDcUxaj5r3g//xSi/LeD3DQ==
X-Received: by 2002:a05:600c:2241:b0:401:bdd7:49ae with SMTP id a1-20020a05600c224100b00401bdd749aemr7933282wmm.18.1695031355266;
        Mon, 18 Sep 2023 03:02:35 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c207:9dee:97a6:8348? ([2001:8b0:aba:5f3c:c207:9dee:97a6:8348])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c0b5500b003fbe791a0e8sm11936347wmr.0.2023.09.18.03.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:02:34 -0700 (PDT)
Message-ID: <0b769953cf43aaaaf13e335550b42ca0fe7b44f6.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 0/1] Fix dependency handling bug of
 :remove operation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Insu Park <insu0.park@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 18 Sep 2023 11:02:34 +0100
In-Reply-To: <20230918090522.659869-1-insu0.park@gmail.com>
References: <20230918090522.659869-1-insu0.park@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 10:02:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15078

On Mon, 2023-09-18 at 18:05 +0900, Insu Park wrote:
> Unlike the meta layers under the Yocto projects, custom layers frequently=
 use following style
> of overriding to disable something default in the base layer without touc=
hing it:
>     bb in the base layer:
>         OPTIONS =3D "foo bar"
>     bbappend in the custom layer:
>         OPTIONS:remove =3D "${@bb.utils.contains('CUSTOM_FEATURES', 'no-f=
oo', 'foo', '', d)}"
>=20
> The problem is that the value of "CUSTOM_FEATURES" is not shown in the ta=
sk signature.
> Here is a test example.
>=20
> test-remove-operation.bb:
>     TEST_VAR        =3D  "v1 ${@bb.utils.contains('TEST_FEAT1', 'foo', 'v=
1foo', '', d)}"
>     TEST_VAR:append =3D " v2 ${@bb.utils.contains('TEST_FEAT2', 'bar', 'v=
2bar', '', d)}"
>     TEST_VAR:remove =3D  "v3 ${@bb.utils.contains('TEST_FEAT3', 'disable-=
v1', 'v1', '', d)}"
>=20
> local.conf:
>     TEST_FEAT1 =3D "foo"
>     TEST_FEAT2 =3D "foo"
>     TEST_FEAT3 =3D "foo"
>=20
> Signature dump (Bug):
>     Variable TEST_VAR value is v1 ${@bb.utils.contains('TEST_FEAT1', 'foo=
', 'v1foo', '', d)} v2 ${@bb.utils.contains('TEST_FEAT2', 'bar', 'v2bar', '=
', d)}
>     TEST_FEAT1{foo} =3D Set
>     TEST_FEAT2{bar} =3D Unset
>     _remove of v3 ${@bb.utils.contains('TEST_FEAT3', 'disable-v1', 'v1', =
'', d)}
>=20
> Note that the signature dump above doesn't take the value of TEST_FEAT3 i=
nto account.
> Therefore, even if the local.conf changes the TEST_FEAT3 value to "disabl=
e-v1",
> the two different configs produce exactly same signature, so the recipe w=
on't be re-built,
> even worse, its sstate-cache output is not deterministic (depend on the c=
onfig it first met).
>=20
> With the fixed code, the new signature recognizes the TEST_FEAT3, and the=
 problem solved.
> Signature dump (Fixed):
>     (Same as above)
>     TEST_FEAT3{disable-v1} =3D Unset

This looks reasonable to fix but before we do, I'd like to ensure that
there are tests for it added to lib/bb/tests/ (run with bitbake-
selftest). Could you have a look and see if you could add them please?

This is to ensure we don't regress this corner case in future.

Thanks,

Richard

