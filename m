Return-Path: <mhalstead@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE0AC43217
	for <webhook@archiver.kernel.org>; Mon, 18 Apr 2022 14:25:52 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web08.9915.1650042372967209772
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 10:06:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cgFxyFoS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.181,
 mailfrom: mhalstead@linuxfoundation.org)
Received: by mail-lj1-f181.google.com with SMTP id f5so2541402ljp.8
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Apr 2022 10:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYG2l///UxfeolOR8WyfhFOsv6oSs2njg26+txOTzss=;
        b=cgFxyFoSGTQJzWDAfgEtifbPIiOfQRecFqNxmib5IrE1Jkd7mxQH0b9NE/+u7R5lbk
         eyuF4PovJnkqcaSiB6VUyCi35UlMFWdaMH7GCwXMNREabwqWZnl07P+HbpsEtXlTlk+S
         1yBx9F+oW8AXwJ9oo8dIbaaP0POPqj889D2HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYG2l///UxfeolOR8WyfhFOsv6oSs2njg26+txOTzss=;
        b=5xWcvhkmqRFPMSqq8Y5wucnwrugaa3ewWXDMVW/ea0MIyrs5nFj610hTjOcL0O06I1
         84v3kXeC2gu4m6IFTg6NpOegEsZoUw5z+EtiRyu6qSdfkgbsjTtJgPL1qnz/vdYw5xnx
         +ocv/PN+ebv0Ter4I7MnL/L5Df8Lsyue1iLWKqlogGrwnnIQLlA9A7i2wJdQtANIVYpo
         YHQabVY8ITXYGpr81MgPLamzgtThLb7SapNBGmBRhyN6iBEqmxmuV66vMNo62bwVQtQC
         7/27AupV0fqXuLRNk/C01+FCJUhuAe1m71NkFit+lfk9tFMnHaimnGhgHM+9ECGIlz0K
         k2zQ==
X-Gm-Message-State: AOAM533Wl7QMyZp/4bX3LuYamQbBQFle3uy86rW58ccklYksNcXer3pO
	/OC1ftBXw6uG9ZxB2nFDa5Ltp+fdh/Y404JQ9i0fAA==
X-Google-Smtp-Source: 
 ABdhPJx5IfuEEA7KlpbzJA1rlapf1avcj95rfH5lyvqf6YlHS2cnO64UxKXMcvo3qHQhvyGdNtN/gPRi9SeAsrBVib0=
X-Received: by 2002:a2e:9c43:0:b0:24b:469:2bb6 with SMTP id
 t3-20020a2e9c43000000b0024b04692bb6mr67205ljj.248.1650042370994; Fri, 15 Apr
 2022 10:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <D247F1F9-1C2C-4B53-828A-ABB4D29800DF@gmail.com>
 <91312f6a-5758-3758-0896-e7dcd438cd90@bootlin.com>
 <75e09aed-e62e-f596-32ea-c2ac76d9b186@theobroma-systems.com>
In-Reply-To: <75e09aed-e62e-f596-32ea-c2ac76d9b186@theobroma-systems.com>
From: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 15 Apr 2022 10:05:59 -0700
Message-ID: 
 <CADfgfoZiBuY0JeJPqZa_=w+bE+d4mQTbPSENepKVt-=hqOoXow@mail.gmail.com>
Subject: Re: [bitbake-devel] Branch switch doesn't work on openembedded.org
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000634d5a05dcb46db1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Apr 2022 14:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13635

--000000000000634d5a05dcb46db1
Content-Type: text/plain; charset="UTF-8"

Hi Marius,
If I understand correctly you want to get a 404 page when the path
specified doesn't exist in the branch selected. Dropping the id from the
query string when switching branches would accomplish that. The correct
place to propose these changes is on the cgit mailing list. You can join at
https://lists.zx2c4.com/mailman/listinfo/cgit. Once the changes are in cgit
you can email it-coreprojects-helpdesk@linuxfoundation.org to request we
pull them into production.

On Fri, Apr 15, 2022 at 4:32 AM Quentin Schulz <
quentin.schulz@theobroma-systems.com> wrote:

> Hi Marius,
>
>
> http://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-devtools/python/python3-pybind11_2.6.2.bb?id=82b80e6ab10a0cf678428ff11832dc9b90f9d5a6&h=master
>
> is actually going to show you the state of the file at the given commit
> hash passed in the id argument and the branch (h argument) will be ignored.
>
> I assume we'd like to remove the id argument when the dropdown menu for
> versions is used to switch between branches.
>
> I don't know where to do this so I'll let the competent people do it or
> guide us :)
>
> Cheers,
> Quentin
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13631):
> https://lists.openembedded.org/g/bitbake-devel/message/13631
> Mute This Topic: https://lists.openembedded.org/mt/90421898/1003190
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> mhalstead@linuxfoundation.org]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

-- 
Michael Halstead
Linux Foundation / Yocto Project
Systems Operations Engineer

--000000000000634d5a05dcb46db1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Marius,</div><div>If I understand correctly you wa=
nt to get a 404 page when the path specified=C2=A0doesn&#39;t exist=C2=A0in=
 the branch selected. Dropping the id from the query string when switching =
branches would accomplish that. The correct place to propose these changes =
is on the cgit mailing list. You can join at=C2=A0<a href=3D"https://lists.=
zx2c4.com/mailman/listinfo/cgit">https://lists.zx2c4.com/mailman/listinfo/c=
git</a>. Once the changes are in cgit you can email=C2=A0<a href=3D"mailto:=
it-coreprojects-helpdesk@linuxfoundation.org">it-coreprojects-helpdesk@linu=
xfoundation.org</a> to request we pull them into production.</div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 15,=
 2022 at 4:32 AM Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@theobr=
oma-systems.com">quentin.schulz@theobroma-systems.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Marius,<br>
<br>
<a href=3D"http://git.openembedded.org/meta-openembedded/tree/meta-python/r=
ecipes-devtools/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428=
ff11832dc9b90f9d5a6&amp;h=3Dmaster" rel=3D"noreferrer" target=3D"_blank">ht=
tp://git.openembedded.org/meta-openembedded/tree/meta-python/recipes-devtoo=
ls/python/python3-pybind11_2.6.2.bb?id=3D82b80e6ab10a0cf678428ff11832dc9b90=
f9d5a6&amp;h=3Dmaster</a><br>
<br>
is actually going to show you the state of the file at the given commit <br=
>
hash passed in the id argument and the branch (h argument) will be ignored.=
<br>
<br>
I assume we&#39;d like to remove the id argument when the dropdown menu for=
 <br>
versions is used to switch between branches.<br>
<br>
I don&#39;t know where to do this so I&#39;ll let the competent people do i=
t or <br>
guide us :)<br>
<br>
Cheers,<br>
Quentin<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13631): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13631" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13631</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/90421898/1003=
190" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/90421898/1003190</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:mhalstead@linuxfoundation.org" tar=
get=3D"_blank">mhalstead@linuxfoundation.org</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Michael Halstead<div>Linux Foun=
dation / Yocto Project</div><div>Systems Operations Engineer</div></div></d=
iv></div>

--000000000000634d5a05dcb46db1--

