Return-Path: <Markus.Niebel@ew.tq-group.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236CC197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 13:01:59 +0000 (UTC)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 by mx.groups.io with SMTP id smtpd.web11.49624.1700485311196648686
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 05:01:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tq-group.com header.s=key1 header.b=Q1h8Lnxo;
 spf=pass (domain: ew.tq-group.com, ip: 93.104.207.81, mailfrom: markus.niebel@ew.tq-group.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1700485311; x=1732021311;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L1Li9GyUWZId7xQuKakGK+VBT5xrVGRdAZQHQizWRWU=;
  b=Q1h8LnxoiAt1tVa9hPz6xMVs6j23foU5aTZ+axCYuTTnz725dPFR6bhr
   gD2/8sEto0t7fwYUKuEvjcV8G0g3KWDtJv60XbBKMsAIvoiejbPDKhzyx
   wT3GQ25OCto+VFNcXivf42Ss/UlqNscuqDIErsHKZtTBEF0qFn5Y4NW/+
   /tiF/N28V6h/p3VHjQj3GCeNbQ4j7qVi5ralYuDRUGX/xkw8EyhGDDFa6
   CLnVqdenOv2EYjJhec1Rr/mBpk2CYJqzkNuVg8AUZgTOs0mZl5B2Mt8Q2
   Z4ioN3HZM1B8cwqQDiX8CBng4TUxx5shWKfsQM/jnX89ZJhGa10ALfd3t
   g==;
X-IronPort-AV: E=Sophos;i="6.04,213,1695679200"; 
   d="scan'208";a="34072506"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Nov 2023 14:01:48 +0100
Received: from NIEBEL-W3.tq-net.de (NIEBEL-W3.tq-net.de [10.123.53.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0352928007F;
	Mon, 20 Nov 2023 14:01:47 +0100 (CET)
Message-ID: <70e7245a5f6b37f9045027f90c665c244a28a234.camel@ew.tq-group.com>
Subject: Re: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline"
 builds?
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Christian Eggers <ceggers@arri.de>, Alexander Kanavin
	 <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Nov 2023 14:01:47 +0100
In-Reply-To: <2250070.iZASKD2KPV@n95hx1g2>
References: <4851356.GXAFRqVoOG@n95hx1g2>
	 <CANNYZj-cc2wDXUODqveROB6Hdpr0CnHoNLt49Nywfcpgs_19xA@mail.gmail.com>
	 <2250070.iZASKD2KPV@n95hx1g2>
Organization: TQ Systems GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 13:01:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15536

Am Montag, dem 20.11.2023 um 13:19 +0100 schrieb Christian Eggers:
>  
> Hi Alex,
> 
> On Monday, 20 November 2023, 12:05:28 CET, Alexander Kanavin wrote:
> 
> > On Mon, 20 Nov 2023 at 11:59, Christian Eggers <ceggers@arri.de>
> wrote:
> > 
> > > When having NPM based application in my SDK (e.g. quicktype [1],
> recipe is
> > > attached), the "fetch" tasks perform a full build of nodejs
> before starting
> > > the actual download of the quicktype sources. But building nodejs
> (and its
> > > dependencies) during the "fetch" stage, compromises my wish to
> perform the
> > > actual build in an offline environment.
> > >
> > 
> > I'm not sure I understand what is being compromised here. If you
> want an
> > offline build, throw away the sstate cache that was created in the
> fetching
> > step, and nodejs will be again rebuilt together with everything
> else.
> 
> my intend is to run as few build scripts as possible as long as the
> build
> machine has access to the internet. For security reasons I would like
> to divide
> the build into two stages, one stage for downloading (with internet
> access enabled)
> and one stage for compiling (without internet access).
> 
> While I highly trust the OpenEmbedded/Yocto projects, I fear that
> single upstream
> projects may become targets for supply chain attacks in the future.
> Running
> the package Makefiles/scripts etc. on a machine (e.g. docker) without
> network
> access reduces the possibility for manipulated packages to retrieve
> internal
> secrets and upload them to the internet.
> 
> Are there any other use cases why people want to perform an "offline"
> build?
> 

At least offline builds are useful for release builds to make sure no
recipe tries to bypass the normal fetch logic. We saw this several
times in the past with silicon vendor stuff - recipes tried to fetch
things during configuration or as part of compilation.

Another thing I can imagine are builds against an internal PREMIRROR
for several reasons.

regards
Markus

> regards,
> Christian
> 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/


