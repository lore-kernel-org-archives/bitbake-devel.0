Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B1DC61DA4
	for <webhook@archiver.kernel.org>; Tue, 14 Feb 2023 11:05:13 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.4003.1676372711156451405
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 03:05:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=eAeFmZ5N;
 spf=pass (domain: snapchat.com, ip: 209.85.160.50, mailfrom: ecordonnier@snapchat.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-169ba826189so18557125fac.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 03:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iSwGzGaY9HrAJUZlc6a2qysTnOYGgO/iDK8lne4yJ/Q=;
        b=eAeFmZ5NdD29Pj6hq4GAyI3oP5L8GxZAByxv1mx1tnQtzKaWcUfeKkJc5/EEmbBeYp
         igchj5B9Ekhes9slfFG7Jr8N7nKNdRZMDEJBK9i/gepuCAXZe6FH0E0RJlKBxHX9ZZFS
         SoaKZu81X43pkwp7VihfeTr/FbSatz98AVFyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSwGzGaY9HrAJUZlc6a2qysTnOYGgO/iDK8lne4yJ/Q=;
        b=LdmmEvmconZdSClsdnEtsYaBK5L67pYiRjVxpt6iC9eyYs+VsHhCu6auXOGUS/ZViI
         a3X/VJUJW1PBiE08Y/aNQTxS4XWl0bQBruSqBG5Gtl23RpEN8dz2GCJ3EaZ3dOHON6ni
         7gc6r3l9Jbzcphsgjd9VdW+RiL130tzPm0uhRzBp3h/0EduYEqwKkFWfDOjl7whFkwZj
         4FhIL5JmlypX95Y8QWSEwcRiWMmACDp3G47ZvJqZW9fVM2XD8mi1YlBeGBWDRtGezDj8
         r4cvGt6y0lTIKX8ENdIzXwfxNupPXV6IJYt990YYEtFnVmFuKjY+t+w8j9usMSn6VZLF
         kabA==
X-Gm-Message-State: AO0yUKWoekObNm6Gw1oflBL/uzQ2qCJYa5EPxsCAekmDzfbXC0+fYcgl
	PemZnG1JwjFG4IqS01EJuBiq1Ss7kdPXagn8lUMs+g==
X-Google-Smtp-Source: AK7set8SeUEpg6m/U/FJcLLPQZEmHaCN03p7HP93atoUbpypGrt4Oxfi4Jf2wEQhRTGyS7ZkAhKTy2ZJDwwrn9wZWEA=
X-Received: by 2002:a05:6870:1705:b0:16e:21c7:5e29 with SMTP id
 h5-20020a056870170500b0016e21c75e29mr145967oae.111.1676372710272; Tue, 14 Feb
 2023 03:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20230214103441.1516378-1-ecordonnier@snap.com> <CA+chaQcDfmRif6AEN-jAtBYy=fzXhnn6tNOVK7NmROG9k3XNdg@mail.gmail.com>
In-Reply-To: <CA+chaQcDfmRif6AEN-jAtBYy=fzXhnn6tNOVK7NmROG9k3XNdg@mail.gmail.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Tue, 14 Feb 2023 12:04:58 +0100
Message-ID: <CAHUKmYaKHLi2OQS_JURzMfo=aMpjZmUZ16rxrq=2W6aMoE0weg@mail.gmail.com>
Subject: Re: [bitbake-devel] [kirkstone][2.0][PATCH] siggen: fix inefficient
 string concatenation
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, JJ Robertson <jrobertson@snap.com>
Content-Type: multipart/alternative; boundary="000000000000e8510405f4a6efba"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Feb 2023 11:05:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14406

--000000000000e8510405f4a6efba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note that this is just a cherry-pick from the main branch, so I kept the
commit exactly identical.

However in case your test-case is still slow, I believe there is a
potential for speed optimization by creating a list and then calling join()
one time once the loop is finished ("loop 5" in
https://stackoverflow.com/a/75313327/1710392 ). Of course the memory usage
would increase, but it's a trade-off.

On Tue, Feb 14, 2023 at 11:57 AM Martin Jansa <martin.jansa@gmail.com>
wrote:

> This might help with:
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14942
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.yoctopro=
ject.org_show-5Fbug.cgi-3Fid-3D14942&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4v=
CHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3Doi=
N1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DyeRxgb55=
69zYnhHWpVFzs4fvU9NrVNah2UOPePY64Rs&e=3D>
>
> will test it on my testcase with 380227 paths and update the ticket if
> this helps.
>
> On Tue, Feb 14, 2023 at 11:35 AM ecordonnier via lists.openembedded.org
> <https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.openembedded=
.org&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNon=
VuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP=
9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DURKYJE0IqTwSkkx42HBRLJE5BsC41VfpRdhus8DX=
5xY&e=3D>
> <ecordonnier=3Dsnap.com@lists.openembedded.org> wrote:
>
>> From: Etienne Cordonnier <ecordonnier@snap.com>
>>
>> As discussed in https://stackoverflow.com/a/4435752/1710392
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__stackoverflow.co=
m_a_4435752_1710392&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckf=
diw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DoiN1UiZT6K3vh9RWCh9=
pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DQpRKrH6Ih3NfErHKEJ3_t6yoj=
MBxhRvk66sn4Gsazkw&e=3D>
>> , CPython
>> has an optimization for statements in the form "a =3D a + b" or "a +=3D =
b".
>> It seems that this line does not get optimized, because it has a form a =
=3D
>> a + b + c:
>> data =3D data + "./" + f.split("/./")[1]
>>
>> For that reason, it does a copy of data for each iteration, potentially
>> copying megabytes
>> of data for each iteration.
>>
>> Changing this line causes SignatureGeneratorBasic::get_taskhash to take
>> 0.06 seconds
>> instead of 45 seconds on my test setup where SRC_URI points to a big
>> directory.
>>
>> Note that PEP8 recommends explicitely not to use this optimization which
>> is specific to CPython:
>> "do not rely on CPython=E2=80=99s efficient implementation of in-place s=
tring
>> concatenation for statements in the form a +=3D b or a =3D a + b"
>>
>> However, the PEP8 recommended form using "join()" also does not avoid th=
e
>> copy and takes 45 seconds in my test setup:
>> data =3D ''.join((data, "./", f.split("/./")[1]))
>>
>> I have changed the other lines to also use +=3D for consistency only,
>> however those were in the form a =3D a + b
>> and were optimized already.
>>
>> Co-authored-by: JJ Robertson <jrobertson@snap.com>
>> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
>> ---
>>  lib/bb/siggen.py | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
>> index 130b38d8..2381edd2 100644
>> --- a/lib/bb/siggen.py
>> +++ b/lib/bb/siggen.py
>> @@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):
>>
>>          data =3D self.basehash[tid]
>>          for dep in self.runtaskdeps[tid]:
>> -            data =3D data + self.get_unihash(dep)
>> +            data +=3D self.get_unihash(dep)
>>
>>          for (f, cs) in self.file_checksum_values[tid]:
>>              if cs:
>>                  if "/./" in f:
>> -                    data =3D data + "./" + f.split("/./")[1]
>> -                data =3D data + cs
>> +                    data +=3D "./" + f.split("/./")[1]
>> +                data +=3D cs
>>
>>          if tid in self.taints:
>>              if self.taints[tid].startswith("nostamp:"):
>> -                data =3D data + self.taints[tid][8:]
>> +                data +=3D self.taints[tid][8:]
>>              else:
>> -                data =3D data + self.taints[tid]
>> +                data +=3D self.taints[tid]
>>
>>          h =3D hashlib.sha256(data.encode("utf-8")).hexdigest()
>>          self.taskhash[tid] =3D h
>> --
>> 2.36.1.vfs.0.0
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14404):
>> https://lists.openembedded.org/g/bitbake-devel/message/14404
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedd=
ed.org_g_bitbake-2Ddevel_message_14404&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_=
4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3D=
oiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DVw-mNH=
nRPLvPlWEXUYciNNhBB4pZanI2ZGEsbWRNR-g&e=3D>
>> Mute This Topic: https://lists.openembedded.org/mt/96957072/3617156
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedd=
ed.org_mt_96957072_3617156&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkIC=
C2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DoiN1UiZT6K3v=
h9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3Dl4fkRs6786x3hj5GGh=
T8XQ30SmRozQ8PJGoP_xPn_y0&e=3D>
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.openembedd=
ed.org_g_bitbake-2Ddevel_unsub&d=3DDwMFaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabg=
GkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&m=3DoiN1UiZT=
6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&s=3DDVQKHhGOkYy3oS=
bWagenl7KtRRYBC1655FauLxtgkHw&e=3D>
>> [Martin.Jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>

--000000000000e8510405f4a6efba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Note that this is just a cherry-pick from the main branch,=
 so I kept the commit exactly identical.<br><br>However in case your test-c=
ase is still slow, I believe there is a potential for speed optimization by=
 creating a list and then calling join() one time once the loop is finished=
 (&quot;loop 5&quot; in=C2=A0<a href=3D"https://stackoverflow.com/a/7531332=
7/1710392">https://stackoverflow.com/a/75313327/1710392</a> ). Of course th=
e memory usage would increase, but it&#39;s a trade-off.</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 202=
3 at 11:57 AM Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com">ma=
rtin.jansa@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr">This might help with:<div><a href=3D"h=
ttps://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.yoctoproject=
.org_show-5Fbug.cgi-3Fid-3D14942&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hp=
F_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67=
E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&=
amp;s=3DyeRxgb5569zYnhHWpVFzs4fvU9NrVNah2UOPePY64Rs&amp;e=3D" target=3D"_bl=
ank">https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14942</a><br></div=
><div><br></div><div>will test it on my testcase with=C2=A0380227 paths and=
 update the ticket if this helps.</div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 14, 2023 at 11:35 AM eco=
rdonnier via <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3=
A__lists.openembedded.org&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHv=
abgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=
=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&amp;s=
=3DURKYJE0IqTwSkkx42HBRLJE5BsC41VfpRdhus8DX5xY&amp;e=3D" target=3D"_blank">=
lists.openembedded.org</a> &lt;ecordonnier=3D<a href=3D"mailto:snap.com@lis=
ts.openembedded.org" target=3D"_blank">snap.com@lists.openembedded.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From:=
 Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.com" target=3D"_=
blank">ecordonnier@snap.com</a>&gt;<br>
<br>
As discussed in <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhtt=
ps-3A__stackoverflow.com_a_4435752_1710392&amp;d=3DDwMFaQ&amp;c=3DncDTmphkJ=
TvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTK=
UkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVk=
LEOc4mUN5&amp;s=3DQpRKrH6Ih3NfErHKEJ3_t6yojMBxhRvk66sn4Gsazkw&amp;e=3D" rel=
=3D"noreferrer" target=3D"_blank">https://stackoverflow.com/a/4435752/17103=
92</a> , CPython<br>
has an optimization for statements in the form &quot;a =3D a + b&quot; or &=
quot;a +=3D b&quot;.<br>
It seems that this line does not get optimized, because it has a form a =3D=
 a + b + c:<br>
data =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
<br>
For that reason, it does a copy of data for each iteration, potentially cop=
ying megabytes<br>
of data for each iteration.<br>
<br>
Changing this line causes SignatureGeneratorBasic::get_taskhash to take 0.0=
6 seconds<br>
instead of 45 seconds on my test setup where SRC_URI points to a big direct=
ory.<br>
<br>
Note that PEP8 recommends explicitely not to use this optimization which is=
 specific to CPython:<br>
&quot;do not rely on CPython=E2=80=99s efficient implementation of in-place=
 string concatenation for statements in the form a +=3D b or a =3D a + b&qu=
ot;<br>
<br>
However, the PEP8 recommended form using &quot;join()&quot; also does not a=
void the copy and takes 45 seconds in my test setup:<br>
data =3D &#39;&#39;.join((data, &quot;./&quot;, f.split(&quot;/./&quot;)[1]=
))<br>
<br>
I have changed the other lines to also use +=3D for consistency only, howev=
er those were in the form a =3D a + b<br>
and were optimized already.<br>
<br>
Co-authored-by: JJ Robertson &lt;<a href=3D"mailto:jrobertson@snap.com" tar=
get=3D"_blank">jrobertson@snap.com</a>&gt;<br>
Signed-off-by: Etienne Cordonnier &lt;<a href=3D"mailto:ecordonnier@snap.co=
m" target=3D"_blank">ecordonnier@snap.com</a>&gt;<br>
---<br>
=C2=A0lib/bb/siggen.py | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py<br>
index 130b38d8..2381edd2 100644<br>
--- a/lib/bb/siggen.py<br>
+++ b/lib/bb/siggen.py<br>
@@ -328,19 +328,19 @@ class SignatureGeneratorBasic(SignatureGenerator):<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D self.basehash[tid]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for dep in self.runtaskdeps[tid]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + self.get_unihash=
(dep)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.get_unihash(dep)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (f, cs) in self.file_checksum_values[=
tid]:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if cs:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;/./&=
quot; in f:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
 =3D data + &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + cs=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=
 +=3D &quot;./&quot; + f.split(&quot;/./&quot;)[1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D cs<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if tid in self.taints:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.taints[tid].startsw=
ith(&quot;nostamp:&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + se=
lf.taints[tid][8:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.tai=
nts[tid][8:]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D data + se=
lf.taints[tid]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data +=3D self.tai=
nts[tid]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0h =3D hashlib.sha256(data.encode(&quot;ut=
f-8&quot;)).hexdigest()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.taskhash[tid] =3D h<br>
-- <br>
2.36.1.vfs.0.0<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14404): <a href=3D"https://urldefense.proofpoint.com/v2=
/url?u=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_14404&a=
mp;d=3DDwMFaQ&amp;c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DA=
hkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z=
-ZcCPacnWP9stnxw3HyKW5Qn-XC3JVkLEOc4mUN5&amp;s=3DVw-mNHnRPLvPlWEXUYciNNhBB4=
pZanI2ZGEsbWRNR-g&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://li=
sts.openembedded.org/g/bitbake-devel/message/14404</a><br>
Mute This Topic: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dht=
tps-3A__lists.openembedded.org_mt_96957072_3617156&amp;d=3DDwMFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Q=
n-XC3JVkLEOc4mUN5&amp;s=3Dl4fkRs6786x3hj5GGhT8XQ30SmRozQ8PJGoP_xPn_y0&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/96957072/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-=
3A__lists.openembedded.org_g_bitbake-2Ddevel_unsub&amp;d=3DDwMFaQ&amp;c=3Dn=
cDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&amp;r=3DAhkbNonVuMIGRfPx_Qj9TsRi=
h1DULJTKUkSGa66m67E&amp;m=3DoiN1UiZT6K3vh9RWCh9pNu6Z-ZcCPacnWP9stnxw3HyKW5Q=
n-XC3JVkLEOc4mUN5&amp;s=3DDVQKHhGOkYy3oSbWagenl7KtRRYBC1655FauLxtgkHw&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/=
bitbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=
=3D"_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000e8510405f4a6efba--

