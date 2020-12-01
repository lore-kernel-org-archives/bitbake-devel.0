Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.12914.1606840341502149174
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=XF3nUMTi;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id bo9so5314188ejb.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaJlpXwFERNnYpeqLcohCmAQRabffP1/ZfK6jzRDaBA=;
        b=XF3nUMTinY0adGy4i2EG0dyyR1mUqBaeWG9mJBHRElGIhJ5qBpfsA6sJi+MtyMjav+
         eyP2OxQd6P7VOp9Jw56Yf+emo/tMjlRQWZWf0CRE1pD/ZwDZ5iaQycJHuomw5r/UnBpJ
         X1t6St3HU+f0hol0oqZ2/UrLn4CR5/72Ox4Ws2w+2DzLnbI3RmYP5+G/gieLFFH9QBhh
         /vNfwnxw1mLY5lSIc7ChgqkO/i6VsFKXwF187Y90KIMcuBNXZGtfeDGKlBvx/bZHjYH1
         PUM0P3u/LLZ2QvI7Mgb2gxZ+RQR/pkox4BryRPN0iHXYEgYzU/cT3mESgVtqKQFXpNuM
         1h8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaJlpXwFERNnYpeqLcohCmAQRabffP1/ZfK6jzRDaBA=;
        b=GLAIMi13+rSBA2G7O4f5RfiPeSzjfA5/grG3nUhGU2TNpdKkzqWqlkzPM2gFYxcl5K
         q/ZQ3cvhejjTm7r5/2voZWJeYgSR1h77/rjtCwaSriVQeVM548xH0nuAowRlJiNJBBYS
         Mln1X8xoY6fnSRKgckL9FQqrl4sLgxSEnvkdUeWK+X8siZ2mGq20aOPzfSb5IZLuwF9Q
         CouwW0bg/MMK4+m2ptz+ylFv2r4gvB+wJBmMyhFd8Z0nO1iB30oZvxDnSyge2JczdypN
         XpQ2DZPWzYZiGibYjE+NxnayA4Li2gUxvdy4l37YPZUsBQWlJiYksvH01L4a5I5tpZnR
         3oSw==
X-Gm-Message-State: AOAM5327SIBWvbFUUl9IqQ0dth40paswK1xvjqTNgrw+cq5ihMJDODpM
	/yfk8PyiMxlKfskNudyeo30c7PL1ORiraw9v3BDnJRT6
X-Google-Smtp-Source: ABdhPJxg3Z+YslJaecHfGe+SdhhlzxAsKa5Ruv71VoNVvA67ZDPh9VPk0KzKEVDTdFMPke9+1KhAvLhG9Fn5Nzbw3gQ=
X-Received: by 2002:a17:907:2706:: with SMTP id w6mr3695399ejk.137.1606840340119;
 Tue, 01 Dec 2020 08:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20201201162627.47760-1-ernstp@gmail.com> <164CA4BB733E4CEA.8361@lists.openembedded.org>
In-Reply-To: <164CA4BB733E4CEA.8361@lists.openembedded.org>
From: "Martin Jansa" <Martin.Jansa@gmail.com>
Date: Tue, 1 Dec 2020 17:32:09 +0100
Message-ID: <CA+chaQdg-=KcD98S9n2oPpkuzYEAYG4nLsiX9EKzUKBGuSVkEg@mail.gmail.com>
Subject: Re: [bitbake-devel] [dunfell 1/5] python3: split python target configuration into own class
To: Martin Jansa <Martin.Jansa@gmail.com>
Cc: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="000000000000af054805b569ab10"

--000000000000af054805b569ab10
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also all these e-mails belong to openembedded-core ML not bitbake-devel.

On Tue, Dec 1, 2020 at 5:31 PM Martin Jansa via lists.openembedded.org
<Martin.Jansa=3Dgmail.com@lists.openembedded.org> wrote:

> Not sure if this is worth backport (it's very useful, but requires chang=
es
> in other layers - and these changes aren't backwards compatible so they
> would need to be applied only in dunfell and not gatesgarth branches of
> these layers or the same patchset would need to land in oe-core/gatesgar=
th
> first).
>
> But you're definitely missing this fix from master:
>
> https://git.openembedded.org/openembedded-core/commit/?id=3Dc99bb79087e7=
4a967286469e1d8888a546ebec83
>
> On Tue, Dec 1, 2020 at 5:27 PM Ernst Sj=C3=B6strand <ernstp@gmail.com> w=
rote:
>
>> From: Alexander Kanavin <alex.kanavin@gmail.com>
>>
>> Setting _PYTHON_SYSCONFIGDATA_NAME in python3native class globally was
>> problematic as it was leaking into host python environment, which
>> was causing tracebacks depending on host distro and action
>> (typically anything involving importing sysconfig module).
>>
>> The new class sets the variable only in specific tasks where it is need=
ed,
>> and should be inherited explicitly:
>> - use python3native to run scripts with native python
>> - use python3targetconfig to run scripts with native python
>> if those scripts need to access target config data (such
>> as correct installation directories). This also adds a dependency
>> on target python, so should be used carefully to avoid lengthening buil=
ds.
>>
>> (From OE-Core rev: 5a118d4e7985fa88f04c3611f8db813f0dafce75)
>>
>> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>> (cherry picked from commit c9f7ed88a946078c27fa1a62d54d6310fad9d37a)
>> ---
>>  meta/classes/python3native.bbclass       |  2 --
>>  meta/classes/python3targetconfig.bbclass | 15 +++++++++++++++
>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>  create mode 100644 meta/classes/python3targetconfig.bbclass
>>
>> diff --git a/meta/classes/python3native.bbclass
>> b/meta/classes/python3native.bbclass
>> index d98fb4c758..2e3a88c126 100644
>> --- a/meta/classes/python3native.bbclass
>> +++ b/meta/classes/python3native.bbclass
>> @@ -17,8 +17,6 @@ export STAGING_LIBDIR
>>  export
>> PYTHON_LIBRARY=3D"${STAGING_LIBDIR}/lib${PYTHON_DIR}${PYTHON_ABI}.so"
>>  export PYTHON_INCLUDE_DIR=3D"${STAGING_INCDIR}/${PYTHON_DIR}${PYTHON_A=
BI}"
>>
>> -export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>> -
>>  # suppress host user's site-packages dirs.
>>  export PYTHONNOUSERSITE =3D "1"
>>
>> diff --git a/meta/classes/python3targetconfig.bbclass
>> b/meta/classes/python3targetconfig.bbclass
>> new file mode 100644
>> index 0000000000..640d0c97b6
>> --- /dev/null
>> +++ b/meta/classes/python3targetconfig.bbclass
>> @@ -0,0 +1,15 @@
>> +inherit python3native
>> +
>> +DEPENDS_append =3D " python3"
>> +
>> +do_configure_prepend() {
>> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>> +}
>> +
>> +do_compile_prepend() {
>> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>> +}
>> +
>> +do_install_prepend() {
>> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>> +}
>> --
>> 2.29.2
>>
>>
>>
>>
>>
>=20
>
>

--000000000000af054805b569ab10
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Also all these e-mails belong to openembedded-core ML not =
bitbake-devel.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Dec 1, 2020 at 5:31 PM Martin Jansa via <a href=3D=
"http://lists.openembedded.org">lists.openembedded.org</a> &lt;Martin.Jansa=
=
=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gmail.com@lists.ope=
nembedded.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr">Not sure if this is worth backport (it&#39;s =
very useful, but requires changes in other layers - and these changes aren&=
#39;t backwards compatible so they would need to be applied only in dunfell=
 and not gatesgarth branches of these layers or the same patchset would nee=
d to land in oe-core/gatesgarth first).<div><br></div><div>But you&#39;re d=
efinitely missing this fix from master:</div><div><a href=3D"https://git.op=
enembedded.org/openembedded-core/commit/?id=3Dc99bb79087e74a967286469e1d888=
8a546ebec83" target=3D"_blank">https://git.openembedded.org/openembedded-co=
re/commit/?id=3Dc99bb79087e74a967286469e1d8888a546ebec83</a><br></div></div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tu=
e, Dec 1, 2020 at 5:27 PM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp=
@gmail.com" target=3D"_blank">ernstp@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">From: Alexander Kanavin &lt;<=
a href=3D"mailto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gma=
il.com</a>&gt;<br>
<br>
Setting _PYTHON_SYSCONFIGDATA_NAME in python3native class globally was<br>
problematic as it was leaking into host python environment, which<br>
was causing tracebacks depending on host distro and action<br>
(typically anything involving importing sysconfig module).<br>
<br>
The new class sets the variable only in specific tasks where it is needed,=
<br>
and should be inherited explicitly:<br>
- use python3native to run scripts with native python<br>
- use python3targetconfig to run scripts with native python<br>
if those scripts need to access target config data (such<br>
as correct installation directories). This also adds a dependency<br>
on target python, so should be used carefully to avoid lengthening builds.=
<br>
<br>
(From OE-Core rev: 5a118d4e7985fa88f04c3611f8db813f0dafce75)<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex.kanavin@gmail.=
com" target=3D"_blank">alex.kanavin@gmail.com</a>&gt;<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfo=
undation.org" target=3D"_blank">richard.purdie@linuxfoundation.org</a>&gt;<=
br>
(cherry picked from commit c9f7ed88a946078c27fa1a62d54d6310fad9d37a)<br>
---<br>
=C2=A0meta/classes/python3native.bbclass=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 --<br>
=C2=A0meta/classes/python3targetconfig.bbclass | 15 +++++++++++++++<br>
=C2=A02 files changed, 15 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 meta/classes/python3targetconfig.bbclass<br>
<br>
diff --git a/meta/classes/python3native.bbclass b/meta/classes/python3nati=
ve.bbclass<br>
index d98fb4c758..2e3a88c126 100644<br>
--- a/meta/classes/python3native.bbclass<br>
+++ b/meta/classes/python3native.bbclass<br>
@@ -17,8 +17,6 @@ export STAGING_LIBDIR<br>
=C2=A0export PYTHON_LIBRARY=3D&quot;${STAGING_LIBDIR}/lib${PYTHON_DIR}${PY=
THON_ABI}.so&quot;<br>
=C2=A0export PYTHON_INCLUDE_DIR=3D&quot;${STAGING_INCDIR}/${PYTHON_DIR}${P=
YTHON_ABI}&quot;<br>
<br>
-export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sysconfigdata&quot;<br>
-<br>
=C2=A0# suppress host user&#39;s site-packages dirs.<br>
=C2=A0export PYTHONNOUSERSITE =3D &quot;1&quot;<br>
<br>
diff --git a/meta/classes/python3targetconfig.bbclass b/meta/classes/pytho=
n3targetconfig.bbclass<br>
new file mode 100644<br>
index 0000000000..640d0c97b6<br>
--- /dev/null<br>
+++ b/meta/classes/python3targetconfig.bbclass<br>
@@ -0,0 +1,15 @@<br>
+inherit python3native<br>
+<br>
+DEPENDS_append =3D &quot; python3&quot;<br>
+<br>
+do_configure_prepend() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sy=
sconfigdata&quot;<br>
+}<br>
+<br>
+do_compile_prepend() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sy=
sconfigdata&quot;<br>
+}<br>
+<br>
+do_install_prepend() {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 export _PYTHON_SYSCONFIGDATA_NAME=3D&quot;_sy=
sconfigdata&quot;<br>
+}<br>
-- <br>
2.29.2<br>
<br>
<br>
<br>
<br>
</blockquote></div>
<br>
<br>
<br>
</blockquote></div>

--000000000000af054805b569ab10--
