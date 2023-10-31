Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43465C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 16:04:38 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.2754.1698768272498321001
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 09:04:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OD5Ahzr5;
 spf=pass (domain: gmail.com, ip: 209.85.219.170, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so5381415276.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 09:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698768271; x=1699373071; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhfSCEjcOCqZyBbxr/5EVsT8EhHNxCoHCds1XtCOYIY=;
        b=OD5Ahzr5ldQpzNH7M81ymhJ3jDjrAeTZeCgbYBka7MA4lfceg/t90Q4KsChb4NFtON
         mVsj6VNUBjPPYe/IrV0CgfavGuEn2Xr0gOGPSdsMlFfJYQMNeMX9+CqzW1sJBh2VlWpa
         DtSasBdVHG1XGhQVX4VGvw3YNbHA7mGouyfiPz0kX5utpyai5lOOmX7H9DGjc2na9hvO
         Lom4GL84Dlun/o52+vBsX3u5ZcZyUBKlCWSofqnAVMPf+GYXHrHZlAMF82LNG5qVRCsm
         fB/fxZ80mAw3NAeL5emeXIgmji9DdH14AoYyy7CFmvB0diWU8rhdvleZW6ubU8WUoOmb
         gBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698768271; x=1699373071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhfSCEjcOCqZyBbxr/5EVsT8EhHNxCoHCds1XtCOYIY=;
        b=UNPr0z62+3PSUJBSwilfGekebLxK/FNhzkkR8RWE4rYTuhsDGn7qWdb1+fhDL9K4mC
         /F+ZmzADqo64qIu++RD2paqLJAV+4BUDwrVMVrTfCAJNsnewv6TWaiqQet+lM99CBaxZ
         mw7q16GDgOM1kzGXZ56oeRmfgOWFq9iXpuBm1HzExxyiks8s/TjVz1fqmxBvSaxkSSQ6
         XaceOqnb6g3WNeV9YWRwD5eQA18ha40QcCwTZnQ30CDptP+UxKkD7E/mJjYy/6oXcpNx
         VoLpft5wVwY+jUzrKePkN+e9v8PZRZOv/QCw/zLcUDUscix90sgE7g0C0IXikamRWDpQ
         Qo+w==
X-Gm-Message-State: AOJu0Yzs8/Ytf410RCYv3nWX50bVbniea4mQav7wBb4/ylA/bzQkgNEZ
	nyrsQFhuRy+pO1hSew0kpYLy3zhC5JWNU800HvaHiBjH1gs=
X-Google-Smtp-Source: AGHT+IEi1ESVPISutJFjJMSMoZDPRz7liIwhvXh0vuymVvOLzSHo56KkFwocQrPo41LYslIQWjQ3ougXpN4RZBk72Uc=
X-Received: by 2002:a25:690f:0:b0:da0:cbae:34ba with SMTP id
 e15-20020a25690f000000b00da0cbae34bamr11587742ybc.33.1698768271373; Tue, 31
 Oct 2023 09:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com> <20231030222618.404081-3-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030222618.404081-3-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 09:04:19 -0700
Message-ID: <CANx9H-Bmo+SfXNQYc=vCmro0aNLav5JHjdQuh=B=4k2CkGf2dg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/3] Toaster: Test jumbotron links visible
 and clickable
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000005ef9340609054fe2"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 16:04:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15349

--0000000000005ef9340609054fe2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 3:26=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Test that the followings link are visible and clickable:
>  - OpenEmbedded
>  - BitBake
>  - Yocto Project
>  - Read the Toaster manual
>  - Contribute to Toaster
>
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  .../tests/browser/test_landing_page.py        | 89 ++++++++++++++++++-
>  1 file changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/lib/toaster/tests/browser/test_landing_page.py
> b/lib/toaster/tests/browser/test_landing_page.py
> index e731af22..ecbc0af3 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -12,7 +12,7 @@ from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
>
> -from orm.models import Project, Build
> +from orm.models import Layer, Layer_Version, Project, Build
>
>  class TestLandingPage(SeleniumTestCase):
>      """ Tests for redirects on the landing page """
> @@ -61,6 +61,93 @@ class TestLandingPage(SeleniumTestCase):
>              '
> http://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manua=
l
> ')
>          self.assertTrue("Documentation" in documentation_link.text)
>
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
> +        self.assertTrue("yoctoproject.org/software-item/bitbake" in
> self.driver.current_url)
> +
> +    def test_yoctoproject_jumbotron_link_visible_and_clickable(self):
> +        """ Test Yocto Project link jumbotron is visible and clickable:
> """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Yocto Project
> +        yoctoproject =3D jumbotron.find_element_by_link_text('Yocto
> Project')
> +        self.assertTrue(yoctoproject.is_displayed())
> +        yoctoproject.click()
> +        self.assertTrue("yoctoproject.org" in self.driver.current_url)
> +
> +    def test_link_setup_usign_toaster_visible_and_clickable(self):
>
Typo usign -> using


> +        """ Test big magenta button setting up and using toaster link in
> jumbotron
> +            if visible and clickable

Your patch has a trailing whitespace in the above line, please check for
that.

>
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
> +        self.assertTrue("
> docs.yoctoproject.org/toaster-manual/setup-and-use.html#setting-up-and-us=
ing-toaster"
> in self.driver.current_url)
> +
> +    def
> test_link_create_new_project_in_jumbotron_visible_and_clickable(self):
> +        """ Test big blue button create new project jumbotron if visible
> and clickable """
> +        # Create a layer and a layer version to make visible the big blu=
e
> button
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
> +        self.assertTrue("toastergui/newproject/" in
> self.driver.current_url)
> +
> +    def test_toaster_manual_link_visible_and_clickable(self):
> +        """ Test Read the Toaster manual link jumbotron is visible and
> clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Read the Toaster manual
> +        toaster_manual =3D jumbotron.find_element_by_link_text('Read the
> Toaster manual')
> +        self.assertTrue(toaster_manual.is_displayed())
> +        toaster_manual.click()
> +        self.assertTrue("
> https://docs.yoctoproject.org/toaster-manual/index.html#toaster-user-manu=
al"
> in self.driver.current_url)
> +
> +    def test_contrib_to_toaster_link_visible_and_clickable(self):
> +        """ Test Contribute to Toaster link jumbotron is visible and
> clickable: """
> +        self.get(reverse('landing'))
> +        jumbotron =3D self.find('.jumbotron')
> +
> +        # check Contribute to Toaster
> +        contribute_to_toaster =3D
> jumbotron.find_element_by_link_text('Contribute to Toaster')
> +        self.assertTrue(contribute_to_toaster.is_displayed())
> +        contribute_to_toaster.click()
> +        self.assertTrue("wiki.yoctoproject.org/wiki/contribute_to_toaste=
r"
> in str(self.driver.current_url).lower())
> +
>      def test_only_default_project(self):
>          """
>          No projects except default
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15335):
> https://lists.openembedded.org/g/bitbake-devel/message/15335
> Mute This Topic: https://lists.openembedded.org/mt/102286646/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000005ef9340609054fe2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 3:26=E2=80=AF=
PM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfairelinux=
.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Test that the followings link ar=
e visible and clickable:<br>
=C2=A0- OpenEmbedded<br>
=C2=A0- BitBake<br>
=C2=A0- Yocto Project<br>
=C2=A0- Read the Toaster manual<br>
=C2=A0- Contribute to Toaster<br>
<br>
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0.../tests/browser/test_landing_page.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8=
9 ++++++++++++++++++-<br>
=C2=A01 file changed, 88 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/t=
ests/browser/test_landing_page.py<br>
index e731af22..ecbc0af3 100644<br>
--- a/lib/toaster/tests/browser/test_landing_page.py<br>
+++ b/lib/toaster/tests/browser/test_landing_page.py<br>
@@ -12,7 +12,7 @@ from django.urls import reverse<br>
=C2=A0from django.utils import timezone<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
<br>
-from orm.models import Project, Build<br>
+from orm.models import Layer, Layer_Version, Project, Build<br>
<br>
=C2=A0class TestLandingPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot; Tests for redirects on the landing p=
age &quot;&quot;&quot;<br>
@@ -61,6 +61,93 @@ class TestLandingPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;<a href=3D"http://docs=
.yoctoproject.org/toaster-manual/index.html#toaster-user-manual" rel=3D"nor=
eferrer" target=3D"_blank">http://docs.yoctoproject.org/toaster-manual/inde=
x.html#toaster-user-manual</a>&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(&quot;Documentation&quot;=
 in documentation_link.text)<br>
<br>
+=C2=A0 =C2=A0 def test_openembedded_jumbotron_link_visible_and_clickable(s=
elf):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test OpenEmbedded link jumb=
otron is visible and clickable: &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check OpenEmbedded<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openembedded =3D jumbotron.find_element_by_lin=
k_text(&#39;OpenEmbedded&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(openembedded.is_displayed())<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 openembedded.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;<a href=3D"http://openem=
bedded.org" rel=3D"noreferrer" target=3D"_blank">openembedded.org</a>&quot;=
 in self.driver.current_url)<br>
+<br>
+=C2=A0 =C2=A0 def test_bitbake_jumbotron_link_visible_and_clickable(self):=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test BitBake link jumbotron=
 is visible and clickable: &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check BitBake<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake =3D jumbotron.find_element_by_link_tex=
t(&#39;BitBake&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(bitbake.is_displayed())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;<a href=3D"http://yoctop=
roject.org/software-item/bitbake" rel=3D"noreferrer" target=3D"_blank">yoct=
oproject.org/software-item/bitbake</a>&quot; in self.driver.current_url)<br=
>
+<br>
+=C2=A0 =C2=A0 def test_yoctoproject_jumbotron_link_visible_and_clickable(s=
elf):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test Yocto Project link jum=
botron is visible and clickable: &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check Yocto Project<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 yoctoproject =3D jumbotron.find_element_by_lin=
k_text(&#39;Yocto Project&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(yoctoproject.is_displayed())<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 yoctoproject.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;<a href=3D"http://yoctop=
roject.org" rel=3D"noreferrer" target=3D"_blank">yoctoproject.org</a>&quot;=
 in self.driver.current_url)<br>
+<br>
+=C2=A0 =C2=A0 def test_link_setup_usign_toaster_visible_and_clickable(self=
):<br></blockquote><div>Typo usign=C2=A0-&gt; using</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test big magenta button set=
ting up and using toaster link in jumbotron<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if visible and clickable</blockq=
uote><div>Your patch has a trailing whitespace in the above line, please ch=
eck for that.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
 <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check Big magenta button<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 big_magenta_button =3D jumbotron.find_element_=
by_link_text(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Toaster is ready to capture=
 your command line builds&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(big_magenta_button.is_displaye=
d())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 big_magenta_button.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;<a href=3D"http://docs.y=
octoproject.org/toaster-manual/setup-and-use.html#setting-up-and-using-toas=
ter" rel=3D"noreferrer" target=3D"_blank">docs.yoctoproject.org/toaster-man=
ual/setup-and-use.html#setting-up-and-using-toaster</a>&quot; in self.drive=
r.current_url)<br>
+<br>
+=C2=A0 =C2=A0 def test_link_create_new_project_in_jumbotron_visible_and_cl=
ickable(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test big blue button create=
 new project jumbotron if visible and clickable &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Create a layer and a layer version to make v=
isible the big blue button<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layer =3D Layer.objects.create(name=3D&#39;bar=
&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Layer_Version.objects.create(layer=3Dlayer)<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check Big Blue button<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 big_blue_button =3D jumbotron.find_element_by_=
link_text(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;Create your first Toaster p=
roject to run manage builds&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(big_blue_button.is_displayed()=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 big_blue_button.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;toastergui/newproject/&q=
uot; in self.driver.current_url)<br>
+<br>
+=C2=A0 =C2=A0 def test_toaster_manual_link_visible_and_clickable(self):<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test Read the Toaster manua=
l link jumbotron is visible and clickable: &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check Read the Toaster manual<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 toaster_manual =3D jumbotron.find_element_by_l=
ink_text(&#39;Read the Toaster manual&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(toaster_manual.is_displayed())=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 toaster_manual.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;<a href=3D"https://docs.=
yoctoproject.org/toaster-manual/index.html#toaster-user-manual" rel=3D"nore=
ferrer" target=3D"_blank">https://docs.yoctoproject.org/toaster-manual/inde=
x.html#toaster-user-manual</a>&quot; in self.driver.current_url)<br>
+<br>
+=C2=A0 =C2=A0 def test_contrib_to_toaster_link_visible_and_clickable(self)=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test Contribute to Toaster =
link jumbotron is visible and clickable: &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 jumbotron =3D self.find(&#39;.jumbotron&#39;)<=
br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check Contribute to Toaster<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 contribute_to_toaster =3D jumbotron.find_eleme=
nt_by_link_text(&#39;Contribute to Toaster&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(contribute_to_toaster.is_displ=
ayed())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 contribute_to_toaster.click()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;<a href=3D"http://wiki.y=
octoproject.org/wiki/contribute_to_toaster" rel=3D"noreferrer" target=3D"_b=
lank">wiki.yoctoproject.org/wiki/contribute_to_toaster</a>&quot; in str(sel=
f.driver.current_url).lower())<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def test_only_default_project(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No projects except default<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15335): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15335" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15335</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102286646/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102286646/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000005ef9340609054fe2--

