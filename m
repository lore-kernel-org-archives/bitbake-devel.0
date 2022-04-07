Return-Path: <kergoth@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397B0C4332F
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 23:49:46 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web09.449.1649368783786879687
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Apr 2022 14:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=B5JT0gPu;
 spf=pass (domain: gmail.com, ip: 209.85.214.172, mailfrom: kergoth@gmail.com)
Received: by mail-pl1-f172.google.com with SMTP id j8so6223817pll.11
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Apr 2022 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version;
        bh=8I3x8HfZBLKa+OvxuXCfDGfh8YtWb2IhlRO98+6pLrw=;
        b=B5JT0gPuyN/KRFxej/qH1mL1MuGMM5EqbipHeQXu57MtlvkBj6G8h8erZaGrIo+3LD
         V+vQbdy9xVR1AXYjs3uLQoqs33jdk8Knh+vizKUKpS5ywEiYd6TBtCaffcl/Q0hiMFB2
         zt+6FjE80iFfRBEwsYnJKr34W5r5SpFTUXGXrxSQajODkYOUeKRmgvd2vV9qNhAIs8FK
         0swGTRb1zJWATR8vecbz23S5gVDQnEeQm9s7lobH0Pt22u+chGytymSF9n6uWUkdmhRT
         r2VI6d8ub1xnNAxkjJCaqCSGdmx6AlebQLEcFUzY/+KGet+B9RRPJheexF+MJw9QyTad
         JCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version;
        bh=8I3x8HfZBLKa+OvxuXCfDGfh8YtWb2IhlRO98+6pLrw=;
        b=3G9U+fqjdKnRXsRfTu4/gb8+wz3SLumVjKtVXgjhpNIJRraS0eHyLA03cMMHT1YYBQ
         gZeTlI2uDzDlvzMwtDaFndZJJcCwfSjnB/vGdUG0ki+uMuAPmIxWgvbmftGGnpAcgUXs
         pSCdOMi6+ImL0Gc0OLu83CjAeLoqB1yRX70P528HIuaw9OrWI7dH5LP5Qyln/W9xU7AM
         8NjtazhFyNbs6OOrSz1BuEZIvoqKnlA36kE4uEHUmjI0/VhiQ1524wjofIgp15pltzfJ
         D4s7XZr/TDujuI5E43Irzb5I+rmF3FqSiiH3lNNoZY177LPQoE1yKMlJYHCrM6Z0GECL
         Qx3Q==
X-Gm-Message-State: AOAM530Uhs6YuwNPmPhSW5I7vUa/oY3vdNMEjaiSwTbEjCAuMPK0KWl7
	lrF+2eXXXVJUU/1Jn7cB+pm6ywqGEL8=
X-Google-Smtp-Source: 
 ABdhPJyrCbZ6cuUwDG9DZhQST1MaHKbGbZGZEcnRmVfGIPj54bWCJukbfSvnAeUmNwEoq+kPfvKPog==
X-Received: by 2002:a17:902:e545:b0:154:4d5b:2006 with SMTP id
 n5-20020a170902e54500b001544d5b2006mr15991918plf.94.1649368782855;
        Thu, 07 Apr 2022 14:59:42 -0700 (PDT)
Received: from [192.168.1.17] (ip70-188-217-212.ph.ph.cox.net.
 [70.188.217.212])
        by smtp.gmail.com with ESMTPSA id
 f14-20020a056a0022ce00b004fabe9fac23sm25256071pfj.151.2022.04.07.14.59.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:59:41 -0700 (PDT)
Date: Thu, 7 Apr 2022 14:59:39 -0700
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org, Christian Eggers
 <ceggers@arri.de>
Message-ID: <9b705184-11b1-48fa-98b5-814a754b1b5b@Spark>
In-Reply-To: <1839335.tdWV9SEqCh@localhost.localdomain>
References: <1839335.tdWV9SEqCh@localhost.localdomain>
Subject: Re: [bitbake-devel] conditional inheriting classes does not
 work with bbappends
X-Readdle-Message-ID: 9b705184-11b1-48fa-98b5-814a754b1b5b@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="624f5ecb_327b23c6_165b8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Apr 2022 23:49:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13595

--624f5ecb_327b23c6_165b8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

There=E2=80=99s no way to avoid that, inherit lines are evaluated *at the=
 moment of inherit* on that line, they aren=E2=80=99t postponed.

--
Christopher Larson
chris=5Flarson=40mentor.com, chris.larson=40siemens.com, kergoth=40gmail.=
com
Principal Software Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemens =
Digital Industries Software
On Apr 7, 2022, 7:17 AM -0700, Christian Eggers <ceggers=40arri.de>, wrot=
e:
> Example: meta-openembedded/meta-networking/recipes-support/chrony/chron=
y=5F4.2.bb
>
> --------------------------------8<--------------------------------
> =23 Add chronyd user if privdrop packageconfig is selected
> inherit =24=7B=40bb.utils.contains('PACKAGECON=46IG', 'privdrop', 'user=
add', '', d)=7D
> USERADD=5FPACKAGES =3D =22=24=7B=40bb.utils.contains('PACKAGECON=46IG',=
 'privdrop', '=24=7BPN=7D', '', d)=7D=22
> USERADD=5FPARAM:=24=7BPN=7D +=3D =22=24=7B=40bb.utils.contains('PACKAGE=
CON=46IG', 'privdrop', '--system -d / -M --shell /bin/nologin chronyd;', =
'', d)=7D=22
>
> ...
>
> PACKAGECON=46IG =3F=3F=3D ...
> -------------------------------->8--------------------------------
>
>
> Problem =231: useradd is not inherited because PACKAGECON=46IG is set b=
elow the conditional =22inherit=22
> statement. Even when I add =22privdrop=22 to PACKAGECON=46IG here, user=
add.bbclass is not inherited. I
> must move the PACKAGECON=46IG line above the inherit statement to make =
this work.
>
> Problem =232: Due to problem =231, useradd.bbclass is also not inherite=
d when I add =22privdrop=22 to
> PACKAGECON=46IG in bbappend file (in a custom layer).
>
> regards
> Christian
>
>
>
>
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F
> Christian
> Eggers
> Software=C2=A0Engineer
>
> ARRI
> Arnold=C2=A0&=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH=C2=A0&=C2=A0=
Co.=C2=A0Betriebs=C2=A0KG
> Arriweg=C2=A017 ,
> 83071
> Stephanskirchen
> www.arri.com
>
> +49=C2=A08036=C2=A03009-3118
> CEggers=40arri.de
>
>
> Get=C2=A0all=C2=A0the=C2=A0latest=C2=A0information=C2=A0from=C2=A0www.a=
rri.com,=C2=A0=46acebook,=C2=A0Twitter,=C2=A0Instagram,=C2=A0LinkedIn=C2=A0=
and=C2=A0YouTube.
>
> Arnold=C2=A0&=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH=C2=A0&=C2=A0=
Co.=C2=A0Betriebs=C2=A0KG
> Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsg=
ericht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Handelsregisternummer:=C2=A0=
HRA=C2=A057918
> Pers=C3=B6nlich=C2=A0haftender=C2=A0Gesellschafter:=C2=A0Arnold=C2=A0&=C2=
=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH
> Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsg=
ericht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Handelsregisternummer:=C2=A0=
HRB=C2=A054477
> Gesch=C3=A4ftsf=C3=BChrer:=C2=A0Dr.=C2=A0Matthias=C2=A0Erb=C2=A0(Chairm=
an);=C2=A0Dr.=C2=A0Michael=C2=A0Neuh=C3=A4user;=C2=A0Stephan=C2=A0Schenk;=
=C2=A0Walter=C2=A0Trauninger
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (=2313594): https://lists.openembedded.org/g/bitbake-=
devel/message/13594
> Mute This Topic: https://lists.openembedded.org/mt/90313668/3617123
> Group Owner: bitbake-devel+owner=40lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =5Bke=
rgoth=40gmail.com=5D
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--624f5ecb_327b23c6_165b8
Content-Type: multipart/related; boundary="624f5ecb_6b8b4567_165b8"

--624f5ecb_6b8b4567_165b8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>There=E2=80=99s no way to avoid that, inherit lines=
 are evaluated *at the moment of inherit* on that line, they aren=E2=80=99=
t postponed.</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22>
<div dir=3D=22auto=22>--</div>
<div dir=3D=22auto=22>Christopher Larson</div>
<div dir=3D=22auto=22>chris=5Flarson=40mentor.com, chris.larson=40siemens=
.com, kergoth=40gmail.com</div>
<div dir=3D=22auto=22><span style=3D=22color: var(--textColor); backgroun=
d-color: var(--backgroundColor);=22>Principal Software Engineer,&=23160;<=
/span><span style=3D=22color: var(--textColor); background-color: var(--b=
ackgroundColor);=22>Embedded Linux Solutions,&=23160;</span><span style=3D=
=22color: var(--textColor); background-color: var(--backgroundColor);=22>=
Siemens Digital Industries Software</span><br /></div>
</div>
</div>
<div name=3D=22messageReplySection=22>On Apr 7, 2022, 7:17 AM -0700, Chri=
stian Eggers &lt;ceggers=40arri.de&gt;, wrote:<br />
<blockquote type=3D=22cite=22 style=3D=22border-left-color: grey; border-=
left-width: thin; border-left-style: solid; margin: 5px 5px;padding-left:=
 10px;=22>
<div>Example: meta-openembedded/meta-networking/recipes-support/chrony/ch=
rony=5F4.2.bb<br />
<br />
--------------------------------8&lt;--------------------------------<br =
/>
=23 Add chronyd user if privdrop packageconfig is selected<br />
inherit =24=7B=40bb.utils.contains('PACKAGECON=46IG', 'privdrop', 'userad=
d', '', d)=7D<br />
USERADD=5FPACKAGES =3D =22=24=7B=40bb.utils.contains('PACKAGECON=46IG', '=
privdrop', '=24=7BPN=7D', '', d)=7D=22<br />
USERADD=5FPARAM:=24=7BPN=7D +=3D =22=24=7B=40bb.utils.contains('PACKAGECO=
N=46IG', 'privdrop', '--system -d / -M --shell /bin/nologin chronyd;', ''=
, d)=7D=22<br />
<br />
...<br />
<br />
PACKAGECON=46IG =3F=3F=3D ...<br />
--------------------------------&gt;8--------------------------------<br =
/>
<br />
<br />
Problem =231: useradd is not inherited because PACKAGECON=46IG is set bel=
ow the conditional =22inherit=22<br />
statement. Even when I add =22privdrop=22 to PACKAGECON=46IG here, userad=
d.bbclass is not inherited. I<br />
must move the PACKAGECON=46IG line above the inherit statement to make th=
is work.<br />
<br />
Problem =232: Due to problem =231, useradd.bbclass is also not inherited =
when I add =22privdrop=22 to<br />
PACKAGECON=46IG in bbappend file (in a custom layer).<br />
<br />
regards<br />
Christian<br />
<br />
<br />
<br />
<br /></div>
<div dir=3D=22ltr=22 style=3D=22mso-line-height-rule:exactly;-webkit-text=
-size-adjust:100%;direction:ltr;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22width:100%;=22>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;=22>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22width:100%;font-size:0;=22>
<tr style=3D=22font-size:14.67px;color:=237=467=467=46;font-style:normal;=
font-weight:400;white-space:nowrap;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22>=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F<span style=3D=22font-family:remialcx=
esans;font-size:1px;color:=23=46=46=46=46=46=46;line-height:1px;=22>=E2=80=
=8B</span></td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;=22>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=237=467=467=46;font-style:normal;font-weight:400=
;white-space:nowrap;=22>
<tr style=3D=22font-size:14.67px;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22>Christian</td>
<td align=3D=22left=22 style=3D=22vertical-align:top;color:=23000001;font=
-family:Calibri,Arial,sans-serif;=22>&=23160;<br /></td>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22>Eggers</td>
</tr>
</table>
</td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=237=467=467=46;font-style:normal;font-weight:400=
;white-space:nowrap;=22>
<tr style=3D=22font-size:14.67px;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22>Software&=23160;Engineer</td>
</tr>
<tr style=3D=22font-size:14.67px;color:=23000001;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22>=E2=80=8B</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;=22>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=230E50AD;font-style:normal;font-weight:400;white=
-space:nowrap;=22>
<tr style=3D=22font-size:13.33px;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:'Arial B=
lack';=22>ARRI</td>
</tr>
<tr style=3D=22font-size:10.67px;color:=237=467=467=46;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Arial;=22=
><span style=3D=22font-size:11px;=22>Arnold&=23160;&amp;&=23160;Richter&=23=
160;Cine&=23160;Technik&=23160;GmbH&=23160;&amp;&=23160;Co.&=23160;Betrie=
bs&=23160;KG</span>&=23160;<br /></td>
</tr>
</table>
</td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=237=467=467=46;font-style:normal;font-weight:400=
;white-space:nowrap;=22>
<tr style=3D=22font-size:10.67px;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Arial;=22=
>Arriweg&=23160;17</td>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Arial;=22=
>,&=23160;<br /></td>
<td align=3D=22left=22 style=3D=22vertical-align:middle;font-family:Arial=
;=22>83071</td>
<td align=3D=22left=22 style=3D=22vertical-align:middle;font-family:Arial=
;=22>&=23160;<br /></td>
<td align=3D=22left=22 style=3D=22vertical-align:middle;font-family:Arial=
;=22>Stephanskirchen</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;=22>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=231532B9;font-style:normal;font-weight:400;white=
-space:nowrap;=22>
<tr style=3D=22font-size:11px;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Arial;=22=
><span style=3D=22text-decoration:underline;=22><a href=3D=22http://www.a=
rri.com/=22 target=3D=22=5Fblank=22 id=3D=22LPlnk689713=22 style=3D=22tex=
t-decoration:underline;color:=231532B9;=22><strong style=3D=22font-weight=
:400;=22>www.arri.com&=23160;<br />
<br /></strong></a></span></td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=23858080;font-style:normal;font-weight:400;line-=
height:normal;white-space:nowrap;=22>
<tr style=3D=22font-size:14.67px;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;font-size:=
0;=22><img src=3D=22cid:image372264.png=40B779705B.AEB47B54=22 width=3D=22=
20=22 border=3D=220=22 alt=3D=22=22 style=3D=22width:20px;min-width:20px;=
max-width:20px;font-size:0;=22 /></td>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;=22><a href=3D=22tel:+49%208036%203009-3118=22=
 target=3D=22=5Fblank=22 id=3D=22LPlnk689713=22 style=3D=22text-decoratio=
n:none;color:=23858080;=22><strong style=3D=22font-weight:400;=22>+49&=23=
160;8036&=23160;3009-3118</strong></a></td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22></td>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22></td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22></td>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22></td>
</tr>
<tr style=3D=22font-size:14.67px;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;font-size:=
0;=22><img src=3D=22cid:image543396.png=40DE15=467C4.2=46912BD5=22 width=3D=
=2220=22 border=3D=220=22 alt=3D=22=22 style=3D=22width:20px;min-width:20=
px;max-width:20px;font-size:0;=22 /></td>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;=22><a href=3D=22mailto:CEggers=40arri.de=22 t=
arget=3D=22=5Fblank=22 id=3D=22LPlnk689713=22 style=3D=22text-decoration:=
none;color:=23858080;=22><strong style=3D=22font-weight:400;=22>CEggers=40=
arri.de</strong></a></td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
<tr style=3D=22font-size:14.67px;color:=23000001;font-style:normal;font-w=
eight:400;white-space:nowrap;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22><br />
=E2=80=8B</td>
</tr>
</table>
</td>
</tr>
<tr style=3D=22font-size:0;line-height:normal;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22><a hre=
f=3D=22https://www.arri.com/trinity2=5Fartemis2=22 target=3D=22=5Fblank=22=
 id=3D=22LPlnk689713=22 style=3D=22text-decoration:none;=22><img src=3D=22=
https://assets.arri.com/media/sign/20220401=5Ftrinity2=5Fartemis2=5FE-mai=
l=5FSignature=5F650x95.jpg=22 border=3D=220=22 title=3D=22One modular sys=
tem, two new stabilizers: ARTEMIS 2 &amp; TRINITY 2=22 alt=3D=22One modul=
ar system, two new stabilizers: ARTEMIS 2 &amp; TRINITY 2=22 style=3D=22f=
ont-size:12px;=22 /></a></td>
</tr>
<tr style=3D=22font-size:13px;color:=237=467=467=46;font-style:normal;fon=
t-weight:400;white-space:nowrap;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;=22>Get&=23160;all&=23160;the&=23160;latest&=23=
160;information&=23160;from&=23160;<span style=3D=22text-decoration:under=
line;=22><a href=3D=22https://www.arri.com/=22 target=3D=22=5Fblank=22 id=
=3D=22LPlnk689713=22 style=3D=22text-decoration:underline;color:=237=467=46=
7=46;=22><strong style=3D=22font-weight:400;=22>www.arri.com</strong></a>=
</span>,&=23160;<span style=3D=22text-decoration:underline;=22><a href=3D=
=22https://www.facebook.com/TeamARRI=22 target=3D=22=5Fblank=22 id=3D=22L=
Plnk689713=22 style=3D=22text-decoration:underline;color:=237=467=467=46;=
=22><strong style=3D=22font-weight:400;=22>=46acebook</strong></a></span>=
,&=23160;<span style=3D=22text-decoration:underline;=22><a href=3D=22http=
s://twitter.com/ARRIChannel=22 target=3D=22=5Fblank=22 id=3D=22LPlnk68971=
3=22 style=3D=22text-decoration:none;color:=237=467=467=46;=22><strong st=
yle=3D=22font-weight:400;=22>Twitter</strong></a></span>,&=23160;<a href=3D=
=22https://www.instagram.com/arri/=22 target=3D=22=5Fblank=22 id=3D=22LPl=
nk689713=22 style=3D=22text-decoration:none;color:=237=467=467=46;=22><st=
rong style=3D=22font-weight:400;=22><span style=3D=22text-decoration:unde=
rline;=22>Instagram</span></strong></a>,&=23160;<a href=3D=22https://www.=
linkedin.com/company/arri=22 target=3D=22=5Fblank=22 id=3D=22LPlnk689713=22=
 style=3D=22text-decoration:none;color:=237=467=467=46;=22><strong style=3D=
=22font-weight:400;=22><span style=3D=22text-decoration:underline;=22>Lin=
kedIn</span></strong></a>&=23160;and&=23160;<a href=3D=22https://www.yout=
ube.com/user/ARRIChannel=22 target=3D=22=5Fblank=22 id=3D=22LPlnk689713=22=
 style=3D=22text-decoration:none;color:=237=467=467=46;=22><strong style=3D=
=22font-weight:400;=22><span style=3D=22text-decoration:underline;=22>You=
Tube</span></strong></a>.<br /></td>
</tr>
<tr style=3D=22font-size:0;=22>
<td align=3D=22left=22 style=3D=22padding:0;vertical-align:top;=22>
<table cellpadding=3D=220=22 cellspacing=3D=220=22 border=3D=220=22 style=
=3D=22font-size:0;color:=236A6A6A;font-style:normal;font-weight:400;white=
-space:nowrap;=22>
<tr style=3D=22font-size:10px;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Arial;=22=
><br />
Arnold&=23160;&amp;&=23160;Richter&=23160;Cine&=23160;Technik&=23160;GmbH=
&=23160;&amp;&=23160;Co.&=23160;Betriebs&=23160;KG<br />
Sitz:&=23160;M=C3=BCnchen&=23160;=E2=80=91&=23160;Registergericht:&=23160=
;Amtsgericht&=23160;M=C3=BCnchen&=23160;=E2=80=91&=23160;Handelsregistern=
ummer:&=23160;HRA&=23160;57918<br />
Pers=C3=B6nlich&=23160;haftender&=23160;Gesellschafter:&=23160;Arnold&=23=
160;&amp;&=23160;Richter&=23160;Cine&=23160;Technik&=23160;GmbH<br />
Sitz:&=23160;M=C3=BCnchen&=23160;=E2=80=91&=23160;Registergericht:&=23160=
;Amtsgericht&=23160;M=C3=BCnchen&=23160;=E2=80=91&=23160;Handelsregistern=
ummer:&=23160;HRB&=23160;54477<br />
Gesch=C3=A4ftsf=C3=BChrer:&=23160;Dr.&=23160;Matthias&=23160;Erb&=23160;(=
Chairman);&=23160;Dr.&=23160;Michael&=23160;Neuh=C3=A4user;&=23160;Stepha=
n&=23160;Schenk;&=23160;Walter&=23160;Trauninger<br /></td>
</tr>
<tr style=3D=22font-size:14.67px;color:=23000001;=22>
<td align=3D=22left=22 style=3D=22vertical-align:top;font-family:Calibri,=
Arial,sans-serif;=22><br />
=E2=80=8B<br /></td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
</div>
<br />
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br />
Links: You receive all messages sent to this group.<br />
View/Reply Online (=2313594): https://lists.openembedded.org/g/bitbake-de=
vel/message/13594<br />
Mute This Topic: https://lists.openembedded.org/mt/90313668/3617123<br />=

Group Owner: bitbake-devel+owner=40lists.openembedded.org<br />
Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =5Bkerg=
oth=40gmail.com=5D<br />
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br />
<br /></blockquote>
</div>
</body>
</html>

--624f5ecb_6b8b4567_165b8
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-ID: <image372264.png@B779705B.AEB47B54>
Content-Disposition: inline; filename="image372264.png"

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAGlSURBVDhP1ZOxSgNBEIZ3o6QSSWGRwiJFCl9A
iCDEIqKFgo2FYGHjA1hYRZ0sGrURgq0WgkoqEUHQShJMYWFhmcLCwsIHsJBEs/5zmTvvJIE9sPGD
Zf7Zu/tvdndW/TVaogcRDSWVKlilMhvGVGQ6FoEhzAaTWt9AFji31q7C9Jh1HBISFSpbQPDMGK31
NlcsqTOBIRxmRPmkUTGJdubHUKmsxDA5ic6EDV8k+jRa1i6KdiYw/LL2QiTzDrNpY8yb5M4EhlvG
XKNdniXl9pkTHYvwkrlXDkTxIR3tEWUkcyZi2FbqBOGxm6lUR+tT7k/JnYgYYs8+sHfzkP7eTaJ1
LmGaktyjTDSGsSxphMjV89khyqGx7yG96rC3r7g5S5vGNHaJsrb7LI3RwPw6btQDv8f0NGRwTWYT
Wlch/eo+Mc5gPoWPfu9tpVgqrbGIHkoIVHOLQ5qAQVOmuNqVHma8guDK9jVkisY029aOQ/JhcYU9
wbLPRaoBiX2p1+utu1rtqpDPV9FKHVQziiqH5fETzMr40yHe68hcfPaJRnHyI5L+K5T6BsZ9gKi6
xb3hAAAAAElFTkSuQmCC

--624f5ecb_6b8b4567_165b8
Content-Type: image/png
Content-Transfer-Encoding: base64
Content-ID: <image543396.png@DE15F7C4.2F912BD5>
Content-Disposition: inline; filename="image543396.png"

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALNSURBVDhPtZQ/SNVRFMfv1Z/S4PCGBoeg1Uih
oaFB8j1wMGgweBJBgUNRUQ2BQaH2e79SaKipwcGhlkioQEiooT++7RUOBkYODg0GgiIOLyi1bp/v
/d3fL8U31hfuO/ec3z3nfM895z7zr2GDbIg4jgutxvQ6Yw5IRy5uGzOfJMmKP9AADQMSaH+LtQ/5
WEaNUutfEHj5t3OXbyfJTDDl2BNwPI7LxtoJthFOD5A1WM0hf7QY04FDB98vohdZjzeduwbjOnuP
piA9QrBnMJjl4KHRJBmD3hJlF5HdW8Z8HU6SqeFKpeScu4BLmUoepd4pcoYqs9XaLwo2UqkMoEfo
YjrIysreNs6dI+kk515b516wf4ptgETPdSBnqDtDRFuUIJ1g0s/jOE3pJ7TQZ30AY9pg4tmyn8E2
AYE29mlmdVMNwInrSFbG4vgq5kvY7lHeLZ0ROFcj0SrbCFYfZNM9N1n7XveLOucZajQQCl6TTsYr
MFv66dyo1wNItoFQg4QF/dAwL0GnfnxAnP2cqZu6S3WSD1MEwLQbnFVpdcpdlM6ZNcSatfaw9Cyg
2Ml5G7bd3ubcJ8md0D2RTEzmU0uOPLEPyM8yIiLqEYIXZMtY7wTJhsI2K1tJ2hHtEPgs3QfcVPdS
HGP5UijhtGSGO3F8EuOw9pmzGNOkSbYbkHkjGxWkGK9UXsGqk7Hp4tBLTN3oU2RcQvahH0VO49DP
XgxF4iyr8Is5zJ6hZyg08TY5XCDY3WbnzgTnMnKEz5FeBgN/ijG5gW1fSKLh7tr5pnOGguaPUjXQ
93l6GhlddlsYl13gmfZzVTXNbTB5NAfp8a5a/Vjq6flO0JsM6yD3sspaf1utruu77qy3WDzeWyo9
4T6HKO8bPunsBuximIHs+kfRo1eThA1KrHM46/w8pV/nzyNrZo6GATNwBRqjPtgeRK2H7i6MJEk+
Nv8ZxvwBPgIhrepF7fMAAAAASUVORK5CYII=

--624f5ecb_6b8b4567_165b8--

--624f5ecb_327b23c6_165b8--


