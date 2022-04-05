Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E827C35276
	for <webhook@archiver.kernel.org>; Tue,  5 Apr 2022 17:24:47 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.5957.1649164752424637861
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Apr 2022 06:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=CaQ0sy9Z;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194,
 mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 2D2534001A;
	Tue,  5 Apr 2022 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1649164750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fpjJS0ZkwWfI03+0KT6xIyBgtNnWDNpRFtaXzcDuylI=;
	b=CaQ0sy9Zv2Ql87caZztvSXt7qKV+sgRBt7UkYqDDciUV2GTyu8xHqHyAgPPAxmk61PYPp2
	wQKqrHKhQpaTqSE2Gzu6ZImjuRo/sc6I41PypLDBfZRytVx+xrDNRJU+Ch1bIEJB3WmngI
	6bqLGrQx4u0hNzq+0C3D6z2E6KTsV9kiQA6ysgfiJuiu8109Xv9JmqETsKNYd1WX7f8zjG
	Pv7mm7a5PKBbP7Dh/64HoBaNXKmIelYODc6MxuiPDmSe0L+LCxz2tAl5BAJHx60aAuqQeN
	CNGPRp8OxBkj5rroElomjY8k0GZ+D0nRqZM4g7BKm9U72nWU1XRbC0HuniQNEw==
Date: Tue, 5 Apr 2022 15:19:09 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Olaf Mandel <o.mandel@menlosystems.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>,
	Marek Vasut <marex@denx.de>
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/git: stop generated tarballs
 from leaking info
Message-ID: <YkxBza0yKOaAelwr@mail.local>
References: <20220324164759.4097867-1-o.mandel@menlosystems.com>
 <20220328173618.960965-1-o.mandel@menlosystems.com>
 <e5d525bf-e18a-6129-8d62-c3e33ec4b218@menlosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d525bf-e18a-6129-8d62-c3e33ec4b218@menlosystems.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Apr 2022 17:24:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13580

Hello,

On 05/04/2022 13:38:41+0200, Olaf Mandel wrote:
> Hello,
> 
> Am 28.03.2022 um 19:36 schrieb Olaf Mandel:
> > When using BB_GENERATE_MIRROR_TARBALLS="1" to generate mirror tarballs
> > of git repositories, they leaked local information: username, group and
> > time of the last fetch. Remove all these by setting fixed information:
> > 
> >   * uname = pokybuild (6000)
> >   * gname = users (100)
> 
> it was pointed out to me by Marek that instead of using pokybuild:users,
> which seems to be an artifact of the YP autobuilder, I should use the
> "canonical" combination oe:oe. But that raises the question: which numerical
> IDs should I use then?
> 

Note that patch has already been applied so you'd have to send a patch
on top of master.

> Best regards,
> Olaf Mandel




> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13579): https://lists.openembedded.org/g/bitbake-devel/message/13579
> Mute This Topic: https://lists.openembedded.org/mt/90090609/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

