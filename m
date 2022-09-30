Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA06C433F5
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 18:00:15 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web11.376.1664560809027845505
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Sep 2022 11:00:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=WGmGmGpe;
 spf=pass (domain: gmail.com, ip: 209.85.166.169,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id j7so2557887ilu.7
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Sep 2022 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6dzBjoUvuAZ5HeSIggUt6l6xnVEk9bZP2iY3Xbudx9Y=;
        b=WGmGmGpeylP5RhISaCIcuejYwp5kDft/yPoFd6wUwq0kO+/Sb3tshNbF8NoSOtwI5J
         ddAFBvd2Q01fGJnQMr97h235zjIkO3s1+gfCrh/nMKJtAsdLwFo71v6fdFXvBI2LQQI+
         JZsz4eUhfjVoXwEKJ9tIjhQqESV1lAJuBUTwGdtgOurAiVtJyO0zxpvDUO1pPXWKlRqo
         tTqcIf5zKhWHL4n5E0B98NQa7W7Y9aFW3hg5hyM8tBJN72k/xCoExYsbltfGNqjadaW/
         7DQMKEHodZtJ6OiShOta+y/GDowWkvTtySdhgv7NnR4NSx4dDOfHSKP4gd7IDMypjsWk
         6IxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6dzBjoUvuAZ5HeSIggUt6l6xnVEk9bZP2iY3Xbudx9Y=;
        b=41dEPl6bGVrSBWnuT0FCW5f6rSnLYVywNG6CwOInTTRYAaIQcZiSKgCv8FEYlsmyOE
         DipKPXodvFZbyXA1M0qo6Ete1umiOffQhhnIwpvdfu1BWi+w5omw8YOeouEeweR6Ch3D
         q3liMoRi05xlz/a/1w60xQdl9Jlmv5RudVI7nieVW/3AG/8Y1wdA/0YVsDZ6qL8ARJsL
         IDT6cMcgGj5n6FihY4gOeL9yEMmLu1mpU60mmbhCG6Yz8jxALldb/61BcPw1YPoX42SK
         tQ8TYqRH88+opp2y/eP2qJwp0lEV5u01X+E44cSEgQ/8SE3fNg2tPRjqih/BPK98aqXI
         mSJA==
X-Gm-Message-State: ACrzQf3Sy7iLKDZAoXxwo5z/Vm9ctAA2lDc5SR4Sy1iyasxQ+MoyXqj9
	ZgDcoe0S04mIOfjKJho46t/9lj+y13uZA4Ack7b2pH5U
X-Google-Smtp-Source: 
 AMsMyM6whKzLdC5o7eT74Pyedf1TUZtgEwdDXCfrPq/ETQRAxBXjPBabLQI7Ic4hX/6MlbcpUlNWSYVRbqSLVErkcXw=
X-Received: by 2002:a05:6e02:17cb:b0:2f9:1fb4:ba3b with SMTP id
 z11-20020a056e0217cb00b002f91fb4ba3bmr4608536ilu.257.1664560808348; Fri, 30
 Sep 2022 11:00:08 -0700 (PDT)
MIME-Version: 1.0
References: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
In-Reply-To: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 30 Sep 2022 19:59:56 +0200
Message-ID: 
 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
To: Nicholas Jackson <Nicholas.Jackson@zii.aero>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/related; boundary="000000000000b0d62705e9e8c394"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Sep 2022 18:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14002

--000000000000b0d62705e9e8c394
Content-Type: multipart/alternative; boundary="000000000000b0d62605e9e8c393"

--000000000000b0d62605e9e8c393
Content-Type: text/plain; charset="UTF-8"

How can the problem be reproduced?

Alex

On Fri, 30 Sept 2022 at 19:55, Nicholas Jackson <Nicholas.Jackson@zii.aero>
wrote:

> From: Nicholas Jackson <nicholas.jackson@zii.aero>
>
> The netrc module will refuse to use a file that is not owned by the
> current user. Psuedo can trigger this failure due to a reported uid of
> 0. To fix this, change ownership of the default netrc file to 0:0. This
> has no permanent effect on the actual netrc file.
>
> Note that while it is not possible to ask the netrc module what the
> default netrc file is, the documentation explicitly mentions that
> expanduser is used.
>
> Signed-off-by: Nicholas Jackson <nicholas.jackson@zii.aero>
> ---
>  bitbake/lib/bb/fetch2/wget.py | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
> index 821afa5b58..0ce6e25c5c 100644
> --- a/bitbake/lib/bb/fetch2/wget.py
> +++ b/bitbake/lib/bb/fetch2/wget.py
> @@ -360,10 +360,16 @@ class Wget(FetchMethod):
>
>                  try:
>                      import netrc
> +                    # Pseudo can cause ownership mismatch issues with
> netrc, which is
> +                    # required to be owned by the current user (root).
> +                    if os.environ.get("PSEUDO_DISABLED") == "0":
> +                        os.chown(os.path.join(os.path.expanduser("~"),
> ".netrc"), 0, 0)
>                      n = netrc.netrc()
>                      login, unused, password =
> n.authenticators(urllib.parse.urlparse(uri).hostname)
>                      add_basic_auth("%s:%s" % (login, password), r)
> -                except (TypeError, ImportError, IOError,
> netrc.NetrcParseError):
> +                except netrc.NetrcParseError as e:
> +                    logger.debug("netrc failed: %s" % e)
> +                except (TypeError, ImportError, IOError) as e:
>                      pass
>
>                  with opener.open(r, timeout=30) as response:
> --
> 2.37.2
>
>
>
> *Nicholas JACKSON*
> Software Engineer II
>
> Safran Passenger Innovations
>
> T +1 714 854 8600 ext 527
>
> 3151 East Imperial Hwy
>
> Brea, Ca 92821 USA
>
> *www.safran-passenger-innovations.com*
> <http://www.safran-passenger-innovations.com/>
>
>
>
>
> <http://www.safran-group.com/subscription-account?utm_source=subscribemail&utm_medium=mailpro&utm_campaign=subscribemailEN>
> <http://www.safran-group.com/subscription-account?utm_source=subscribemail&utm_medium=mailpro&utm_campaign=subscribemailEN>
>
> <http://twitter.com/SAFRAN>
>
> <http://www.facebook.com/GroupeSafran>
>
> <http://fr.linkedin.com/company/safran>
>
>
> ------------------------------
>
> This email and any files transmitted with it are confidential &
> proprietary to Safran Passenger Innovations. This information is intended
> solely for the use of the individual or entity to which it is addressed.
> Access or transmittal of the information contained in this e-mail, in full
> or in part, to any other organization or persons is not authorized.
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14001):
> https://lists.openembedded.org/g/bitbake-devel/message/14001
> Mute This Topic: https://lists.openembedded.org/mt/94022677/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--000000000000b0d62605e9e8c393
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>How can the problem be reproduced?</div><div><br></di=
v><div>Alex<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, 30 Sept 2022 at 19:55, Nicholas Jackson &lt;<a=
 href=3D"mailto:Nicholas.Jackson@zii.aero">Nicholas.Jackson@zii.aero</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div cl=
ass=3D"msg7483792620520446128">




<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<span style=3D"font-size:12pt;margin:0px;color:black;background-color:white=
">From: Nicholas Jackson &lt;<a href=3D"mailto:nicholas.jackson@zii.aero" t=
arget=3D"_blank">nicholas.jackson@zii.aero</a>&gt;</span><span style=3D"bac=
kground-color:rgb(255,255,255);display:inline"></span>
<div style=3D"font-size:12pt;margin:0px;color:black;background-color:white"=
><br>
</div>
<span style=3D"background-color:rgb(255,255,255);display:inline">The netrc =
module will refuse to use a file that is not owned by the</span>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">current user. P=
suedo can trigger this failure due to a reported uid of</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">0. To fix this,=
 change ownership of the default netrc file to 0:0. This</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">has no permanen=
t effect on the actual netrc file.</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)"><br>
</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">Note that while=
 it is not possible to ask the netrc module what the</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">default netrc f=
ile is, the documentation explicitly mentions that</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">expanduser is u=
sed.</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)"><br>
</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">Signed-off-by: =
Nicholas Jackson &lt;<a href=3D"mailto:nicholas.jackson@zii.aero" target=3D=
"_blank">nicholas.jackson@zii.aero</a>&gt;</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">---</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0bitbake/l=
ib/bb/fetch2/wget.py | 8 +++++++-</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A01 file ch=
anged, 7 insertions(+), 1 deletion(-)</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)"><br>
</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">diff --git a/bi=
tbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">index 821afa5b5=
8..0ce6e25c5c 100644</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">--- a/bitbake/l=
ib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+++ b/bitbake/l=
ib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">@@ -360,10 +360=
,16 @@ class Wget(FetchMethod):</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import netrc<=
/div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Pseudo can cause =
ownership mismatch issues with netrc, which is</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# required to be ow=
ned by the current user (root).</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.environ.get(&=
quot;PSEUDO_DISABLED&quot;) =3D=3D &quot;0&quot;:</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.ch=
own(os.path.join(os.path.expanduser(&quot;~&quot;), &quot;.netrc&quot;), 0,=
 0)</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D netrc.n=
etrc()</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0login, unused=
, password =3D n.authenticators(urllib.parse.urlparse(uri).hostname)</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_basic_aut=
h(&quot;%s:%s&quot; % (login, password), r)</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (TypeError, ImportError, I=
OError, netrc.NetrcParseError):</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except netrc.NetrcParseError as e=
:</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(&quot;=
netrc failed: %s&quot; % e)</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except (TypeError, ImportError, I=
OError) as e:</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with opener.open(r, timeout=
=3D30) as response:</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">--</div>
<div style=3D"margin:0px;background-color:rgb(255,255,255)">2.37.2</div>
<div style=3D"font-size:12pt;margin:0px;color:black;background-color:white"=
><span style=3D"margin:0px"></span></div>
<br>
<br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div id=3D"m_7483792620520446128Signature">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
</div>
<div></div>
<div></div>
<div id=3D"m_7483792620520446128divtagdefaultwrapper" dir=3D"ltr" style=3D"=
font-size:12pt;color:rgb(0,0,0);font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0px;margin-bottom:0px"></p>
<table style=3D"color:rgb(33,33,33);font-family:wf_segoe-ui_normal,&quot;Se=
goe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;f=
ont-size:15px;table-layout:fixed" cellspacing=3D"0" cellpadding=3D"0" borde=
r=3D"0">
<tbody>
<tr style=3D"height:83.45pt">
<td style=3D"width:311px;height:83.45pt;padding:10.5pt 0px;border-style:sol=
id none none;border-top-width:1pt;border-top-color:rgb(0,67,145)">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<b><span style=3D"color:rgb(82,86,104);font-size:9pt;font-family:Arial,sans=
-serif,serif,EmojiFont">Nicholas JACKSON</span></b><span style=3D"color:rgb=
(82,86,104);font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont">=C2=
=A0<br>
Software Engineer II</span></p>
<p style=3D"margin:0px 0px 12pt;font-size:11pt;font-family:Calibri,sans-ser=
if,serif,EmojiFont">
<span style=3D"color:rgb(82,86,104);font-size:9pt;font-family:Arial,sans-se=
rif,serif,EmojiFont"><span style=3D"font-family:Arial,sans-serif;text-align=
:start;background-color:rgb(255,255,255);display:inline">Safran Passenger I=
nnovations</span></span></p>
<p style=3D"margin:0px 0px 12pt;font-size:11pt;font-family:Calibri,sans-ser=
if,serif,EmojiFont">
<span style=3D"color:rgb(82,86,104);font-size:9pt;font-family:Arial,sans-se=
rif,serif,EmojiFont"><span style=3D"color:rgb(128,128,128);font-family:Aria=
l,sans-serif,serif,EmojiFont;font-size:10.6667px"><span style=3D"color:rgb(=
82,86,104);font-family:Arial,sans-serif;font-size:12px;text-align:start;bac=
kground-color:rgb(255,255,255);display:inline">T</span></span><span style=
=3D"color:rgb(82,86,104);font-family:arial,sans-serif;font-size:9pt;backgro=
und-color:rgb(255,255,255)">=C2=A0+1
 714 854 8600 ext 527</span></span></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"color:rgb(82,86,104);font-size:9pt;font-family:Arial,sans-se=
rif,serif,EmojiFont"></span></p>
<p style=3D"margin:0in;font-size:11pt;font-family:Calibri,sans-serif;color:=
rgb(32,31,30);text-align:start;background-color:rgb(255,255,255)">
<span style=3D"margin:0px;font-size:9pt;font-family:Arial,sans-serif;color:=
rgb(82,86,104)">3151 East Imperial Hwy</span></p>
<p></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"color:rgb(82,86,104);font-size:9pt;font-family:Arial,sans-se=
rif,serif,EmojiFont">Brea, Ca 92821 USA</span></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"color:rgb(82,86,104);font-size:9pt;font-family:Arial,sans-se=
rif,serif,EmojiFont"><a href=3D"http://www.safran-passenger-innovations.com=
/" rel=3D"noopener noreferrer" style=3D"margin:0px;font-size:14.6667px;font=
-family:Calibri,sans-serif;text-align:start;background-color:rgb(255,255,25=
5)" target=3D"_blank"><span style=3D"font-family:Arial;font-size:9pt"><b>ww=
w.safran-passenger-innovations.com</b></span></a></span></p>
</td>
<td style=3D"padding:0px;border-style:none;width:2px">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
=C2=A0</p>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"padding:0px 0px 12.75pt;border-style:none none s=
olid;border-bottom-width:1pt;border-bottom-color:rgb(0,67,145)">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"color:rgb(82,86,104);font-size:12pt;font-family:Arial,sans-s=
erif,serif,EmojiFont"><img src=3D"cid:1838f8deba81078ea171"></span><span st=
yle=3D"color:rgb(82,86,104);font-size:12pt;font-family:Arial,sans-serif,ser=
if,EmojiFont" lang=3D"fr"></span></p>
</td>
</tr>
<tr>
<td colspan=3D"2" style=3D"padding:3pt 0px;border-style:none none solid;bor=
der-bottom-width:1pt;border-bottom-color:rgb(0,67,145)">
<table style=3D"width:315px" cellspacing=3D"0" cellpadding=3D"0" border=3D"=
0">
<tbody>
<tr>
<td style=3D"width:180pt;padding:0px">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<a href=3D"http://www.safran-group.com/subscription-account?utm_source=3Dsu=
bscribemail&amp;utm_medium=3Dmailpro&amp;utm_campaign=3DsubscribemailEN" re=
l=3D"noopener noreferrer" target=3D"_blank"><span style=3D"color:rgb(1,68,1=
45);font-size:9pt;font-family:&quot;Times New Roman&quot;,serif,serif,Emoji=
Font;text-decoration-line:none"><img src=3D"cid:1838f8deba9b4d74fd92"></spa=
n></a><a href=3D"http://www.safran-group.com/subscription-account?utm_sourc=
e=3Dsubscribemail&amp;utm_medium=3Dmailpro&amp;utm_campaign=3Dsubscribemail=
EN" rel=3D"noopener noreferrer" target=3D"_blank"><span style=3D"color:rgb(=
78,193,224);font-size:9pt;font-family:&quot;Times New Roman&quot;,serif,ser=
if,EmojiFont;text-decoration-line:none"><img src=3D"cid:1838f8deba9b501410f=
3"></span></a><span style=3D"font-size:1pt;font-family:&quot;Times New Roma=
n&quot;,serif,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont;text-align:right" align=3D"right">
<a href=3D"http://twitter.com/SAFRAN" rel=3D"noopener noreferrer" title=3D"=
&quot;Twitter&quot;" target=3D"_blank"><span style=3D"color:blue;font-size:=
9pt;font-family:&quot;Times New Roman&quot;,serif,serif,EmojiFont;text-deco=
ration-line:none"><img src=3D"cid:1838f8deba964f504804"></span></a><span st=
yle=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;,serif,serif,Em=
ojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont;text-align:right" align=3D"right">
<a href=3D"http://www.facebook.com/GroupeSafran" rel=3D"noopener noreferrer=
" title=3D"&quot;Facebook&quot;" target=3D"_blank"><span style=3D"color:blu=
e;font-size:9pt;font-family:&quot;Times New Roman&quot;,serif,serif,EmojiFo=
nt;text-decoration-line:none"><img src=3D"cid:1838f8deba96698e6055"></span>=
</a><span style=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;,se=
rif,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont;text-align:right" align=3D"right">
<span style=3D"color:blue;font-size:9pt;font-family:&quot;Times New Roman&q=
uot;,serif,serif,EmojiFont;text-decoration-line:none"><a href=3D"http://fr.=
linkedin.com/company/safran" rel=3D"noopener noreferrer" title=3D"&quot;Lin=
kedIn&quot;" target=3D"_blank"><img src=3D"cid:1838f8deba9d184584d6"></a></=
span></p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<p style=3D"margin-top:0px;margin-bottom:0px"></p>
</div>
</div>
</div>
</div>
<br>
<hr>
<font size=3D"1" face=3D"Arial" color=3D"Gray"><br>
This email and any files transmitted with it are confidential &amp; proprie=
tary to Safran Passenger Innovations. This information is intended solely f=
or the use of the individual or entity to which it is addressed. Access or =
transmittal of the information contained
 in this e-mail, in full or in part, to any other organization or persons i=
s not authorized.<br>
</font>
</div>

<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#14001): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/14001" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/14001</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/94022677/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/94022677/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</div></blockquote></div>

--000000000000b0d62605e9e8c393--

--000000000000b0d62705e9e8c394
Content-Type: image/png; name="Outlook-1h4phv2m.png"
Content-Disposition: inline; filename="Outlook-1h4phv2m.png"
Content-Transfer-Encoding: base64
Content-ID: <1838f8deba81078ea171>
X-Attachment-Id: 1838f8deba81078ea171

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
--000000000000b0d62705e9e8c394
Content-Type: image/png; name="Outlook-1pkwad4d.png"
Content-Disposition: inline; filename="Outlook-1pkwad4d.png"
Content-Transfer-Encoding: base64
Content-ID: <1838f8deba9b4d74fd92>
X-Attachment-Id: 1838f8deba9b4d74fd92

iVBORw0KGgoAAAANSUhEUgAAAEMAAAAVCAIAAACSf8TOAAADzElEQVRYCe1XUWiaVxT+OuYWKXGN
sUWSdBVlUQikloCsIaiDH8K6rg8ujLXbkFCqDKSFDCpCG1hokf/FhyIM14VMRjaI4lNo6PhhUaQZ
+lCxLTUpOm3T4kxMbKTENQ8Zf284/GiUsTIIJT8+nHvO+b7vnnvPvRcPbG9v44343nojqhCL2K9k
723l/p7szT0plaucY1pm9Y/fEAD4puIyq59NVWb1+6biAGRWP/txjun04jMApXL17OWwzOo/ezmc
e1IG8GLzJXlK5aoU5bo2+2LzJfM0I2S6TCU0l2YTCM2lSVpm9acXn0lVGCfLFLvrEn97ea3m5DTe
SOZ2bLHZclt6Ozw2Q3Rp3Tt5h6Hu5p7zduPd3HNfcAEAfzMWThQ9NkM4UZz4Psp4GCog5OPJP+uY
6whZlLcbebtRr1WxoV6r4u1GAJbeDt5uVKvapSr8zRhxvg0gnCjydqPzC1PmcYgCjcapk8fGRocA
eCOZX1+hPDbD2OhQpVpb26gBmIkVnJxm4iIH4M79vxgDQ3kjmQfZlWGzXkpbR8hCTILS+vVd/fou
dzBFyaSytlGbiRUmLu7kipXoVPLkw6ITEH74EsCD7AoRtTB0Kvmj5UqpXGVTB5Bd3XR0HwJAnhbw
/xwiFW33oayQJx6xuxyf6MOJ4sDXP1N3UlhqJB8WJ0NJbyTj5DSE6v4sSGdAmkz2rYWC69osgD7d
YXIyo46QOX1Tcd9UXHoA6lDNhuKejI0O9ekO/zR77xwfUxx8t1lqOFEMJ4piyw68z1Af9vf8Mnc/
IC7Mb/4rp3cFRpfWo0vrIyZ1XWuxrpYSMrg7mALw1ZnjB+Xv7ErYzLnzngyb9T9+d6Z1a/F249a8
y8lprk4mGd3ggMZ/5bST07wqZncJ8QRympXK343hRkIAW/OurXnXkc72xvzWHrESzjEdmkv/yzVQ
Ktqyq5uEAqBUtDENnUqee1oBMH5D4BzTJPyp+YPo0jq7qclJBhGSp7VBKrmnFZ1KTslidy2v1a5O
Ju89KgE4qlawBmPNLe3vWwuFSlW8Liy9HYR6UtyYiRVGTGoAn5uPeSMZpUKgs8RkTvR1Afj9j5z2
aCcJA6gjZCH22nCD2n69iGr8SCUg5D02AyWIezJz/eMeZZs3kvHYDKeshmGznrcbA0I+IOR5u5H6
W3xJIpkeZZvv248I5Q6mTmjf85wfBOC+YB4xqb2RzIhJPf6NhTSOdLZbejuEZIE8zKgjZE53MOUO
phZzq3XJNJSquC+YyX9g//8JrcVeMXburr0yndeYx34lr7F4/xP0HznQ1fmW5FX0AAAAAElFTkSu
QmCC
--000000000000b0d62705e9e8c394
Content-Type: image/png; name="Outlook-kybjmhvy.png"
Content-Disposition: inline; filename="Outlook-kybjmhvy.png"
Content-Transfer-Encoding: base64
Content-ID: <1838f8deba9b501410f3>
X-Attachment-Id: 1838f8deba9b501410f3

iVBORw0KGgoAAAANSUhEUgAAAGAAAAAVCAIAAAA2FXwdAAAE9klEQVRYCe1YT2zbVBj/ZpzYru21
NUmWZP1D2QIq60bG2JAi1IIoAvVQISGVS6VVO40Tlx1AaEjAAY4gpMERpHDJCfVQIW1ItIhoMKlL
u5ZuS9eoTZeGNHNaXlLbjXGR/drHU+y2g3N8qL7v+ft9v/f9/N73XnpkZ2cHms/+CjD7v2q+sRVo
CnTIOmgK1BToEAUOed1cQYcIxAJAMqumCggAhkLi5d4ARoyl8wDwbaKTDgCAT08F71R0HH8w5MZ6
7esLxwWWGZ5cHonKozFleHK5XxGunA6puvnx7J85zaQZAYBE4imND3STuWHqq/PrcZn75IVwulj7
/F75UlfrWz1tOObaucjPa1V3ITgtkWF8oHt4cvlx3LjMfXAmxKaLtVQB9SsCAEyUamfahURYVHVT
rVsAoOqmwtsiAsBIVAaAJym3qJsHQNS6dbusJcIimQ0xvvijvGla/YpA4OTVjfXaaEwhLjYIdVzm
VvQ6AJQ0++9idRsAiroJACvVursQkqdHYM+32zXi51C3V+YmSrXvsiq7hAwAuHI6pJlWfnoN4/MO
MQDc3TAS4V2BGuaN3anJ5SVkJMKiJ+THAqIFGgqJF53iM8gYicpv97QRxr2Zg1q3ZspbxMUGoY4K
bAYZmmlhaeacyee1elzmPAshec63CyQJADyOWzWtmxWNkVi7Dc2UtwSW+fLCcVzPnYqu+BjFx2BW
QtNgaKa9yvDjCckgI7uh74XA5d6A4NApPuY+sj8+YSQxAHB9rUq7tH1C9gPAI92cQ0aPwKp1SzOt
nGZGBdazEBr7X+0wb+dnTrXzAHB1fn0snb+++hfOch9t98lcn8zdqmgkbzKrJrMqESWZVT+bLQHA
0zIHAJ4QAPjJq9rBoJhBxru/PySMhAUAplQN7xoySKifkmyBVqp1tW69GrQ37+2yPcMTst+zEJLh
VkVLZlVCd7BLUPZFMdbGXzsXudTVCgBfPaikizXNtDLIOCn5T0r+nGYSRVIFlCog2s0gIy5zibC4
H2QoJE6UajQftkdjyvvPBrp4H2akA3A3nFL//TAAQKhxB5x1PtuLwRYAwHaIZ92F0GlzmpkqoJnK
7nI+2KWBdn/pkPwdkr8/Io399nAJGUH+CQCYruhHffbuW93rR+MD3TRyfKB7LJ3fNP8mMW7IaxHJ
UyAASITFswHhnV/zuIWRzGGe7VeEBoFoasXH3HQE6pD8cZnDdqezshoKodsfPkYJy8EuCbNX0A+5
jY+miwBATqt5R+YMMvAssUtjiD0YFHOauVrd3g8Sa+PjzgYkEGy852wu3I8aXgHA6xHJPUhG+mRO
rVs4bdRpQ3a75Fl3IQTy/4yibio+xl5BGWR8s1CuOh33mMDOOB0a34DG0vnF6nZ472hvYHop2JIq
oIUNfbG6rfgYT8ibUTlzzz4o6WfTtL5f2Xzg9Oljwu4pSQKeD7QoPgbfM/BgMqsCwCsRqUPy48lE
HZTds0u1Lt6HwxoKIQndht1bnZz4aHO71YXylKoNhUTmjc6j+D4yh4yhkPhyWJpDRt/eZ++TuYbV
TpPF2vgegf2ltHUA5GxAUJytSgM/fC7YyjITpRpmpF9he9BpwGQc96BHzn0Hnwn4OMM9+xnnaHMX
QuBuA/cgct11uxOlWlzmLsaUI83/B7nlo0eav8VoNTzspkAeotBDTYFoNTzspkAeotBD/wDHO/NC
zFjfiwAAAABJRU5ErkJggg==
--000000000000b0d62705e9e8c394
Content-Type: image/png; name="Outlook-1z2l04w5.png"
Content-Disposition: inline; filename="Outlook-1z2l04w5.png"
Content-Transfer-Encoding: base64
Content-ID: <1838f8deba964f504804>
X-Attachment-Id: 1838f8deba964f504804

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAACV0lEQVQ4EaWTS2sTURTH/3ceyQxJ
2tgisaS2QUttUQhYbUAxG2lB7aYUN7rQhd9AQRf6CVyI26D4AHdCFykurIsaaqRIF8U0gWigkZYk
0iYxDzOZR0Ym6czcxrqQ3M09997zO+dw/ucSXH6KHhbTA2ugvfLcgfy6DkIO3ABo6ZBVKBpEB1gC
HWBsH4rv+AEQeDuEpAC4MDUCIL6ZQ1WC22m/Aibf0gFcDY/FNnZquzV4BMNJUniBf/5gduHSGMeS
9fTPxdUMgGfRr6Vq06iFEBYnrhiutabP17fyZOH85FD0S1bO/QLLoKHcvRW6d/0szzEswxw/6pmZ
GnGL/Kv3Kbkhg2ep/omOwl49mS3OhQLrkRu3b077fH0Q+dlzo3S1sqpFoolaXYZjv3CzfoYIira4
mpmeODbu9764P1OsSvFkfnL0CM3XGsrL5RRUzeqRycsq1y+Gg8Os2dsBjzAXCtAwgN2KZNxwRuWd
Zerv5Gr5Smxju1hte5jPXfunRA6SQutn8oTAIzx+vRZP5rsY+vj2YxqNQ3nA0EPRNrf2aIC2l9a2
3sW+Q6SmAzD1A6DpkJQPK9+ylWY46BedZmvaMdI75fmH0Xr5N1yHzo/a8g26Tgb9XpdjIjAgmPJ0
8n9O5uYfLRW2S/tzRVVlJ6lLysXTQ3eunRn3ewHIqtZoqslsMRJNvFlOKX9NbicIsf+/2gJD3CLv
G3SfGu4v1+VCqZH5UTRmXuQtwanchknxAHTd6IKqGb8NMCaUYztz3oVZR7v+djQCjoBj/pXNwizD
1N+6+E+jV/4PYgbPhuN5GeEAAAAASUVORK5CYII=
--000000000000b0d62705e9e8c394
Content-Type: image/png; name="Outlook-w1u0235i.png"
Content-Disposition: inline; filename="Outlook-w1u0235i.png"
Content-Transfer-Encoding: base64
Content-ID: <1838f8deba96698e6055>
X-Attachment-Id: 1838f8deba96698e6055

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAABu0lEQVQ4EbWSPUvDUBSG35g2ja2t
pTjUD4qKIgq6CEUF6+AgIjq4OPUnuLoKurg6+At0UhedRJy6FJwEFRSkFgx+YAz9SNKkTRtJEzGJ
NyqId8m9J+c559z3vhRmt/GH1fIrtqGjoRMzfcToZ7CsQKqCoY1IkAHr//zV3H3Ll5VYvH05NRAN
BwAcZu7y+TdXCW++rIyNdO5vLg71RM2ez4Kcv+AQd4zgwWsN1Opr6aQJ33KFoqTmnooIMb+bX6sj
FhrsNjpnLh9nVvdRqiDSijDr4j30l6sQpJJcBfDwWsb9G6p1aHUXDIBG/7w7qtSmJvrmpgfmk70d
ERY6xCCTHE8ISq3Ai/A13+KDoQj+EaSjnZWlyf6PHOub3jrd2ztHPGKPk+b301d5geNFtWYMXFE1
jhc5XjT0M41gK0Dqr+usj46EAwfrC6nRruNsLr1x4mNoQVJtoLUlvR9FKQVZsWWXXorw02gLgKJc
JUjzA0a23ap+Gq3MVxiAB+/q4n38Tz7adGu0ze05+zQk/QDTJLtnN8OJWPb6ybi8xyK9n5mq61A1
i7Jr6Szk0R8w1HZa1QlaJ2/euMXP6r4D45GH2XAQI60AAAAASUVORK5CYII=
--000000000000b0d62705e9e8c394
Content-Type: image/png; name="Outlook-vuq5al0t.png"
Content-Disposition: inline; filename="Outlook-vuq5al0t.png"
Content-Transfer-Encoding: base64
Content-ID: <1838f8deba9d184584d6>
X-Attachment-Id: 1838f8deba9d184584d6

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAACKklEQVQ4EaWTwWsTQRTGv8ns7Cab
KjGoYBW1JWItUqQGKSiIrNB6UpCARfDSv0CqIAjiyWsoCF68Kii2KPRQBMVGVFCxWqgIkRrBEMS2
pkmM2c1OVmY2u+56aWrn9Oa9+X3zZr4ZAmMCGxiRDbACDfNLNVTNdSl6PG/B4oNDPam+7Wg0O5eQ
PG/BtMdODzyfyOSymcxwf+ddSL7JYwn9ymha15QdSX3sVL/Y3+KddCF5Rn8v/7r/LO8CM2++wmyC
khDPW+CtUEZOSNs/i8PmgwM7AbybL0JXxRFMeRFdGmomNCYU65Yo6aovpLQjlaZ6klviopDat+1z
/odxrDeZ0AFMv/py4GD3yJG98ShbLK3eefyxUTV9CcnL+7t+Yei8sR/Ajbtvr84+ujyaNg7vVgh5
+GLxzNFef8PM8dS5a9PlSgNRFvL/p+d8uWZCVZZWGwohtuO4sO04rsRwes9Zo0+cSA7Pf18/HCiE
lFbqJ8cnRy5NLRSW3eKJQ7vQpbkGeecPY8FZ9sHck8n3ALLdidvjhu048SgDo+Cio7X5lWoDiRiA
St0SAJG+0gi4eCBr9B9sZHPANj+/Dt5ngsH/8DGN+hJ/eY21s0wRSXFJcmzS24HPBAPv/jTl3tNP
+WKZKZGZ1wVsjd+cmnu5UGpynvtQFG4Bs/PfLt7KMUoL3ytCQn4Q7/27H860RUFToFJhr82FSe40
uICS8Pt1G1KpwPzxzxQQ1eACufIPfBi14pXIw4kAAAAASUVORK5CYII=
--000000000000b0d62705e9e8c394--

