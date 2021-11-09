Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F0C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 15:47:16 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web09.13855.1636472836190131097
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 07:47:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=F8e6BwXb;
 spf=pass (domain: gmail.com, ip: 209.85.215.171,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id f5so18831264pgc.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 07:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WGiOO022AWH7xDbv+AFZ/TTgh1LKYYN63I4R+0e8qw=;
        b=F8e6BwXbV1Nmymy5S7lfJUvCKNVaRy2Ev5GXhQjNU2DSX4RAF7/rHki953hf1cW99G
         W5QlhdRUnLqiM9S2/2/+aGkQ4iCYMb9I8p8SFmB0gbSJ+z1UbO/Zu8B5Inej+ygjVi2S
         F2R9OzHEVBoJFVZXmOn3lP1n59+dQtO9kSTqpzb8e2mxYbpkKN0okGrx9YSqOrTd9xkg
         EdW1RE2F7s6QihEPN7qVBxIcBMsTTsFpjnQFYzaIuXl9u/xEhlm+u1IgC8Ez5cCNQeBF
         8AgE/fAdEo3zJdBIVTeKvot5ZN7BX/0Y8IJePVXqeXM9F6EgIaqpP7a+8JC8tR4WLX8/
         MIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WGiOO022AWH7xDbv+AFZ/TTgh1LKYYN63I4R+0e8qw=;
        b=wV9SXUJrofmpcBFZQYkebNvPDiPcHcqRvlkmLDCOBRCgtd8E83xSB+6bcgPtB+1gcB
         /xjS6aOVVgXvUO9wEfQRVAebJn9WVTdpz0M+bFGwvxIuFUSExORwVLflcasklwFFukbc
         WAc3GOFh9Va+LKTinUAZ4DtAAu8JrOQxZC4unzp8xcgq1zfWT4S3jj5BtrICyHHCNeQ+
         qjssNstgD97B3uWTFBgND1UmKdEK9DV+Sjy1cqdADZzkIP5rEAYP+0zFyh9K7ICTQG1R
         AxQchVbYqQKVzplAYk7ItZVpH0TNGMgOHccH3SQ/3h9UMm4WeTXh/yWvaI8CdZGkgprg
         aaqw==
X-Gm-Message-State: AOAM532A4InlZW3cK8/oy4jYTISD/AJnd2bn/YgyHOqVhh1okO1PjTp5
	arYR5XR/mkInv6ualwFZXsk9Z8GR6N2jBVk72TFfPY8yHcw=
X-Google-Smtp-Source: 
 ABdhPJxIU+CVZBib5XsRnRYyhZTwEI4trG3ZbiyV6kGHCiextEdxjNuOkb77UrdN4OjHXp+udgx+sw7pT6k+9EBAWBA=
X-Received: by 2002:a63:f20f:: with SMTP id v15mr6684862pgh.100.1636472835759;
 Tue, 09 Nov 2021 07:47:15 -0800 (PST)
MIME-Version: 1.0
References: 
 <6a5db3389ed956233ca71f9b72b2fc051386ac34.camel@linuxfoundation.org>
 <450.1636472426380500781@lists.openembedded.org>
In-Reply-To: <450.1636472426380500781@lists.openembedded.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 9 Nov 2021 16:47:04 +0100
Message-ID: 
 <CA+chaQc1n4sZDrNvBN5HGebqWLKLSXFr2w9xDEKhQMEfg_dOrQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] fetch/git: Handle github dropping
 git:// support
To: gabriel.valcazar@digi.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000000f64bb05d05d0612"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 15:47:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12984

--0000000000000f64bb05d05d0612
Content-Type: text/plain; charset="UTF-8"

FWIW: It was already backported all the way to 1.40 version used in Yocto
2.6 Thud:
https://git.openembedded.org/bitbake/log/?h=1.40

All the way till 1.16 version used in Yocto 1.3 Danny, is still quite long.
Maybe you can backport the bitbake patch on your end? I would be surprised
if you don't have bunch of various other changes backported just to keep
these ancient builds going _and_ reliable PREMIRROR to never access
upstream repos from 2012.

On Tue, Nov 9, 2021 at 4:40 PM gabriel.valcazar via lists.openembedded.org
<gabriel.valcazar=digi.com@lists.openembedded.org> wrote:

> Hi Richard,
>
> Are there any plans to backport this fix to older versions of
> bitbake/poky? My company has a line of legacy embedded products that are
> only supported in older versions of our Yocto distribution (1.3 in the most
> extreme case), and although we can manually change the protocol from git to
> https in the recipes in our layer, we can't do the same for other third
> party layers our distribution depends on (meta-qt5, meta-freescale,
> poky...). Since backporting the fix to older bitbake versions is trivial,
> do you intend to incorporate it in older bibake/poky versions in the near
> future?
>
> Otherwise, are there any alternative approaches we can take to ensure that
> users that depend on our legacy products can continue to build our Yocto
> distribution? Upgrading our entire legacy line to newer Yocto versions is
> not a viable solution for us.
>
> Thanks and best regards,
> Gabriel
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12982):
> https://lists.openembedded.org/g/bitbake-devel/message/12982
> Mute This Topic: https://lists.openembedded.org/mt/86764631/3617156
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> Martin.Jansa@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>

--0000000000000f64bb05d05d0612
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">FWIW: It was already backported all the way to 1.40 versio=
n used in Yocto 2.6 Thud:<div><a href=3D"https://git.openembedded.org/bitba=
ke/log/?h=3D1.40">https://git.openembedded.org/bitbake/log/?h=3D1.40</a></d=
iv><div><br></div><div>All the way till 1.16 version used in Yocto 1.3 Dann=
y, is still quite long. Maybe you can backport the bitbake patch on your en=
d? I would be surprised if you don&#39;t have bunch of various other change=
s backported just to keep these ancient builds going _and_ reliable PREMIRR=
OR to never access upstream repos from 2012.</div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 9, 2021 at 4:=
40 PM gabriel.valcazar via <a href=3D"http://lists.openembedded.org">lists.=
openembedded.org</a> &lt;gabriel.valcazar=3D<a href=3D"mailto:digi.com@list=
s.openembedded.org">digi.com@lists.openembedded.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Richard,<br><br>Are t=
here any plans to backport this fix to older versions of bitbake/poky? My c=
ompany has a line of legacy embedded products that are only supported in ol=
der versions of our Yocto distribution (1.3 in the most extreme case), and =
although we can manually change the protocol from git to https in the recip=
es in our layer, we can&#39;t do the same for other third party layers our =
distribution depends on (meta-qt5, meta-freescale, poky...). Since backport=
ing the fix to older bitbake versions is trivial, do you intend to incorpor=
ate it in older bibake/poky versions in the near future?<br><br>Otherwise, =
are there any alternative approaches we can take to ensure that users that =
depend on our legacy products can continue to build our Yocto distribution?=
 Upgrading our entire legacy line to newer Yocto versions is not a viable s=
olution for us.<br><br>Thanks and best regards,<br>Gabriel
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#12982): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/12982" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/12982</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/86764631/3617=
156" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/86764631/3617156</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"=
_blank">Martin.Jansa@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--0000000000000f64bb05d05d0612--

