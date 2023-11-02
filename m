Return-Path: <alassane.yattara@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99635C4332F
	for <webhook@archiver.kernel.org>; Thu,  2 Nov 2023 14:58:48 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.33083.1698937121578081729
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Nov 2023 07:58:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=q1zYIsfN;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: alassane.yattara@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 249CD9C339B;
	Thu,  2 Nov 2023 10:58:40 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id msA93Lh32Kmm; Thu,  2 Nov 2023 10:58:35 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id ADA399C33AD;
	Thu,  2 Nov 2023 10:58:35 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com ADA399C33AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1698937115; bh=8Ze+WYXkxs/q4MJC6TEeSK4anKo8zTX1lyIXCvaIVYE=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=q1zYIsfNm9eAbvI57k/QhdkINSK9+vCxwWtn2c1nRjZ18NQo2jpRSt19Wln610EKG
	 mMbqXw2hRwAM/5U7yVvbSAPpROIdIFzBJsxwoGAOAckUqPUfv6/Y2owSXhP3PXA2rw
	 NY9DHssCh5nb4C/x+bNrE7be/fOVUxJF01Jzj3B5vzw7nZ0eu0tngfeEJDzPlfdPFz
	 6ZFXlm6xwFMdQk7X7c467RdmFORn9Qo9v5OqqqqXDzOs93JOhwn5a9vBK8qAYo9PFT
	 uOf8IWWtdm0EkoGA2qBTgl3s7+TY/Du3ikQB3NMJF1D1Yc/ZObmlpCnOdt5qLgNy0d
	 u5Ru8CrbulGNg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id hNusqtoAy_Dq; Thu,  2 Nov 2023 10:58:35 -0400 (EDT)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.48.237])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 960DD9C339B;
	Thu,  2 Nov 2023 10:58:35 -0400 (EDT)
Date: Thu, 2 Nov 2023 10:58:35 -0400 (EDT)
From: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <274479857.372292.1698937115563.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <20231102144253276e56a8@mail.local>
References: <20231031184438.743924-1-alassane.yattara@savoirfairelinux.com> <20231102144253276e56a8@mail.local>
Subject: Re: [bitbake-devel] [PATCH v2 3/3] Toaster: Test jumbotron links
 visible and clickable
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_4562 (ZimbraWebClient - GC117 (Linux)/8.8.15_GA_4570)
Thread-Topic: Toaster: Test jumbotron links visible and clickable
Thread-Index: IsGsieXYy66xumdQFz2EtWiSeY2Nuw==
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Nov 2023 14:58:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15414

Alexander,

You right i sent [PATCH v2 3/3] Toaster: Test jumbotron links visible and c=
lickable,

But not an "v2" for [bitbake-devel] [PATCH 4/4] Toaster: Remove unused slee=
p import from time,  because it hasn't.

i'll send a full series together.

Thanks,
Alassane
----- Mail original -----
De: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
=C3=80: "Alassane Yattara" <alassane.yattara@savoirfairelinux.com>, "Marlon=
 Rodriguez Garcia" <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Envoy=C3=A9: Jeudi 2 Novembre 2023 15:42:53
Objet: Re: [bitbake-devel] [PATCH v2 3/3] Toaster: Test jumbotron links vis=
ible and clickable

Hello,

I'm sorry, I have a hard time finding what to apply and in which order.

For example, this patch was sent alone and doesn't apply on master:

Alassane Yattara   31/10/23 15:20 [bitbake-devel] [PATCH 4/4] Toaster: Remo=
ve unused sleep import from time

This one was also sent alone:

Alassane Yattara   31/10/23 19:44 [bitbake-devel] [PATCH v2 3/3] Toaster: T=
est jumbotron links visible and clickable

While I could go and try to find the series it is part of, this imposes
work on the maintainer.

Can you make sure you send full series that apply on master or
master-next every time?


Also if series are depending on each other, then, this should be only
one series or you should probably wait for the first series to be
applied.

Maybe you could provide a bitbake branch so I can know what you expect
to be merged? If you do so, please ensure the content of the branch is
exactly what you sent on the list. Ideally, you would collect review
tags.

Thanks!

On 31/10/2023 19:44:38+0100, Alassane Yattara wrote:
> Test that the followings link are visible and clickable:
>  - OpenEmbedded
>  - BitBake
>  - Yocto Project
>  - Read the Toaster manual
>  - Contribute to Toaster
>=20
>  - Fixed typo: using instead of usign line:97
>  - Remove whitespace
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../tests/browser/test_landing_page.py        | 89 ++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster=
/tests/browser/test_landing_page.py
> index e731af22..756497bd 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -12,7 +12,7 @@ from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
> =20
> -from orm.models import Project, Build
> +from orm.models import Layer, Layer_Version, Project, Build
> =20
>  class TestLandingPage(SeleniumTestCase):
>      """ Tests for redirects on the landing page """
> @@ -61,6 +61,93 @@ class TestLandingPage(SeleniumTestCase):
>              'http://docs.yoctoproject.org/toaster-manual/index.html#toas=
ter-user-manual')
>          self.assertTrue("Documentation" in documentation_link.text)
> =20
> +    def test_openembedded_jumbotron_link_visible_and_clickable(self):
> +        """ Test OpenEmbedded link jumbotron is visible and clickable: "=
""
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check OpenEmbedded
> +        openembedded =3D jumbotron.find_element_by_link_text('OpenEmbedd=
ed')
> +        self.assertTrue(openembedded.is_displayed())
> +        openembedded.click()
> +        self.assertTrue("openembedded.org" in self.driver.current_url)
> +
> +    def test_bitbake_jumbotron_link_visible_and_clickable(self):
> +        """ Test BitBake link jumbotron is visible and clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check BitBake
> +        bitbake =3D jumbotron.find_element_by_link_text('BitBake')
> +        self.assertTrue(bitbake.is_displayed())
> +        bitbake.click()
> +        self.assertTrue("yoctoproject.org/software-item/bitbake" in self=
.driver.current_url)
> +
> +    def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
> +        """ Test Yocto Project link jumbotron is visible and clickable: =
"""
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Yocto Project
> +        yoctoproject =3D jumbotron.find_element_by_link_text('Yocto Proj=
ect')
> +        self.assertTrue(yoctoproject.is_displayed())
> +        yoctoproject.click()
> +        self.assertTrue("yoctoproject.org" in self.driver.current_url)
> +
> +    def test_link_setup_using_toaster_visible_and_clickable(self):
> +        """ Test big magenta button setting up and using toaster link in=
 jumbotron
> +            if visible and clickable
> +        """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Big magenta button
> +        big_magenta_button =3D jumbotron.find_element_by_link_text(
> +            'Toaster is ready to capture your command line builds'
> +        )
> +        self.assertTrue(big_magenta_button.is_displayed())
> +        big_magenta_button.click()
> +        self.assertTrue("docs.yoctoproject.org/toaster-manual/setup-and-=
use.html#setting-up-and-using-toaster" in self.driver.current_url)
> +
> +    def test_link_create_new_project_in_jumbotron_visible_and_clickable(=
self):
> +        """ Test big blue button create new project jumbotron if visible=
 and clickable """
> +        # Create a layer and a layer version to make visible the big blu=
e button
> +        layer =3D Layer.objects.create(name=3D'bar')
> +        Layer_Version.objects.create(layer=3Dlayer)
> +
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Big Blue button
> +        big_blue_button =3D jumbotron.find_element_by_link_text(
> +            'Create your first Toaster project to run manage builds'
> +        )
> +        self.assertTrue(big_blue_button.is_displayed())
> +        big_blue_button.click()
> +        self.assertTrue("toastergui/newproject/" in self.driver.current_=
url)
> +
> +    def test_toaster_manual_link_visible_and_clickable(self):
> +        """ Test Read the Toaster manual link jumbotron is visible and c=
lickable: """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Read the Toaster manual
> +        toaster_manual =3D jumbotron.find_element_by_link_text('Read the=
 Toaster manual')
> +        self.assertTrue(toaster_manual.is_displayed())
> +        toaster_manual.click()
> +        self.assertTrue("https://docs.yoctoproject.org/toaster-manual/in=
dex.html#toaster-user-manual" in self.driver.current_url)
> +
> +    def test_contrib_to_toaster_link_visible_and_clickable(self):
> +        """ Test Contribute to Toaster link jumbotron is visible and cli=
ckable: """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Contribute to Toaster
> +        contribute_to_toaster =3D jumbotron.find_element_by_link_text('C=
ontribute to Toaster')
> +        self.assertTrue(contribute_to_toaster.is_displayed())
> +        contribute_to_toaster.click()
> +        self.assertTrue("wiki.yoctoproject.org/wiki/contribute_to_toaste=
r" in str(self.driver.current_url).lower())
> +
>      def test_only_default_project(self):
>          """
>          No projects except default
> --=20
> 2.34.1
>=20

>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15379): https://lists.openembedded.org/g/bitbake-deve=
l/message/15379
> Mute This Topic: https://lists.openembedded.org/mt/102304202/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexan=
dre.belloni@bootlin.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


--=20
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

