Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB91DC4332F
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 15:19:27 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.web10.1462.1698765557945565924
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 08:19:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vw76zbZe;
 spf=pass (domain: gmail.com, ip: 209.85.128.180, mailfrom: ticotimo@gmail.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5afbdbf3a19so44505487b3.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 08:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698765557; x=1699370357; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfpoldcdiB/jBFO60YfBRLZumm8luAfhkGBQhnLr89M=;
        b=Vw76zbZe5L5CEKwHQGfFW/khQlSkAb/E7BrZh1FaS4S7bq96JyMwkkONamxAO8cqWh
         mPZPYWRbPJY9hG8ZCyV14C+R7vDTBca8IeqkWApJevTrGAQ6wBI2Epi/+wV6v1XxiZOf
         Vvb9dmWyLqpOF6yftDDg5qS0k02JX3Qucl+Gw8uvI/2P6F7cUglYyDhg7M9o21m7pJXj
         EtkFOhzKUp1n9NwebRk5unhjoeAVXxwnkMSqTMnLmfJk1FamIpEibpKus+68n9zyguF5
         T11Bp19iu5qUnFl0Bs//QQeePpOEbUj291+gCe7UDLmIOHdOwhD38d/q5jb5XHGaAvUU
         V1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698765557; x=1699370357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfpoldcdiB/jBFO60YfBRLZumm8luAfhkGBQhnLr89M=;
        b=t/2JfTu2cOVNM56i3vjRv/xwaUr68kTyoh8CHyFm3SgnqgCE0ZTxPTjHTM478tECzv
         bT5IWK5BK02/Sb54RkVNkNENdpqRou43j5QHSA0MasVIotVeNFd9RidoEZsmN3nHanCF
         6kXsgPEE55Q3DabeKl7NsF6JgS/9+58CnYqwYcQims7cAl21JI4jmsciuGmNOKM9O01U
         ssCAKDcxs4OOpMdQFfHudW9HxnH18ITUIUKbrx/JSxMdyMMG1I19Pt3VydFpGL23As4c
         OAZDbtc3zT06quKUA2ZgMlSmBd8txamiMkdC5GpoBguI6NRvBJcOoyANjDPBTS9CvRlA
         zG0w==
X-Gm-Message-State: AOJu0Yyw2YFu9wXNmhrtftj5pzYyhNt/t9VusRNSQ2UvfrznwoqUodwm
	TUJjr8R4s7mYoLr/QfZ+dK0TZpPU/BZyjb5U2Zc=
X-Google-Smtp-Source: AGHT+IHHtVIwS3bNbU3TnUM1PCZToXHPbJNct1Hn8u/8RhZNFa9yPUSqDJy9KAWSyD53E09R6w9oxNatCvPHwYYigrg=
X-Received: by 2002:a81:e50c:0:b0:5b0:6326:75a4 with SMTP id
 s12-20020a81e50c000000b005b0632675a4mr8309766ywl.7.1698765557024; Tue, 31 Oct
 2023 08:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231030195037.232912-1-alassane.yattara@savoirfairelinux.com>
 <20231030195037.232912-8-alassane.yattara@savoirfairelinux.com> <17933A217E9E5F53.17388@lists.yoctoproject.org>
In-Reply-To: <17933A217E9E5F53.17388@lists.yoctoproject.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 31 Oct 2023 08:19:06 -0700
Message-ID: <CANx9H-BtncK3onG3hoLtGf2yQeUsYK+sCoLyrPcZ+hccXG0DzA@mail.gmail.com>
Subject: Re: [Toaster] [bitbake-devel] [PATCH 8/8] Toaster: Added pytest.init file
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
Cc: bitbake-devel@lists.openembedded.org, toaster@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000954d4b060904ad51"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 15:19:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15346

--000000000000954d4b060904ad51
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 8:16=E2=80=AFAM Tim Orling via lists.yoctoproject.o=
rg
<ticotimo=3Dgmail.com@lists.yoctoproject.org> wrote:

>
>
> On Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara <
> alassane.yattara@savoirfairelinux.com> wrote:
>
>> Added pytest init file to configure pytest and generate test reports.
>>
>
> Typo: pytest.ini file?
>
>
>>
>> Objective
>> - We propose to integrate the plugin Pytest to generate test reports for
>> Toaster application.
>> - To keep configurations to a minimal, we propose to integrate Pytest
>> with Tox(tox.ini).
>> - Tox will automate the execution of the Pytest test cases.
>>
>> Pros
>> - Generate test reports
>> - Create a historical record of test results over time
>> - Track Toasters stability and quality
>> - Documentation and Transparency
>> - Debugging, troubleshooting  : identify regressions (input, output,)
>>
>> Cons
>> - Limited predefined report options. Although Pytest provides different
>> report
>> formats, its default reports are rather straightforward, We might have t=
o
>> put extra effort into crafting them ourselves.
>>
>
> One of the benefits of pytest is in fact that report plugins are availabl=
e
> and fairly straightforward to implement if we need our own custom report
> format (although we should avoid custom plugins and use upstream maintain=
ed
> ones wherever possible).
>
> We do need to ensure that plain text output is generated for consumption
> by the AutoBuilder. Fancy html output is going to clutter the
> testresults.json that will be where these test results will ultimately be
> stored:
> https://git.yoctoproject.org/poky/plain/scripts/resulttool
> https://git.yoctoproject.org/yocto-testresults/
>
> https://docs.yoctoproject.org/test-manual/understand-autobuilder.html?hig=
hlight=3Dresulttool#resulttool
>
> The reason is that the testresults.json is consumed by tooling to look fo=
r
> regressions. It must be machine readable and easily processed.
>
>
>> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
>> ---
>>  lib/toaster/pytest.ini | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>  create mode 100644 lib/toaster/pytest.ini
>>
>> diff --git a/lib/toaster/pytest.ini b/lib/toaster/pytest.ini
>> new file mode 100644
>> index 00000000..f07076b7
>> --- /dev/null
>> +++ b/lib/toaster/pytest.ini
>> @@ -0,0 +1,19 @@
>> +# -- FILE: pytest.ini (or tox.ini)
>> +[pytest]
>> +DJANGO_SETTINGS_MODULE =3D toastermain.settings_test
>> +
>> +python_files =3D db/test_*.py commands/test_*.py views/test_*.py
>> browser/test_*.py functional/test_*.py
>> +
>> +# --create-db - force re creation of the test database
>> +#
>> https://pytest-django.readthedocs.io/en/latest/database.html#create-db-f=
orce-re-creation-of-the-test-database
>> +
>> +# --html=3Dreport.html --self-contained-html
>> +# https://docs.pytest.org/en/latest/usage.html#creating-html-reports
>> +#
>> https://pytest-html.readthedocs.io/en/latest/user_guide.html#creating-a-=
self-contained-report
>> +addopts =3D --create-db --html=3D"Toaster Tests Report.html"
>> --self-contained-html
>
> Your patch had a trailing whitespace at the end of the above line. Please
double check for that in the future.

>
>> +
>> +# Define environment variables using pytest-env
>> +# A pytest plugin that enables you to set environment variables in the
>> pytest.ini file.
>> +# https://pypi.org/project/pytest-env/
>> +env =3D
>> +    TOASTER_BUILDSERVER=3D1
>> --
>> 2.34.1
>>
>>
>>
>>
>>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5921):
> https://lists.yoctoproject.org/g/toaster/message/5921
> Mute This Topic: https://lists.yoctoproject.org/mt/102299113/924729
> Group Owner: toaster+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/toaster/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--000000000000954d4b060904ad51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 31, 2023 at 8:16=E2=80=AF=
AM Tim Orling via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproj=
ect.org</a> &lt;ticotimo=3D<a href=3D"mailto:gmail.com@lists.yoctoproject.o=
rg">gmail.com@lists.yoctoproject.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Mon, Oct 30, 2023 at 12:51=E2=80=AFPM Alassane Yattara &lt;<a href=3D"mai=
lto:alassane.yattara@savoirfairelinux.com" target=3D"_blank">alassane.yatta=
ra@savoirfairelinux.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Added pytest init file to configure pytest and gener=
ate test reports.<br></blockquote><div><br></div><div>Typo: pytest.ini file=
?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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
f=3D"https://git.yoctoproject.org/poky/plain/scripts/resulttool" target=3D"=
_blank">https://git.yoctoproject.org/poky/plain/scripts/resulttool</a><br><=
/div><div><a href=3D"https://git.yoctoproject.org/yocto-testresults/" targe=
t=3D"_blank">https://git.yoctoproject.org/yocto-testresults/</a><br></div><=
div><a href=3D"https://docs.yoctoproject.org/test-manual/understand-autobui=
lder.html?highlight=3Dresulttool#resulttool" target=3D"_blank">https://docs=
.yoctoproject.org/test-manual/understand-autobuilder.html?highlight=3Dresul=
ttool#resulttool</a><br></div><div><br></div><div>The reason is that the te=
stresults.json=C2=A0is consumed by tooling to look for regressions. It must=
 be machine readable and easily processed.</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
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
elf-contained-html</blockquote></div></div></blockquote><div>Your patch had=
 a trailing whitespace at the end of the above line. Please double check fo=
r that in the future.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"> <br>
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
<br>
<br>
</blockquote></div></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#5921): <a href=3D"https://lists.yoctoproject.org/g/toas=
ter/message/5921" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctop=
roject.org/g/toaster/message/5921</a><br>
Mute This Topic: <a href=3D"https://lists.yoctoproject.org/mt/102299113/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/mt=
/102299113/924729</a><br>
Group Owner: <a href=3D"mailto:toaster%2Bowner@lists.yoctoproject.org" targ=
et=3D"_blank">toaster+owner@lists.yoctoproject.org</a><br>
Unsubscribe: <a href=3D"https://lists.yoctoproject.org/g/toaster/unsub" rel=
=3D"noreferrer" target=3D"_blank">https://lists.yoctoproject.org/g/toaster/=
unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">ticotimo=
@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div></div>

--000000000000954d4b060904ad51--

