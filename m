Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153BC41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 15:29:17 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
 by mx.groups.io with SMTP id smtpd.web10.1746.1698766149588465680
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 08:29:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RAj6qocR;
 spf=pass (domain: gmail.com, ip: 209.85.219.174, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9ac9573274so5315323276.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 08:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766149; x=1699370949; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whLi5Hmyw6oBviuDhSFFYkxHUnlA+Zk9QzSkUotFHo8=;
        b=RAj6qocR2ARuGzF9Hlhj+nRTPGj79Ymqn4IoKJr1ZLILUqdCemPEfhGpFUHLuyqGe5
         jWac5T57i9wrNgSf3zH/RYqb+HkmR1tm+mbaGPQhuqxs9aWJ+TnlNkRdlfozfyN4wwUC
         vc0KtOwNatWNsmv+gE4GVgQUPXdCb8Ejvudm7i4aAr/fipKHB2SKs837uNM0W/obdtoN
         xE9hFD+i0i+xEfNpoZAj58HThumByRX7q1A+0k1nqFKHMRNGIbEiXFcMDBcDCdgvky+2
         Hs4o1v+XfrQt/XJPuox7YrhL0FU/DpV4YK8R3xgA/wAal0xBSr/CY1fHHMp3ZDYOJ7zl
         gp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766149; x=1699370949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whLi5Hmyw6oBviuDhSFFYkxHUnlA+Zk9QzSkUotFHo8=;
        b=RGW/KG6mhjp9+zQuPPZbk1JCSYTRNRlogHFnqOvZEF6+ECjFlNNAk7TiglcL83mpSG
         WLomXbCESYaSi0o7YXPLjfczMClXMC+CoIzZOMSuxRiUz/J/awWZpP1Jj5IYODFVCuY9
         KZyNj6Onv2iWXzUoIO9ZtCA/UAn0kY0eFApbtKd0Qk6cu3E168K3XzbI0p0lLd5zu0ZK
         1Ov5u7uxfUKbb9cPcDRgfRADc4n4blR9QQbrC3ZeCTtKpbBf20/qc7dOQa6abtwY+zjq
         VUf4eWydZ5zxhj+b7RQK3/SVsUDxb21/vm86t++CEfk2pyESxw/Yrkp04fjCGk4moCCw
         mb2Q==
X-Gm-Message-State: AOJu0YzkkJs+jWEDvWxxuo9azExRhf818zv0WHd0mduD0bCsCZXxY6Mo
	HfXXzJ7lHy6RjEt7Pi3n7bwCJpg32Kocg6ZgFbCvoE2vvaI=
X-Google-Smtp-Source: AGHT+IFcUazeZPaqEz+op5D7CKoRLx6+mizSEql+dzc0qnVPzV859DMhd3zCfUfeA0TfdQN9pEy5f0RTsFUKncM5/6U=
X-Received: by 2002:a25:cf88:0:b0:d9a:ed4d:b396 with SMTP id
 f130-20020a25cf88000000b00d9aed4db396mr11967286ybg.6.1698766148710; Tue, 31
 Oct 2023 08:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030222618.404081-1-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 08:28:57 -0700
Message-ID: <CANx9H-CjFsyKpJ-HtLVJnozJhxM4D2==nWX=Yzo2_rsQgPvmzw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] Toaster: Check info_sign is visible
 and clickable in landing page
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000d9bde7060904d0ea"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 15:29:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15347

--000000000000d9bde7060904d0ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 3:26=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Check the information icon is visible and clickable
> Also if popup appearing when clicked and contain "Toaster version
> information"
>
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/browser/test_landing_page.py | 17 +++++++++++++++++
>  lib/toaster/toastergui/templates/base.html     |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/lib/toaster/tests/browser/test_landing_page.py
> b/lib/toaster/tests/browser/test_landing_page.py
> index 8bb64b9f..2f092400 100644
> --- a/lib/toaster/tests/browser/test_landing_page.py
> +++ b/lib/toaster/tests/browser/test_landing_page.py
> @@ -7,6 +7,7 @@
>  # Copyright (C) 2013-2016 Intel Corporation
>  #
>
> +from time import sleep
>

This import is unused in this commit. Also, in general we want to avoid
tests that rely on specific timing anyway.


>  from django.urls import reverse
>  from django.utils import timezone
>  from tests.browser.selenium_helpers import SeleniumTestCase
> @@ -29,6 +30,22 @@ class TestLandingPage(SeleniumTestCase):
>          self.project.is_default =3D True
>          self.project.save()
>
>
The test case itself seems reasonable.


> +    def test_icon_info_visible_and_clickable(self):
> +        """ Test that the information icon is visible and clickable """
> +        self.get(reverse('landing'))
> +        info_sign =3D self.find('#toaster-version-info-sign')
> +
> +        # check that the info sign is visible
> +        self.assertTrue(info_sign.is_displayed())
> +
> +        # check that the info sign is clickable
> +        # and info modal is appearing when clicking on the info sign
> +        info_sign.click() # click on the info sign make attribute
> 'aria-describedby' visible
> +        info_model_id =3D info_sign.get_attribute('aria-describedby')
> +        info_modal =3D self.find(f'#{info_model_id}')
> +        self.assertTrue(info_modal.is_displayed())
> +        self.assertTrue("Toaster version information" in info_modal.text=
)
> +
>      def test_only_default_project(self):
>          """
>          No projects except default
> diff --git a/lib/toaster/toastergui/templates/base.html
> b/lib/toaster/toastergui/templates/base.html
> index e8600f3e..041448d1 100644
> --- a/lib/toaster/toastergui/templates/base.html
> +++ b/lib/toaster/toastergui/templates/base.html
> @@ -94,7 +94,7 @@
>              </a>
>              <a class=3D"brand" href=3D"/">Toaster</a>
>              {% if DEBUG %}
> -            <span class=3D"glyphicon glyphicon-info-sign"
> title=3D"<strong>Toaster version information</strong>"
> data-content=3D"<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git
> revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>"></i>
> +            <span id=3D"toaster-version-info-sign" class=3D"glyphicon
> glyphicon-info-sign" title=3D"<strong>Toaster version information</strong=
>"
> data-content=3D"<dl><dt>Git branch</dt><dd>{{TOASTER_BRANCH}}</dd><dt>Git
> revision</dt><dd>{{TOASTER_REVISION}}</dd></dl>">


Adding an id for the span is very helpful for both testing and using e.g.
Developer Tools in Chromium or Firefox. Good idea.


> </i>
>              {% endif %}
>            </div>
>          </div>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15333):
> https://lists.openembedded.org/g/bitbake-devel/message/15333
> Mute This Topic: https://lists.openembedded.org/mt/102286644/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000d9bde7060904d0ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 3:26=E2=80=AF=
PM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfairelinux=
.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Check the information icon is vi=
sible and clickable<br>
Also if popup appearing when clicked and contain &quot;Toaster version info=
rmation&quot;<br>
<br>
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0lib/toaster/tests/browser/test_landing_page.py | 17 +++++++++++++++++=
<br>
=C2=A0lib/toaster/toastergui/templates/base.html=C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
=C2=A02 files changed, 18 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/toaster/tests/browser/test_landing_page.py b/lib/toaster/t=
ests/browser/test_landing_page.py<br>
index 8bb64b9f..2f092400 100644<br>
--- a/lib/toaster/tests/browser/test_landing_page.py<br>
+++ b/lib/toaster/tests/browser/test_landing_page.py<br>
@@ -7,6 +7,7 @@<br>
=C2=A0# Copyright (C) 2013-2016 Intel Corporation<br>
=C2=A0#<br>
<br>
+from time import sleep<br></blockquote><div><br></div><div>This import is =
unused in this commit. Also, in general we want to avoid tests that rely on=
 specific timing anyway.</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
=C2=A0from django.urls import reverse<br>
=C2=A0from django.utils import timezone<br>
=C2=A0from tests.browser.selenium_helpers import SeleniumTestCase<br>
@@ -29,6 +30,22 @@ class TestLandingPage(SeleniumTestCase):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.project.is_default =3D True<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.project.save()<br>
<br></blockquote><div><br></div><div>The test case itself seems reasonable.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 def test_icon_info_visible_and_clickable(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot; Test that the information i=
con is visible and clickable &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.get(reverse(&#39;landing&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info_sign =3D self.find(&#39;#toaster-version-=
info-sign&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check that the info sign is visible<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(info_sign.is_displayed())<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # check that the info sign is clickable<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # and info modal is appearing when clicking on=
 the info sign<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info_sign.click() # click on the info sign mak=
e attribute &#39;aria-describedby&#39; visible<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info_model_id =3D info_sign.get_attribute(&#39=
;aria-describedby&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info_modal =3D self.find(f&#39;#{info_model_id=
}&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(info_modal.is_displayed())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(&quot;Toaster version informat=
ion&quot; in info_modal.text)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def test_only_default_project(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0No projects except default<br>
diff --git a/lib/toaster/toastergui/templates/base.html b/lib/toaster/toast=
ergui/templates/base.html<br>
index e8600f3e..041448d1 100644<br>
--- a/lib/toaster/toastergui/templates/base.html<br>
+++ b/lib/toaster/toastergui/templates/base.html<br>
@@ -94,7 +94,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/a&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;a class=3D&quot;brand&q=
uot; href=3D&quot;/&quot;&gt;Toaster&lt;/a&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{% if DEBUG %}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;span class=3D&quot;glyphicon=
 glyphicon-info-sign&quot; title=3D&quot;&lt;strong&gt;Toaster version info=
rmation&lt;/strong&gt;&quot; data-content=3D&quot;&lt;dl&gt;&lt;dt&gt;Git b=
ranch&lt;/dt&gt;&lt;dd&gt;{{TOASTER_BRANCH}}&lt;/dd&gt;&lt;dt&gt;Git revisi=
on&lt;/dt&gt;&lt;dd&gt;{{TOASTER_REVISION}}&lt;/dd&gt;&lt;/dl&gt;&quot;&gt;=
&lt;/i&gt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;span id=3D&quot;toaster-vers=
ion-info-sign&quot; class=3D&quot;glyphicon glyphicon-info-sign&quot; title=
=3D&quot;&lt;strong&gt;Toaster version information&lt;/strong&gt;&quot; dat=
a-content=3D&quot;&lt;dl&gt;&lt;dt&gt;Git branch&lt;/dt&gt;&lt;dd&gt;{{TOAS=
TER_BRANCH}}&lt;/dd&gt;&lt;dt&gt;Git revision&lt;/dt&gt;&lt;dd&gt;{{TOASTER=
_REVISION}}&lt;/dd&gt;&lt;/dl&gt;&quot;&gt;</blockquote><div><br></div><div=
>Adding an id for the span is very helpful for both testing and using e.g. =
Developer Tools in Chromium or Firefox. Good idea.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">&lt;/i&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{% endif %}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/div&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;/div&gt;<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15333): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15333" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15333</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102286644/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102286644/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000d9bde7060904d0ea--

