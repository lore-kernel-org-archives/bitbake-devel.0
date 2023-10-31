Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF25C4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 15:16:47 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web10.1385.1698765399771717403
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 08:16:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Iwx87wX/;
 spf=pass (domain: gmail.com, ip: 209.85.128.174, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7c95b8d14so50653567b3.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698765399; x=1699370199; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XUuL0ZqhnmczPK1s0xQVaA790wg24JkPh12uIc19CY8=;
        b=Iwx87wX/0SudnOVLIO5KeqWv4u6jG+/wj1JOcTAJ10pNzqNVU26b/LNy+YCT7jQ/HB
         Rlw08EAb0KWQnnJtmY0YhmUIDeazjkh8OxDBKGsha87lA3M/Y9HnYZfZjRaqmPYvz83O
         Y5iOpc6l9O1uSyACeS3XK6nepYVBEnyFghCU9xDu2Ot5zm+rIxm3nxGBkWxym0UBmTr4
         EUsUgjosYzVs4+zakKI8yG07LLW1MaKWYE3+aoP6WmLaPysBRJ25lxDsWko5RmxWDskB
         9YmkyY6tuIuWU5BesehZgXMaAQqhUDsrZWkYkgPH5BlAro+pIgN6PHhU/7DZ7vptT0h4
         dBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765399; x=1699370199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUuL0ZqhnmczPK1s0xQVaA790wg24JkPh12uIc19CY8=;
        b=VeuCBJlAS7MMftaF/ZnqtpuzvcZgdVFoVvrMg372rLp2FJF8q/HrkmiNINc0Rj36Wj
         7DfgEags42vI+HzyyeZyUMscNgTEjR7GK8MvslwL5BYTKpjsPE7T4+Wz4/PeWNUyY45d
         l1zkqzbcX7nuSopkLRHS+oV0wpTFIb4xw1ikcmKPjI2Z3X132c4Z8JW8dnaF28Iptsoo
         vTjkzRFekCOTD822HcBTZVFTe915WTij/ULghuGcrFbZXwuxDipHnJsKA3dC17RhJaZ5
         El1pSLhnQ0QCkdDVRwc5DHCsK+omtbHR4j9ynKiNzqKK0hTKVh9ylPqlrrCdF+p8bfNV
         Ap6Q==
X-Gm-Message-State: AOJu0Yy8Ex1jSYqSyjrV+sPuEIvAY8kzeydLP/Y8R4v5nXwCIuyK9vfl
	xGFdtymcyBFbOZ4L9urqGY29BCQILL7rvRLcj3Fq4rmKftP4ww==
X-Google-Smtp-Source: AGHT+IFmZFUhr83Z4gsegi05qTnOZtiK0taBjp9TbX+LdX0xxevV+qus8wGVOApxfyTdgHX1P1xfuCbPVejecbq4Zv4=
X-Received: by 2002:a05:690c:87:b0:5b3:26e1:31f8 with SMTP id
 be7-20020a05690c008700b005b326e131f8mr2342783ywb.12.1698765398636; Tue, 31
 Oct 2023 08:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com> <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com>
In-Reply-To: <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 08:16:27 -0700
Message-ID: <CANx9H-ChzdqV_wyra4RFhswNYZYmjaXO-iFdJvateo7NtL5f2A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 8/8] Toaster: Added pytest.init file
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000247b38060904a4af"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 15:16:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15345

--000000000000247b38060904a4af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
alassane.yattara@savoirfairelinux.com> wrote:

> Added pytest init file to configure pytest and generate test reports.
>

Typo: pytest.ini file?


>
> Objective
> - We propose to integrate the plugin Pytest to generate test reports for
> Toaster application.
> - To keep configurations to a minimal, we propose to integrate Pytest wit=
h
> Tox(tox.ini).
> - Tox will automate the execution of the Pytest test cases.
>
> Pros
> - Generate test reports
> - Create a historical record of test results over time
> - Track Toasters stability and quality
> - Documentation and Transparency
> - Debugging, troubleshooting  : identify regressions (input, output,)
>
> Cons
> - Limited predefined report options. Although Pytest provides different
> report
> formats, its default reports are rather straightforward, We might have to
> put extra effort into crafting them ourselves.
>

One of the benefits of pytest is in fact that report plugins are available
and fairly straightforward to implement if we need our own custom report
format (although we should avoid custom plugins and use upstream maintained
ones wherever possible).

We do need to ensure that plain text output is generated for consumption by
the AutoBuilder. Fancy html output is going to clutter the testresults.json
that will be where these test results will ultimately be stored:
https://git.yoctoproject.org/poky/plain/scripts/resulttool
https://git.yoctoproject.org/yocto-testresults/
https://docs.yoctoproject.org/test-manual/understand-autobuilder.html?highl=
ight=3Dresulttool#resulttool

The reason is that the testresults.json is consumed by tooling to look for
regressions. It must be machine readable and easily processed.


> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/pytest.ini | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 lib/toaster/pytest.ini
>
> diff --git a/lib/toaster/pytest.ini b/lib/toaster/pytest.ini
> new file mode 100644
> index 00000000..f07076b7
> --- /dev/null
> +++ b/lib/toaster/pytest.ini
> @@ -0,0 +1,19 @@
> +# -- FILE: pytest.ini (or tox.ini)
> +[pytest]
> +DJANGO_SETTINGS_MODULE =3D toastermain.settings_test
> +
> +python_files =3D db/test_*.py commands/test_*.py views/test_*.py
> browser/test_*.py functional/test_*.py
> +
> +# --create-db - force re creation of the test database
> +#
> https://pytest-django.readthedocs.io/en/latest/database.html#create-db-fo=
rce-re-creation-of-the-test-database
> +
> +# --html=3Dreport.html --self-contained-html
> +# https://docs.pytest.org/en/latest/usage.html#creating-html-reports
> +#
> https://pytest-html.readthedocs.io/en/latest/user_guide.html#creating-a-s=
elf-contained-report
> +addopts =3D --create-db --html=3D"Toaster Tests Report.html"
> --self-contained-html
> +
> +# Define environment variables using pytest-env
> +# A pytest plugin that enables you to set environment variables in the
> pytest.ini file.
> +# https://pypi.org/project/pytest-env/
> +env =3D
> +    TOASTER_BUILDSERVER=3D1
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15332):
> https://lists.openembedded.org/g/bitbake-devel/message/15332
> Mute This Topic: https://lists.openembedded.org/mt/102283466/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000247b38060904a4af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 12:51=E2=80=
=AFPM Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savoirfaireli=
nux.com">alassane.yattara@savoirfairelinux.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Added pytest init file to con=
figure pytest and generate test reports.<br></blockquote><div><br></div><di=
v>Typo: pytest.ini file?</div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
Objective<br>
- We propose to integrate the plugin Pytest to generate test reports for To=
aster application.<br>
- To keep configurations to a minimal, we propose to integrate Pytest with =
Tox(tox.ini).<br>
- Tox will automate the execution of the Pytest test cases.=C2=A0 <br>
<br>
Pros<br>
- Generate test reports<br>
- Create a historical record of test results over time<br>
- Track Toasters stability and quality <br>
- Documentation and Transparency<br>
- Debugging, troubleshooting=C2=A0 : identify regressions (input, output,) =
<br>
<br>
Cons<br>
- Limited predefined report options. Although Pytest provides different rep=
ort<br>
formats, its default reports are rather straightforward, We might have to p=
ut extra effort into crafting them ourselves.<br></blockquote><div><br></di=
v><div>One of the benefits of pytest is in fact that report plugins are ava=
ilable and fairly straightforward to implement if we need our own custom re=
port format (although we should avoid=C2=A0custom plugins and use upstream =
maintained ones wherever possible).=C2=A0</div><div><br></div><div>We do ne=
ed to ensure that plain text output is generated for consumption by the Aut=
oBuilder. Fancy html output is going to clutter the testresults.json that w=
ill be where these test results will ultimately be stored:</div><div><a hre=
f=3D"https://git.yoctoproject.org/poky/plain/scripts/resulttool">https://gi=
t.yoctoproject.org/poky/plain/scripts/resulttool</a><br></div><div><a href=
=3D"https://git.yoctoproject.org/yocto-testresults/">https://git.yoctoproje=
ct.org/yocto-testresults/</a><br></div><div><a href=3D"https://docs.yoctopr=
oject.org/test-manual/understand-autobuilder.html?highlight=3Dresulttool#re=
sulttool">https://docs.yoctoproject.org/test-manual/understand-autobuilder.=
html?highlight=3Dresulttool#resulttool</a><br></div><div><br></div><div>The=
 reason is that the testresults.json=C2=A0is consumed by tooling to look fo=
r regressions. It must be machine readable and easily processed.</div><div>=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Alassane Yattara &lt;<a href=3D"mailto:alassane.yattara@savo=
irfairelinux.com" target=3D"_blank">alassane.yattara@savoirfairelinux.com</=
a>&gt;<br>
---<br>
=C2=A0lib/toaster/pytest.ini | 19 +++++++++++++++++++<br>
=C2=A01 file changed, 19 insertions(+)<br>
=C2=A0create mode 100644 lib/toaster/pytest.ini<br>
<br>
diff --git a/lib/toaster/pytest.ini b/lib/toaster/pytest.ini<br>
new file mode 100644<br>
index 00000000..f07076b7<br>
--- /dev/null<br>
+++ b/lib/toaster/pytest.ini<br>
@@ -0,0 +1,19 @@<br>
+# -- FILE: pytest.ini (or tox.ini)<br>
+[pytest]<br>
+DJANGO_SETTINGS_MODULE =3D toastermain.settings_test<br>
+<br>
+python_files =3D db/test_*.py commands/test_*.py views/test_*.py browser/t=
est_*.py functional/test_*.py<br>
+<br>
+# --create-db - force re creation of the test database<br>
+# <a href=3D"https://pytest-django.readthedocs.io/en/latest/database.html#=
create-db-force-re-creation-of-the-test-database" rel=3D"noreferrer" target=
=3D"_blank">https://pytest-django.readthedocs.io/en/latest/database.html#cr=
eate-db-force-re-creation-of-the-test-database</a><br>
+<br>
+# --html=3Dreport.html --self-contained-html<br>
+# <a href=3D"https://docs.pytest.org/en/latest/usage.html#creating-html-re=
ports" rel=3D"noreferrer" target=3D"_blank">https://docs.pytest.org/en/late=
st/usage.html#creating-html-reports</a><br>
+# <a href=3D"https://pytest-html.readthedocs.io/en/latest/user_guide.html#=
creating-a-self-contained-report" rel=3D"noreferrer" target=3D"_blank">http=
s://pytest-html.readthedocs.io/en/latest/user_guide.html#creating-a-self-co=
ntained-report</a><br>
+addopts =3D --create-db --html=3D&quot;Toaster Tests Report.html&quot; --s=
elf-contained-html <br>
+<br>
+# Define environment variables using pytest-env<br>
+# A pytest plugin that enables you to set environment variables in the pyt=
est.ini file.<br>
+# <a href=3D"https://pypi.org/project/pytest-env/" rel=3D"noreferrer" targ=
et=3D"_blank">https://pypi.org/project/pytest-env/</a><br>
+env =3D<br>
+=C2=A0 =C2=A0 TOASTER_BUILDSERVER=3D1<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15332): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15332" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15332</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102283466/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/102283466/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000247b38060904a4af--

