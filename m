Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E7CD6E4F
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:56:58 +0000 (UTC)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23118.1763038613218426783
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 04:56:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KkoPfLDx;
 spf=pass (domain: gmail.com, ip: 209.85.160.174, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda057f3c0so8384111cf.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 04:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763038612; x=1763643412; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MiaN5Y+fAFNkZ3jh/b//ihpF9GW/CI/NqHLMxjmMQzE=;
        b=KkoPfLDxfLJTXPhiC8TWg7Q+0SwS2ZgPhnoZQjbqdKRZvVPMEGAynj6/olaTMwr09y
         xkjK8KUJ0aMGR0zB7u02c02JW8Jmcd4UCvAHBQcYH+U1MaQrIYXri++tIE/eiAyhjlB4
         QNbAtygEiyztFT5yXqGldzMJqEOU0KIESQm1OnyxpUeXas9V+aY5GHGi6um+vDaXDpsy
         /RigBe3PA+fC+A6M/wF89OSD4jB+Ti8KIUBzvFYxqFLrllJkMyigXtavXAmTy38xzaLx
         cpGkkPr6yx4DhUDrj0/6bcTlp7trCEGJtCoPTC02wC9Nhvm3ijTov7Cvul5AchLvduux
         bujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763038612; x=1763643412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiaN5Y+fAFNkZ3jh/b//ihpF9GW/CI/NqHLMxjmMQzE=;
        b=cXYJFV8trJwdke4r2jHKYKKxStd+jFzrokMrgZBVVQUH00ZfqIxBmz6tnQfU8DGsxE
         MkbFiWyu5A5OYzPudbtUH0eJiYpPi6jG5aoMVYw3oPdgbftyoVqi9ueyHj1Ud/3RsdcR
         KEKN8uO3dkc2zeGytH6GMYjT9DqdRXbf9CVdamLjlqenkjpoKy7EaYHcFSZwi3qAqOyf
         wInwvBTJ5sdvDGz40yF9zKA3Rvv3zpXKEIFq97WStF1xB//PoS+SbQIKFWBi3CeqzmSy
         dK9R+pfRJdiEWnM/vLMQ3usajGsm6PI800KVHg0WX7EMYorexBnACUcGdnm2/mjABqJm
         wbZg==
X-Forwarded-Encrypted: i=1; AJvYcCUnqCb/RtrRf1Fz/f94i6tYSI4Cb2uQSW40jy7Sy1AgC2V8/iU1aJlwsIv8nKpqGAZRWzPfg889ZT7UCY0z@lists.openembedded.org
X-Gm-Message-State: AOJu0YyjZnSCQWwlqm50jTK3cU4Afc/qBHZZ8X/wgk5bpCfoGvrpqpGZ
	U0qQJNB+TvwQEs6vwKSKam31KrmiQ4Od308Tk6GZ7F8iibU9DJuMysA8DlhBUujmtWgEdeZwWif
	og+G229fwM64/OFgeyj4oAXD8B8b7Sdg=
X-Gm-Gg: ASbGncs3l4ACrDwTvYCKRL/7ad23bA3GOtu0y5YDhyErb2Xte8V/w6J8GMjvWWH0CAl
	Xf4zNivvUguj2AJrRVB9Jf7T7w4iJGEjNjRxALupZnn1IOMfY9/+1IISXf9+2ZLVWOBa9yoRVVK
	J4T7q0ZZ2U4ewxRFYodECOzsfMkKzUT14j2au/AMhkm9BIuEHSpkh8bZDWqZawOL7SpT9gA1nLW
	QmEVNX4o6KX5HDzPS2Fozk30v+TuORyLTomhhE25VFutXAdEpjJfhkDZorVbZD4VKKD0UM3lwOM
	MBsxDkqHNBC2fGsBgDbJA184rVe0xVBuVkQ560U=
X-Google-Smtp-Source: AGHT+IHY8mOxbNYG+xM+09C9a8sJF86juNRG7EPJCNlFVFvKm5wkG8MfORAMZ5P7m4k4NrVimhZ1vk3PT4CZjTUSDbA=
X-Received: by 2002:ac8:5a8b:0:b0:4ed:a176:fec2 with SMTP id
 d75a77b69052e-4eddbddbd05mr72854721cf.42.1763038612065; Thu, 13 Nov 2025
 04:56:52 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <CAMSfU+49avzzK7OYFtGAT+R39Eppp_ggjyTPb6Y7hAi9G=iDjQ@mail.gmail.com>
In-Reply-To: <CAMSfU+49avzzK7OYFtGAT+R39Eppp_ggjyTPb6Y7hAi9G=iDjQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Nov 2025 13:56:40 +0100
X-Gm-Features: AWmQ_blfPLpnS201n7RlxnvNoczeHqpxUF1iEzC3kYXCTfDviH2Hy3IA0sm2oDM
Message-ID: <CANNYZj9W2v=dR7bvxJ+=zqC=_PP29c8rDfFF0ErOQvsYZtGuig@mail.gmail.com>
Subject: Re: [bitbake-devel] bitbake-setup steps for release
To: Yoann Congal <yoann.congal@smile.fr>
Cc: richard.purdie@linuxfoundation.org, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Paul Barker <paul@pbarker.dev>, 
	Ross Burton <ross.burton@arm.com>, reatmon <reatmon@ti.com>, 
	Robert Yang <liezhi.yang@windriver.com>, "antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>, 
	Corentin GUILLEVIC <corentin.guillevic@smile.fr>
Content-Type: multipart/alternative; boundary="0000000000003290ca0643796ad0"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 12:56:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18372

--0000000000003290ca0643796ad0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This can wait until after the release I think. I want the optional path
tweak in because the schema and the oe-setup-build are already updated but
not bitbake-setup.

Alex

On Thu 13. Nov 2025 at 13.40, Yoann Congal <yoann.congal@smile.fr> wrote:

> Le jeu. 13 nov. 2025 =C3=A0 12:16, Richard Purdie via lists.openembedded.=
org
> <richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> a =C3=A9cri=
t :
>
>> I'll let anyone add anything I've missed.
>
>
> FYI, we are working to simplify the "git-remote" element for the simple
> (and IMHO most common) case : a single remote called "origin".
> In this case, we plan to be able to replace
>
>         "bitbake": {
>             "git-remote": {
>                 "remotes": {
>                     "origin": {
>                         "uri": "git://git.openembedded.org/bitbake;protoc=
ol=3Dhttps"
>                     }
>                 },
>                 "rev": "master"
>             },
>         },
>
> by
>
>         "bitbake": {
>             "git-remote": {
>                 "uri": "git://git.openembedded.org/bitbake;protocol=3Dhtt=
ps",
>                 "rev": "master"
>             }
>         },
>
> "uri" and "remote" would then be mutually exclusive.
>
> Originally I planned to discuss this around the working patches but since
> you asked...
> I'm not sure we can send this before the release deadline though, but I
> feel like this is something that can be added between the release and the
> LTS.
> On the other hand, if there is a strong opinion for integrating that into
> the release I can shuffle priorities and make it happen.
> --
> Yoann Congal
> Smile ECS
>

--0000000000003290ca0643796ad0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This can wait until after the release I think. I want the=
 optional path tweak in because the schema and the oe-setup-build are alrea=
dy updated but not bitbake-setup.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Alex</div><div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Thu 13. Nov 2025 at 13.40, Yoan=
n Congal &lt;<a href=3D"mailto:yoann.congal@smile.fr">yoann.congal@smile.fr=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-lef=
t:1ex;border-left-color:rgb(204,204,204)"><div dir=3D"ltr"><div dir=3D"ltr"=
>Le=C2=A0jeu. 13 nov. 2025 =C3=A0=C2=A012:16, Richard Purdie via <a href=3D=
"http://lists.openembedded.org" target=3D"_blank">lists.openembedded.org</a=
> &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundation.org@lists.openembe=
dded.org" target=3D"_blank">linuxfoundation.org@lists.openembedded.org</a>&=
gt; a =C3=A9crit=C2=A0:</div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">
I&#39;ll let anyone add anything I&#39;ve missed.
</blockquote></div><div><br></div><div>FYI, we are working to simplify the =
&quot;git-remote&quot; element for the simple (and IMHO most common) case :=
 a single remote called &quot;origin&quot;.</div><div>In this case, we plan=
 to be able to replace<br><pre style=3D"font-family:monospace">        &quo=
t;bitbake&quot;: {
            &quot;git-remote&quot;: {
                &quot;remotes&quot;: {
                    &quot;origin&quot;: {
                        &quot;uri&quot;: &quot;git://<a href=3D"http://git.=
openembedded.org/bitbake;protocol=3Dhttps" target=3D"_blank" style=3D"font-=
family:monospace">git.openembedded.org/bitbake;protocol=3Dhttps</a>&quot;=
=20
                    }
                },
                &quot;rev&quot;: &quot;master&quot;=20
            },
        },<br></pre>by</div><div><pre style=3D"font-family:monospace">     =
   &quot;bitbake&quot;: {
            &quot;git-remote&quot;: {
                &quot;uri&quot;: &quot;git://<a href=3D"http://git.openembe=
dded.org/bitbake;protocol=3Dhttps" target=3D"_blank" style=3D"font-family:m=
onospace">git.openembedded.org/bitbake;protocol=3Dhttps</a>&quot;,
                &quot;rev&quot;: &quot;master&quot;=20
            }
        },<br></pre>&quot;uri&quot; and &quot;remote&quot; would then be mu=
tually exclusive.</div><div><br></div><div>Originally I planned to discuss =
this around the working patches but since you asked...</div><div>I&#39;m no=
t sure we can send this before the release deadline though, but I feel like=
 this is something that can be added between the release and the LTS.</div>=
<div>On the other hand, if there is a strong opinion for integrating that i=
nto the release I can shuffle priorities and=C2=A0make it happen.=C2=A0</di=
v></div><div dir=3D"ltr"><span class=3D"gmail_signature_prefix">-- </span><=
br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=
=3D"Raleway, regular" style=3D"font-family:Raleway,regular;color:rgb(0,0,0)=
">Yoann Congal</font><div><font face=3D"Raleway, regular" style=3D"font-fam=
ily:Raleway,regular;color:rgb(0,0,0)">Smile ECS</font></div></div></div></d=
iv>
</blockquote></div></div>

--0000000000003290ca0643796ad0--

