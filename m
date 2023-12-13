Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CB5C4332F
	for <webhook@archiver.kernel.org>; Wed, 13 Dec 2023 14:30:53 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.37512.1702477843923989818
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Dec 2023 06:30:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YZKa2yIq;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ADFE99C102B;
	Wed, 13 Dec 2023 09:30:42 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id HQYoov630OaB; Wed, 13 Dec 2023 09:30:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id EE3039C320B;
	Wed, 13 Dec 2023 09:30:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com EE3039C320B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702477841; bh=sWENcgS27UGzsvY2qzxhbql7jbDre/n4AowBokgOdjU=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=YZKa2yIqXd8hSyPq1x6rGSP01SDuQxgvnzE3TdQRPX/TEkXh+BVuXJFMFkEwxe2fH
	 07raPSx+ESZ4LRthuhi70LmtEIWdlb4tTxHOBnpbVXbayio+JyezFKd44wVuRZfpH6
	 SkbyTTM1FKih+y9Z0QB2AKvS301VT1dy/cgW9En9fjou3wVuijoFMA8NDVw/sXllDG
	 BJEEuUyZptKYkL5uLRSse3fgTJOIkX0JJBt8iGMOEpmQIyKavDCvZJ4mQT7NKLDFjx
	 sZj6d16qmjknNm/ntgBARNm1iyHPCfbky0Io0xkEOGBGo3IFkSSXN8MlvhJ7976o/n
	 JxDIEbCxcd97w==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 1He_-kWL5AEC; Wed, 13 Dec 2023 09:30:41 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DA68E9C102B;
	Wed, 13 Dec 2023 09:30:41 -0500 (EST)
Date: Wed, 13 Dec 2023 09:30:41 -0500 (EST)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <997322523.77393.1702477841842.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <bff0319360d0af67cd0d3ecdfb4a46e84445e2ac.camel@linuxfoundation.org>
References: <20231212141708.19395-1-alassane.yattara@savoirfairelinux.com> <20231212141708.19395-4-alassane.yattara@savoirfairelinux.com> <bff0319360d0af67cd0d3ecdfb4a46e84445e2ac.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 4/4] toaster/test: Fixes functional
 tests warning on autobuilder
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC119 (Linux)/8.8.15_GA_4570)
Thread-Topic: toaster/test: Fixes functional tests warning on autobuilder
Thread-Index: vhSQwO013Mka3PrJh+4Rm1yODNCWFw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Dec 2023 14:30:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15662

Richard,

Also, I am currently working on a new version of this series of patches wit=
h new bug-fixes on functional tests.

Alassane
----- Mail original -----
De: "Richard Purdie" <richard.purdie@linuxfoundation.org>
=C3=80: "Alassane Yattara" <alassane.yattara@savoirfairelinux.com>, "bitbak=
e-devel" <bitbake-devel@lists.openembedded.org>
Envoy=C3=A9: Mercredi 13 D=C3=A9cembre 2023 14:58:24
Objet: Re: [bitbake-devel] [PATCH 4/4] toaster/test: Fixes functional tests=
 warning on autobuilder

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

