Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB9C433F5
	for <webhook@archiver.kernel.org>; Fri, 11 Feb 2022 22:06:36 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.2316.1644617196209212926
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Feb 2022 14:06:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VIT1KsZI;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: kergoth@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id
 h7-20020a17090a648700b001b927560c2bso8879858pjj.1
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Feb 2022 14:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version;
        bh=lfA4JLwKsf+4/NT+IY0MgNuSRjeiWRFqzUWfikahjBc=;
        b=VIT1KsZIMXvKWlAXS8gp8At3u9BO9qgArTihGemkk2LCGU2SIiK8+c0wYqrRMYUhzP
         NWwMIuBIb69K3JGHSTvPOqV7Ysth891Qkqb22UojHByuHpsPUrAChLrFeJqv3cVhghJZ
         J0Om9wt6xGxpU/m1pCswwUCD/BV7kftULb8OdMgQiGchCKoP2EgCr9sKcg6qx1hGgHtS
         VQb4qqp4Ut/3J6R0O5ev1uIeJrlSN51fMVeT/+EdCBgvzGwfd4yYW7KDp7fpZidOgycT
         xUnC96aDlJtPVYK3rRqOWgot9Oki4rL8d9+ykYPqO6EaUluMb7OFBhX6+xiC1T08rX7g
         tEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version;
        bh=lfA4JLwKsf+4/NT+IY0MgNuSRjeiWRFqzUWfikahjBc=;
        b=ObcbeNhAfGqBwzmTFtAlpnH7CGOVVlH39Wk6CRQbrGtNzAn5pQBMjvwrjzFxpiBdmu
         2NiST0lP2AwbBJbauSgaM49Fy/5IwlAQCvGigCmfSjw2xt4X0pfyU5eDblf+6Wlwh7H1
         ru/vnbMFqL7mY0mZJPYA57hCvYLrVo8qPfCj6wpODhssJC4LBjvLbPTjiQ3TpZ2VpdqU
         TK5QEenYtoOhnKxX4R3aAslW5zVq7Iy9EdRSrpZtjDrh4Amc8RxS6kbYbi5+tmKtVzLu
         lz/pvc4I3f5Jkp/ByFdWFxZdOehkaVjbb293bFumzuKMqgI5tiDiTUfKbf51PVbUndlA
         nU6g==
X-Gm-Message-State: AOAM533imDqo4YZM+lpI8sqB7aWfqkcKG6OtEfUS/C0uq9LpKzpCsqdu
	BkPrqh9/SsnJ/AY0XCll8a/EQSQhUFjJFw==
X-Google-Smtp-Source: 
 ABdhPJwkMb14bLdzlTzTOCInRyqAGg9vEwFwX6kHJULyVvAySFgsjm5e1pZIPqo/5ah9E9IExJs2Ug==
X-Received: by 2002:a17:90a:bf81:: with SMTP id
 d1mr2446434pjs.147.1644617195131;
        Fri, 11 Feb 2022 14:06:35 -0800 (PST)
Received: from [192.168.1.17] (ip70-188-217-212.ph.ph.cox.net.
 [70.188.217.212])
        by smtp.gmail.com with ESMTPSA id
 m1sm29398143pfk.202.2022.02.11.14.06.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Feb 2022 14:06:34 -0800 (PST)
Date: Fri, 11 Feb 2022 15:06:27 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Martin Leduc
 <martin.leduc@luminator.com>
Message-ID: <5689f841-7090-4141-ae31-8d02596bdad1@Spark>
In-Reply-To: <Me0Z.1644602104245206529.KOgD@lists.openembedded.org>
References: <Me0Z.1644602104245206529.KOgD@lists.openembedded.org>
Subject: Re: [bitbake-devel] bitbake addtask bbclass dependancies
X-Readdle-Message-ID: 5689f841-7090-4141-ae31-8d02596bdad1@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6206dde8_38437fdb_4f0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Feb 2022 22:06:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13341

--6206dde8_38437fdb_4f0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Tasks you add are *not* automatically run, unless they=E2=80=99re explici=
tly requested with -c or they=E2=80=99re pulled in as a dependency by a t=
ask already being run (i.e. our default task, do=5Fbuild, see BB=5FDE=46A=
ULT=5FTASK). i.e. addtask thisattheend after do=5Fimage=5Fcomplete before=
 do=5Fbuild.

--
Christopher =E2=80=9Ckergoth=E2=80=9D Larson
chris=5Flarson=40mentor.com, chris.larson=40siemens.com, kergoth=40gmail.=
com
On =46eb 11, 2022, 10:55 AM -0700, Martin Leduc <martin.leduc=40luminator=
.com>, wrote:
> Hi everyone,
>
> I try to figure if the approach is good.
>
> =46or my embeeded image, I need to run a function name do=5Fthisattheen=
d.=C2=A0 The approach I've is:
>
> Into a=C2=A0thisattheend.bbclass=C2=A0file, I write:
>
> inherit logging
> do=5Fthisattheend () =7B
> bbplain Well, it's done
> =7D
>
> do=5Fthisattheend=5Bnostamp=5D =3D =221=22
>
> addtask after do=5Fimage=5Fcomplete
>
>
> bitbake show the do=5Frootfs execution, a little quickly do=5Fimage=5Fc=
omplete and done.
>
> If I replace=C2=A0addtask thisattheend after do=5Fimage=5Fcomplete
> by=C2=A0addtask thisattheend before do=5Fbuild after do=5Fimage=5Fcompl=
ete
> I see Well, it's done
>
> And I see it 2 times, when my comprehension is the do=5Fimage=5Fcomplet=
e is called one time.
>
>
> I've to say that I'm confused about the dependency structure and layout=
 because when I look at the picture:
>
> <dummyfile.0.part>
>
> The do=5Fimage=5Fcomplete is the last state of the build process, exact=
ly where I need to run my task.
>
>
>
> What I'm doing wrong=3F
>
>
>
> Any help is appreciated.
>
>
>
> Thank you
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (=2313340): https://lists.openembedded.org/g/bitbake-=
devel/message/13340
> Mute This Topic: https://lists.openembedded.org/mt/89077246/3617123
> Group Owner: bitbake-devel+owner=40lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =5Bke=
rgoth=40gmail.com=5D
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--6206dde8_38437fdb_4f0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Tasks you add are *not* automatically run, unless t=
hey=E2=80=99re explicitly requested with -c or they=E2=80=99re pulled in =
as a dependency by a task already being run (i.e. our default task, do=5F=
build, see BB=5FDE=46AULT=5FTASK). i.e. addtask thisattheend after do=5Fi=
mage=5Fcomplete before do=5Fbuild.</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22>
<div dir=3D=22auto=22>--</div>
<div dir=3D=22auto=22>Christopher =E2=80=9Ckergoth=E2=80=9D Larson</div>
<div dir=3D=22auto=22>chris=5Flarson=40mentor.com, chris.larson=40siemens=
.com, kergoth=40gmail.com</div>
</div>
</div>
<div name=3D=22messageReplySection=22>On =46eb 11, 2022, 10:55 AM -0700, =
Martin Leduc &lt;martin.leduc=40luminator.com&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>Hi everyone,<br />
<br />
I try to figure if the approach is good.<br />
<br />
=46or my embeeded image, I need to run a function name do=5Fthisattheend.=
&=23160; The approach I've is:<br />
<br />
Into a&=23160;<span style=3D=22color: =23d4d4d4; font-family: Consolas, '=
Courier New', monospace; white-space: pre; background-color: =231e1e1e;=22=
>thisattheend.bbclass</span>&=23160;file, I write:<br />
<br />
<div style=3D=22color: =23d4d4d4; background-color: =231e1e1e; font-famil=
y: Consolas, 'Courier New', monospace; line-height: 19px; white-space: pr=
e;=22><span style=3D=22color: =23c586c0;=22>inherit</span> logging<br />
do=5Fthisattheend () =7B<br />
bbplain Well, it's done<br />
=7D<br />
<br />
<div style=3D=22line-height: 19px;=22>do=5Fthisattheend<span style=3D=22c=
olor: =239cdcfe;=22>=5Bnostamp=5D</span> =3D <span style=3D=22color: =23c=
e9178;=22>=221=22</span></div>
<br />
addtask after do=5Fimage=5Fcomplete<br />
<br /></div>
<br />
bitbake show the do=5Frootfs execution, a little quickly do=5Fimage=5Fcom=
plete and done.<br />
<br />
If I replace&=23160;<span style=3D=22color: =23d4d4d4; font-family: Conso=
las, 'Courier New', monospace; white-space: pre; background-color: =231e1=
e1e;=22>addtask</span> <span style=3D=22color: =23d4d4d4; font-family: Co=
nsolas, 'Courier New', monospace; white-space: pre; background-color: =23=
1e1e1e;=22>thisattheend a</span><span style=3D=22color: =23d4d4d4; font-f=
amily: Consolas, 'Courier New', monospace; white-space: pre; background-c=
olor: =231e1e1e;=22>fter do=5Fimage=5Fcomplete<br /></span>by&=23160;<spa=
n style=3D=22color: =23d4d4d4; font-family: Consolas, 'Courier New', mono=
space; white-space: pre; background-color: =231e1e1e;=22>addtask</span> <=
span style=3D=22color: =23d4d4d4; font-family: Consolas, 'Courier New', m=
onospace; white-space: pre; background-color: =231e1e1e;=22>thisattheend<=
/span> <span style=3D=22color: =23d4d4d4; font-family: Consolas, 'Courier=
 New', monospace; white-space: pre; background-color: =231e1e1e;=22>befor=
e do=5Fbuild after do=5Fimage=5Fcomplete<br /></span><span style=3D=22col=
or: =23000000; font-family: Consolas, 'Courier New', monospace; white-spa=
ce: pre;=22><span style=3D=22background-color: =23ffffff;=22>I see</span>=
</span> <span style=3D=22color: =23d4d4d4; font-family: Consolas, 'Courie=
r New', monospace; white-space: pre; background-color: =231e1e1e;=22>Well=
, it's done<br />
<span style=3D=22background-color: =23ffffff; color: =23000000;=22>And I =
see it 2 times, when my comprehension is the do=5Fimage=5Fcomplete is cal=
led one time.</span><br />
<br />
<br />
<span style=3D=22background-color: =23ffffff; color: =23000000;=22>I've t=
o say that I'm confused about the dependency structure and layout because=
 when I look at the picture:</span><br />
<br /></span> &lt;dummyfile.0.part&gt;<br />
<br />
<span style=3D=22color: =23000000; font-family: Consolas, 'Courier New', =
monospace; white-space: pre; background-color: =23ffffff;=22>The do=5Fima=
ge=5Fcomplete is the last state of the build process, exactly where I nee=
d to run my task.<br />
<br />
What I'm doing wrong=3F<br />
<br />
Any help is appreciated.<br />
<br />
Thank you</span><br />
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br />
Links: You receive all messages sent to this group.<br />
View/Reply Online (=2313340): https://lists.openembedded.org/g/bitbake-de=
vel/message/13340<br />
Mute This Topic: https://lists.openembedded.org/mt/89077246/3617123<br />=

Group Owner: bitbake-devel+owner=40lists.openembedded.org<br />
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =5Bkerg=
oth=40gmail.com=5D<br />
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br />
<br /></blockquote>
</div>
</body>
</html>

--6206dde8_38437fdb_4f0--


