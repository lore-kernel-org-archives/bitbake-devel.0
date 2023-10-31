Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC585C4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 15:07:27 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web10.1120.1698764847109986205
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 08:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XecpBsV3;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: ticotimo@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6cd09663b1cso3340732a34.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698764846; x=1699369646; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3AVzxCXZgDaTuqM+Y+u+SYKPLmxAUTr6wOHu/vMFJo=;
        b=XecpBsV3L77t6QCy4n2ZJMQcDFbdm0MbVAmMw4XO4ZxXV85x0rtajjChWYnfAQUpei
         lSmBIJx8TIpDRU6tkMwNxZEhoidiUIUysUONd5VbF1ke9yvvFFqiGA9Mz3TFRcz8OGA5
         f6hPzKW61zpwOZDNGCr5+xgQXyYZUG7ZuHcN5eYNpqZGcZb5mIVAyDsMkUGJus+UR6VN
         Webj6Jz0IrbDU5jCBjf3LeXuvAtCwnLTFzJcXOLipLW8fF7Q0IuFfv97N3NA5/EZCQZY
         L109C8mZ8w7TqNnHfwOjv63urQALyYfjAikUr9vohPCoHogD6jzZ+TLw1OxNSz0tfTiE
         SgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764846; x=1699369646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3AVzxCXZgDaTuqM+Y+u+SYKPLmxAUTr6wOHu/vMFJo=;
        b=xAqeALX84uzUAQpXhKpn1SBDYCFAUwAShnQgrUCcbKQHZSSwnd2zu4LDeiWvRoMlHa
         upekzGt72G1irKqkkCD4vn+MRSbBCU8Rr3T41abNkAN2og+mBKBdKEaphavBVp/CYN9x
         XQ/+kqeYbDzwVzGudlusmSGO59weo7rCmnRYXU6i0O9aGZId3uPw57aiqogTViW2K6vF
         OERiasuEZffFeSGA7WJ6osG8Q7x+bZkl/LxFw4d41deX5UGXsCAjOhlN9z96JjWo+8FE
         jks3wxjl+1KDajvXuwNhM2TEmDf8Q6lU/tTenjeMugirralpZmeD1lZywtOj5osQ50sp
         5N5g==
X-Gm-Message-State: AOJu0YymhUUOb1oVHnHYM2vc6AO6M3Ewz9ixA7DTXT+AZ6Kw2nV0x6Zb
	y6pbACeWJpmiF7qKFKiQFwC/DztXNhCOEnLZa4mb0fOJxzs=
X-Google-Smtp-Source: AGHT+IEuipkXcXZg1S3SLZOn8W8L+Aur7dsejgyeNn2HH/nX/cvsmzcPIYRGD6PBbvlwN1LFndqIE8NORxpAH36htaM=
X-Received: by 2002:a05:6830:43a6:b0:6bc:9824:5089 with SMTP id
 s38-20020a05683043a600b006bc98245089mr15888672otv.4.1698764846368; Tue, 31
 Oct 2023 08:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-7-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-7-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 08:07:15 -0700
Message-ID: <CANx9H-BwNdO1LFzwuu1yEwJ_5ApTTCSuKssn6VUPp2T95MMMCg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 7/8] Toaster: fixed: Tests fail when
 executed one after the other out of sequence
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000398cbe0609048379"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 15:07:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15344

--000000000000398cbe0609048379
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> As mentionned in earlier commit, pytest-django takes a conservative
> approach
> to enabling database access. By default our tests will fail if they try t=
o
> access
> the database, Only if we explicitly request database access will this be
> allowed,
> using pytest marks to tell pytest-django our test needs database access.
>
> A side effect of pytest mark, is test_case method marked is execute out o=
f
> scope of its module class, which create an inconsistance sequence and mak=
e
> fails
> followings tests.
>
> The scope of the ordering is global per default, e.g. tests with lower
> ordinal
> numbers are always executed before tests with higher numbers in the same
> test session,
> regardless of the module and class they reside in. This can be changed by
> using
> the --order-scope option from module pytest-order.
>
> To fix that i added execution order to tests suite using pytest-order.
>
>
This seems like a reasonable explanation of what is happening and why the
change is being made.


> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
>
Reviewed-by: Tim Orling <tim.orling@konsulko.com>

> ---
>  lib/toaster/tests/functional/test_functional_basic.py | 4 +++-
>  lib/toaster/tests/toaster-tests-requirements.txt      | 1 +
>  lib/toaster/tests/views/test_views.py                 | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/toaster/tests/functional/test_functional_basic.py
> b/lib/toaster/tests/functional/test_functional_basic.py
> index 7e9be91c..f558cce8 100644
> --- a/lib/toaster/tests/functional/test_functional_basic.py
> +++ b/lib/toaster/tests/functional/test_functional_basic.py
> @@ -8,12 +8,14 @@
>  #
>
>  import re, time
> -import pytest
>  from django.urls import reverse
> +import pytest
>  from tests.functional.functional_helpers import SeleniumFunctionalTestCa=
se
>  from orm.models import Project
>  from selenium.webdriver.common.by import By
>
> +
> +@pytest.mark.order("last")
>  class FuntionalTestBasic(SeleniumFunctionalTestCase):
>
>  #   testcase (1514)
> diff --git a/lib/toaster/tests/toaster-tests-requirements.txt
> b/lib/toaster/tests/toaster-tests-requirements.txt
> index 7109c625..71cc0834 100644
> --- a/lib/toaster/tests/toaster-tests-requirements.txt
> +++ b/lib/toaster/tests/toaster-tests-requirements.txt
> @@ -4,3 +4,4 @@ pytest-django=3D=3D4.5.2
>  pytest-env=3D=3D1.1.0
>  pytest-html=3D=3D4.0.2
>  pytest-metadata=3D=3D3.0.0
> +pytest-order=3D=3D1.1.0
> diff --git a/lib/toaster/tests/views/test_views.py
> b/lib/toaster/tests/views/test_views.py
> index 06bf6c20..349881eb 100644
> --- a/lib/toaster/tests/views/test_views.py
> +++ b/lib/toaster/tests/views/test_views.py
> @@ -9,6 +9,7 @@
>
>  """Test cases for Toaster GUI and ReST."""
>
> +import pytest
>  from django.test import TestCase
>  from django.test.client import RequestFactory
>  from django.urls import reverse
> @@ -33,6 +34,7 @@ PROJECT_NAME2 =3D "test project 2"
>  CLI_BUILDS_PROJECT_NAME =3D 'Command line builds'
>
>
> +@pytest.mark.order(1)
>  class ViewTests(TestCase):
>      """Tests to verify view APIs."""
>
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15331):
> https://lists.openembedded.org/g/bitbake-devel/message/15331
> Mute This Topic: https://lists.openembedded.org/mt/102283465/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000398cbe0609048379
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">As mentionned in earlier comm=
it, pytest-django takes a conservative approach<br>
to enabling database access. By default our tests will fail if they try to =
access<br>
the database, Only if we explicitly request database access will this be al=
lowed,<br>
using pytest marks to tell pytest-django our test needs database access.<br=
>
<br>
A side effect of pytest mark, is test_case method marked is execute out of<=
br>
scope of its module class, which create an inconsistance sequence and make =
fails<br>
followings tests.<br>
<br>
The scope of the ordering is global per default, e.g. tests with lower ordi=
nal<br>
numbers are always executed before tests with higher numbers in the same te=
st session,<br>
regardless of the module and class they reside in. This can be changed by u=
sing<br>
the --order-scope option from module pytest-order.<br>
<br>
To fix that i added execution order to tests suite using pytest-order.<br>
<br></blockquote><div><br></div><div>This seems like a reasonable explanati=
on of what is happening and why the change is being made.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br></blockquote><div>Reviewed-by: Tim Orling &lt;<a href=3D"mailto:t=
im.orling@konsulko.com">tim.orling@konsulko.com</a>&gt;=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/toaster/tests/functional/test_functional_basic.py | 4 +++-<br>
=C2=A0lib/toaster/tests/toaster-tests-requirements.txt=C2=A0 =C2=A0 =C2=A0 =
| 1 +<br>
=C2=A0lib/toaster/tests/views/test_views.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A03 files changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/toaster/tests/functional/test_functional_basic.py b/lib/to=
aster/tests/functional/test_functional_basic.py<br>
index 7e9be91c..f558cce8 100644<br>
--- a/lib/toaster/tests/functional/test_functional_basic.py<br>
+++ b/lib/toaster/tests/functional/test_functional_basic.py<br>
@@ -8,12 +8,14 @@<br>
=C2=A0#<br>
<br>
=C2=A0import re, time<br>
-import pytest<br>
=C2=A0from django.urls import reverse<br>
+import pytest<br>
=C2=A0from tests.functional.functional_helpers import SeleniumFunctionalTes=
tCase<br>
=C2=A0from orm.models import Project<br>
=C2=A0from <a href=3D"http://selenium.webdriver.common.by" rel=3D"noreferre=
r" target=3D"_blank">selenium.webdriver.common.by</a> import By<br>
<br>
+<br>
+@pytest.mark.order(&quot;last&quot;)<br>
=C2=A0class FuntionalTestBasic(SeleniumFunctionalTestCase):<br>
<br>
=C2=A0#=C2=A0 =C2=A0testcase (1514)<br>
diff --git a/lib/toaster/tests/toaster-tests-requirements.txt b/lib/toaster=
/tests/toaster-tests-requirements.txt<br>
index 7109c625..71cc0834 100644<br>
--- a/lib/toaster/tests/toaster-tests-requirements.txt<br>
+++ b/lib/toaster/tests/toaster-tests-requirements.txt<br>
@@ -4,3 +4,4 @@ pytest-django=3D=3D4.5.2<br>
=C2=A0pytest-env=3D=3D1.1.0<br>
=C2=A0pytest-html=3D=3D4.0.2<br>
=C2=A0pytest-metadata=3D=3D3.0.0<br>
+pytest-order=3D=3D1.1.0<br>
diff --git a/lib/toaster/tests/views/test_views.py b/lib/toaster/tests/view=
s/test_views.py<br>
index 06bf6c20..349881eb 100644<br>
--- a/lib/toaster/tests/views/test_views.py<br>
+++ b/lib/toaster/tests/views/test_views.py<br>
@@ -9,6 +9,7 @@<br>
<br>
=C2=A0&quot;&quot;&quot;Test cases for Toaster GUI and ReST.&quot;&quot;&qu=
ot;<br>
<br>
+import pytest<br>
=C2=A0from django.test import TestCase<br>
=C2=A0from django.test.client import RequestFactory<br>
=C2=A0from django.urls import reverse<br>
@@ -33,6 +34,7 @@ PROJECT_NAME2 =3D &quot;test project 2&quot;<br>
=C2=A0CLI_BUILDS_PROJECT_NAME =3D &#39;Command line builds&#39;<br>
<br>
<br>
+@pytest.mark.order(1)<br>
=C2=A0class ViewTests(TestCase):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Tests to verify view APIs.&quot;&quot=
;&quot;<br>
<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15331): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15331" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15331</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283465/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283465/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000398cbe0609048379--

