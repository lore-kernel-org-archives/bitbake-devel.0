Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E2FCD6E4D
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:40:58 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22885.1763037652800408608
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 04:40:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=zV+NZsxX;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b387483bbso642603f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 04:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1763037651; x=1763642451; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y2GhkxtpGoGyB+mImIBwZQXadPNRnaHs8N6F/1z4s9w=;
        b=zV+NZsxXqpgGL9LlVE8pprMaiazkDRCASWm/N0Afz4lOGGyO2RkfrogMibwN+2wHzX
         KIE4SjcoRUwjpxGm+Hz/8xaAPHWVjXrLqN05hLCWC4AJeaPENzgNEnpJVwgtzolvJLmI
         iFPD/CW5eOnERq+xUkC32qRaUpWD/ahhhyds0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763037651; x=1763642451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2GhkxtpGoGyB+mImIBwZQXadPNRnaHs8N6F/1z4s9w=;
        b=bNVV4Ac2CBB0GDeCkGudEjWGoBRAogqBHpXmcMdsi4v0DWiVIT+wIn7CVnJBOqAUjQ
         IGooxr6Si3d76VXCurGUNl9MKi5K8W2gvdzMDLBqYNvgxeVlYq50ldjTLsbGkuUMeYnl
         vBRNiElLFVqAQDmFNHpkSNqTkaB/a4X1LcpyBSaMu9OFClylJ4EfUdVNAQZeSOrTxqyI
         YQT9nfvtzQDAK2/JRnXDNkN2Cn6SQOBwfBMr+i1KaP/73ta+UqP/JrFHDc6SxqkBLGen
         tPiH06nGRlOIvPU+2wSzV3smf30SXeWk914rpcO9bRFfWFnPbn4Lr/nsQ9Ds8RF8Q1V5
         2SDQ==
X-Gm-Message-State: AOJu0YyKVvDmLaZGY4y3i2X14sJg6bwXs0/u8Q1JbaS0nds+7+Pn8Z6N
	lo2apH0w5LIBdbxpyn1wGxq7BHFrOFlBS9T3l8BOOWImOyUHyvWmQLmrPMrcKZd2HSvx9v3URhF
	amXSTlz7WGJC+jsHw241ervElkpjFIRtxcb1g4+NCkw==
X-Gm-Gg: ASbGnctufNMhmC3Qz7mRgTj8yM9cte2XfV1+udEyRIZDuI1kHyElqJ09gxVo7CXo8fJ
	svyvR3HPFEoRmtyn+04TenllSbSv4I252QvXFV5lMlffVl8SvatRO46zBUoz0AeB8dPaTt0Ep0P
	C4aWrlMEb2L41iKXj+sABCaw+LxOC8dC3gYCdH4WI/CKrgW19pu5Wcqd2yXa+YizOARjDkrkqvf
	bdHnEierQH1fSaOJhguBwoEXJ8vYWHCUMXcUPQLdp/DE0EQpIoV5kDSjLvnmOYEl19wBCBVT3n2
	SOjPKXzzT82SPjyok2zcKG/wMf0aJw==
X-Google-Smtp-Source: AGHT+IHgE8d6/QA5dGLuy5q9jplMG0BlGDJ91C9Y7v/NlwVNHKDTN5Mv0R5Dz1QU/qOGMPKpNW3r/dMicFnzPOCP0sQ=
X-Received: by 2002:a05:6000:2006:b0:429:c4bb:fbc5 with SMTP id
 ffacd0b85a97d-42b4bb87694mr4436593f8f.7.1763037651035; Thu, 13 Nov 2025
 04:40:51 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
In-Reply-To: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 13 Nov 2025 13:40:24 +0100
X-Gm-Features: AWmQ_bmxV5jGXXXwkp51x9AMbLjo_2F-dp1w3_y5xLG_AfHesTJueG9GAp5NjbQ
Message-ID: <CAMSfU+49avzzK7OYFtGAT+R39Eppp_ggjyTPb6Y7hAi9G=iDjQ@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup steps for release
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Paul Barker <paul@pbarker.dev>, 
	Alexander Kanavin <alex.kanavin@gmail.com>, Ross Burton <ross.burton@arm.com>, reatmon <reatmon@ti.com>, 
	Robert Yang <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Content-Type: multipart/alternative; boundary="000000000000ea7bae064379303a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 12:40:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18371

--000000000000ea7bae064379303a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 13 nov. 2025 =C3=A0 12:16, Richard Purdie via lists.openembedded.or=
g
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> a =C3=A9crit =
:

> I'll let anyone add anything I've missed.


FYI, we are working to simplify the "git-remote" element for the simple
(and IMHO most common) case : a single remote called "origin".
In this case, we plan to be able to replace

        "bitbake": {
            "git-remote": {
                "remotes": {
                    "origin": {
                        "uri":
"git://git.openembedded.org/bitbake;protocol=3Dhttps"
                    }
                },
                "rev": "master"
            },
        },

by

        "bitbake": {
            "git-remote": {
                "uri": "git://git.openembedded.org/bitbake;protocol=3Dhttps=
",
                "rev": "master"
            }
        },

"uri" and "remote" would then be mutually exclusive.

Originally I planned to discuss this around the working patches but since
you asked...
I'm not sure we can send this before the release deadline though, but I
feel like this is something that can be added between the release and the
LTS.
On the other hand, if there is a strong opinion for integrating that into
the release I can shuffle priorities and make it happen.
--=20
Yoann Congal
Smile ECS

--000000000000ea7bae064379303a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Le=C2=A0jeu. 13 nov. 2025 =C3=A0=C2=A012:=
16, Richard Purdie via <a href=3D"http://lists.openembedded.org">lists.open=
embedded.org</a> &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundation.org=
@lists.openembedded.org">linuxfoundation.org@lists.openembedded.org</a>&gt;=
 a =C3=A9crit=C2=A0:</div><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;ll let anyone add anything I&#39;ve missed.
</blockquote></div><div><br></div><div>FYI, we are working to simplify the =
&quot;git-remote&quot; element for the simple (and IMHO most common) case :=
 a single remote called &quot;origin&quot;.</div><div>In this case, we plan=
 to be able to replace<br><pre>        &quot;bitbake&quot;: {
            &quot;git-remote&quot;: {
                &quot;remotes&quot;: {
                    &quot;origin&quot;: {
                        &quot;uri&quot;: &quot;git://<a href=3D"http://git.=
openembedded.org/bitbake;protocol=3Dhttps">git.openembedded.org/bitbake;pro=
tocol=3Dhttps</a>&quot;=20
                    }
                },
                &quot;rev&quot;: &quot;master&quot;=20
            },
        },<br></pre>by</div><div><pre>        &quot;bitbake&quot;: {
            &quot;git-remote&quot;: {
                &quot;uri&quot;: &quot;git://<a href=3D"http://git.openembe=
dded.org/bitbake;protocol=3Dhttps">git.openembedded.org/bitbake;protocol=3D=
https</a>&quot;,
                &quot;rev&quot;: &quot;master&quot;=20
            }
        },<br></pre>&quot;uri&quot; and &quot;remote&quot; would then be mu=
tually exclusive.</div><div><br></div><div>Originally I planned to discuss =
this around the working patches but since you asked...</div><div>I&#39;m no=
t sure we can send this before the release deadline though, but I feel like=
 this is something that can be added between the release and the LTS.</div>=
<div>On the other hand, if there is a strong opinion for integrating that i=
nto the release I can shuffle priorities and=C2=A0make it happen.=C2=A0</di=
v><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" cla=
ss=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"Raleway, regular">Yoa=
nn Congal</font><div><font face=3D"Raleway, regular">Smile ECS</font></div>=
</div></div></div>

--000000000000ea7bae064379303a--

