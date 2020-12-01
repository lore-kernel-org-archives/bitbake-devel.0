Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web12.12891.1606840758951300397
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Dec 2020 08:39:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=BNkM6m8f;
 spf=pass (domain: gmail.com, ip: 209.85.208.53, mailfrom: ernstp@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id r5so812234eda.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 01 Dec 2020 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o2cIVWjsROQa8AmScwF5C39oP6aicQCaAYkA3TzhzsU=;
        b=BNkM6m8fZbCgfFKGYYFUIw3BKcIw+nHSDCY9O0Gv+XiLfs7yw2Bv9Q4Bz9gcgU0n7n
         jiMYmqFKZxWbhHzEP+dAPusVwDk+UCYumaxn6IF9K3najTVTOUHUVaX9GySlNIRVYfRJ
         uadJA8EyPHTDGMJNbfxaYW07eRCDmfWfPhhrGPtrPBCfQfeZipApV/QoNyig1axfD9Pj
         3a739ZS5WIBWIVhbZsjlQ7YZBqb6t5/ohOaXVf2eDa8dopMUl/WwjdiWUV/+Esvfd7Y4
         bFi3KGAjmzfoldSY8LlXigiuJ79qtDoJbMfNfRNE3iGycd5EREEKoHDuCwG6Itk+bo/H
         iqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2cIVWjsROQa8AmScwF5C39oP6aicQCaAYkA3TzhzsU=;
        b=hlt33MeoRMuoWAaNGRTFyW9D9BaEuDY3Js0wHDfGjAzDgPweVc4YN6XZn4SnE03FFy
         5VB5QKBrW0g1ujJDlmYOafa8G/V1eATXGnLFg3cBuFPQWIXNht7OAqJkpK1VxASbToW6
         sLCDC6idz7RmV5xHBpOIn5VzYI8CJ7yaJKw5RzaOKM77BNgRNC7rTRNN9PgM+B6/gti2
         GF958ZdH14jZGcqyQmMbeL3IsD4fsG12ZqG9EGM/EzOBZ56o44ZlXR16MSOd6wlPvx8n
         YLXE9uslsSNmaDlQQRxs4yczMkPuVwU5Sjoqv9kTkbdR3QOA8VgGx0DZmkthuwW+nfUV
         DSzA==
X-Gm-Message-State: AOAM532gM2r3ImEi8ld3JRuBh/DUw1Y0D/yapNv5E16b93J/a+39zke0
	2choZeONtqZ4kPGFOpQHCwui/Fl2tzZS1z+6M28=
X-Google-Smtp-Source: ABdhPJzLWUgq95/AvVWew4z4SqBISjISGM+zcubQivpHCQm+jPkyQmWfV6r8CDxA6IzjCKVeLb1vxMGO57krYXpH9kE=
X-Received: by 2002:aa7:cfcd:: with SMTP id r13mr3934862edy.63.1606840757422;
 Tue, 01 Dec 2020 08:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20201201162627.47760-1-ernstp@gmail.com> <164CA4BB733E4CEA.8361@lists.openembedded.org>
 <CA+chaQdg-=KcD98S9n2oPpkuzYEAYG4nLsiX9EKzUKBGuSVkEg@mail.gmail.com>
In-Reply-To: <CA+chaQdg-=KcD98S9n2oPpkuzYEAYG4nLsiX9EKzUKBGuSVkEg@mail.gmail.com>
From: =?UTF-8?B?RXJuc3QgU2rDtnN0cmFuZA==?= <ernstp@gmail.com>
Date: Tue, 1 Dec 2020 17:39:06 +0100
Message-ID: <CAD=4a=VT5YZWq+xEf30n3J1DC0W1k6=65Mg5itLN-5x-v0aDGw@mail.gmail.com>
Subject: Re: [bitbake-devel] [dunfell 1/5] python3: split python target configuration into own class
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, 
	Alexander Kanavin <alex.kanavin@gmail.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: multipart/alternative; boundary="0000000000008e8dfb05b569c4e3"

--0000000000008e8dfb05b569c4e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah I was preparing for both lists and got it mixed up. :-) There's
another patch that goes to the bitbake list.
(bitbake: lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME
unsetting)

Ah the patch you mentioned is a bit newer than my initial local backport.

The reason for the backport is that many of the initial reports were for
Dunfell, and that Dunfell will be LTS.

Regards
//Ernst

Den tis 1 dec. 2020 kl 17:32 skrev Martin Jansa <martin.jansa@gmail.com>:

> Also all these e-mails belong to openembedded-core ML not bitbake-devel.
>
> On Tue, Dec 1, 2020 at 5:31 PM Martin Jansa via lists.openembedded.org
> <Martin.Jansa=3Dgmail.com@lists.openembedded.org> wrote:
>
>> Not sure if this is worth backport (it's very useful, but requires
>> changes in other layers - and these changes aren't backwards compatible=
 so
>> they would need to be applied only in dunfell and not gatesgarth branch=
es
>> of these layers or the same patchset would need to land in
>> oe-core/gatesgarth first).
>>
>> But you're definitely missing this fix from master:
>>
>> https://git.openembedded.org/openembedded-core/commit/?id=3Dc99bb79087e=
74a967286469e1d8888a546ebec83
>>
>> On Tue, Dec 1, 2020 at 5:27 PM Ernst Sj=C3=B6strand <ernstp@gmail.com> =
wrote:
>>
>>> From: Alexander Kanavin <alex.kanavin@gmail.com>
>>>
>>> Setting _PYTHON_SYSCONFIGDATA_NAME in python3native class globally was
>>> problematic as it was leaking into host python environment, which
>>> was causing tracebacks depending on host distro and action
>>> (typically anything involving importing sysconfig module).
>>>
>>> The new class sets the variable only in specific tasks where it is
>>> needed,
>>> and should be inherited explicitly:
>>> - use python3native to run scripts with native python
>>> - use python3targetconfig to run scripts with native python
>>> if those scripts need to access target config data (such
>>> as correct installation directories). This also adds a dependency
>>> on target python, so should be used carefully to avoid lengthening
>>> builds.
>>>
>>> (From OE-Core rev: 5a118d4e7985fa88f04c3611f8db813f0dafce75)
>>>
>>> Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> (cherry picked from commit c9f7ed88a946078c27fa1a62d54d6310fad9d37a)
>>> ---
>>>  meta/classes/python3native.bbclass       |  2 --
>>>  meta/classes/python3targetconfig.bbclass | 15 +++++++++++++++
>>>  2 files changed, 15 insertions(+), 2 deletions(-)
>>>  create mode 100644 meta/classes/python3targetconfig.bbclass
>>>
>>> diff --git a/meta/classes/python3native.bbclass
>>> b/meta/classes/python3native.bbclass
>>> index d98fb4c758..2e3a88c126 100644
>>> --- a/meta/classes/python3native.bbclass
>>> +++ b/meta/classes/python3native.bbclass
>>> @@ -17,8 +17,6 @@ export STAGING_LIBDIR
>>>  export
>>> PYTHON_LIBRARY=3D"${STAGING_LIBDIR}/lib${PYTHON_DIR}${PYTHON_ABI}.so"
>>>  export PYTHON_INCLUDE_DIR=3D"${STAGING_INCDIR}/${PYTHON_DIR}${PYTHON_=
ABI}"
>>>
>>> -export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>>> -
>>>  # suppress host user's site-packages dirs.
>>>  export PYTHONNOUSERSITE =3D "1"
>>>
>>> diff --git a/meta/classes/python3targetconfig.bbclass
>>> b/meta/classes/python3targetconfig.bbclass
>>> new file mode 100644
>>> index 0000000000..640d0c97b6
>>> --- /dev/null
>>> +++ b/meta/classes/python3targetconfig.bbclass
>>> @@ -0,0 +1,15 @@
>>> +inherit python3native
>>> +
>>> +DEPENDS_append =3D " python3"
>>> +
>>> +do_configure_prepend() {
>>> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>>> +}
>>> +
>>> +do_compile_prepend() {
>>> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>>> +}
>>> +
>>> +do_install_prepend() {
>>> +        export _PYTHON_SYSCONFIGDATA_NAME=3D"_sysconfigdata"
>>> +}
>>> --
>>> 2.29.2
>>>
>>>
>>>
>>>
>>>
>>=20
>>
>>

--0000000000008e8dfb05b569c4e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif"><div class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif">Yeah I was preparing for both lists and got it mixed=
 up. :-) There&#39;s another patch that goes to the bitbake list.</div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">(=
bitbake: lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetti=
ng)</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,=
sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:ari=
al,helvetica,sans-serif">Ah the patch you mentioned is a bit newer than my =
initial local backport.<br></div><div class=3D"gmail_default" style=3D"font=
-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" =
style=3D"font-family:arial,helvetica,sans-serif">The reason for the backpor=
t is that many of the initial reports were for Dunfell, and that Dunfell wi=
ll be LTS.</div><div class=3D"gmail_default" style=3D"font-family:arial,hel=
vetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif">Regards</div><div class=3D"gmail_default" s=
tyle=3D"font-family:arial,helvetica,sans-serif">//Ernst</div></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Den tis =
1 dec. 2020 kl 17:32 skrev Martin Jansa &lt;<a href=3D"mailto:martin.jansa@=
gmail.com">martin.jansa@gmail.com</a>&gt;:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><div dir=3D"ltr">Also all these e-mails belong t=
o openembedded-core ML not bitbake-devel.</div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 1, 2020 at 5:31 PM Mar=
tin Jansa via <a href=3D"http://lists.openembedded.org" target=3D"_blank">l=
ists.openembedded.org</a> &lt;Martin.Jansa=3D<a href=3D"mailto:gmail.com@li=
sts.openembedded.org" target=3D"_blank">gmail.com@lists.openembedded.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"ltr">Not sure if this is worth backport (it&#39;s very useful, but=
 requires changes in other layers - and these changes aren&#39;t backwards =
compatible so they would need to be applied only in dunfell and not gatesga=
rth branches of these layers or the same patchset would need to land in oe-=
core/gatesgarth first).<div><br></div><div>But you&#39;re definitely missin=
g this fix from master:</div><div><a href=3D"https://git.openembedded.org/o=
penembedded-core/commit/?id=3Dc99bb79087e74a967286469e1d8888a546ebec83" tar=
get=3D"_blank">https://git.openembedded.org/openembedded-core/commit/?id=3D=
c99bb79087e74a967286469e1d8888a546ebec83</a><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 1, 2020=
 at 5:27 PM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail.com" ta=
rget=3D"_blank">ernstp@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">From: Alexander Kanavin &lt;<a href=3D"ma=
ilto:alex.kanavin@gmail.com" target=3D"_blank">alex.kanavin@gmail.com</a>&g=
t;<br>
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
</blockquote></div>

--0000000000008e8dfb05b569c4e3--
