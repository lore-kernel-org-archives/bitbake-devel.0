Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83E8C433F5
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 13:09:55 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by mx.groups.io with SMTP id smtpd.web10.11519.1636031394877131674
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 06:09:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=H4FXLy9n;
 spf=pass (domain: gmail.com, ip: 209.85.222.51,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f51.google.com with SMTP id b17so10818626uas.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HD5ZApbjP14OsCJE5QzVcXw62EHgHruUK99HJu0nVDc=;
        b=H4FXLy9nmOEeNeHhERDLTMBEvtIEIFtodDuDa1Pcf6afL5L5zsRqzTKgOUZxv6k//V
         J+7yfGS/+FR7sAO1aKr6ctf2a1zYhqA6Bg7kgBEmgkLYCmAJtnNRZ5jo7/DgWssPrBKR
         WPM67vZ8wWTA9yn/O6LC+BtNLYlf6AA3emCDNNLxplTwSSK7D9M/UwNsj0XrAbnpSXZN
         8j3zzJak2/TQrVu4x7N98GDV27w+J7PMUFNGld5P7ORmzyz8vL2W8tSZ9N2MduV3jTZ/
         j3VudshDYisoqJ/RiNLA/EIJSJJ31jLTfNRx22XtBrjpnj2bUDD2gWMqdiOUHZzcE3Th
         C7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HD5ZApbjP14OsCJE5QzVcXw62EHgHruUK99HJu0nVDc=;
        b=2hOLyfe6L8Bwkq0JrDWQphPopFCP4a10+8IgPqYse0pixT6eeGhMaYQ9tmEEKMLYwc
         Nb8ER48+XmVJ6FUJWQprSwjHVYYHP/sOHlpP+2DARa7AaTB4y4byOd2dQj8LWTMVU9Uz
         fosSlpNqPNvfkBmTkl+1NbZqGG7y67yCHkrho+i5RcjV/9qNCmRWYKBduW5es6U8l2o0
         DcdoERIwwcfYnsgkLHpkyvKxrSAcy/uaHlJNmLX8GVWn++IFZIfDOL6mVUDFbE5RrPAx
         Yb2SDxU1+KBFCiyJd+jIS4Q0W5nIeFDMyCRUDFY3EJh1A+vcBismP09JEqS5hJLUq/Lo
         iD8A==
X-Gm-Message-State: AOAM532pH8ZQR1anEtZrfPfzKjW9XQbg76VZjGXNJt+LkcXTGXSqC04m
	vgSFA0xZLBWOxQVNmlhjpMb0UBkE69QXa0dG2G0=
X-Google-Smtp-Source: 
 ABdhPJzU1XFYnOllQ4jMbk79PRyFgAE+T9oovcNMC5SNER9pahHZsxljQQPd2xr28Rjf8huRpOJ5kyQnv2qtAq4lCZM=
X-Received: by 2002:ab0:3d10:: with SMTP id
 f16mr37370431uax.100.1636031393895;
 Thu, 04 Nov 2021 06:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
In-Reply-To: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 4 Nov 2021 14:09:42 +0100
Message-ID: 
 <CANNYZj_0U_Yk4TPVxS4hQ5zdeSvZ1LZkFQ+8fv8-x9ieZ4AH7g@mail.gmail.com>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
To: Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
Content-Type: multipart/alternative; boundary="0000000000001315f005cff63e4c"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 13:09:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12876

--0000000000001315f005cff63e4c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jasper,

I want to invite Stefan to this discussion because he's been facing similar
issues in integrating npm code with Yocto. He's been working on some
improvements to npm fetcher and class, and is most qualified to comment, so
maybe you guys can work out a plan to make it shine (or at least not be too
horrible).

To the best of my knowledge, no other companies at the moment are using
Yocto to integrate npm-based items into a product.

Alex

On Thu, 4 Nov 2021 at 13:29, Jasper Orschulko <
Jasper.Orschulko@iris-sensing.com> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Dear Bitbake developers,
>
> recently we have been looking at the npmsw fetcher and discovered some
> challenges regarding the integration into the developer workflow as
> well as the build times within Bitbake. We believe that we found a
> mechanism which would integrate well into Bitbake's existing project
> structure and drastically improve the situation.
>
>
> But first, what are the issues with the current npmsw fetcher?
>
> 1. Let's have a look at a typical npm-based project. You'd typically
> have your package-lock.json (aka shrinkwrap file) stored within the git
> repository containing your source code. Developers will rely on this
> package-lock file on a daily basis during the development cycle.
> Unfortunately, the current npmsw fetcher only supports shrinkwrap files
> stored within the meta layer or within an npm registry. This is not
> ideal, as changes to the file might be made within the project repo,
> which then need to be manually applied to the lock file within the meta
> repo. An ideal npmsw fetcher therefore would support using the lock
> file directly from the source code repo.
>
> 2. The current implementation of the npm class uses multiple shellouts
> per npm module in order to add these to the npm cache. This is done, as
> the `npm install` command is not called within the do_fetch, but at the
> end of the do_configure step. This drastically increases the time
> Bitbake spends in the do_configure step for a npm based recipe. In our
> case (we have a relatively small project with approx. 600 npm packages
> in total, including recursive packages) this takes ~100 minutes to
> complete. What makes things worse, every change to the recipe and/or
> lock file will cause a complete rerun of the do_configure job.
>
> As a result, the npm fetcher currently is not really usable for
> production workloads.
>
>
> So how can we address these issues?
>
> We plan to implement a "sub-fetcher" for npmsw (a concept which might
> also be recyclable for similar use-cases). This would take the
> form of e.g.:
>
> SRC_URI =3D "npmsw+git://git-uri.git;npm-topdir=3Dpath_to_npm_project;...=
"
>
> The idea is, that the npsw fetcher would then call an arbitrary sub-
> fetcher (in this case git, however any fetcher will be supported) and
> after the sub-fetcher has extracted the source code into the DL_DIR,
> the npm fetcher will create a secondary download folder as a copy of
> the sub-fetchers download folder. Within this copy, the npm fetcher
> will call `npm ci`, effectively downloading the npm packages by doing a
> clean-install on the basis of the package.json and the package-
> lock.json files within the npmsw download dir. This results in a much
> faster build, as it removes the need for seperate handling of the
> individual node packages, as well as streamlining the developers
> workflow with the build process within Bitbake.
>
> As this fetcher would be implemented separately from the current npmsw
> fetcher, this will not cause any breaking changes for existing setups.
>
> Additionally, we plan on writing a separate npmsw.bbclass, which will
> parse the package.json for each node module for an automated Bitbake
> license manifest generation, which will resolve the current challenge
> of having to maintain these manually, as currently described at
>
> https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#npm=
-using-the-registry-modules-method
> .
>
> If this is something you see as a worthwhile goal, we will provide a
> set of patch files within the coming weeks.
>
> - --
> With best regards
>
> Jasper Orschulko
> DevOps Engineer
>
> Tel. +49 30 58 58 14 265
> Fax +49 30 58 58 14 999
> Jasper.Orschulko@iris-sensing.com
>
> =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=
=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=
=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2
>
> iris-GmbH
> infrared & intelligent sensors
> Schnellerstra=C3=9Fe 1-5 | 12439 Berlin
>
> https://iris-sensing.com/
>
>
>
>
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAEBCAAdFiEE4WyPMIC5Ap4+Ooo1Ygqew07VMNUFAmGD0jsACgkQYgqew07V
> MNVa1Qf+MwrlwXeS+FI8JrtHdTJ5CNJ64DkiTe0Tgqb7SQVkawXlm6KPezBYFIZb
> HmAruV8vpQpUHkyKXpwuH4X0A2CO3jJ9v20H3sdRfL+33gSCOY9+LDOADlRf1MhT
> fkV+OqwYufwG02ZnOpF3YRcTiDfG9UEzM+lzArOzhY6GjMp4FxvQZ/xLjEvdGVJ1
> l3h3NPmsedqsJnal022wkPi2gN2ZCQPyIw11EJL929wqwPHudvqj8OX2q1JhDUn5
> vjRpN2l4yg6g8bpF1If+5YkT/ZVjrZqcleL9pYPpVOuqk+j/iWbPSTmXjvzsrKDL
> 1UWqTBtRmWMYH+xkjKxD7Spjz1scRA=3D=3D
> =3DqjQA
> -----END PGP SIGNATURE-----
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12875):
> https://lists.openembedded.org/g/bitbake-devel/message/12875
> Mute This Topic: https://lists.openembedded.org/mt/86814331/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> alex.kanavin@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--0000000000001315f005cff63e4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Jasper,</div><div><br></div><div>I want to invi=
te Stefan to this discussion because he&#39;s been facing similar issues in=
 integrating npm code with Yocto. He&#39;s been working on some improvement=
s to npm fetcher and class, and is most qualified to comment, so maybe you =
guys can work out a plan to make it shine (or at least not be too horrible)=
.</div><div><br></div><div>To the best of my knowledge, no other companies =
at the moment are using Yocto to integrate npm-based items into a product.<=
br></div><div><br></div><div>Alex<br></div></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 4 Nov 2021 at 13:29, Jas=
per Orschulko &lt;<a href=3D"mailto:Jasper.Orschulko@iris-sensing.com">Jasp=
er.Orschulko@iris-sensing.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA256<br>
<br>
Dear Bitbake developers,<br>
<br>
recently we have been looking at the npmsw fetcher and discovered some<br>
challenges regarding the integration into the developer workflow as<br>
well as the build times within Bitbake. We believe that we found a<br>
mechanism which would integrate well into Bitbake&#39;s existing project<br=
>
structure and drastically improve the situation.<br>
<br>
<br>
But first, what are the issues with the current npmsw fetcher?<br>
<br>
1. Let&#39;s have a look at a typical npm-based project. You&#39;d typicall=
y<br>
have your package-lock.json (aka shrinkwrap file) stored within the git<br>
repository containing your source code. Developers will rely on this<br>
package-lock file on a daily basis during the development cycle.<br>
Unfortunately, the current npmsw fetcher only supports shrinkwrap files<br>
stored within the meta layer or within an npm registry. This is not<br>
ideal, as changes to the file might be made within the project repo,<br>
which then need to be manually applied to the lock file within the meta<br>
repo. An ideal npmsw fetcher therefore would support using the lock<br>
file directly from the source code repo. <br>
<br>
2. The current implementation of the npm class uses multiple shellouts<br>
per npm module in order to add these to the npm cache. This is done, as<br>
the `npm install` command is not called within the do_fetch, but at the<br>
end of the do_configure step. This drastically increases the time<br>
Bitbake spends in the do_configure step for a npm based recipe. In our<br>
case (we have a relatively small project with approx. 600 npm packages<br>
in total, including recursive packages) this takes ~100 minutes to<br>
complete. What makes things worse, every change to the recipe and/or<br>
lock file will cause a complete rerun of the do_configure job.<br>
<br>
As a result, the npm fetcher currently is not really usable for<br>
production workloads.<br>
<br>
<br>
So how can we address these issues?<br>
<br>
We plan to implement a &quot;sub-fetcher&quot; for npmsw (a concept which m=
ight<br>
also be recyclable for similar use-cases). This would take the<br>
form of e.g.:<br>
<br>
SRC_URI =3D &quot;npmsw+git://git-uri.git;npm-topdir=3Dpath_to_npm_project;=
...&quot;<br>
<br>
The idea is, that the npsw fetcher would then call an arbitrary sub-<br>
fetcher (in this case git, however any fetcher will be supported) and<br>
after the sub-fetcher has extracted the source code into the DL_DIR,<br>
the npm fetcher will create a secondary download folder as a copy of<br>
the sub-fetchers download folder. Within this copy, the npm fetcher<br>
will call `npm ci`, effectively downloading the npm packages by doing a<br>
clean-install on the basis of the package.json and the package-<br>
lock.json files within the npmsw download dir. This results in a much<br>
faster build, as it removes the need for seperate handling of the<br>
individual node packages, as well as streamlining the developers<br>
workflow with the build process within Bitbake.<br>
<br>
As this fetcher would be implemented separately from the current npmsw<br>
fetcher, this will not cause any breaking changes for existing setups.<br>
<br>
Additionally, we plan on writing a separate npmsw.bbclass, which will<br>
parse the package.json for each node module for an automated Bitbake<br>
license manifest generation, which will resolve the current challenge<br>
of having to maintain these manually, as currently described at<br>
<a href=3D"https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual=
.html#npm-using-the-registry-modules-method" rel=3D"noreferrer" target=3D"_=
blank">https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.htm=
l#npm-using-the-registry-modules-method</a><br>
.<br>
<br>
If this is something you see as a worthwhile goal, we will provide a<br>
set of patch files within the coming weeks.<br>
<br>
- -- <br>
With best regards<br>
<br>
Jasper Orschulko<br>
DevOps Engineer<br>
<br>
Tel. +49 30 58 58 14 265<br>
Fax +49 30 58 58 14 999<br>
<a href=3D"mailto:Jasper.Orschulko@iris-sensing.com" target=3D"_blank">Jasp=
er.Orschulko@iris-sensing.com</a><br>
<br>
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=
=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=
=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2 =
=E2=80=A2 =E2=80=A2 =E2=80=A2 =E2=80=A2<br>
<br>
iris-GmbH<br>
infrared &amp; intelligent sensors<br>
Schnellerstra=C3=9Fe 1-5 | 12439 Berlin<br>
<br>
<a href=3D"https://iris-sensing.com/" rel=3D"noreferrer" target=3D"_blank">=
https://iris-sensing.com/</a><br>
<br>
<br>
<br>
<br>
-----BEGIN PGP SIGNATURE-----<br>
<br>
iQEzBAEBCAAdFiEE4WyPMIC5Ap4+Ooo1Ygqew07VMNUFAmGD0jsACgkQYgqew07V<br>
MNVa1Qf+MwrlwXeS+FI8JrtHdTJ5CNJ64DkiTe0Tgqb7SQVkawXlm6KPezBYFIZb<br>
HmAruV8vpQpUHkyKXpwuH4X0A2CO3jJ9v20H3sdRfL+33gSCOY9+LDOADlRf1MhT<br>
fkV+OqwYufwG02ZnOpF3YRcTiDfG9UEzM+lzArOzhY6GjMp4FxvQZ/xLjEvdGVJ1<br>
l3h3NPmsedqsJnal022wkPi2gN2ZCQPyIw11EJL929wqwPHudvqj8OX2q1JhDUn5<br>
vjRpN2l4yg6g8bpF1If+5YkT/ZVjrZqcleL9pYPpVOuqk+j/iWbPSTmXjvzsrKDL<br>
1UWqTBtRmWMYH+xkjKxD7Spjz1scRA=3D=3D<br>
=3DqjQA<br>
-----END PGP SIGNATURE-----<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12875): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12875" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12875</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86814331/1686=
489" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86814331/1686489</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:alex.kanavin@gmail.com" target=3D"=
_blank">alex.kanavin@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000001315f005cff63e4c--

