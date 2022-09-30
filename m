Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C16DC433FE
	for <webhook@archiver.kernel.org>; Fri, 30 Sep 2022 19:51:56 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
 [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web09.1653.1664567510240732877
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Sep 2022 12:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=f0mP78WA;
 spf=pass (domain: gmail.com, ip: 209.85.166.48,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id d8so4079376iof.11
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Sep 2022 12:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hYMAC47wPkrwW231O7VnhZXFGUJ4HCckYZkal+R38/0=;
        b=f0mP78WABZCfHMaJaza7pUdCaUk+FNOuzjj58GJhDqDvdj0VZdBEDzX47I4F7rODu0
         x3fMrSdAKEP6dFnpJganinnzCDFqCOENMG6qgUSfsnsedfYLpidcv9aMuGoAo6+9pruO
         JcuBtFaIJQkh5880DxL1tRiBtu3ilw4mpm8+ZtR7FtVCe2TCYCfOOnkY/7RX0Uy3mC5c
         FHWzUH9KR0dON+E8IuK8gWg46bHIwKj3CO/JlTd26uQm+UCPYJuysUYXyJDZv/wgTX++
         rAuxf0di7GKKIS0usV6m+E1xr71s1hm/wLl0nQ6Z5hoSSnh58nIeJZLg9r4myAIWGASs
         MfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hYMAC47wPkrwW231O7VnhZXFGUJ4HCckYZkal+R38/0=;
        b=mPaPjTYqIeeXfjU8sgFu/1rAi7LcHn7AnfE7b1ul8WHoyQpsZWlTcoOXlA5FaIxLDK
         lVshqAFB1Fclwah9Cb5rDu/eHdtnWpoGyQimL9mi1YpmJSd7jvzQkHjUyMKUmmp0hX/O
         kWolTRcv6nSUisj9RAqdd7zfd0opLAiSWiBWhLXFxY5T996l6f5k3COAWah3+S6N8DCY
         5Hb+wwfVMiaj8sjgUbIu7/IxayqrsisyWNQk472BEypNEQEhqOoTGimnKKjNIUXB1hgC
         5o5c6BLvuAC+6+rQzUiL0975fHe0H3ieeFmcPIz2tpeMsI1C5WAMAvmntxlGzLcOwKoz
         pppg==
X-Gm-Message-State: ACrzQf2zD5ItqL1ZYipHYOFrmYYvx9pFR+KvGY5lLhzWE6en1MVxCCaH
	GulTDYSniZQYLcVNWRoFfgzRX6ERtWDS4AKTi3Q=
X-Google-Smtp-Source: 
 AMsMyM5xfGlKXh3RtkTnC9JOLVvajrPW6aoMUuKYcG894NJGaIraVod3oyC48/EjgT0ynBJYqlF5MyAE1PMTq85BNb4=
X-Received: by 2002:a05:6638:14d6:b0:35a:6425:a027 with SMTP id
 l22-20020a05663814d600b0035a6425a027mr5659224jak.254.1664567508886; Fri, 30
 Sep 2022 12:51:48 -0700 (PDT)
MIME-Version: 1.0
References: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
In-Reply-To: 
 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 30 Sep 2022 21:51:37 +0200
Message-ID: 
 <CANNYZj9ETtBH1mY3x3G2Fe4Fjyni7zkRMcA9UsYtpBcTznUQDg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
To: Nicholas Jackson <Nicholas.Jackson@zii.aero>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/related; boundary="000000000000129b5105e9ea5321"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Sep 2022 19:51:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14004

--000000000000129b5105e9ea5321
Content-Type: multipart/alternative; boundary="000000000000129b5005e9ea5320"

--000000000000129b5005e9ea5320
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This does seem like there=E2=80=99s something particular about your setup
triggering this. Can you try outside if docker?

Alex

On Fri 30. Sep 2022 at 21.24, Nicholas Jackson <Nicholas.Jackson@zii.aero>
wrote:

> Thanks for the quick response.
> My setup is an Artifactory replication of https://sstate.yoctoproject.org=
/,
> with
> the Artifactory credentials stored in a netrc file. The issue specificall=
y
> occurs
> when attempting to build certain packages using bitbake --setscene-only=
=E2=80=8B.
> (It probably also happens without --setscene-only).
> A warning is produced, e.g.:
> WARNING: efibootmgr-18-r0 do_package_setscene: No sstate archive
> obtainable, will run full task instead.
> WARNING: Logfile for failed setscene task is
> /home/foo/bar/build/tmp/work/core2-64-poky-linux/efibootmgr/18-r0/temp/lo=
g.do_package_setscene.472771
> WARNING: Setscene task (/home/foo/bar
> /poky/meta/recipes-bsp/efibootmgr/efibootmgr_18.bb:do_package_setscene)
> failed with exit code '1' - real task will be run instead
>
> In certain cases, bitbake will spawn a bitbake-worker with
> PSEUDO_DISABLED=3D0.
> Unfortunately, I have not been able to pinpoint when exactly this happens=
.
> I'm not
> familiar with bitbake internals, so I don't know when pseudo is used
> specifically.
> What I can say for sure is that bitbake --setscene-only world=E2=80=8B wi=
ll always
> reproduce the issue for me without this patch.
>
> For my environment, I am building the default core-image-minimal for
> qemux86-64 with
> the three default poky layers. I've reproduced the issue in both Ubuntu
> 22.04 and
> Docker using the image ghcr.io/siemens/kas/kas:3.1. In case it matters, I
> am using kas.
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
> <http://www.safran-group.com/subscription-account?utm_source=3Dsubscribem=
ail&utm_medium=3Dmailpro&utm_campaign=3DsubscribemailEN>
> <http://www.safran-group.com/subscription-account?utm_source=3Dsubscribem=
ail&utm_medium=3Dmailpro&utm_campaign=3DsubscribemailEN>
>
> <http://twitter.com/SAFRAN>
>
> <http://www.facebook.com/GroupeSafran>
>
> <http://fr.linkedin.com/company/safran>
>
> ------------------------------
> *From:* bitbake-devel@lists.openembedded.org <
> bitbake-devel@lists.openembedded.org> on behalf of Alexander Kanavin <
> alex.kanavin@gmail.com>
> *Sent:* Friday, September 30, 2022 10:59 AM
> *To:* Nicholas Jackson <Nicholas.Jackson@zii.aero>
> *Cc:* bitbake-devel@lists.openembedded.org <
> bitbake-devel@lists.openembedded.org>
> *Subject:* Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with
> pseudo
>
> How can the problem be reproduced?
>
> Alex
>
> On Fri, 30 Sept 2022 at 19:55, Nicholas Jackson <Nicholas.Jackson@zii.aer=
o>
> wrote:
>
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
> diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.p=
y
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
> +                    if os.environ.get("PSEUDO_DISABLED") =3D=3D "0":
> +                        os.chown(os.path.join(os.path.expanduser("~"),
> ".netrc"), 0, 0)
>                      n =3D netrc.netrc()
>                      login, unused, password =3D
> n.authenticators(urllib.parse.urlparse(uri).hostname)
>                      add_basic_auth("%s:%s" % (login, password), r)
> -                except (TypeError, ImportError, IOError,
> netrc.NetrcParseError):
> +                except netrc.NetrcParseError as e:
> +                    logger.debug("netrc failed: %s" % e)
> +                except (TypeError, ImportError, IOError) as e:
>                      pass
>
>                  with opener.open(r, timeout=3D30) as response:
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
> <https://urldefense.com/v3/__http://www.safran-passenger-innovations.com/=
__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wR=
p_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyCHL6szf$>
>
>
>
>
> <https://urldefense.com/v3/__http://www.safran-group.com/subscription-acc=
ount?utm_source=3Dsubscribemail&utm_medium=3Dmailpro&utm_campaign=3Dsubscri=
bemailEN__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0I=
rd5wj8wRp_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyBduGohQ$>
> <https://urldefense.com/v3/__http://www.safran-group.com/subscription-acc=
ount?utm_source=3Dsubscribemail&utm_medium=3Dmailpro&utm_campaign=3Dsubscri=
bemailEN__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0I=
rd5wj8wRp_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyBduGohQ$>
>
>
> <https://urldefense.com/v3/__http://twitter.com/SAFRAN__;!!BXNzmnhnlE-olP=
yVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wRp_VGu9fGuLkpGGLDedR=
zDSMUZ1LJCoQAS8jyNnzvPqy$>
>
>
> <https://urldefense.com/v3/__http://www.facebook.com/GroupeSafran__;!!BXN=
zmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wRp_VGu9fG=
uLkpGGLDedRzDSMUZ1LJCoQAS8jyHmr7D_P$>
>
>
> <https://urldefense.com/v3/__http://fr.linkedin.com/company/safran__;!!BX=
NzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wRp_VGu9f=
GuLkpGGLDedRzDSMUZ1LJCoQAS8jyGC1R16c$>
>
>
> ------------------------------
>
> This email and any files transmitted with it are confidential &
> proprietary to Safran Passenger Innovations. This information is intended
> solely for the use of the individual or entity to which it is addressed.
> Access or transmittal of the information contained in this e-mail, in ful=
l
> or in part, to any other organization or persons is not authorized.
>
>
>
>
> ------------------------------
>
> This email and any files transmitted with it are confidential &
> proprietary to Safran Passenger Innovations. This information is intended
> solely for the use of the individual or entity to which it is addressed.
> Access or transmittal of the information contained in this e-mail, in ful=
l
> or in part, to any other organization or persons is not authorized.
>

--000000000000129b5005e9ea5320
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This does seem like there=E2=80=99s something particular =
about your setup triggering this. Can you try outside if docker?</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Alex</div><div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri 30. Sep 2022 at 21=
.24, Nicholas Jackson &lt;<a href=3D"mailto:Nicholas.Jackson@zii.aero">Nich=
olas.Jackson@zii.aero</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">




<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Thanks for the quick response.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
My setup is an Artifactory replication of=C2=A0<a href=3D"https://sstate.yo=
ctoproject.org/" target=3D"_blank" style=3D"font-family:Calibri,Arial,Helve=
tica,sans-serif">https://sstate.yoctoproject.org/</a>, with</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
the Artifactory credentials stored in a netrc file. The issue specifically =
occurs</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
when attempting to build certain packages using <code style=3D"font-family:=
monospace">bitbake --setscene-only</code>=E2=80=8B.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
(It probably also happens without --setscene-only).</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
A warning is produced, e.g.:</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<span style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12p=
t;color:rgb(0,0,0)">WARNING: efibootmgr-18-r0 do_package_setscene: No sstat=
e archive obtainable, will run full task instead.</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif">WARNING: Logf=
ile for failed setscene task is /home/foo/bar/build/tmp/work/core2-64-poky-=
linux/efibootmgr/18-r0/temp/log.do_package_setscene.472771</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif">WARNING: Sets=
cene task (<span style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;di=
splay:inline!important;background-color:rgb(255,255,255)">/home/foo/bar</sp=
an>/poky/meta/recipes-bsp/efibootmgr/efibootmgr_18.bb:do_package_setscene) =
failed with exit code &#39;1&#39; - real task will be run instead</div>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
In certain cases, bitbake will spawn a bitbake-worker with=C2=A0<span style=
=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt;color:rgb=
(0,0,0)">PSEUDO_DISABLED=3D0.</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Unfortunately, I have not been able to pinpoint when exactly this happens. =
I&#39;m not</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
familiar with bitbake internals, so I don&#39;t know when pseudo is used sp=
ecifically.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
What I can say for sure is that <code style=3D"font-family:monospace">bitba=
ke --setscene-only world</code>=E2=80=8B will always</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
reproduce the issue for me without this patch.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
For my environment, I am building the default core-image-minimal for qemux8=
6-64 with</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
the three default poky layers.=C2=A0<span style=3D"font-family:Calibri,Aria=
l,Helvetica,sans-serif;font-size:12pt;color:rgb(0,0,0)">I&#39;ve reproduced=
 the issue in both Ubuntu 22.04 and</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
Docker using the image=C2=A0<a href=3D"http://ghcr.io/siemens/kas/kas:3.1" =
target=3D"_blank" style=3D"font-family:Calibri,Arial,Helvetica,sans-serif">=
ghcr.io/siemens/kas/kas:3.1</a>. In case it matters, I am using kas.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div id=3D"m_-8722381858772988065Signature">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
</div>
<div></div>
<div></div>
<div id=3D"m_-8722381858772988065divtagdefaultwrapper" dir=3D"ltr" style=3D=
"font-size:12pt;font-family:Calibri,Helvetica,sans-serif;color:rgb(0,0,0)">
<p style=3D"margin-top:0px;margin-bottom:0px;font-family:Calibri,Helvetica,=
sans-serif"></p>
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"font-famil=
y:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial=
,sans-serif,serif,EmojiFont;font-size:15px;table-layout:fixed;color:rgb(33,=
33,33)">
<tbody style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;S=
egoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<tr style=3D"height:83.45pt;font-family:wf_segoe-ui_normal,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td style=3D"width:311px;height:83.45pt;padding:10.5pt 0px;border-style:sol=
id none none;border-top-width:1pt;font-family:wf_segoe-ui_normal,&quot;Sego=
e UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;bor=
der-top-color:rgb(0,67,145)">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<b style=3D"font-family:Calibri,sans-serif,serif,EmojiFont"><span style=3D"=
font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;color:rgb(82,86,=
104)">Nicholas JACKSON</span></b><span style=3D"font-size:9pt;font-family:A=
rial,sans-serif,serif,EmojiFont;color:rgb(82,86,104)">=C2=A0<br>
Software Engineer II</span></p>
<p style=3D"margin:0px 0px 12pt;font-size:11pt;font-family:Calibri,sans-ser=
if,serif,EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"><span style=3D"font-family:Arial,sans-serif;text-align=
:start;display:inline!important;background-color:rgb(255,255,255)">Safran P=
assenger Innovations</span></span></p>
<p style=3D"margin:0px 0px 12pt;font-size:11pt;font-family:Calibri,sans-ser=
if,serif,EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"><span style=3D"font-family:Arial,sans-serif,serif,Emoj=
iFont;font-size:10.6667px;color:rgb(128,128,128)"><span style=3D"font-famil=
y:Arial,sans-serif;font-size:12px;text-align:start;display:inline!important=
;background-color:rgb(255,255,255);color:rgb(82,86,104)">T</span></span><sp=
an style=3D"font-family:arial,sans-serif;font-size:9pt;background-color:rgb=
(255,255,255);color:rgb(82,86,104)">=C2=A0+1
 714 854 8600 ext 527</span></span></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"></span></p>
<p style=3D"margin:0in;font-size:11pt;font-family:Calibri,sans-serif;text-a=
lign:start;background-color:rgb(255,255,255);color:rgb(32,31,30)">
<span style=3D"margin:0px;font-size:9pt;font-family:Arial,sans-serif;color:=
rgb(82,86,104)">3151 East Imperial Hwy</span></p>
<p style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe=
 WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont"></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)">Brea, Ca 92821 USA</span></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"><a href=3D"http://www.safran-passenger-innovations.com=
/" rel=3D"noopener noreferrer" style=3D"margin:0px;font-size:14.6667px;font=
-family:Calibri,sans-serif;text-align:start;background-color:rgb(255,255,25=
5)" target=3D"_blank"><span style=3D"font-family:Arial;font-size:9pt"><b st=
yle=3D"font-family:Arial">www.safran-passenger-innovations.com</b></span></=
a></span></p>
</td>
<td style=3D"padding:0px;border-style:none;width:2px;font-family:wf_segoe-u=
i_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,=
serif,EmojiFont">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
=C2=A0</p>
</td>
</tr>
<tr style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td colspan=3D"2" style=3D"padding:0px 0px 12.75pt;border-style:none none s=
olid;border-bottom-width:1pt;font-family:wf_segoe-ui_normal,&quot;Segoe UI&=
quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;border-b=
ottom-color:rgb(0,67,145)">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:12pt;font-family:Arial,sans-serif,serif,EmojiFont;=
color:rgb(82,86,104)"><img src=3D"cid:1838fef3a6420d4b2947" style=3D"width:=
 147px; max-width: 100%; background-color: rgba(0, 0, 0, 0) !important; bor=
der-color: rgb(161, 165, 185) !important; color: rgb(188, 192, 212) !import=
ant;"></span><span lang=3D"fr" style=3D"font-size:12pt;font-family:Arial,sa=
ns-serif,serif,EmojiFont;color:rgb(82,86,104)"></span></p>
</td>
</tr>
<tr style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td colspan=3D"2" style=3D"padding:3pt 0px;border-style:none none solid;bor=
der-bottom-width:1pt;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&q=
uot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;border-bottom-co=
lor:rgb(0,67,145)">
<table border=3D"0" cellspacing=3D"0" cellpadding=3D"0" style=3D"width:315p=
x;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,=
Tahoma,Arial,sans-serif,serif,EmojiFont">
<tbody style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;S=
egoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<tr style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td style=3D"width:180pt;padding:0px;font-family:wf_segoe-ui_normal,&quot;S=
egoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont"=
>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<a href=3D"http://www.safran-group.com/subscription-account?utm_source=3Dsu=
bscribemail&amp;utm_medium=3Dmailpro&amp;utm_campaign=3DsubscribemailEN" re=
l=3D"noopener noreferrer" target=3D"_blank" style=3D"font-family:Calibri,sa=
ns-serif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&quot;Ti=
mes New Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:rgb(1,=
68,145)"><img src=3D"cid:1838fef3a64a87b16978" style=3D"width: 67px; max-wi=
dth: 100%; background-color: rgba(0, 0, 0, 0) !important; border-color: rgb=
(162, 183, 245) !important; color: rgb(188, 207, 248) !important;"></span><=
/a><a href=3D"http://www.safran-group.com/subscription-account?utm_source=
=3Dsubscribemail&amp;utm_medium=3Dmailpro&amp;utm_campaign=3DsubscribemailE=
N" rel=3D"noopener noreferrer" target=3D"_blank" style=3D"font-family:Calib=
ri,sans-serif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&qu=
ot;Times New Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:r=
gb(78,193,224)"><img src=3D"cid:1838fef3a64f7432f799" style=3D"width: 96px;=
 max-width: 100%; background-color: rgba(0, 0, 0, 0) !important; border-col=
or: rgb(12, 91, 113) !important; color: rgb(15, 112, 136) !important;"></sp=
an></a><span style=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;=
,serif,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px;font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t">
<p align=3D"right" style=3D"margin:0px;font-size:11pt;font-family:Calibri,s=
ans-serif,serif,EmojiFont;text-align:right">
<a href=3D"http://twitter.com/SAFRAN" rel=3D"noopener noreferrer" title=3D"=
&quot;Twitter&quot;" target=3D"_blank" style=3D"font-family:Calibri,sans-se=
rif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&quot;Times N=
ew Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:blue"><img =
src=3D"cid:1838fef3a64c82a9bc9a" style=3D"width: 21px; max-width: 100%; bac=
kground-color: rgba(0, 0, 0, 0) !important; border-color: rgb(190, 138, 242=
) !important; color: rgb(219, 163, 245) !important;"></span></a><span style=
=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;,serif,serif,Emoji=
Font"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px;font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t">
<p align=3D"right" style=3D"margin:0px;font-size:11pt;font-family:Calibri,s=
ans-serif,serif,EmojiFont;text-align:right">
<a href=3D"http://www.facebook.com/GroupeSafran" rel=3D"noopener noreferrer=
" title=3D"&quot;Facebook&quot;" target=3D"_blank" style=3D"font-family:Cal=
ibri,sans-serif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&=
quot;Times New Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color=
:blue"><img src=3D"cid:1838fef3a64f82a6facb" style=3D"width: 21px; max-widt=
h: 100%; background-color: rgba(0, 0, 0, 0) !important; border-color: rgb(1=
90, 138, 242) !important; color: rgb(219, 163, 245) !important;"></span></a=
><span style=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;,serif=
,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px;font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t">
<p align=3D"right" style=3D"margin:0px;font-size:11pt;font-family:Calibri,s=
ans-serif,serif,EmojiFont;text-align:right">
<span style=3D"font-size:9pt;font-family:&quot;Times New Roman&quot;,serif,=
serif,EmojiFont;text-decoration:none;color:blue"><a href=3D"http://fr.linke=
din.com/company/safran" rel=3D"noopener noreferrer" title=3D"&quot;LinkedIn=
&quot;" target=3D"_blank" style=3D"font-family:&quot;Times New Roman&quot;,=
serif,serif,EmojiFont"><img src=3D"cid:1838fef3a64923d3295c" style=3D"width=
: 21px; max-width: 100%; background-color: rgba(0, 0, 0, 0) !important; bor=
der-color: rgb(55, 120, 211) !important; color: rgb(99, 150, 238) !importan=
t;"></a></span></p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<p style=3D"margin-top:0px;margin-bottom:0px;font-family:Calibri,Helvetica,=
sans-serif"></p>
</div>
</div>
</div>
</div>
<div id=3D"m_-8722381858772988065appendonsend"></div>
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-8722381858772988065divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" style=3D"font-size:11pt;font-family:Calibri,sans-serif;=
color:rgb(0,0,0)"><b style=3D"font-family:Calibri,sans-serif">From:</b> <a =
href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank" styl=
e=3D"font-family:Calibri,sans-serif">bitbake-devel@lists.openembedded.org</=
a> &lt;<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_b=
lank" style=3D"font-family:Calibri,sans-serif">bitbake-devel@lists.openembe=
dded.org</a>&gt; on behalf of Alexander Kanavin &lt;<a href=3D"mailto:alex.=
kanavin@gmail.com" target=3D"_blank" style=3D"font-family:Calibri,sans-seri=
f">alex.kanavin@gmail.com</a>&gt;<br>
<b style=3D"font-family:Calibri,sans-serif">Sent:</b> Friday, September 30,=
 2022 10:59 AM<br>
<b style=3D"font-family:Calibri,sans-serif">To:</b> Nicholas Jackson &lt;<a=
 href=3D"mailto:Nicholas.Jackson@zii.aero" target=3D"_blank" style=3D"font-=
family:Calibri,sans-serif">Nicholas.Jackson@zii.aero</a>&gt;<br>
<b style=3D"font-family:Calibri,sans-serif">Cc:</b> <a href=3D"mailto:bitba=
ke-devel@lists.openembedded.org" target=3D"_blank" style=3D"font-family:Cal=
ibri,sans-serif">bitbake-devel@lists.openembedded.org</a> &lt;<a href=3D"ma=
ilto:bitbake-devel@lists.openembedded.org" target=3D"_blank" style=3D"font-=
family:Calibri,sans-serif">bitbake-devel@lists.openembedded.org</a>&gt;<br>
<b style=3D"font-family:Calibri,sans-serif">Subject:</b> Re: [bitbake-devel=
] [PATCH] bitbake: wget: fix netrc with pseudo</font>
<div>=C2=A0</div>
</div></div><div dir=3D"ltr">
<div>
<div dir=3D"ltr">
<div>How can the problem be reproduced?</div>
<div><br>
</div>
<div>Alex<br>
</div>
</div>
<br>
<div>
<div dir=3D"ltr">On Fri, 30 Sept 2022 at 19:55, Nicholas Jackson &lt;<a hre=
f=3D"mailto:Nicholas.Jackson@zii.aero" target=3D"_blank">Nicholas.Jackson@z=
ii.aero</a>&gt; wrote:<br>
</div>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">
<div>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<span style=3D"font-size:12pt;margin:0px;font-family:Calibri,Arial,Helvetic=
a,sans-serif;background-color:white;color:black">From: Nicholas Jackson &lt=
;<a href=3D"mailto:nicholas.jackson@zii.aero" target=3D"_blank" style=3D"fo=
nt-family:Calibri,Arial,Helvetica,sans-serif">nicholas.jackson@zii.aero</a>=
&gt;</span><span style=3D"display:inline;font-family:Calibri,Arial,Helvetic=
a,sans-serif;background-color:rgb(255,255,255)"></span>
<div style=3D"font-size:12pt;margin:0px;font-family:Calibri,Arial,Helvetica=
,sans-serif;background-color:white;color:black"><br>
</div>
<span style=3D"display:inline;font-family:Calibri,Arial,Helvetica,sans-seri=
f;background-color:rgb(255,255,255)">The netrc module will refuse to use a =
file that is not owned by the</span>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">current user. Psuedo can trigger this failu=
re due to a reported uid of</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">0. To fix this, change ownership of the def=
ault netrc file to 0:0. This</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">has no permanent effect on the actual netrc=
 file.</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)"><br>
</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">Note that while it is not possible to ask t=
he netrc module what the</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">default netrc file is, the documentation ex=
plicitly mentions that</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">expanduser is used.</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)"><br>
</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">Signed-off-by: Nicholas Jackson &lt;<a href=
=3D"mailto:nicholas.jackson@zii.aero" target=3D"_blank" style=3D"font-famil=
y:Calibri,Arial,Helvetica,sans-serif">nicholas.jackson@zii.aero</a>&gt;</di=
v>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">---</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0bitbake/lib/bb/fetch2/wget.py | 8 +++=
++++-</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A01 file changed, 7 insertions(+), 1 de=
letion(-)</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)"><br>
</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">diff --git a/bitbake/lib/bb/fetch2/wget.py =
b/bitbake/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">index 821afa5b58..0ce6e25c5c 100644</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">--- a/bitbake/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+++ b/bitbake/lib/bb/fetch2/wget.py</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">@@ -360,10 +360,16 @@ class Wget(FetchMetho=
d):</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0try:</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import netrc</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Pseudo can cause ownership mismatch issues wi=
th netrc, which is</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# required to be owned by the current user (roo=
t).</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if os.environ.get(&quot;PSEUDO_DISABLED&quot;) =
=3D=3D &quot;0&quot;:</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.chown(os.path.join(os.path.exp=
anduser(&quot;~&quot;), &quot;.netrc&quot;), 0, 0)</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n =3D netrc.netrc()</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0login, unused, password =3D n.authenticat=
ors(urllib.parse.urlparse(uri).hostname)</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_basic_auth(&quot;%s:%s&quot; % (login=
, password), r)</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0except (TypeError, ImportError, IOError, netrc.NetrcParseErro=
r):</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0except netrc.NetrcParseError as e:</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.debug(&quot;netrc failed: %s&quot; % e)<=
/div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0except (TypeError, ImportError, IOError) as e:</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0with opener.open(r, timeout=3D30) as response:</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">--</div>
<div style=3D"margin:0px;font-family:Calibri,Arial,Helvetica,sans-serif;bac=
kground-color:rgb(255,255,255)">2.37.2</div>
<div style=3D"font-size:12pt;margin:0px;font-family:Calibri,Arial,Helvetica=
,sans-serif;background-color:white;color:black"><span style=3D"margin:0px;f=
ont-family:Calibri,Arial,Helvetica,sans-serif"></span></div>
<br>
<br>
</div>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
<br>
</div>
<div id=3D"m_-8722381858772988065x_m_7483792620520446128Signature">
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif;font-size:12pt=
;color:rgb(0,0,0)">
</div>
<div></div>
<div></div>
<div id=3D"m_-8722381858772988065x_m_7483792620520446128divtagdefaultwrappe=
r" dir=3D"ltr" style=3D"font-size:12pt;font-family:Calibri,Helvetica,sans-s=
erif;color:rgb(0,0,0)">
<p style=3D"margin-top:0px;margin-bottom:0px;font-family:Calibri,Helvetica,=
sans-serif"></p>
<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" style=3D"font-famil=
y:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial=
,sans-serif,serif,EmojiFont;font-size:15px;table-layout:fixed;color:rgb(33,=
33,33)">
<tbody style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;S=
egoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<tr style=3D"height:83.45pt;font-family:wf_segoe-ui_normal,&quot;Segoe UI&q=
uot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td style=3D"width:311px;height:83.45pt;padding:10.5pt 0px;border-style:sol=
id none none;border-top-width:1pt;font-family:wf_segoe-ui_normal,&quot;Sego=
e UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;bor=
der-top-color:rgb(0,67,145)">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<b style=3D"font-family:Calibri,sans-serif,serif,EmojiFont"><span style=3D"=
font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;color:rgb(82,86,=
104)">Nicholas JACKSON</span></b><span style=3D"font-size:9pt;font-family:A=
rial,sans-serif,serif,EmojiFont;color:rgb(82,86,104)">=C2=A0<br>
Software Engineer II</span></p>
<p style=3D"margin:0px 0px 12pt;font-size:11pt;font-family:Calibri,sans-ser=
if,serif,EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"><span style=3D"font-family:Arial,sans-serif;text-align=
:start;display:inline;background-color:rgb(255,255,255)">Safran Passenger I=
nnovations</span></span></p>
<p style=3D"margin:0px 0px 12pt;font-size:11pt;font-family:Calibri,sans-ser=
if,serif,EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"><span style=3D"font-family:Arial,sans-serif,serif,Emoj=
iFont;font-size:10.6667px;color:rgb(128,128,128)"><span style=3D"font-famil=
y:Arial,sans-serif;font-size:12px;text-align:start;display:inline;backgroun=
d-color:rgb(255,255,255);color:rgb(82,86,104)">T</span></span><span style=
=3D"font-family:arial,sans-serif;font-size:9pt;background-color:rgb(255,255=
,255);color:rgb(82,86,104)">=C2=A0+1
 714 854 8600 ext 527</span></span></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"></span></p>
<p style=3D"margin:0in;font-size:11pt;font-family:Calibri,sans-serif;text-a=
lign:start;background-color:rgb(255,255,255);color:rgb(32,31,30)">
<span style=3D"margin:0px;font-size:9pt;font-family:Arial,sans-serif;color:=
rgb(82,86,104)">3151 East Imperial Hwy</span></p>
<p style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe=
 WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont"></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)">Brea, Ca 92821 USA</span></p>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:9pt;font-family:Arial,sans-serif,serif,EmojiFont;c=
olor:rgb(82,86,104)"><a href=3D"https://urldefense.com/v3/__http://www.safr=
an-passenger-innovations.com/__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4R=
mEeqROZCvPaimgdLyag0Ird5wj8wRp_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyCHL6szf$" =
rel=3D"noopener noreferrer" style=3D"margin:0px;font-size:14.6667px;font-fa=
mily:Calibri,sans-serif;text-align:start;background-color:rgb(255,255,255)"=
 target=3D"_blank"><span style=3D"font-family:Arial;font-size:9pt"><b style=
=3D"font-family:Arial">www.safran-passenger-innovations.com</b></span></a><=
/span></p>
</td>
<td style=3D"padding:0px;border-style:none;width:2px;font-family:wf_segoe-u=
i_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,=
serif,EmojiFont">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
=C2=A0</p>
</td>
</tr>
<tr style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td colspan=3D"2" style=3D"padding:0px 0px 12.75pt;border-style:none none s=
olid;border-bottom-width:1pt;font-family:wf_segoe-ui_normal,&quot;Segoe UI&=
quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;border-b=
ottom-color:rgb(0,67,145)">
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<span style=3D"font-size:12pt;font-family:Arial,sans-serif,serif,EmojiFont;=
color:rgb(82,86,104)"><img src=3D"cid:1838fef3a63bb3ee15b1" style=3D"width:=
 147px; max-width: 100%; background-color: rgba(0, 0, 0, 0) !important; bor=
der-color: rgb(161, 165, 185) !important; color: rgb(188, 192, 212) !import=
ant;"></span><span lang=3D"fr" style=3D"font-size:12pt;font-family:Arial,sa=
ns-serif,serif,EmojiFont;color:rgb(82,86,104)"></span></p>
</td>
</tr>
<tr style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td colspan=3D"2" style=3D"padding:3pt 0px;border-style:none none solid;bor=
der-bottom-width:1pt;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&q=
uot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont;border-bottom-co=
lor:rgb(0,67,145)">
<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" style=3D"width:315p=
x;font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,=
Tahoma,Arial,sans-serif,serif,EmojiFont">
<tbody style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;S=
egoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<tr style=3D"font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont">
<td style=3D"width:180pt;padding:0px;font-family:wf_segoe-ui_normal,&quot;S=
egoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFont"=
>
<p style=3D"margin:0px;font-size:11pt;font-family:Calibri,sans-serif,serif,=
EmojiFont">
<a href=3D"https://urldefense.com/v3/__http://www.safran-group.com/subscrip=
tion-account?utm_source=3Dsubscribemail&amp;utm_medium=3Dmailpro&amp;utm_ca=
mpaign=3DsubscribemailEN__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqR=
OZCvPaimgdLyag0Ird5wj8wRp_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyBduGohQ$" rel=
=3D"noopener noreferrer" target=3D"_blank" style=3D"font-family:Calibri,san=
s-serif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&quot;Tim=
es New Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:rgb(1,6=
8,145)"><img src=3D"cid:1838fef3a63acc5a1812" style=3D"width: 67px; max-wid=
th: 100%; background-color: rgba(0, 0, 0, 0) !important; border-color: rgb(=
162, 183, 245) !important; color: rgb(188, 207, 248) !important;"></span></=
a><a href=3D"https://urldefense.com/v3/__http://www.safran-group.com/subscr=
iption-account?utm_source=3Dsubscribemail&amp;utm_medium=3Dmailpro&amp;utm_=
campaign=3DsubscribemailEN__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEe=
qROZCvPaimgdLyag0Ird5wj8wRp_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyBduGohQ$" rel=
=3D"noopener noreferrer" target=3D"_blank" style=3D"font-family:Calibri,san=
s-serif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&quot;Tim=
es New Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:rgb(78,=
193,224)"><img src=3D"cid:1838fef3a63ffaecb153" style=3D"width: 96px; max-w=
idth: 100%; background-color: rgba(0, 0, 0, 0) !important; border-color: rg=
b(12, 91, 113) !important; color: rgb(15, 112, 136) !important;"></span></a=
><span style=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;,serif=
,serif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px;font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t">
<p align=3D"right" style=3D"margin:0px;font-size:11pt;font-family:Calibri,s=
ans-serif,serif,EmojiFont;text-align:right">
<a href=3D"https://urldefense.com/v3/__http://twitter.com/SAFRAN__;!!BXNzmn=
hnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wRp_VGu9fGuLk=
pGGLDedRzDSMUZ1LJCoQAS8jyNnzvPqy$" rel=3D"noopener noreferrer" title=3D"&qu=
ot;Twitter&quot;" target=3D"_blank" style=3D"font-family:Calibri,sans-serif=
,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&quot;Times New =
Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:blue"><img src=
=3D"cid:1838fef3a63a8ac7fa4" style=3D"width: 21px; max-width: 100%; backgro=
und-color: rgba(0, 0, 0, 0) !important; border-color: rgb(190, 138, 242) !i=
mportant; color: rgb(219, 163, 245) !important;"></span></a><span style=3D"=
font-size:1pt;font-family:&quot;Times New Roman&quot;,serif,serif,EmojiFont=
"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px;font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t">
<p align=3D"right" style=3D"margin:0px;font-size:11pt;font-family:Calibri,s=
ans-serif,serif,EmojiFont;text-align:right">
<a href=3D"https://urldefense.com/v3/__http://www.facebook.com/GroupeSafran=
__;!!BXNzmnhnlE-olPyVU9tI!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wR=
p_VGu9fGuLkpGGLDedRzDSMUZ1LJCoQAS8jyHmr7D_P$" rel=3D"noopener noreferrer" t=
itle=3D"&quot;Facebook&quot;" target=3D"_blank" style=3D"font-family:Calibr=
i,sans-serif,serif,EmojiFont"><span style=3D"font-size:9pt;font-family:&quo=
t;Times New Roman&quot;,serif,serif,EmojiFont;text-decoration:none;color:bl=
ue"><img src=3D"cid:1838fef3a634dcaf8f15" style=3D"width: 21px; max-width: =
100%; background-color: rgba(0, 0, 0, 0) !important; border-color: rgb(190,=
 138, 242) !important; color: rgb(219, 163, 245) !important;"></span></a><s=
pan style=3D"font-size:1pt;font-family:&quot;Times New Roman&quot;,serif,se=
rif,EmojiFont"></span></p>
</td>
<td style=3D"width:18.75pt;padding:0px;font-family:wf_segoe-ui_normal,&quot=
;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif,serif,EmojiFon=
t">
<p align=3D"right" style=3D"margin:0px;font-size:11pt;font-family:Calibri,s=
ans-serif,serif,EmojiFont;text-align:right">
<span style=3D"font-size:9pt;font-family:&quot;Times New Roman&quot;,serif,=
serif,EmojiFont;text-decoration:none;color:blue"><a href=3D"https://urldefe=
nse.com/v3/__http://fr.linkedin.com/company/safran__;!!BXNzmnhnlE-olPyVU9tI=
!As8zj7fVv20WKGLUTF4RmEeqROZCvPaimgdLyag0Ird5wj8wRp_VGu9fGuLkpGGLDedRzDSMUZ=
1LJCoQAS8jyGC1R16c$" rel=3D"noopener noreferrer" title=3D"&quot;LinkedIn&qu=
ot;" target=3D"_blank" style=3D"font-family:&quot;Times New Roman&quot;,ser=
if,serif,EmojiFont"><img src=3D"cid:1838fef3a6379eb4ca36" style=3D"width: 2=
1px; max-width: 100%; background-color: rgba(0, 0, 0, 0) !important; border=
-color: rgb(55, 120, 211) !important; color: rgb(99, 150, 238) !important;"=
></a></span></p>
</td>
</tr>
</tbody>
</table>
</td>
</tr>
</tbody>
</table>
<p style=3D"margin-top:0px;margin-bottom:0px;font-family:Calibri,Helvetica,=
sans-serif"></p>
</div>
</div>
</div>
</div>
<br>
<hr>
<font size=3D"1" face=3D"Arial" style=3D"font-family:Arial;color:rgb(128,12=
8,128)"><br>
This email and any files transmitted with it are confidential &amp; proprie=
tary to Safran Passenger Innovations. This information is intended solely f=
or the use of the individual or entity to which it is addressed. Access or =
transmittal of the information contained
 in this e-mail, in full or in part, to any other organization or persons i=
s not authorized.<br>
</font></div>
<br>
<br>
<br>
</div>
</blockquote>
</div>
</div>
<br>
<hr>
<font face=3D"Arial" size=3D"1" style=3D"font-family:Arial;color:rgb(128,12=
8,128)"><br>
This email and any files transmitted with it are confidential &amp; proprie=
tary to Safran Passenger Innovations. This information is intended solely f=
or the use of the individual or entity to which it is addressed. Access or =
transmittal of the information contained
 in this e-mail, in full or in part, to any other organization or persons i=
s not authorized.<br>
</font>
</div>

</blockquote></div></div>

--000000000000129b5005e9ea5320--

--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-kybjmhvy.png"
Content-Disposition: inline; filename="Outlook-kybjmhvy.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a63ffaecb153>
X-Attachment-Id: 1838fef3a63ffaecb153

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-w1u0235i.png"
Content-Disposition: inline; filename="Outlook-w1u0235i.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a634dcaf8f15>
X-Attachment-Id: 1838fef3a634dcaf8f15

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAABu0lEQVQ4EbWSPUvDUBSG35g2ja2t
pTjUD4qKIgq6CEUF6+AgIjq4OPUnuLoKurg6+At0UhedRJy6FJwEFRSkFgx+YAz9SNKkTRtJEzGJ
NyqId8m9J+c559z3vhRmt/GH1fIrtqGjoRMzfcToZ7CsQKqCoY1IkAHr//zV3H3Ll5VYvH05NRAN
BwAcZu7y+TdXCW++rIyNdO5vLg71RM2ez4Kcv+AQd4zgwWsN1Opr6aQJ33KFoqTmnooIMb+bX6sj
FhrsNjpnLh9nVvdRqiDSijDr4j30l6sQpJJcBfDwWsb9G6p1aHUXDIBG/7w7qtSmJvrmpgfmk70d
ERY6xCCTHE8ISq3Ai/A13+KDoQj+EaSjnZWlyf6PHOub3jrd2ztHPGKPk+b301d5geNFtWYMXFE1
jhc5XjT0M41gK0Dqr+usj46EAwfrC6nRruNsLr1x4mNoQVJtoLUlvR9FKQVZsWWXXorw02gLgKJc
JUjzA0a23ap+Gq3MVxiAB+/q4n38Tz7adGu0ze05+zQk/QDTJLtnN8OJWPb6ybi8xyK9n5mq61A1
i7Jr6Szk0R8w1HZa1QlaJ2/euMXP6r4D45GH2XAQI60AAAAASUVORK5CYII=
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-vuq5al0t.png"
Content-Disposition: inline; filename="Outlook-vuq5al0t.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a6379eb4ca36>
X-Attachment-Id: 1838fef3a6379eb4ca36

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-5hcun3aa.png"
Content-Disposition: inline; filename="Outlook-5hcun3aa.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a64f7432f799>
X-Attachment-Id: 1838fef3a64f7432f799

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-1z2l04w5.png"
Content-Disposition: inline; filename="Outlook-1z2l04w5.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a63a8ac7fa4>
X-Attachment-Id: 1838fef3a63a8ac7fa4

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-1pkwad4d.png"
Content-Disposition: inline; filename="Outlook-1pkwad4d.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a63acc5a1812>
X-Attachment-Id: 1838fef3a63acc5a1812

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-5ajisvr2.png"
Content-Disposition: inline; filename="Outlook-5ajisvr2.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a64a87b16978>
X-Attachment-Id: 1838fef3a64a87b16978

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-loscivc5.png"
Content-Disposition: inline; filename="Outlook-loscivc5.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a64c82a9bc9a>
X-Attachment-Id: 1838fef3a64c82a9bc9a

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-x2vgiek3.png"
Content-Disposition: inline; filename="Outlook-x2vgiek3.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a6420d4b2947>
X-Attachment-Id: 1838fef3a6420d4b2947

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-iz5nuuf5.png"
Content-Disposition: inline; filename="Outlook-iz5nuuf5.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a64f82a6facb>
X-Attachment-Id: 1838fef3a64f82a6facb

iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAIAAAAmdTLBAAABu0lEQVQ4EbWSPUvDUBSG35g2ja2t
pTjUD4qKIgq6CEUF6+AgIjq4OPUnuLoKurg6+At0UhedRJy6FJwEFRSkFgx+YAz9SNKkTRtJEzGJ
NyqId8m9J+c559z3vhRmt/GH1fIrtqGjoRMzfcToZ7CsQKqCoY1IkAHr//zV3H3Ll5VYvH05NRAN
BwAcZu7y+TdXCW++rIyNdO5vLg71RM2ez4Kcv+AQd4zgwWsN1Opr6aQJ33KFoqTmnooIMb+bX6sj
FhrsNjpnLh9nVvdRqiDSijDr4j30l6sQpJJcBfDwWsb9G6p1aHUXDIBG/7w7qtSmJvrmpgfmk70d
ERY6xCCTHE8ISq3Ai/A13+KDoQj+EaSjnZWlyf6PHOub3jrd2ztHPGKPk+b301d5geNFtWYMXFE1
jhc5XjT0M41gK0Dqr+usj46EAwfrC6nRruNsLr1x4mNoQVJtoLUlvR9FKQVZsWWXXorw02gLgKJc
JUjzA0a23ap+Gq3MVxiAB+/q4n38Tz7adGu0ze05+zQk/QDTJLtnN8OJWPb6ybi8xyK9n5mq61A1
i7Jr6Szk0R8w1HZa1QlaJ2/euMXP6r4D45GH2XAQI60AAAAASUVORK5CYII=
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-1h4phv2m.png"
Content-Disposition: inline; filename="Outlook-1h4phv2m.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a63bb3ee15b1>
X-Attachment-Id: 1838fef3a63bb3ee15b1

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
--000000000000129b5105e9ea5321
Content-Type: image/png; name="Outlook-qob15plp.png"
Content-Disposition: inline; filename="Outlook-qob15plp.png"
Content-Transfer-Encoding: base64
Content-ID: <1838fef3a64923d3295c>
X-Attachment-Id: 1838fef3a64923d3295c

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
--000000000000129b5105e9ea5321--

