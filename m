Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A039CC4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:44:57 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web10.425.1698763490247830204
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:44:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HHT2teVL;
 spf=pass (domain: gmail.com, ip: 209.85.219.179, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d8a000f6a51so5090010276.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 07:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698763489; x=1699368289; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9+CJ0n4k/ql7Dyzj0xuKkjLjm3QUN7o3U1HaucATvY=;
        b=HHT2teVLZ4bquBq+RoikClUHmD4AC0bKjPIuv2H5xEc+psOwLNla3x3w9AvszAZftM
         111UoKdu5F0gECViafwtOGgWWEbEBWIXyEsYLf7JoLcBVcriaegbgA4FCo2q4XV/GE77
         8esY54RRDPcbigkfA3vku8OTGxvraPpWVAQBQ2jCMZfB6CrF4h/mqGgOaDhlrEZK5aZk
         jJ3+G7Z3+4v19m8Eep661z/N9kmzyZu8zoOhucKwK3oyvS+n3CmxglnTF5MQo2Js//f5
         djM/lHXBoHWsPQfK1JNC13J5czMSDFRx5GmqcSv4BkBUAI6sHDBtpIy1UKPFbSm7YXNy
         jTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763489; x=1699368289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9+CJ0n4k/ql7Dyzj0xuKkjLjm3QUN7o3U1HaucATvY=;
        b=reW1ABVaCQ/aiUw83j0xjKHpgW0fMLv1K13Yh3la2mq17RbRjWLyZj2PFCRVG831WY
         cA6Omug02CQvI6VdRsV8sQcVqi0k62sAYSUq3K6lZYG6kXzhG3XJKTjGiNCYUDSj8Y3R
         XekCrnPfbRKssaXNFwIybeHxH1xAK23Nc47DGggp3pCva5KEYJJdkQNpwELYSipESaXX
         6mhbl7iKIiB273+LkOJeLvGOgK0TzA+zdF/DWhhCdphqZCVHCciltI2m4NoW5+xRikAZ
         njBp/JqIKkq5x/1+cUf+tfOyzJ0BcNEFxULmUb20d+w32PawNpl3TQPE6B8xEio0BjLE
         nGZw==
X-Gm-Message-State: AOJu0YzAnJfC0+6MWIIodArWoxe4M7ylu5gAHF0A1gvbGi8AfA16nOsL
	+xieHKt//WrKYREMSfNEBF9Wkb7XeVeumPaQ6X2kKY3AjOtvdw==
X-Google-Smtp-Source: AGHT+IFOe2eB4wyePbGxv9xZKAZ1Grb298VSxES6A8sp9zFBY0MAN4B4xH5vJQZz8DSC2ArEYb+GIyVCgIyYZBb3qXk=
X-Received: by 2002:a5b:9d2:0:b0:d9a:642b:3500 with SMTP id
 y18-20020a5b09d2000000b00d9a642b3500mr11085637ybq.12.1698763489145; Tue, 31
 Oct 2023 07:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-3-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-3-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 07:44:38 -0700
Message-ID: <CANx9H-C9TNSg+C0gZZZzBTPaiJwxhnq6PgQ-H2iGz63OqWgcxg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/8] Toaster: Bug-fix pytest and Failed:
 Database access not allowed
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000053f8ac060904321c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:44:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15341

--00000000000053f8ac060904321c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Remove load and create build environment from
> tests/functional/functional_helpers
>
> We really need some explanation of why here. This seems like it is
crippling the whole purpose of Toaster and hence the tests: running builds.

If another commit is adding a different way of accomplishing the same
thing, then that should be documented here.

Can we not mark the class with @pytest.mark.django_db?
" Remember that you can apply marks at the single test level, the class
level, the module level, and dynamically in a hook or fixture."
https://pytest-django.readthedocs.io/en/latest/helpers.html#markers

If this code is really not needed, then an explanation of why it is not
needed should be provided.



> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/functional/functional_helpers.py | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/lib/toaster/tests/functional/functional_helpers.py
> b/lib/toaster/tests/functional/functional_helpers.py
> index c3191f66..b80d403b 100644
> --- a/lib/toaster/tests/functional/functional_helpers.py
> +++ b/lib/toaster/tests/functional/functional_helpers.py
> @@ -15,8 +15,6 @@ import time
>  import re
>
>  from tests.browser.selenium_helpers_base import SeleniumTestCaseBase
> -from tests.builds.buildtest import load_build_environment
> -from bldcontrol.models import BuildEnvironment
>  from selenium.webdriver.common.by import By
>  from selenium.common.exceptions import NoSuchElementException
>
> @@ -33,10 +31,6 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase)=
:
>              raise RuntimeError("Please initialise django with the tests
> settings:  " \
>                  "DJANGO_SETTINGS_MODULE=3D'toastermain.settings_test'")
>
> -        if BuildEnvironment.objects.count() =3D=3D 0:
> -
> BuildEnvironment.objects.create(betype=3DBuildEnvironment.TYPE_LOCAL)
> -        load_build_environment()
> -
>          # start toaster
>          cmd =3D "bash -c 'source toaster start'"
>          p =3D subprocess.Popen(
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15327):
> https://lists.openembedded.org/g/bitbake-devel/message/15327
> Mute This Topic: https://lists.openembedded.org/mt/102283458/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000053f8ac060904321c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Remove load=
 and create build environment from tests/functional/functional_helpers<br>
<br></blockquote><div>We really need some explanation of why here. This see=
ms like it is crippling the whole purpose of Toaster and hence the tests: r=
unning builds.</div><div><br></div><div>If another commit is adding a diffe=
rent way of accomplishing the same thing, then that should be documented he=
re.</div><div><br></div><div>Can we not mark the class with=C2=A0<a class=
=3D"gmail_plusreply" id=3D"plusReplyChip-1">@pytest.mark.django_db?</a></di=
v><div>&quot;=C2=A0Remember that you can apply marks at the single test lev=
el, the class level, the module level, and dynamically in a hook or fixture=
.&quot;</div><div><a href=3D"https://pytest-django.readthedocs.io/en/latest=
/helpers.html#markers">https://pytest-django.readthedocs.io/en/latest/helpe=
rs.html#markers</a></div><div><br></div><div>If this code is really not nee=
ded, then an explanation of why it is not needed should be provided.<br><a =
class=3D"gmail_plusreply"><br></a></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0lib/toaster/tests/functional/functional_helpers.py | 6 ------<br>
=C2=A01 file changed, 6 deletions(-)<br>
<br>
diff --git a/lib/toaster/tests/functional/functional_helpers.py b/lib/toast=
er/tests/functional/functional_helpers.py<br>
index c3191f66..b80d403b 100644<br>
--- a/lib/toaster/tests/functional/functional_helpers.py<br>
+++ b/lib/toaster/tests/functional/functional_helpers.py<br>
@@ -15,8 +15,6 @@ import time<br>
=C2=A0import re<br>
<br>
=C2=A0from tests.browser.selenium_helpers_base import SeleniumTestCaseBase<=
br>
-from tests.builds.buildtest import load_build_environment<br>
-from bldcontrol.models import BuildEnvironment<br>
=C2=A0from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferre=
r" target=3D"_blank">selenium.webdriver.common.by</a> import By<br>
=C2=A0from selenium.common.exceptions import NoSuchElementException<br>
<br>
@@ -33,10 +31,6 @@ class SeleniumFunctionalTestCase(SeleniumTestCaseBase):<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise RuntimeError(&quot;Pl=
ease initialise django with the tests settings:=C2=A0 &quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;DJANGO_=
SETTINGS_MODULE=3D&#39;toastermain.settings_test&#39;&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if BuildEnvironment.objects.count() =3D=3D 0:<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BuildEnvironment.objects.create(=
betype=3DBuildEnvironment.TYPE_LOCAL)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 load_build_environment()<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# start toaster<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd =3D &quot;bash -c &#39;source toaster=
 start&#39;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D subprocess.Popen(<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15327): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15327" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15327</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283458/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283458/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--00000000000053f8ac060904321c--

