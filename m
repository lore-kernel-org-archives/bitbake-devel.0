Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77C8C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 13:58:32 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.36178.1702475907796454531
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Dec 2023 05:58:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CIHJ6sRy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32f8441dfb5so6364448f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 05:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702475906; x=1703080706; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWKi0VxyEEA44+pj9yy/Pz2Aj/N02U3hEj02lilnDg4=;
        b=CIHJ6sRyzXDmlfF78S2Oqk7GbxAQdA8XFovnoLMfpVyHgYL/aFsBAdVurVemSPBuAu
         Q4F6msJGxHbHFJhxUGjQGahb0q0p+jvsZRP5wbK3DW7GFCQgf0iMA5luFbh6Hx4OpZ3K
         nR/XWZIaandjycibomKaSxks8i3ZG7K8vzYMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702475906; x=1703080706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWKi0VxyEEA44+pj9yy/Pz2Aj/N02U3hEj02lilnDg4=;
        b=gBKIKYDiubEyKw6qPix0u803+/CGLozYcDOuMQTQCAVorHJwKI/7GGOcviYUawoyLq
         ec/pPiWeN2AbGfa0/3K+zVlrlh9sdoL2mhKuJKICTHjx/AiB5TvSWFiMuNjnQXWl+25J
         y1cidlKNyt8DBBXwjlC9M2beQKfoBKCVDEqIlXez96zKfjK47LON+lcjP9bz8z0t5rul
         bT/Dj4Gf/6/bVJww0/yqbU2dGGN4mFw9B10/LPNEzTFmENE9wv1A+C6n8H1wysyQuG4y
         WmRvbL6eeIXyd3KBGwMu+9pUZE6I2ea0cfX/J5FX0qXYEitRXTa8WaVlekKe+pnHtXoq
         7/SQ==
X-Gm-Message-State: AOJu0Yy6YDEHLbw+65Y+k8IZ2gCok7fmP8TEfBYNBFswosbw53bnoMzt
	JOV/n9pQcyxKUavXJsY45jATFA==
X-Google-Smtp-Source: AGHT+IFLq/a8A6AkR6vPyJUONnO0IHKda2/1BBk1JwSHIbjboOSJQQsAybk+qNi6+0HCbSPO6Qou7g==
X-Received: by 2002:a05:600c:2214:b0:40c:2680:de24 with SMTP id z20-20020a05600c221400b0040c2680de24mr3765478wml.39.1702475905702;
        Wed, 13 Dec 2023 05:58:25 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7173:bb34:6d69:83d3? ([2001:8b0:aba:5f3c:7173:bb34:6d69:83d3])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040c57e4ea28sm4014980wmq.17.2023.12.13.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:58:25 -0800 (PST)
Message-ID: <bff0319360d0af67cd0d3ecdfb4a46e84445e2ac.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 4/4] toaster/test: Fixes functional
 tests warning on autobuilder
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 13 Dec 2023 13:58:24 +0000
In-Reply-To: <20231212141708.19395-4-alassane.yattara@savoirfairelinux.com>
References: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com>
	 <20231212141708.19395-4-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 13:58:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15660

On Tue, 2023-12-12 at 15:17 +0100, Alassane Yattara wrote:
> tests/functional/test_project_config.py::TestProjectConfig::test_set_down=
load_dir
>   /home/pokybuild/yocto-worker/toaster/build/buildtools/sysroots/x86_64-p=
okysdk-linux/usr/lib/python3.11/unittest/case.py:678: DeprecationWarning: I=
t is deprecated to return a value that is not None from a test case (<bound=
 method TestProjectConfig.test_set_download_dir of <toaster.tests.functiona=
l.test_project_config.TestProjectConfig testMethod=3Dtest_set_download_dir>=
>)
>     return self.run(*args, **kwds)
>=20
> tests/functional/test_project_config.py::TestProjectConfig::test_set_ssta=
te_dir
>   /home/pokybuild/yocto-worker/toaster/build/buildtools/sysroots/x86_64-p=
okysdk-linux/usr/lib/python3.11/unittest/case.py:678: DeprecationWarning: I=
t is deprecated to return a value that is not None from a test case (<bound=
 method TestProjectConfig.test_set_sstate_dir of <toaster.tests.functional.=
test_project_config.TestProjectConfig testMethod=3Dtest_set_sstate_dir>>)
>     return self.run(*args, **kwds)
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../tests/functional/test_project_config.py   | 164 +++++++++---------
>  1 file changed, 85 insertions(+), 79 deletions(-)
>=20
> diff --git a/lib/toaster/tests/functional/test_project_config.py b/lib/to=
aster/tests/functional/test_project_config.py
> index 2d162d81..dbee36aa 100644
> --- a/lib/toaster/tests/functional/test_project_config.py
> +++ b/lib/toaster/tests/functional/test_project_config.py
> @@ -163,51 +163,53 @@ class TestProjectConfig(SeleniumFunctionalTestCase)=
:
>              change_dl_dir_btn =3D self.wait_until_visible('#change-dl_di=
r-icon', poll=3D2)
>          except TimeoutException:
>              # If download dir is not displayed, test is skipped
> -            return True
> -        change_dl_dir_btn =3D self.wait_until_visible('#change-dl_dir-ic=
on', poll=3D2)
> -        change_dl_dir_btn.click()
> +            change_dl_dir_btn =3D None
> =20
> -        # downloads dir path doesn't start with / or ${...}
> -        input_field =3D self.wait_until_visible('#new-dl_dir', poll=3D2)
> -        input_field.clear()
> -        self.enter_text('#new-dl_dir', 'home/foo')
> -        element =3D self.wait_until_visible('#hintError-initialChar-dl_d=
ir', poll=3D2)
> +        if change_dl_dir_btn:
> +            change_dl_dir_btn =3D self.wait_until_visible('#change-dl_di=
r-icon', poll=3D2)
> +            change_dl_dir_btn.click()
> +
> +            # downloads dir path doesn't start with / or ${...}
> +            input_field =3D self.wait_until_visible('#new-dl_dir', poll=
=3D2)
> +            input_field.clear()
> +            self.enter_text('#new-dl_dir', 'home/foo')
> +            element =3D self.wait_until_visible('#hintError-initialChar-=
dl_dir', poll=3D2)
> =20
> -        msg =3D 'downloads directory path starts with invalid character =
but ' \
> -            'treated as valid'
> -        self.assertTrue((self.INVALID_PATH_START_TEXT in element.text), =
msg)
> +            msg =3D 'downloads directory path starts with invalid charac=
ter but ' \
> +                'treated as valid'
> +            self.assertTrue((self.INVALID_PATH_START_TEXT in element.tex=
t), msg)
> =20
> -        # downloads dir path has a space
> -        self.driver.find_element(By.ID, 'new-dl_dir').clear()
> -        self.enter_text('#new-dl_dir', '/foo/bar a')
> +            # downloads dir path has a space
> +            self.driver.find_element(By.ID, 'new-dl_dir').clear()
> +            self.enter_text('#new-dl_dir', '/foo/bar a')
> =20
> -        element =3D self.wait_until_visible('#hintError-dl_dir', poll=3D=
2)
> -        msg =3D 'downloads directory path characters invalid but treated=
 as valid'
> -        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
> +            element =3D self.wait_until_visible('#hintError-dl_dir', pol=
l=3D2)
> +            msg =3D 'downloads directory path characters invalid but tre=
ated as valid'
> +            self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text=
), msg)
> =20
> -        # downloads dir path starts with ${...} but has a space
> -        self.driver.find_element(By.ID,'new-dl_dir').clear()
> -        self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
> +            # downloads dir path starts with ${...} but has a space
> +            self.driver.find_element(By.ID,'new-dl_dir').clear()
> +            self.enter_text('#new-dl_dir', '${TOPDIR}/down foo')
> =20
> -        element =3D self.wait_until_visible('#hintError-dl_dir', poll=3D=
2)
> -        msg =3D 'downloads directory path characters invalid but treated=
 as valid'
> -        self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text), m=
sg)
> +            element =3D self.wait_until_visible('#hintError-dl_dir', pol=
l=3D2)
> +            msg =3D 'downloads directory path characters invalid but tre=
ated as valid'
> +            self.assertTrue((self.INVALID_PATH_CHAR_TEXT in element.text=
), msg)
> =20
> -        # downloads dir path starts with /
> -        self.driver.find_element(By.ID,'new-dl_dir').clear()
> -        self.enter_text('#new-dl_dir', '/bar/foo')
> +            # downloads dir path starts with /
> +            self.driver.find_element(By.ID,'new-dl_dir').clear()
> +            self.enter_text('#new-dl_dir', '/bar/foo')
> =20
> -        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
> -        self.assertEqual(hidden_element.is_displayed(), False,
> -            'downloads directory path valid but treated as invalid')
> +            hidden_element =3D self.driver.find_element(By.ID,'hintError=
-dl_dir')
> +            self.assertEqual(hidden_element.is_displayed(), False,
> +                'downloads directory path valid but treated as invalid')
> =20
> -        # downloads dir path starts with ${...}
> -        self.driver.find_element(By.ID,'new-dl_dir').clear()
> -        self.enter_text('#new-dl_dir', '${TOPDIR}/down')
> +            # downloads dir path starts with ${...}
> +            self.driver.find_element(By.ID,'new-dl_dir').clear()
> +            self.enter_text('#new-dl_dir', '${TOPDIR}/down')
> =20
> -        hidden_element =3D self.driver.find_element(By.ID,'hintError-dl_=
dir')
> -        self.assertEqual(hidden_element.is_displayed(), False,
> -            'downloads directory path valid but treated as invalid')
> +            hidden_element =3D self.driver.find_element(By.ID,'hintError=
-dl_dir')
> +            self.assertEqual(hidden_element.is_displayed(), False,
> +                'downloads directory path valid but treated as invalid')
> =20
>      def test_set_sstate_dir(self):
>          """
> @@ -217,53 +219,57 @@ class TestProjectConfig(SeleniumFunctionalTestCase)=
:
>          self._navigate_bbv_page()
> =20
>          try:
> -            self.wait_until_visible('#change-sstate_dir-icon', poll=3D2)
> +            btn_chg_sstate_dir =3D self.wait_until_visible(
> +                '#change-sstate_dir-icon',
> +                poll=3D2
> +            )
>              self.click('#change-sstate_dir-icon')
>          except TimeoutException:
>              # If sstate_dir is not displayed, test is skipped
> -            return True
> -

Wouldn't it be easier to do something like a self.skipTest("Some
reason") here?=C2=A0

That would mean the rest of the code didn't need to change?

Cheers,

Richard


