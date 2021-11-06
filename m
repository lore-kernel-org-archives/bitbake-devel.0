Return-Path: <mac@mcrowe.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76747C433EF
	for <webhook@archiver.kernel.org>; Sat,  6 Nov 2021 16:58:38 +0000 (UTC)
Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net
 [212.159.14.18])
 by mx.groups.io with SMTP id smtpd.web12.21246.1636217914083866187
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Nov 2021 09:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mcrowe.com header.s=20191005 header.b=AseNTdiw;
 spf=pass (domain: mcrowe.com, ip: 212.159.14.18, mailfrom: mac@mcrowe.com)
Received: from deneb.mcrowe.com ([80.229.24.9])
	by smtp with ESMTP
	id jP1Rm5soUfv01jP1SmF2Vq; Sat, 06 Nov 2021 16:58:32 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Opwsdwzt c=1 sm=1 tr=0 ts=6186b438
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=iGHA9ds3AAAA:8 a=KBDoviU24F2BO3hyrfMA:9
 a=CjuIK1q_8ugA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mcrowe.com;
	s=20191005; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:CC:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=iABf7eDJ1dcYFBvmHCAf9ypljqrvGQt0gtzWkwOH0LA=; b=AseNT
	diw8PyzcOnERr3s7hq1R53Ktb/wpH6LoGQSmLFiTC2/3zNVn7FfN7ygWKtbJjhOSqyoIlSNjgQfb/
	8QHZl2Zj1icfkDXZzmwDRRcksoemq/ruNl0fGiCJ7Y87gK1VLi6xgqWGrCUpXYdC9HRsoJcSI1K4G
	PnH0zTbyP1p/z4ZOIEZ8DUvG7jfVD/skelgHcS4k2Bgm8uRAAcBaKKzDtfAUtM6ddhidkkKFURizl
	+44y4AEhP7gc7zlkqWaunOXFtm/g/ml4HWuaWEHO3ykFhEsPPW5dfOP2hyC1bZAiLfa1ss07Hlnn0
	Bg7FLFkieUEFvooX5HoV8JfVgjqUg==;
Received: from mac by deneb.mcrowe.com with local (Exim 4.94.2)
	(envelope-from <mac@mcrowe.com>)
	id 1mjP1R-004Vws-Bd; Sat, 06 Nov 2021 16:58:29 +0000
Date: Sat, 6 Nov 2021 16:58:29 +0000
From: Mike Crowe <mac@mcrowe.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>,
	Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>,
	"bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
	"martin@mko.dev" <martin@mko.dev>,
	Caner Altinbasak <cal@brightsign.biz>,
	Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
Message-ID: <YYa0NeCHOjBXYsxA@mcrowe.com>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <CANNYZj_0U_Yk4TPVxS4hQ5zdeSvZ1LZkFQ+8fv8-x9ieZ4AH7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: 
 <CANNYZj_0U_Yk4TPVxS4hQ5zdeSvZ1LZkFQ+8fv8-x9ieZ4AH7g@mail.gmail.com>
X-CMAE-Envelope: 
 MS4xfHiqzZFb+NJ0oboxjaDZecLYD8PNmSDMeBvkoUUXHMb4Sn2bwl+20HPpgaJXAAjU1eQnt52OErY7+X4FkfL9jRBSJwH/FU/YIj8xHDAG4+7PPtSXG8iG
 jfDwgeA4hWpMHq9/rDPWJUheqdn40x+MvljxafDhWTqLcezmi1EvVosFLxI+MOJXQAwa1TIcvhOi7bgAi7GIqDjameukUrfKz8o=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Nov 2021 16:58:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12925

On Thursday 04 November 2021 at 14:09:42 +0100, Alexander Kanavin wrote:
> To the best of my knowledge, no other companies at the moment are using
> Yocto to integrate npm-based items into a product.

We make light use of npm in the production of the rootfs for our products.
The upgrade to Dunfell was a bit painful, and the slowness is annoying too,
but I think that we've ended up with things being better in the end because
we can now be sure that all the sources are captured correctly.

We did run into a few bugs and some of our fixes for those have landed. The
npm fetcher seems to be fighting with the usual way that Bitbake expects
fetchers to work that I don't really understand enough (from either side)
to know how to fix. (e.g.
https://bugzilla.yoctoproject.org/show_bug.cgi?id=14383 which doesn't
directly affect us, but the underlying cause meant that our usual method
for capture sources needed some extra workarounds.)

Mike.

