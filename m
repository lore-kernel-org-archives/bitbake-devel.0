Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0A4C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 11:23:07 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.17068.1700652185683790518
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Nov 2023 03:23:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EFTG5g5b;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-507bd64814fso9342852e87.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700652184; x=1701256984; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVjVvMM3dTkCX428o2bNNa96uDkdI32y+LtaJ6racWs=;
        b=EFTG5g5btsqKrvnD5ps1I0Kov/zSrYCAkLI9DQgIsa5bOJlGktgtsmeaJ/tqZfsj77
         CS8ZfSsmjnXicDGUidt4uUXB/oip16QKV1anXIO+PQwF9tCnglXXNIqLFlnjqCcpJctJ
         Ge3SQeN1jPtC3o4G/tUE10kcpVKZ0CXNTWkVy+kJsERAIlxvwVNUWpiWFYB/zKGw3yzf
         hsyArn1zYqO34qckArh9ugUVUPjZP8QvSAdhljulZz0NcLR+WsKna/9zf7EtQaq0n3/U
         JRiC9WQ988hC+ydSrO7FJntrhM8oLSorV/3wgRt58bRRucmCjY3X6DXCWsHmhx2vvLFd
         HqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700652184; x=1701256984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVjVvMM3dTkCX428o2bNNa96uDkdI32y+LtaJ6racWs=;
        b=kHzwdDbOIxD+Q0ToKYnNZtJA37i16tIFCmrUYWZOEudcUxIQIj2xQqT4m5U44zIcXi
         DUZxlFFNFLEAC8n2wiyF5ACLVoVAunMiSWLeXLsR/2x9+KskLiq408rcDSLsAikNajTO
         6o+IeWZ4cCehRO+B9O2tUPSzAQYPXIG7LV6WqRHIXBq6YW2SV8xvhpRI25k/z+5DRp34
         CoiBk7BfZHc5UZediRfkG/GmPfskqMyKxegaeTuPlXDlK8djxOpWYvaAnv8hEZEqxopO
         QYODiuj7Z+tC9KE7LeqAOj9+XQpZqK178zjz149byjg2WdSFZ4berVYAsS9z04IBQKkz
         yIrQ==
X-Gm-Message-State: AOJu0YwENJ0kHww+ZYokl/WKfYmxrEqEvDoRofsR2FnSGwnyKkmBneO5
	eGWlfFfw7NkxVn/Bmbzf9yEWf+U0kh5zKZQDhHw=
X-Google-Smtp-Source: AGHT+IESMTt7XEBHdH6H4otk4X7gDX45CtTweQ3ZTIXo/kw6CAkBwOwDneM1fTeZlucUVI0gmY2ibnQNBXFE9I11tmw=
X-Received: by 2002:a2e:b538:0:b0:2c5:ab3b:d676 with SMTP id
 z24-20020a2eb538000000b002c5ab3bd676mr1192058ljm.9.1700652183414; Wed, 22 Nov
 2023 03:23:03 -0800 (PST)
MIME-Version: 1.0
References: <3556314.iIbC2pHGDl@n95hx1g2>
In-Reply-To: <3556314.iIbC2pHGDl@n95hx1g2>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 22 Nov 2023 12:22:52 +0100
Message-ID: <CANNYZj83WzD9L6=rw3JRG4TQSjkPjCC+_5gatOzUDr+ZL_4bNw@mail.gmail.com>
Subject: Re: [bitbake-devel] Keeping STAMPS_DIR between CI builds?
To: Christian Eggers <ceggers@arri.de>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/related; boundary="0000000000004786d4060abbf178"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 11:23:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15560

--0000000000004786d4060abbf178
Content-Type: multipart/alternative; boundary="0000000000004786d3060abbf177"

--0000000000004786d3060abbf177
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Your description shows that everything works as intended. If something
needs artefacts in ${B} then do_compile has to run at least once to
populate ${B}. Preserving ${STAMPS_DIR} would clash with that and isn't
going to work. And do_compile isn't sstate-enabled, so there's no shortcut
that way.

I'd suggest that instead of embedding any build id data into the binary
from its recipe, you can do the same step when building the image. There
are hooks for this, e.g. ROOTFS_POSTPROCESS_COMMAND.

Alex

On Wed, 22 Nov 2023 at 11:55, Christian Eggers <ceggers@arri.de> wrote:

> I build OpenEmbedded on a CI machine (GitLab runner). Between the
> individual builds,
> I keep only the DL_DIR and SSTATE_DIR directories. So if nothing has
> changed between
> two builds, I see that mainly setscene tasks are executed.
>
> In one recipe (the "main" application of our embedded product), I have a
> special task
> (between do_build and do_install) which "stamps" the build number of the
> CI system
> (increments on every build) into a special section of the executable. The
> idea is not
> to run the (costly) do_build step on every CI run:
>
> do_stamp() {
> [ -f myexe.orig ] || cp myexe myexe.orig
> # Retrieve original VERSION section size
> ${OBJCOPY} --dump-section VERSION=3Dmyexe.version myexe.orig
> SIZE=3D$(wc -c < myexe.version)
> # Replace VERSION section (ensuring the same section size)
> echo ${MY_VERSION}-${MY_BUILD_ID} > myexe.version
> truncate -s ${SIZE} myexe.version
> ${OBJCOPY} --update-section VERSION=3Dmyexe.version myexe.orig myexe
> }
> do_stamp[dirs] =3D "${B}"
> addtask stamp after do_compile before do_install
>
>
> This works fine on my local machine (here I don't delete anything between
> two
> bitbake runs): After changing MY_BUILD_ID in my local.conf, in the next
> bitbake
> run only the do_stamp (and the following) tasks are rebuild.
>
> But on the CI system, all tasks of my applications recipe are rebuild
> (starting
> from "do_fetch"). This affects only my application's recipe, for all othe=
r
> targets (where no task input has changed), only the setscene tasks are ru=
n.
>
> Summary:
> ---------
> 1. Only build id is incremented (but build tree is kept):
> do_stamp (and following tasks) are run (as desired)
>
> 2. Build id is not changed, but build tree is deleted:
> only setscene tasks are run (as desired)
>
> 3. Build id is incremented AND build tree is deleted
> full applications recipe is run (starting with do_fetch)
>
>
> I already found out, that this is somehow related to deleting the
> STAMPS_DIR
> directory (what I normally do on the CI system). It seems that the stamps
> are not required as long as no input of a recipe has changed. But as soon
> as an input of a single tasks changed, the full recipe is rebuild if no
> stamps are present.
>
> So what is the best practice for the CI build? Should I keep the STAMPS_D=
IR
> between builds (as I do with DL_DIR and SSTATE_DIR), or is there a better
> option
> if I want to avoid rebuilding the whole recipe?
>
> regards,
> Christian
>
>
>
>
> _______________________________________________________=E2=80=8B
> Christian
> Eggers
> Software Engineer
> =E2=80=8B
> ARRI
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Arriweg 17 ,
> 83071
> Stephanskirchen
> www.arri.com
>
> <http://www.arri.com/>
> +49 8036 3009-3118 <+49%208036%203009-3118>
> CEggers@arri.de
>
> =E2=80=8B
> [image: SkyPanel X] <https://www.arri.com/skypanelx>
> Get all the latest information from www.arri.com, Facebook
> <https://www.facebook.com/TeamARRI>, Twitter
> <https://twitter.com/ARRIChannel>, Instagram
> <https://www.instagram.com/arri/>, LinkedIn
> <https://www.linkedin.com/company/arri> and YouTube
> <https://www.youtube.com/user/ARRIChannel> and X
> <https://twitter.com/ARRIChannel>.
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
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Lars Weyer; Steph=
an Schenk; Walter Trauninger
>
> =E2=80=8B
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15559):
> https://lists.openembedded.org/g/bitbake-devel/message/15559
> Mute This Topic: https://lists.openembedded.org/mt/102746583/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000004786d3060abbf177
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Your description shows that everything works as inten=
ded. If something needs artefacts in ${B} then do_compile has to run at lea=
st once to populate ${B}. Preserving ${STAMPS_DIR} would clash with that an=
d isn&#39;t going to work.  And do_compile isn&#39;t sstate-enabled, so the=
re&#39;s no shortcut that way. </div><div><br></div><div>I&#39;d suggest th=
at instead of embedding any build id data into the binary from its recipe, =
you can do the same step when building the image. There are hooks for this,=
 e.g. ROOTFS_POSTPROCESS_COMMAND.</div><div><br></div><div>Alex<br></div></=
div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Wed, 22 Nov 2023 at 11:55, Christian Eggers &lt;<a href=3D"mailto:ceggers@=
arri.de">ceggers@arri.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex"><div><div>I build OpenEmbedded on a CI machine (Git=
Lab runner). Between the individual builds,<br>I keep only the DL_DIR and S=
STATE_DIR directories. So if nothing has changed between<br>two builds, I s=
ee that mainly setscene tasks are executed.<br><br>In one recipe (the &quot=
;main&quot; application of our embedded product), I have a special task<br>=
(between do_build and do_install) which &quot;stamps&quot; the build number=
 of the CI system<br>(increments on every build) into a special section of =
the executable. The idea is not<br>to run the (costly) do_build step on eve=
ry CI run:<br><br>do_stamp() {<br>    [ -f myexe.orig ] || cp myexe myexe.o=
rig<br>    # Retrieve original VERSION section size<br>    ${OBJCOPY} --dum=
p-section VERSION=3Dmyexe.version myexe.orig<br>    SIZE=3D$(wc -c &lt; mye=
xe.version)<br>    # Replace VERSION section (ensuring the same section siz=
e)<br>    echo ${MY_VERSION}-${MY_BUILD_ID} &gt; myexe.version<br>    trunc=
ate -s ${SIZE} myexe.version<br>    ${OBJCOPY} --update-section VERSION=3Dm=
yexe.version myexe.orig myexe<br>}<br>do_stamp[dirs] =3D &quot;${B}&quot;<b=
r>addtask stamp after do_compile before do_install<br><br><br>This works fi=
ne on my local machine (here I don&#39;t delete anything between two<br>bit=
bake runs): After changing MY_BUILD_ID in my local.conf, in the next bitbak=
e<br>run only the do_stamp (and the following) tasks are rebuild.<br><br>Bu=
t on the CI system, all tasks of my applications recipe are rebuild (starti=
ng<br>from &quot;do_fetch&quot;). This affects only my application&#39;s re=
cipe, for all other<br>targets (where no task input has changed), only the =
setscene tasks are run.<br><br>Summary:<br>---------<br>1. Only build id is=
 incremented (but build tree is kept):<br>do_stamp (and following tasks) ar=
e run (as desired)<br><br>2. Build id is not changed, but build tree is del=
eted:<br>only setscene tasks are run (as desired)<br><br>3. Build id is inc=
remented AND build tree is deleted<br>full applications recipe is run (star=
ting with do_fetch)<br><br><br>I already found out, that this is somehow re=
lated to deleting the STAMPS_DIR<br>directory (what I normally do on the CI=
 system). It seems that the stamps<br>are not required as long as no input =
of a recipe has changed. But as soon<br>as an input of a single tasks chang=
ed, the full recipe is rebuild if no<br>stamps are present.<br><br>So what =
is the best practice for the CI build? Should I keep the STAMPS_DIR<br>betw=
een builds (as I do with DL_DIR and SSTATE_DIR), or is there a better optio=
n<br>if I want to avoid rebuilding the whole recipe?<br><br>regards,<br>Chr=
istian<br><br><br><br><br></div><div dir=3D"ltr" style=3D"font-size:1px;dir=
ection:ltr"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"width:100%;font-size:1px"><tbody><tr style=3D"font-size:0px"><td align=
=3D"left" style=3D"vertical-align:top"><table cellpadding=3D"0" cellspacing=
=3D"0" border=3D"0" style=3D"font-size:0px"><tbody><tr style=3D"font-size:0=
px"><td align=3D"left" style=3D"padding:0px;vertical-align:top"><table cell=
padding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;font-size:=
0px"><tbody><tr style=3D"font-size:14.67px;color:rgb(127,127,127);font-styl=
e:normal;font-weight:400;white-space:nowrap"><td align=3D"left" style=3D"ve=
rtical-align:top;font-family:Calibri,Arial,sans-serif">____________________=
___________________________________<span style=3D"font-family:remialcxesans=
;font-size:1px;color:rgb(255,255,255);line-height:1px">=E2=80=8B</span></td=
></tr><tr style=3D"font-size:0px"><td align=3D"left" style=3D"vertical-alig=
n:top"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"fon=
t-size:0px"><tbody><tr style=3D"font-size:0px"><td align=3D"left" style=3D"=
vertical-align:top"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"=
 style=3D"font-size:0px;color:rgb(127,127,127);font-style:normal;font-weigh=
t:400;white-space:nowrap"><tbody><tr style=3D"font-size:14.67px"><td align=
=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif"=
>Christian</td><td align=3D"left" style=3D"vertical-align:top;color:rgb(0,0=
,1);font-family:Calibri,Arial,sans-serif">=C2=A0<br></td><td align=3D"left"=
 style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif">Eggers</=
td></tr></tbody></table></td></tr><tr style=3D"font-size:0px"><td align=3D"=
left" style=3D"vertical-align:top"><table cellpadding=3D"0" cellspacing=3D"=
0" border=3D"0" style=3D"font-size:0px;color:rgb(127,127,127);font-style:no=
rmal;font-weight:400;white-space:nowrap"><tbody><tr style=3D"font-size:14.6=
7px"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Ari=
al,sans-serif">Software=C2=A0Engineer</td></tr><tr style=3D"font-size:14.67=
px;color:rgb(0,0,1)"><td align=3D"left" style=3D"vertical-align:top;font-fa=
mily:Calibri,Arial,sans-serif">=E2=80=8B</td></tr></tbody></table></td></tr=
></tbody></table></td></tr><tr style=3D"font-size:0px"><td align=3D"left" s=
tyle=3D"vertical-align:top"><table cellpadding=3D"0" cellspacing=3D"0" bord=
er=3D"0" style=3D"font-size:0px"><tbody><tr style=3D"font-size:0px"><td ali=
gn=3D"left" style=3D"vertical-align:top"><table cellpadding=3D"0" cellspaci=
ng=3D"0" border=3D"0" style=3D"font-size:0px;color:rgb(14,80,173);font-styl=
e:normal;font-weight:400;white-space:nowrap"><tbody><tr style=3D"font-size:=
13.33px"><td align=3D"left" style=3D"vertical-align:top;font-family:&quot;A=
rial Black&quot;">ARRI</td></tr><tr style=3D"font-size:10.67px;color:rgb(12=
7,127,127)"><td align=3D"left" style=3D"vertical-align:top;font-family:Aria=
l"><span style=3D"font-size:11px">Arnold=C2=A0&amp;=C2=A0Richter=C2=A0Cine=
=C2=A0Technik=C2=A0GmbH=C2=A0&amp;=C2=A0Co.=C2=A0Betriebs=C2=A0KG</span>=C2=
=A0<br></td></tr></tbody></table></td></tr><tr style=3D"font-size:0px"><td =
align=3D"left" style=3D"vertical-align:top"><table cellpadding=3D"0" cellsp=
acing=3D"0" border=3D"0" style=3D"font-size:0px;color:rgb(127,127,127);font=
-style:normal;font-weight:400;white-space:nowrap"><tbody><tr style=3D"font-=
size:10.67px"><td align=3D"left" style=3D"vertical-align:top;font-family:Ar=
ial">Arriweg=C2=A017</td><td align=3D"left" style=3D"vertical-align:top;fon=
t-family:Arial">,=C2=A0<br></td><td align=3D"left" style=3D"vertical-align:=
middle;font-family:Arial">83071</td><td align=3D"left" style=3D"vertical-al=
ign:middle;font-family:Arial">=C2=A0<br></td><td align=3D"left" style=3D"ve=
rtical-align:middle;font-family:Arial">Stephanskirchen</td></tr></tbody></t=
able></td></tr></tbody></table></td></tr><tr style=3D"font-size:0px"><td al=
ign=3D"left" style=3D"vertical-align:top"><table cellpadding=3D"0" cellspac=
ing=3D"0" border=3D"0" style=3D"font-size:0px"><tbody><tr style=3D"font-siz=
e:0px"><td align=3D"left" style=3D"vertical-align:top"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0px;color:rgb(21,5=
0,185);font-style:normal;font-weight:400;white-space:nowrap"><tbody><tr sty=
le=3D"font-size:11px"><td align=3D"left" style=3D"vertical-align:top;font-f=
amily:Arial"><span style=3D"text-decoration:underline"><a href=3D"http://ww=
w.arri.com/" id=3D"m_3284454236883066576LPlnk689713" style=3D"text-decorati=
on:underline;color:rgb(21,50,185)" target=3D"_blank">www.arri.com=C2=A0<br>=
<br></a></span></td></tr><tr style=3D"font-size:0px"><td align=3D"left" sty=
le=3D"vertical-align:top"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0px;color:rgb(133,128,128);font-style:normal;font=
-weight:400;line-height:normal;white-space:nowrap"><tbody><tr style=3D"font=
-size:14.67px"><td align=3D"left" style=3D"padding:0px;vertical-align:top;f=
ont-size:0px"><img src=3D"cid:ii_18bf6bd10461093cbe21" width=3D"20" border=
=3D"0" alt=3D"" style=3D"width: 20px; min-width: 20px; max-width: 20px; fon=
t-size: 0px;"></td><td align=3D"left" style=3D"padding:0px;vertical-align:t=
op;font-family:Calibri,Arial,sans-serif"><a href=3D"tel:+49%208036%203009-3=
118" id=3D"m_3284454236883066576LPlnk689713" style=3D"text-decoration:none;=
color:rgb(133,128,128)" target=3D"_blank">+49=C2=A08036=C2=A03009-3118</a><=
/td></tr><tr style=3D"font-size:0px"><td align=3D"left" style=3D"padding:0p=
x;vertical-align:top"></td><td align=3D"left" style=3D"padding:0px;vertical=
-align:top"></td></tr><tr style=3D"font-size:0px"><td align=3D"left" style=
=3D"padding:0px;vertical-align:top"></td><td align=3D"left" style=3D"paddin=
g:0px;vertical-align:top"></td></tr><tr style=3D"font-size:14.67px"><td ali=
gn=3D"left" style=3D"padding:0px;vertical-align:top;font-size:0px"><img src=
=3D"cid:ii_18bf6bd1047c95e06be2" width=3D"20" border=3D"0" alt=3D"" style=
=3D"width: 20px; min-width: 20px; max-width: 20px; font-size: 0px;"></td><t=
d align=3D"left" style=3D"padding:0px;vertical-align:top;font-family:Calibr=
i,Arial,sans-serif"><a href=3D"mailto:CEggers@arri.de" id=3D"m_328445423688=
3066576LPlnk689713" style=3D"text-decoration:none;color:rgb(133,128,128)" t=
arget=3D"_blank">CEggers@arri.de</a></td></tr></tbody></table></td></tr></t=
body></table></td></tr></tbody></table></td></tr><tr style=3D"font-size:14.=
67px;color:rgb(0,0,1);font-style:normal;font-weight:400;white-space:nowrap"=
><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,s=
ans-serif"><br>=E2=80=8B</td></tr></tbody></table></td></tr><tr style=3D"fo=
nt-size:0px;line-height:normal"><td align=3D"left" style=3D"padding:0px;ver=
tical-align:top"><a href=3D"https://www.arri.com/skypanelx" id=3D"m_3284454=
236883066576LPlnk689713" style=3D"text-decoration:none" target=3D"_blank"><=
img src=3D"https://assets.arri.com/media/sign/20230908a_Stardust_E-mail-Sig=
nature_800x170@2x.jpg" width=3D"660" border=3D"0" title=3D"SkyPanel X" alt=
=3D"SkyPanel X" style=3D"width: 660px; min-width: 660px; max-width: 660px; =
font-size: 12px;"></a></td></tr><tr style=3D"font-size:13px;color:rgb(127,1=
27,127);font-style:normal;font-weight:400;white-space:nowrap"><td align=3D"=
left" style=3D"padding:0px;vertical-align:top;font-family:Calibri,Arial,san=
s-serif">Get=C2=A0all=C2=A0the=C2=A0latest=C2=A0information=C2=A0from=C2=A0=
<span style=3D"text-decoration:underline"><a href=3D"https://www.arri.com/"=
 id=3D"m_3284454236883066576LPlnk689713" style=3D"text-decoration:underline=
;color:rgb(127,127,127)" target=3D"_blank">www.arri.com</a></span>,=C2=A0<s=
pan style=3D"text-decoration:underline"><a href=3D"https://www.facebook.com=
/TeamARRI" id=3D"m_3284454236883066576LPlnk689713" style=3D"text-decoration=
:underline;color:rgb(127,127,127)" target=3D"_blank">Facebook</a></span>,=
=C2=A0<span style=3D"text-decoration:underline"><a href=3D"https://twitter.=
com/ARRIChannel" id=3D"m_3284454236883066576LPlnk689713" style=3D"text-deco=
ration:underline;color:rgb(127,127,127)" target=3D"_blank">Twitter</a></spa=
n>,=C2=A0<a href=3D"https://www.instagram.com/arri/" id=3D"m_32844542368830=
66576LPlnk689713" style=3D"text-decoration:none;color:rgb(127,127,127)" tar=
get=3D"_blank"><span style=3D"text-decoration:underline">Instagram</span></=
a>,=C2=A0<a href=3D"https://www.linkedin.com/company/arri" id=3D"m_32844542=
36883066576LPlnk689713" style=3D"text-decoration:none;color:rgb(127,127,127=
)" target=3D"_blank"><span style=3D"text-decoration:underline">LinkedIn</sp=
an></a>=C2=A0and=C2=A0<a href=3D"https://www.youtube.com/user/ARRIChannel" =
id=3D"m_3284454236883066576LPlnk689713" style=3D"text-decoration:none;color=
:rgb(127,127,127)" target=3D"_blank"><span style=3D"text-decoration:underli=
ne">YouTube</span></a>=C2=A0and=C2=A0<a href=3D"https://twitter.com/ARRICha=
nnel" id=3D"m_3284454236883066576LPlnk689713" style=3D"text-decoration:none=
;color:rgb(127,127,127)" target=3D"_blank"><span style=3D"text-decoration:u=
nderline">X</span></a>.<br></td></tr><tr style=3D"font-size:0px"><td align=
=3D"left" style=3D"padding:0px;vertical-align:top"><table cellpadding=3D"0"=
 cellspacing=3D"0" border=3D"0" style=3D"font-size:0px;color:rgb(106,106,10=
6);font-style:normal;font-weight:400;white-space:nowrap"><tbody><tr style=
=3D"font-size:10px"><td align=3D"left" style=3D"vertical-align:top;font-fam=
ily:Arial"><br>Arnold=C2=A0&amp;=C2=A0Richter=C2=A0Cine=C2=A0Technik=C2=A0G=
mbH=C2=A0&amp;=C2=A0Co.=C2=A0Betriebs=C2=A0KG<br>Sitz:=C2=A0M=C3=BCnchen=C2=
=A0=E2=80=91=C2=A0Registergericht:=C2=A0Amtsgericht=C2=A0M=C3=BCnchen=C2=A0=
=E2=80=91=C2=A0Handelsregisternummer:=C2=A0HRA=C2=A057918<br>Pers=C3=B6nlic=
h=C2=A0haftender=C2=A0Gesellschafter:=C2=A0Arnold=C2=A0&amp;=C2=A0Richter=
=C2=A0Cine=C2=A0Technik=C2=A0GmbH<br>Sitz:=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=
=C2=A0Registergericht:=C2=A0Amtsgericht=C2=A0M=C3=BCnchen=C2=A0=E2=80=91=C2=
=A0Handelsregisternummer:=C2=A0HRB=C2=A054477<br>Gesch=C3=A4ftsf=C3=BChrer:=
=C2=A0Dr.=C2=A0Matthias=C2=A0Erb=C2=A0(Chairman);=C2=A0Lars=C2=A0Weyer;=C2=
=A0Stephan=C2=A0Schenk;=C2=A0Walter=C2=A0Trauninger<br></td></tr><tr style=
=3D"font-size:14.67px;color:rgb(0,0,1)"><td align=3D"left" style=3D"vertica=
l-align:top;font-family:Calibri,Arial,sans-serif"><br>=E2=80=8B<br></td></t=
r></tbody></table></td></tr></tbody></table></td></tr></tbody></table></div=
></div>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15559): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15559" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15559</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/102746583/168=
6489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/102746583/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000004786d3060abbf177--

--0000000000004786d4060abbf178
Content-Type: image/png; name="image085416.png"
Content-Disposition: inline; filename="image085416.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_18bf6bd10461093cbe21>
X-Attachment-Id: ii_18bf6bd10461093cbe21

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
--0000000000004786d4060abbf178
Content-Type: image/png; name="image350721.png"
Content-Disposition: inline; filename="image350721.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_18bf6bd1047c95e06be2>
X-Attachment-Id: ii_18bf6bd1047c95e06be2

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
--0000000000004786d4060abbf178--

