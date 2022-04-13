Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF6C3A5A3
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web09.4555.1649845494511498116
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Apr 2022 03:24:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mvus48E5;
 spf=pass (domain: gmail.com, ip: 209.85.208.181,
 mailfrom: quaresma.jose@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 15so1583952ljw.8
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Apr 2022 03:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQSjlY64jp49nPEmXzRFP/Knps9wBQzbwtfF4MCj5+o=;
        b=mvus48E5E99Mrsm7V1PT9mjIXIk3gsumWAGoJXofOLygG9ostgisF0/bUvqg7pmrFe
         EtOkmeY9DFLB7LdrJ9klji8GJOds+g9o9nqeZy50ozDcph6Jd0Z3toJBnNFzVeyJpIUY
         XWiiqofwpeEbSWeU/T44UhFIux8SWkp9a4q1SXNrlG62aDG6tNgN+pyde1OXk/7qKnpF
         NA0O9zL7ZRZEguaodglMKAsBdKvdGm3DBCtU6q/OYSwsVh8495h5y5C6AlkRAsRzjDcU
         sca7Gp+tzv4bxUMwYEQh39DVwAsdsQ6H328ChQEAVl/qZj/ECoA4c7o2iWjK/0Vmp4WU
         vx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQSjlY64jp49nPEmXzRFP/Knps9wBQzbwtfF4MCj5+o=;
        b=Hqn1SgjyHOg9lEq9azqjZkTpcTDt9UIh6TPlmFAUzv1dusieME7m3VUbCaIT1FtBqK
         0PdfYjIxvnrJCbC9z2vlWsv9+XhPouftFAt3yXLOGzDnk1z5X60cYtft+K9tFcRXJ1iM
         71ZIXxg9rI5DnJvL25qZFFGtgbKeEAIwtS8E3n401XAhsYB8719le3IfBnlzD93Bc6XU
         IkwH1fsizEb8kWT5y0Zks0A15/B4fleU9JCVSgg10Kwa64ThqBStrLZyCYc1azedK2D/
         XZ6rYyEGZo0aVtUlocaJkUAqGjytpTJSyzkOCcd5qDRKkWoJdD5flxiGRm/PzwbRrosi
         HNpA==
X-Gm-Message-State: AOAM532PMBCWWKjrioaDWUPsku+ewyfxgN3w8zNHoRkczQKmv1Q0e3rK
	ojGAitW0FzKszk3pVoNNH68gV+Ypdz20q8NueGg=
X-Google-Smtp-Source: 
 ABdhPJzWS9VDJnYcus9d2gKFpYgs3jbwBcdgO4zbFrK6VgCVEvMPMVfTe3zkObley12gbcBGZxI2Ai7O79vHrUCK29k=
X-Received: by 2002:a2e:b008:0:b0:24b:4ff2:5e09 with SMTP id
 y8-20020a2eb008000000b0024b4ff25e09mr16261383ljk.28.1649845492571; Wed, 13
 Apr 2022 03:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <1839335.tdWV9SEqCh@localhost.localdomain>
 <9b705184-11b1-48fa-98b5-814a754b1b5b@Spark>
In-Reply-To: <9b705184-11b1-48fa-98b5-814a754b1b5b@Spark>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Wed, 13 Apr 2022 11:24:40 +0100
Message-ID: 
 <CANPvuR=BOhbH18iZJZ6n2StSPzxCmFL-o=O59gi6s91YLpzkYw@mail.gmail.com>
Subject: Re: [bitbake-devel] conditional inheriting classes does not work with
 bbappends
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Christian Eggers <ceggers@arri.de>
Content-Type: multipart/related; boundary="00000000000086c16505dc869635"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13611

--00000000000086c16505dc869635
Content-Type: multipart/alternative; boundary="00000000000086c16405dc869634"

--00000000000086c16405dc869634
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Christopher Larson <kergoth@gmail.com> escreveu no dia quinta, 7/04/2022
=C3=A0(s) 22:59:

> There=E2=80=99s no way to avoid that, inherit lines are evaluated *at the=
 moment
> of inherit* on that line, they aren=E2=80=99t postponed.
>

Does the require have the same behaviour as the inherit? i.e: evaluated *at
the moment of inherit*
if not something like that can do the job:

cat <<'EOF' > my.bbappend
PACKAGECONFIG ?=3D "my-knob"
require ${@bb.utils.contains('PACKAGECONFIG', 'my-knob',
'my-conditional-inheriting.inc', '', d)}
EOF

cat <<'EOF' >my-conditional-inheriting.inc
inherit my.bbclass
EOF


Jose


>
> --
> Christopher Larson
> chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
> Principal Software Engineer, Embedded Linux Solutions, Siemens Digital
> Industries Software
> On Apr 7, 2022, 7:17 AM -0700, Christian Eggers <ceggers@arri.de>, wrote:
>
> Example: meta-openembedded/meta-networking/recipes-support/chrony/
> chrony_4.2.bb
>
> --------------------------------8<--------------------------------
> # Add chronyd user if privdrop packageconfig is selected
> inherit ${@bb.utils.contains('PACKAGECONFIG', 'privdrop', 'useradd', '',
> d)}
> USERADD_PACKAGES =3D "${@bb.utils.contains('PACKAGECONFIG', 'privdrop',
> '${PN}', '', d)}"
> USERADD_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG', 'privdrop=
',
> '--system -d / -M --shell /bin/nologin chronyd;', '', d)}"
>
> ...
>
> PACKAGECONFIG ??=3D ...
> -------------------------------->8--------------------------------
>
>
> Problem #1: useradd is not inherited because PACKAGECONFIG is set below
> the conditional "inherit"
> statement. Even when I add "privdrop" to PACKAGECONFIG here,
> useradd.bbclass is not inherited. I
> must move the PACKAGECONFIG line above the inherit statement to make this
> work.
>
> Problem #2: Due to problem #1, useradd.bbclass is also not inherited when
> I add "privdrop" to
> PACKAGECONFIG in bbappend file (in a custom layer).
>
> regards
> Christian
>
>
>
>
> _______________________________________________________
> Christian
> Eggers
> Software Engineer
> ARRI
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Arriweg 17 ,
> 83071
> Stephanskirchen
>
>
> *www.arri.com  * <http://www.arri.com/>
> *+49 8036 3009-3118* <+49%208036%203009-3118>
> *CEggers@arri.de* <CEggers@arri.de>
>
> [image: One modular system, two new stabilizers: ARTEMIS 2 & TRINITY 2]
> <https://www.arri.com/trinity2_artemis2>
> Get all the latest information from *www.arri.com* <https://www.arri.com/=
>
> , *Facebook* <https://www.facebook.com/TeamARRI>, *Twitter*
> <https://twitter.com/ARRIChannel>, *Instagram*
> <https://www.instagram.com/arri/>, *LinkedIn*
> <https://www.linkedin.com/company/arri> and *YouTube*
> <https://www.youtube.com/user/ARRIChannel>.
>
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
>
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
>
> Sitz: M=C3=BCnchen =E2=80=91 Registergericht: Amtsgericht M=C3=BCnchen =
=E2=80=91 Handelsregisternummer: HRB 54477
>
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Dr. Michael Neuh=
=C3=A4user; Stephan Schenk; Walter Trauninger
>
>
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13595):
> https://lists.openembedded.org/g/bitbake-devel/message/13595
> Mute This Topic: https://lists.openembedded.org/mt/90313668/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000086c16405dc869634
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Christopher Larson &lt;<a href=3D"mailto:kergoth@gm=
ail.com">kergoth@gmail.com</a>&gt; escreveu no dia quinta, 7/04/2022 =C3=A0=
(s) 22:59:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">



<div>
<div name=3D"messageBodySection">
<div dir=3D"auto">There=E2=80=99s no way to avoid that, inherit lines are e=
valuated *at the moment of inherit* on that line, they aren=E2=80=99t postp=
oned.</div></div></div></blockquote><div><br></div><div>Does the require ha=
ve the same behaviour as the inherit? i.e: evaluated *at the moment of inhe=
rit*<br></div><div>if not something like that can do the job:</div><div><br=
></div><div>cat &lt;&lt;&#39;EOF&#39; &gt; my.bbappend<br>PACKAGECONFIG ?=
=3D &quot;my-knob&quot;<br>require ${@bb.utils.contains(&#39;PACKAGECONFIG&=
#39;, &#39;my-knob&#39;, &#39;my-conditional-inheriting.inc&#39;, &#39;&#39=
;, d)}<br>EOF<br><br>cat &lt;&lt;&#39;EOF&#39; &gt;my-conditional-inheritin=
g.inc<br>inherit my.bbclass<br>EOF<br></div><div><br></div><div><br></div><=
div>Jose</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div><div name=3D"messageBodySection">
</div>
<div name=3D"messageSignatureSection"><br>
<div>
<div dir=3D"auto">--</div>
<div dir=3D"auto">Christopher Larson</div>
<div dir=3D"auto"><a href=3D"mailto:chris_larson@mentor.com" target=3D"_bla=
nk">chris_larson@mentor.com</a>, <a href=3D"mailto:chris.larson@siemens.com=
" target=3D"_blank">chris.larson@siemens.com</a>, <a href=3D"mailto:kergoth=
@gmail.com" target=3D"_blank">kergoth@gmail.com</a></div>
<div dir=3D"auto"><span>Principal Software Engineer,=C2=A0</span><span>Embe=
dded Linux Solutions,=C2=A0</span><span>Siemens Digital Industries Software=
</span><br></div>
</div>
</div>
<div name=3D"messageReplySection">On Apr 7, 2022, 7:17 AM -0700, Christian =
Eggers &lt;<a href=3D"mailto:ceggers@arri.de" target=3D"_blank">ceggers@arr=
i.de</a>&gt;, wrote:<br>
<blockquote type=3D"cite" style=3D"border-left:thin solid grey;margin:5px;p=
adding-left:10px">
<div>Example: meta-openembedded/meta-networking/recipes-support/chrony/<a h=
ref=3D"http://chrony_4.2.bb" target=3D"_blank">chrony_4.2.bb</a><br>
<br>
--------------------------------8&lt;--------------------------------<br>
# Add chronyd user if privdrop packageconfig is selected<br>
inherit ${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#39;privdrop&#39;, &=
#39;useradd&#39;, &#39;&#39;, d)}<br>
USERADD_PACKAGES =3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#=
39;privdrop&#39;, &#39;${PN}&#39;, &#39;&#39;, d)}&quot;<br>
USERADD_PARAM:${PN} +=3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;=
, &#39;privdrop&#39;, &#39;--system -d / -M --shell /bin/nologin chronyd;&#=
39;, &#39;&#39;, d)}&quot;<br>
<br>
...<br>
<br>
PACKAGECONFIG ??=3D ...<br>
--------------------------------&gt;8--------------------------------<br>
<br>
<br>
Problem #1: useradd is not inherited because PACKAGECONFIG is set below the=
 conditional &quot;inherit&quot;<br>
statement. Even when I add &quot;privdrop&quot; to PACKAGECONFIG here, user=
add.bbclass is not inherited. I<br>
must move the PACKAGECONFIG line above the inherit statement to make this w=
ork.<br>
<br>
Problem #2: Due to problem #1, useradd.bbclass is also not inherited when I=
 add &quot;privdrop&quot; to<br>
PACKAGECONFIG in bbappend file (in a custom layer).<br>
<br>
regards<br>
Christian<br>
<br>
<br>
<br>
<br></div>
<div dir=3D"ltr" style=3D"direction:ltr">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%=
">
<tbody><tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px">
<tbody><tr style=3D"font-size:0px">
<td align=3D"left" style=3D"padding:0px;vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%=
;font-size:0px">
<tbody><tr style=3D"font-size:14.67px;color:rgb(127,127,127);font-style:nor=
mal;font-weight:400;white-space:nowrap">
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif">_______________________________________________________<span styl=
e=3D"font-family:remialcxesans;font-size:1px;color:rgb(255,255,255);line-he=
ight:1px"></span></td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px">
<tbody><tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(127,127,127);font-style:normal;font-weight:400;white-space:no=
wrap">
<tbody><tr style=3D"font-size:14.67px">
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif">Christian</td>
<td align=3D"left" style=3D"vertical-align:top;color:rgb(0,0,1);font-family=
:Calibri,Arial,sans-serif">=C2=A0<br></td>
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif">Eggers</td>
</tr>
</tbody></table>
</td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(127,127,127);font-style:normal;font-weight:400;white-space:no=
wrap">
<tbody><tr style=3D"font-size:14.67px">
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif">Software=C2=A0Engineer</td>
</tr>
<tr style=3D"font-size:14.67px;color:rgb(0,0,1)">
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif"></td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px">
<tbody><tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(14,80,173);font-style:normal;font-weight:400;white-space:nowr=
ap">
<tbody><tr style=3D"font-size:13.33px">
<td align=3D"left" style=3D"vertical-align:top;font-family:&quot;Arial Blac=
k&quot;">ARRI</td>
</tr>
<tr style=3D"font-size:10.67px;color:rgb(127,127,127)">
<td align=3D"left" style=3D"vertical-align:top;font-family:Arial"><span sty=
le=3D"font-size:11px">Arnold=C2=A0&amp;=C2=A0Richter=C2=A0Cine=C2=A0Technik=
=C2=A0GmbH=C2=A0&amp;=C2=A0Co.=C2=A0Betriebs=C2=A0KG</span>=C2=A0<br></td>
</tr>
</tbody></table>
</td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(127,127,127);font-style:normal;font-weight:400;white-space:no=
wrap">
<tbody><tr style=3D"font-size:10.67px">
<td align=3D"left" style=3D"vertical-align:top;font-family:Arial">Arriweg=
=C2=A017</td>
<td align=3D"left" style=3D"vertical-align:top;font-family:Arial">,=C2=A0<b=
r></td>
<td align=3D"left" style=3D"vertical-align:middle;font-family:Arial">83071<=
/td>
<td align=3D"left" style=3D"vertical-align:middle;font-family:Arial">=C2=A0=
<br></td>
<td align=3D"left" style=3D"vertical-align:middle;font-family:Arial">Stepha=
nskirchen</td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px">
<tbody><tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(21,50,185);font-style:normal;font-weight:400;white-space:nowr=
ap">
<tbody><tr style=3D"font-size:11px">
<td align=3D"left" style=3D"vertical-align:top;font-family:Arial"><span sty=
le=3D"text-decoration:underline"><a href=3D"http://www.arri.com/" id=3D"gma=
il-m_5973387606588420208LPlnk689713" style=3D"text-decoration:underline;col=
or:rgb(21,50,185)" target=3D"_blank"><strong style=3D"font-weight:400">www.=
arri.com=C2=A0<br>
<br></strong></a></span></td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(133,128,128);font-style:normal;font-weight:400;line-height:no=
rmal;white-space:nowrap">
<tbody><tr style=3D"font-size:14.67px">
<td align=3D"left" style=3D"padding:0px;vertical-align:top;font-size:0px"><=
img src=3D"cid:1802270d348c027bf381" width=3D"20" border=3D"0" alt=3D"" sty=
le=3D"width: 20px; min-width: 20px; max-width: 20px; font-size: 0px;"></td>
<td align=3D"left" style=3D"padding:0px;vertical-align:top;font-family:Cali=
bri,Arial,sans-serif"><a href=3D"tel:+49%208036%203009-3118" id=3D"gmail-m_=
5973387606588420208LPlnk689713" style=3D"text-decoration:none;color:rgb(133=
,128,128)" target=3D"_blank"><strong style=3D"font-weight:400">+49=C2=A0803=
6=C2=A03009-3118</strong></a></td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"padding:0px;vertical-align:top"></td>
<td align=3D"left" style=3D"padding:0px;vertical-align:top"></td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"padding:0px;vertical-align:top"></td>
<td align=3D"left" style=3D"padding:0px;vertical-align:top"></td>
</tr>
<tr style=3D"font-size:14.67px">
<td align=3D"left" style=3D"padding:0px;vertical-align:top;font-size:0px"><=
img src=3D"cid:1802270d3488def75722" width=3D"20" border=3D"0" alt=3D"" sty=
le=3D"width: 20px; min-width: 20px; max-width: 20px; font-size: 0px;"></td>
<td align=3D"left" style=3D"padding:0px;vertical-align:top;font-family:Cali=
bri,Arial,sans-serif"><a href=3D"mailto:CEggers@arri.de" id=3D"gmail-m_5973=
387606588420208LPlnk689713" style=3D"text-decoration:none;color:rgb(133,128=
,128)" target=3D"_blank"><strong style=3D"font-weight:400">CEggers@arri.de<=
/strong></a></td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
<tr style=3D"font-size:14.67px;color:rgb(0,0,1);font-style:normal;font-weig=
ht:400;white-space:nowrap">
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif"><br>
</td>
</tr>
</tbody></table>
</td>
</tr>
<tr style=3D"font-size:0px;line-height:normal">
<td align=3D"left" style=3D"padding:0px;vertical-align:top"><a href=3D"http=
s://www.arri.com/trinity2_artemis2" id=3D"gmail-m_5973387606588420208LPlnk6=
89713" style=3D"text-decoration:none" target=3D"_blank"><img src=3D"https:/=
/assets.arri.com/media/sign/20220401_trinity2_artemis2_E-mail_Signature_650=
x95.jpg" border=3D"0" title=3D"One modular system, two new stabilizers: ART=
EMIS 2 &amp; TRINITY 2" alt=3D"One modular system, two new stabilizers: ART=
EMIS 2 &amp; TRINITY 2" style=3D"font-size: 12px;"></a></td>
</tr>
<tr style=3D"font-size:13px;color:rgb(127,127,127);font-style:normal;font-w=
eight:400;white-space:nowrap">
<td align=3D"left" style=3D"padding:0px;vertical-align:top;font-family:Cali=
bri,Arial,sans-serif">Get=C2=A0all=C2=A0the=C2=A0latest=C2=A0information=C2=
=A0from=C2=A0<span style=3D"text-decoration:underline"><a href=3D"https://w=
ww.arri.com/" id=3D"gmail-m_5973387606588420208LPlnk689713" style=3D"text-d=
ecoration:underline;color:rgb(127,127,127)" target=3D"_blank"><strong style=
=3D"font-weight:400">www.arri.com</strong></a></span>,=C2=A0<span style=3D"=
text-decoration:underline"><a href=3D"https://www.facebook.com/TeamARRI" id=
=3D"gmail-m_5973387606588420208LPlnk689713" style=3D"text-decoration:underl=
ine;color:rgb(127,127,127)" target=3D"_blank"><strong style=3D"font-weight:=
400">Facebook</strong></a></span>,=C2=A0<span style=3D"text-decoration:unde=
rline"><a href=3D"https://twitter.com/ARRIChannel" id=3D"gmail-m_5973387606=
588420208LPlnk689713" style=3D"text-decoration:none;color:rgb(127,127,127)"=
 target=3D"_blank"><strong style=3D"font-weight:400">Twitter</strong></a></=
span>,=C2=A0<a href=3D"https://www.instagram.com/arri/" id=3D"gmail-m_59733=
87606588420208LPlnk689713" style=3D"text-decoration:none;color:rgb(127,127,=
127)" target=3D"_blank"><strong style=3D"font-weight:400"><span style=3D"te=
xt-decoration:underline">Instagram</span></strong></a>,=C2=A0<a href=3D"htt=
ps://www.linkedin.com/company/arri" id=3D"gmail-m_5973387606588420208LPlnk6=
89713" style=3D"text-decoration:none;color:rgb(127,127,127)" target=3D"_bla=
nk"><strong style=3D"font-weight:400"><span style=3D"text-decoration:underl=
ine">LinkedIn</span></strong></a>=C2=A0and=C2=A0<a href=3D"https://www.yout=
ube.com/user/ARRIChannel" id=3D"gmail-m_5973387606588420208LPlnk689713" sty=
le=3D"text-decoration:none;color:rgb(127,127,127)" target=3D"_blank"><stron=
g style=3D"font-weight:400"><span style=3D"text-decoration:underline">YouTu=
be</span></strong></a>.<br></td>
</tr>
<tr style=3D"font-size:0px">
<td align=3D"left" style=3D"padding:0px;vertical-align:top">
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0px;color:rgb(106,106,106);font-style:normal;font-weight:400;white-space:no=
wrap">
<tbody><tr style=3D"font-size:10px">
<td align=3D"left" style=3D"vertical-align:top;font-family:Arial"><br>
Arnold=C2=A0&amp;=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH=C2=A0&amp;=
=C2=A0Co.=C2=A0Betriebs=C2=A0KG<br>
Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsgeric=
ht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Handelsregisternummer:=C2=A0HRA=C2=
=A057918<br>
Pers=C3=B6nlich=C2=A0haftender=C2=A0Gesellschafter:=C2=A0Arnold=C2=A0&amp;=
=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0GmbH<br>
Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsgeric=
ht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=A0Handelsregisternummer:=C2=A0HRB=C2=
=A054477<br>
Gesch=C3=A4ftsf=C3=BChrer:=C2=A0Dr.=C2=A0Matthias=C2=A0Erb=C2=A0(Chairman);=
=C2=A0Dr.=C2=A0Michael=C2=A0Neuh=C3=A4user;=C2=A0Stephan=C2=A0Schenk;=C2=A0=
Walter=C2=A0Trauninger<br></td>
</tr>
<tr style=3D"font-size:14.67px;color:rgb(0,0,1)">
<td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sa=
ns-serif"><br>
<br></td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table>
</div>
<br>
<br>
<br></blockquote>
</div>
</div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#13595): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/13595" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/13595</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/90313668/5052=
612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/90313668/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9=
 Quaresma</div></div></div></div>

--00000000000086c16405dc869634--

--00000000000086c16505dc869635
Content-Type: image/png; name="image372264.png"
Content-Disposition: inline; filename="image372264.png"
Content-Transfer-Encoding: base64
Content-ID: <1802270d348c027bf381>
X-Attachment-Id: 1802270d348c027bf381

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
--00000000000086c16505dc869635
Content-Type: image/png; name="image543396.png"
Content-Disposition: inline; filename="image543396.png"
Content-Transfer-Encoding: base64
Content-ID: <1802270d3488def75722>
X-Attachment-Id: 1802270d3488def75722

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
--00000000000086c16505dc869635--

