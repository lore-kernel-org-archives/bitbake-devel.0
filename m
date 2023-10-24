Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F58EC25B47
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 21:54:43 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web11.30645.1698184475412780286
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Oct 2023 14:54:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z9QFH+8A;
 spf=pass (domain: gmail.com, ip: 209.85.219.169, mailfrom: ticotimo@gmail.com)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-da0737c451cso37927276.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698184474; x=1698789274; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ki65EWeN6k1I1hhrDjvdXvCSZy3yrzQVZlCUX8ODSO4=;
        b=Z9QFH+8A8PJJhTPe7/l13wckRu/0UONThpj2FtQ9RWkXE3YVnEKEyS/3VqTYfy6TGi
         rDY1W2yYId1UyeExrGsidjaFAgSDV0EDigaaX5bcxkml7k1LRPVvGTe2eqfL8P/uGS68
         xODlbLwza5mCnpkRWJRc2m/2zoIjfr1cnVEtcDHzu+GUAchRhY9ymE+InsFRxQ0K4bHt
         W5YkRaLYMv23cHrY9sLI7NacYsYYaNCf5z8f43d2YzqbgQeAAOxZEgHba9NgQ3Xsjk4G
         FtajuUpwej+4HCWBOSrWzM3/j8cHboQXfpnhWMs22OqJwe/TV6mm+8zsTO4Vi+mugtir
         hALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698184474; x=1698789274;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ki65EWeN6k1I1hhrDjvdXvCSZy3yrzQVZlCUX8ODSO4=;
        b=mw41zsfWK+VXg9j22tvD63UOmWXUaSSJSlBpgTVKwSj4wSphARTDyPLvBG34WYQqUu
         coTAqltSX/lH4yVmCLXoVHVMY06X1crejkc2pYZylAN0rf0tPQPCQvqXG/+Cyvon5Q7D
         u9DknRUTtZHNmd8bf0n1zjA6b5JWoAK77cdVYtIFXTpiFHu7x+gLHbTUhFnFc0DNFT1j
         Co7z67oU6AeaO8wtrcT1V6skCuQQ02SQkgAeI7VC7iD5o88UAXNUpLqA2rLf0d1daq1B
         V83Ma8HDenZ52TTCqAeZgh/u7a3f2XTJSoBTHfnZwe5jtsAdEvQOBbRC4WHc+G/fMTWp
         7wCA==
X-Gm-Message-State: AOJu0Yx1+LNoycMSnpa39+udfcMPOMN1PNQDys2apDEi09hnegbIO4XL
	3R25O5TZIbhn1u2e0VbIlcljDhXI3hSDvxZWtYQ=
X-Google-Smtp-Source: AGHT+IGEpBfxsjLGQTQu8PEXCwGVb6+4+eMz4Q+Uvrui8Oym4THlMfNfSOGb/8PHEmqs/lZPlSpg5qoKmbxUdFKeQvs=
X-Received: by 2002:a05:6902:507:b0:d9a:53cc:e58d with SMTP id
 x7-20020a056902050700b00d9a53cce58dmr16640322ybs.10.1698184474377; Tue, 24
 Oct 2023 14:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231024182828.156237-1-marlon.rodriguez-garcia@savoirfairelinux.com>
In-Reply-To: <20231024182828.156237-1-marlon.rodriguez-garcia@savoirfairelinux.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 24 Oct 2023 14:54:23 -0700
Message-ID: <CANx9H-ApQ=1R_tStRPftBRf2UE6KSFQ7a5tOSrVMZ2SPDws1cA@mail.gmail.com>
Subject: Re: [Toaster] [PATCH v2] toaster: add tox.ini file to execute test suite
To: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="0000000000005bd18706087d6226"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 21:54:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15283

--0000000000005bd18706087d6226
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I still see failing tests, but the tox.ini itself is functional enough and
streamlined enough to merge now.

On Tue, Oct 24, 2023 at 11:28=E2=80=AFAM Marlon Rodriguez Garcia <
marlon.rodriguez-garcia@savoirfairelinux.com> wrote:

> Updated tox file to fix enviroments variables.
> to run tox use the following command:
> tox -e env_name -c /path/to/file/tox.ini
> See tox cli https://tox.wiki/en/latest/cli_interface.html
> The variable env_name is linked to the python versions (py38, py39, py310=
).
> If env_name option is not set,  the test suite will run for all indicated
> versions.
>
> It was also modified the webdriver options for chrome to run selenium tes=
t
> in console because of the error detected in the previous test run
> selenium.common.exceptions.SessionNotCreatedException: Message: session
> not created: Chrome failed to start: exited normally.
>   (session not created: DevToolsActivePort file doesn't exist)
> (The process started from chrome location /usr/bin/google-chrome is no
> longer running, so ChromeDriver is assuming that Chrome has crashed.)
>
> Signed-off-by: Marlon Rodriguez Garcia <
> marlon.rodriguez-garcia@savoirfairelinux.com>
>
Reviewed-by: Tim Orling <tim.orling@konsulko.com>
Tested-by: Tim Orling <tim.orling@konsulko.com>


The following lines belong below the three hyphens (---) so they do not
show up in the final git history.
If you are using git send-email you can use --annotate to edit the patch
before sending.


> Changes in v2
> - Updated variable path BUILDDIR and EVENTREPLAY_DIR to use enviroment
> value
> - Updated toaster-requirements.txt file path
> - Removed flake8
> - Added webdriver options to chrome
> ---
>  .../tests/browser/selenium_helpers_base.py    |  8 +++++++-
>  lib/toaster/tox.ini                           | 20 +++++++++++++++++++
>  2 files changed, 27 insertions(+), 1 deletion(-)
>  create mode 100644 lib/toaster/tox.ini
>
> diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py
> b/lib/toaster/tests/browser/selenium_helpers_base.py
> index 9a4e27a3..e0ac4376 100644
> --- a/lib/toaster/tests/browser/selenium_helpers_base.py
> +++ b/lib/toaster/tests/browser/selenium_helpers_base.py
> @@ -33,7 +33,13 @@ def create_selenium_driver(cls,browser=3D'chrome'):
>          browser =3D env_browser
>
>      if browser =3D=3D 'chrome':
> -        return webdriver.Chrome()
> +        options =3D webdriver.ChromeOptions()
> +        options.add_argument('headless')
> +        options.add_argument('--disable-infobars')
> +        options.add_argument('--disable-dev-shm-usage')
> +        options.add_argument('--no-sandbox')
> +        options.add_argument('--remote-debugging-port=3D9222')
> +        return webdriver.Chrome(options=3Doptions)
>      elif browser =3D=3D 'firefox':
>          return webdriver.Firefox()
>      elif browser =3D=3D 'marionette':
> diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini
> new file mode 100644
> index 00000000..8c0fe171
> --- /dev/null
> +++ b/lib/toaster/tox.ini
> @@ -0,0 +1,20 @@
> +[tox]
> +envlist =3D py38, py39, py310
> +skipsdist =3D True
> +toxworkdir =3D {env:TOX_WORKDIR:.tox}
> +passenv =3D *
> +
> +[testenv]
> +setenv =3D
> +    DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test
> +    TOASTER_BUILDSERVER=3D1
> +    BUILDDIR =3D {env:BUILDDIR}
> +    EVENTREPLAY_DIR =3D {env:EVENTREPLAY_DIR:BUILDDIR}
> +commands =3D
> +    python3 {toxinidir}/manage.py test tests.db tests.commands
> tests.builds tests.browser tests.functional tests.views
> +deps =3D
> +    -r {toxinidir}/../../toaster-requirements.txt
> +    -r {toxinidir}/tests/toaster-tests-requirements.txt
> +
> +[testenv:chrome]
> +commands=3D{[testenv]commands} --splinter-webdriver=3Dchrome
> \ No newline at end of file
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5887):
> https://lists.yoctoproject.org/g/toaster/message/5887
> Mute This Topic: https://lists.yoctoproject.org/mt/102163592/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000005bd18706087d6226
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br class=3D"gmail-Apple-interchange-newl=
ine">I still=C2=A0see failing tests, but the tox.ini itself is functional e=
nough and streamlined enough to merge now.=C2=A0<br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 24, 2023 at=
 11:28=E2=80=AFAM Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodr=
iguez-garcia@savoirfairelinux.com">marlon.rodriguez-garcia@savoirfairelinux=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Updated tox file to fix enviroments variables.<br>
to run tox use the following command:<br>
tox -e env_name -c /path/to/file/tox.ini<br>
See tox cli <a href=3D"https://tox.wiki/en/latest/cli_interface.html" rel=
=3D"noreferrer" target=3D"_blank">https://tox.wiki/en/latest/cli_interface.=
html</a><br>
The variable env_name is linked to the python versions (py38, py39, py310).=
<br>
If env_name option is not set,=C2=A0 the test suite will run for all indica=
ted versions.<br>
<br>
It was also modified the webdriver options for chrome to run selenium test =
in console because of the error detected in the previous test run<br>
selenium.common.exceptions.SessionNotCreatedException: Message: session not=
 created: Chrome failed to start: exited normally.<br>
=C2=A0 (session not created: DevToolsActivePort file doesn&#39;t exist)<br>
(The process started from chrome location /usr/bin/google-chrome is no long=
er running, so ChromeDriver is assuming that Chrome has crashed.)<br>
<br>
Signed-off-by: Marlon Rodriguez Garcia &lt;<a href=3D"mailto:marlon.rodrigu=
ez-garcia@savoirfairelinux.com" target=3D"_blank">marlon.rodriguez-garcia@s=
avoirfairelinux.com</a>&gt;<br></blockquote><div>Reviewed-by: Tim Orling &l=
t;<a href=3D"mailto:tim.orling@konsulko.com">tim.orling@konsulko.com</a>&gt=
;</div><div>Tested-by: Tim Orling &lt;<a href=3D"mailto:tim.orling@konsulko=
.com">tim.orling@konsulko.com</a>&gt;</div><div><br></div><div><br></div><d=
iv>The following lines belong below the three hyphens (---) so they do not =
show up in the final git history.</div><div>If you are using git send-email=
 you can use --annotate to edit the patch before sending.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
Changes in v2<br>
- Updated variable path BUILDDIR and EVENTREPLAY_DIR to use enviroment valu=
e<br>
- Updated toaster-requirements.txt file path<br>
- Removed flake8<br>
- Added webdriver options to chrome<br>
---<br>
=C2=A0.../tests/browser/selenium_helpers_base.py=C2=A0 =C2=A0 |=C2=A0 8 +++=
++++-<br>
=C2=A0lib/toaster/tox.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 +++++++++++++++++++<br=
>
=C2=A02 files changed, 27 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 lib/toaster/tox.ini<br>
<br>
diff --git a/lib/toaster/tests/browser/selenium_helpers_base.py b/lib/toast=
er/tests/browser/selenium_helpers_base.py<br>
index 9a4e27a3..e0ac4376 100644<br>
--- a/lib/toaster/tests/browser/selenium_helpers_base.py<br>
+++ b/lib/toaster/tests/browser/selenium_helpers_base.py<br>
@@ -33,7 +33,13 @@ def create_selenium_driver(cls,browser=3D&#39;chrome&#39=
;):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0browser =3D env_browser<br>
<br>
=C2=A0 =C2=A0 =C2=A0if browser =3D=3D &#39;chrome&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Chrome()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options =3D webdriver.ChromeOptions()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options.add_argument(&#39;headless&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options.add_argument(&#39;--disable-infobars&#=
39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options.add_argument(&#39;--disable-dev-shm-us=
age&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options.add_argument(&#39;--no-sandbox&#39;)<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options.add_argument(&#39;--remote-debugging-p=
ort=3D9222&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return webdriver.Chrome(options=3Doptions)<br>
=C2=A0 =C2=A0 =C2=A0elif browser =3D=3D &#39;firefox&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return webdriver.Firefox()<br>
=C2=A0 =C2=A0 =C2=A0elif browser =3D=3D &#39;marionette&#39;:<br>
diff --git a/lib/toaster/tox.ini b/lib/toaster/tox.ini<br>
new file mode 100644<br>
index 00000000..8c0fe171<br>
--- /dev/null<br>
+++ b/lib/toaster/tox.ini<br>
@@ -0,0 +1,20 @@<br>
+[tox]<br>
+envlist =3D py38, py39, py310<br>
+skipsdist =3D True<br>
+toxworkdir =3D {env:TOX_WORKDIR:.tox}<br>
+passenv =3D *<br>
+<br>
+[testenv]<br>
+setenv =3D<br>
+=C2=A0 =C2=A0 DJANGO_SETTINGS_MODULE=3Dtoastermain.settings_test<br>
+=C2=A0 =C2=A0 TOASTER_BUILDSERVER=3D1<br>
+=C2=A0 =C2=A0 BUILDDIR =3D {env:BUILDDIR}<br>
+=C2=A0 =C2=A0 EVENTREPLAY_DIR =3D {env:EVENTREPLAY_DIR:BUILDDIR}<br>
+commands =3D<br>
+=C2=A0 =C2=A0 python3 {toxinidir}/manage.py test tests.db tests.commands t=
ests.builds tests.browser tests.functional tests.views<br>
+deps =3D <br>
+=C2=A0 =C2=A0 -r {toxinidir}/../../toaster-requirements.txt<br>
+=C2=A0 =C2=A0 -r {toxinidir}/tests/toaster-tests-requirements.txt<br>
+<br>
+[testenv:chrome]<br>
+commands=3D{[testenv]commands} --splinter-webdriver=3Dchrome<br>
\ No newline at end of file<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5887): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5887" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5887</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102163592/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102163592/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--0000000000005bd18706087d6226--

