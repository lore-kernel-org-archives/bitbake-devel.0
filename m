Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34EC41535
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 14:39:47 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
 by mx.groups.io with SMTP id smtpd.web10.287.1698763184125774962
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 07:39:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=G7XN4zF3;
 spf=pass (domain: gmail.com, ip: 209.85.219.182, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso5268911276.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 07:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698763183; x=1699367983; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IvCNB/nbFRzkzFsO8mry+k+bJgl09nvZpLPp6e8FVJ4=;
        b=G7XN4zF305y4dBA41qE2CW7YubvFMB0XxAo2aQDOd6t5UwmZv/nUslaDb5STr8aMsq
         ThAvnpSKZMKgp3bL+pAmNxTaRwHLUfDKaD8pjsjpHhYJ8WENut46nbGXQAwJm0pS9rc9
         bWr7CBxv9R3QNqPZ39o962qsx5PniucxgKoZHdErS0CLJ45NAm+TE0YgnYtOfOvF8kvZ
         3FhhzQFOihc7BsSF1vWbqccoGxFuCh8KC0//2kE2CWMZssVF+F63gW8QWDWNxos4iA+A
         rOzVnPBltxyJkeLyd/zOXwjWWJamYjLxAYm0qY0uQq5qYtwUOF381VDBaaxUVNOvDGqt
         81PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763183; x=1699367983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvCNB/nbFRzkzFsO8mry+k+bJgl09nvZpLPp6e8FVJ4=;
        b=Y91yFo/wFefLRqA7dSV1TWKVYOl/ZuEm07XAcQd0LorrJxebL6jqHchljZDbkCsMiU
         mXrUT95Uei85EfFmbGFloMaT2OBhqsSAhbXHVotbn233UYX6z2G8y4uriTsyJlLksqVY
         seNwPKQeYu3oDl29KoXEm2Nx8UnAEZDRhV1Xo4oRheNugVue7kTbEds1DRIxjB9/8Qow
         DRTeAHeTqNuY7bpwd/VtbrAk3nD/huCG4ckkV/zld2pcE0Xvbq1nrVX/PVP4dI/hlj3a
         bL139z4IDaQkhzs9da+2EOxS/uEESJOH/sYRK+ASsmjxjvS/OtEoYywjbSAJ7/IutjJn
         7OeQ==
X-Gm-Message-State: AOJu0YzP9dJTvp6xTRqhqC61J+UKmY2fKT4Q1q1RwHMq2JqIuF1lDTRs
	SeKh3e1BP30ZrbsnSYd/rNitnGOzvhcU6NFrjhI=
X-Google-Smtp-Source: AGHT+IEMcFx0eqio5Hryi8aX/WNMl40mesFLTkFnbAe75djv6HJ7qU92XcfEl326VfeFj7vSQdnV5wJnpOgogr8EycI=
X-Received: by 2002:a25:d497:0:b0:da0:5ed8:ac72 with SMTP id
 m145-20020a25d497000000b00da05ed8ac72mr12133187ybf.3.1698763182839; Tue, 31
 Oct 2023 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-4-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-4-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 07:39:31 -0700
Message-ID: <CANx9H-AgobLnNY+2CivykboxKn2eZykYRo8uXit=UAhnZ8dzaw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 4/8] Toaster: fixed pytest error: Database
 access not allowed, use the "django_db"
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000121aad060904204a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 14:39:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15340

--000000000000121aad060904204a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Pytest failed on functional/test_functional_basic because database access
> not allowed
> - we should use "django_db" fixture to allowed db access
>
> Note: Pytest-django takes a conservative approach to enabling database
> access.
> By default your tests will fail if they try to access the database.
> Only if you explicitly request database access will this be allowed.
>
> We're missing an opportunity to add a link to pytest.mark.django_db
 documentation:
https://pytest-django.readthedocs.io/en/latest/helpers.html#pytest-mark-dja=
ngo-db-request-database-access

This makes it easier for someone to review the change and for someone in
the future to understand what it does.

Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/functional/test_functional_basic.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/lib/toaster/tests/functional/test_functional_basic.py
> b/lib/toaster/tests/functional/test_functional_basic.py
> index b0def544..7e9be91c 100644
> --- a/lib/toaster/tests/functional/test_functional_basic.py
> +++ b/lib/toaster/tests/functional/test_functional_basic.py
> @@ -8,6 +8,7 @@
>  #
>
>  import re, time
> +import pytest
>  from django.urls import reverse
>  from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
>  from orm.models import Project
> @@ -16,6 +17,7 @@ from selenium.webdriver.common.by import By
>  class FuntionalTestBasic(SeleniumFunctionalTestCase):
>
>  #   testcase (1514)
> +    @pytest.mark.django_db
>      def test_create_slenium_project(self):
>

This would be a great opportunity to fix the typo in the test name
slenium -> selenium


>          project_name =3D 'selenium-project'
>          self.get(reverse('newproject'))
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15328):
> https://lists.openembedded.org/g/bitbake-devel/message/15328
> Mute This Topic: https://lists.openembedded.org/mt/102283460/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000121aad060904204a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Pytest failed on functional/t=
est_functional_basic because database access not allowed<br>
- we should use &quot;django_db&quot; fixture to allowed db access<br>
<br>
Note: Pytest-django takes a conservative approach to enabling database acce=
ss.<br>
By default your tests will fail if they try to access the database.<br>
Only if you explicitly request database access will this be allowed.<br>
<br></blockquote><div>We&#39;re missing an opportunity to add a link to=C2=
=A0<a class=3D"gmail_plusreply" id=3D"plusReplyChip-0">pytest.mark.django_d=
b </a>=C2=A0documentation:</div><div><a href=3D"https://pytest-django.readt=
hedocs.io/en/latest/helpers.html#pytest-mark-django-db-request-database-acc=
ess">https://pytest-django.readthedocs.io/en/latest/helpers.html#pytest-mar=
k-django-db-request-database-access</a><br></div><div><br></div><div>This m=
akes it easier for someone to review the change and for someone in the futu=
re to understand what it does.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0lib/toaster/tests/functional/test_functional_basic.py | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/to=
aster/tests/functional/test_functional_basic.py<br>
index b0def544..7e9be91c 100644<br>
--- a/lib/toaster/tests/functional/test_functional_basic.py<br>
+++ b/lib/toaster/tests/functional/test_functional_basic.py<br>
@@ -8,6 +8,7 @@<br>
=C2=A0#<br>
<br>
=C2=A0import re, time<br>
+import pytest<br>
=C2=A0from django.urls import reverse<br>
=C2=A0from tests.functional.functional_helpers import SeleniumFunctionalTes=
tCase<br>
=C2=A0from orm.models import Project<br>
@@ -16,6 +17,7 @@ from <a href=3D"http://selenium.webdriver.common.by" rel=
=3D"noreferrer" target=3D"_blank">selenium.webdriver.common.by</a> import B=
y<br>
=C2=A0class FuntionalTestBasic(SeleniumFunctionalTestCase):<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1514)<br>
+=C2=A0 =C2=A0 @pytest.mark.django_db<br>
=C2=A0 =C2=A0 =C2=A0def test_create_slenium_project(self):<br></blockquote>=
<div><br></div><div>This would be a great opportunity to fix the typo in th=
e test name slenium=C2=A0-&gt; selenium</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0project_name =3D &#39;selenium-project&#3=
9;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.get(reverse(&#39;newproject&#39;))<b=
r>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15328): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15328" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15328</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283460/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283460/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000121aad060904204a--

