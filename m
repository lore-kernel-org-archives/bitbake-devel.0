Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A31CC76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 05:20:36 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.123311.1680672030651640649
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Apr 2023 22:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OHc+Q7YC;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id j11so45068485lfg.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 04 Apr 2023 22:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680672028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0Az/IyGrcTpwp0LJK+WqiGP89HeMpJrez1zEe0jRukc=;
        b=OHc+Q7YCfbW4KKRMWSZbwi2JDjpCw63GjJA8MKd+q9k3J6lHfCc3x967Q1wheQFEwh
         AeFIpnFU5R88jmsTSxmfzoFqz/79hf/THYVq7XbjqUlkt2TUmAf93Tk3YI7sK++PSNZl
         rPxJ7+8V2KKr8W8gWy2pRRonSLfb7V3Qwhrl2onDiHqFUsKSmSMGDcaAY8qTWltk3JtC
         VoJMohYXr5E4vp/vLQ/avDHdI6TWAoAtcT7hXykNjjj6nJOwJs87mcNAVFTYzgwYY4XE
         IY1nfDu62wpStmPvrTd3JV9Y2N94EEfTnC4SRjy3gAoiBuQ7u24BICsrTDJ1Sym7Yd+f
         bM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Az/IyGrcTpwp0LJK+WqiGP89HeMpJrez1zEe0jRukc=;
        b=yWUiYo70Kt2iM8WJcWjba6+4py29N01wiA3XoLexaOEyvbZIsMI4c+yEw2roM6j0Gl
         rh+FjketWlwsfe5BcR/IQ3Il8GD7wMWNZhfvh4i1tjqrGZy5o+7N9flmVFaF8XOyU1Qn
         XsSTDbtTsZ/8cReQODoYX8WlzwMYZaa2TM64BtVNUiqc72MFjuXUOQso7VHeJhfAyOwH
         Mx4rgL7SNrBupE20MGeX0pmqPmQ5PRhWTdI7cvyeibr5iF1+Z181aFy4nsWvE020CPMx
         0vh5hGG6NZSBY0fHWT7HqsOFZtW7U6LSF+CpN6F3uBSCzMlSJnsvKqklT+jtEHn2LDNN
         O0jA==
X-Gm-Message-State: AAQBX9dO5D2QmBrAoDLyIAPgT+ZFt351a9PhmFBP2TI033VtKXD9Os/q
	ivmBdHozJRbQ474Hrc5hvFKICc57myg1d6dHa/g=
X-Google-Smtp-Source: AKy350b3u0B91liRrEC2jRMnHgtby5kJ4dGxQgq83qx5yQkQZCPMVZgNjdQvgHfTaKIbjNZhDIM4rgXdXT+EMbu6F9U=
X-Received: by 2002:ac2:5939:0:b0:4d5:ca32:6aec with SMTP id
 v25-20020ac25939000000b004d5ca326aecmr1495982lfi.12.1680672028163; Tue, 04
 Apr 2023 22:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230401152101.19037-1-frederic.martinsons@gmail.com>
 <7d59e968-1dea-acf1-6d18-59bb4fd35cb6@mvista.com> <CA+chaQcWaafMWnok=q+3SUcEj-+R99wxdC4JXpaM+rAGYCWhkg@mail.gmail.com>
 <68045681-5481-80f5-30f4-e15616503dcd@mvista.com> <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
In-Reply-To: <CA+chaQead2PQ4yn7XSp-dejU+66kzROBOkAAeAJA42h=BSRLHg@mail.gmail.com>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Wed, 5 Apr 2023 07:20:16 +0200
Message-ID: <CA+cAkeqJmpO2A6-bERPJjTuKt+e-MLBAgtFB34UOSRCb=7hBMw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Display all missing checksum at once
To: Martin Jansa <martin.jansa@gmail.com>
Cc: akuster <akuster@mvista.com>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000039016705f88ff3ba"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 05:20:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14639

--00000000000039016705f88ff3ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I looked at the suricata recipe in meta-security and it didn't use
cargo-update-recipes.bbclass

You should modify your rust recipes to use this class and have access to
"bitbake -c update_crates" .

You can take some examples from , i.e python3-cryptography in
openembedded-core or python3-pyruvate
in meta-python.

The first issue you'll encounter is some kind of bootstrapping (since
update_crates needs to fetch
to be able to write checksum but the fetcher needs the checksum ...). With
this error , you'll
see all the data you need to add to the suricata-crates.inc.

For curiosity, I tested locally the modification of suricata and it seems
that this package embeds
unexpected Cargo.lock format (in rust/vendor/alloc-no-stdlib/Cargo.lock)
which doesn't contain
a source entry (the package doesn't have any dependency).

I don't know how to handle such a file (simply ignore it in the class
instead of raising an error ?)


On Tue, 4 Apr 2023 at 23:35, Martin Jansa <martin.jansa@gmail.com> wrote:

> On Tue, Apr 4, 2023 at 11:08=E2=80=AFPM akuster <akuster@mvista.com> wrot=
e:
>
>>
>>
>> On 4/4/23 1:07 PM, Martin Jansa wrote:
>> > On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM akuster <akuster@mvista.com> wr=
ote:
>> >
>> >
>> >
>> >     On 4/1/23 11:21 AM, Frederic Martinsons wrote:
>> >     > From: Frederic Martinsons <frederic.martinsons@gmail.com>
>> >     >
>> >     > Instead of only display the first and stop.
>> >     > For recipe (crago based) that can contains several artifacts
>> >     > to fetch with their checksum, it will particularly handy
>> >     > to display all of missing one.
>> >     >
>> >     > An example of error message would be
>> >
>> >     I am confused. Is this patch supposed to add the pkg version or
>> >     not?  I
>> >     am not seeing any. Any ideas?
>> >
>> >
>> > name parameter with pkg version was added to bbclass in:
>> >
>> https://git.openembedded.org/openembedded-core/commit/?id=3D1795e98a04ad=
09b011afcc7cc3bf6dc49475b19a
>> >
>> > this change only allows all missing/incorrect checksums to be showsn
>> > at the same time, instead of one checksum per do_fetch failure.
>>
>> I get multiple hashes for the same package.
>>
>> SRC_URI[wasi.sha256sum] =3D
>> "1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f"
>> SRC_URI[wasi.sha256sum] =3D
>> "cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519"
>>
>> so why no version info after the pkg name?
>>
>
> Did you regenerate the SRC_URIs with updated bbclass? It works for me as
> in:
>
> https://github.com/shr-project/meta-webosose/commit/84dc9f3cc3dd85facde07=
ccddce0b9f2bcd90d39
>

--00000000000039016705f88ff3ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I looked at the suricata recipe in meta-security and it di=
dn&#39;t use cargo-update-recipes.bbclass<div><br></div><div>You should mod=
ify your rust recipes to use this class and=C2=A0have access to &quot;bitba=
ke -c update_crates&quot; .</div><div><br></div><div>You can take some exam=
ples from , i.e=C2=A0python3-cryptography in openembedded-core or python3-p=
yruvate</div><div>in meta-python.</div><div><br></div><div>The first issue =
you&#39;ll encounter is some kind of bootstrapping=C2=A0(since update_crate=
s needs to fetch</div><div>to be able to write checksum but the fetcher nee=
ds the checksum ...). With this error , you&#39;ll</div><div>see all the da=
ta you need to add to the suricata-crates.inc.</div><div><br></div><div>For=
 curiosity, I tested locally the modification of suricata and it seems that=
 this package embeds</div><div>unexpected Cargo.lock format (in rust/vendor=
/alloc-no-stdlib/Cargo.lock) which doesn&#39;t contain</div><div>a source e=
ntry (the package doesn&#39;t have any dependency).</div><div><br></div><di=
v>I don&#39;t know how to handle such a file (simply ignore it in the class=
 instead of raising an error ?)</div><div><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 4 Apr 2023 at 2=
3:35, Martin Jansa &lt;<a href=3D"mailto:martin.jansa@gmail.com">martin.jan=
sa@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">On Tue, Apr 4, 2023 at 11:08=
=E2=80=AFPM akuster &lt;<a href=3D"mailto:akuster@mvista.com" target=3D"_bl=
ank">akuster@mvista.com</a>&gt; wrote:<br></div><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 4/4/23 1:07 PM, Martin Jansa wrote:<br>
&gt; On Tue, Apr 4, 2023 at 6:50=E2=80=AFPM akuster &lt;<a href=3D"mailto:a=
kuster@mvista.com" target=3D"_blank">akuster@mvista.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 4/1/23 11:21 AM, Frederic Martinsons wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; From: Frederic Martinsons &lt;<a href=3D"mailt=
o:frederic.martinsons@gmail.com" target=3D"_blank">frederic.martinsons@gmai=
l.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Instead of only display the first and stop.<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; For recipe (crago based) that can contains sev=
eral artifacts<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to fetch with their checksum, it will particul=
arly handy<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to display all of missing one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; An example of error message would be<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0I am confused. Is this patch supposed to add the pk=
g version or<br>
&gt;=C2=A0 =C2=A0 =C2=A0not?=C2=A0 I<br>
&gt;=C2=A0 =C2=A0 =C2=A0am not seeing any. Any ideas?<br>
&gt;<br>
&gt;<br>
&gt; name parameter with pkg version was added to bbclass in:<br>
&gt; <a href=3D"https://git.openembedded.org/openembedded-core/commit/?id=
=3D1795e98a04ad09b011afcc7cc3bf6dc49475b19a" rel=3D"noreferrer" target=3D"_=
blank">https://git.openembedded.org/openembedded-core/commit/?id=3D1795e98a=
04ad09b011afcc7cc3bf6dc49475b19a</a><br>
&gt;<br>
&gt; this change only allows all missing/incorrect checksums to be showsn <=
br>
&gt; at the same time, instead of one checksum per do_fetch failure.<br>
<br>
I get multiple hashes for the same package.<br>
<br>
SRC_URI[wasi.sha256sum] =3D <br>
&quot;1a143597ca7c7793eff794def352d41792a93c481eb1042423ff7ff72ba2c31f&quot=
;<br>
SRC_URI[wasi.sha256sum] =3D <br>
&quot;cccddf32554fecc6acb585f82a32a72e28b48f8c4c1883ddfeeeaa96f7d8e519&quot=
;<br>
<br>
so why no version info after the pkg name?<br></blockquote><div><br></div><=
div>Did you regenerate the SRC_URIs with updated bbclass? It works for me a=
s in:</div><div><a href=3D"https://github.com/shr-project/meta-webosose/com=
mit/84dc9f3cc3dd85facde07ccddce0b9f2bcd90d39" target=3D"_blank">https://git=
hub.com/shr-project/meta-webosose/commit/84dc9f3cc3dd85facde07ccddce0b9f2bc=
d90d39</a></div></div></div>
</blockquote></div>

--00000000000039016705f88ff3ba--

