Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B0AC71153
	for <webhook@archiver.kernel.org>; Tue, 29 Aug 2023 14:39:00 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.19109.1693319937044031406
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Aug 2023 07:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=DP2ArBq0;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FFBE2000B;
	Tue, 29 Aug 2023 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1693319935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBAoMdY/QCCaZ7ElvWH1GTor+U6CBu1rWPo+TcI2qDg=;
	b=DP2ArBq0Q558MjA1YFC+hRgUI9JeYmiGt3g3uZ3j257i4CwDl80//SfRKWely5QtvUnl6d
	Qx/nkQNRGjNJ3NiqYs/10tPxBP2cmGM6SwksYaFpu5VKmMQscF1PJDTIomUtU4i+quwuCX
	IGI4+vnbZaNoHwKTO8xuuZcpLcyOiWJYze4TDZH+M8muwY9WJ4AYB8FSHIJ38J9QdOIpGz
	2cgPQKlhlxZW2U00bGXFGruamRsgMCbiQQ7A1WiN59bbSrNiONur1OPweawEUY95mR9cld
	nrqlPSqwt603XtqWV59iSL2qyPExQlVtZOsGamof1j+NehBSQqLHA0lfCCneoA==
Date: Tue, 29 Aug 2023 16:38:54 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: david.reyna@windriver.com
Cc: bitbake-devel@lists.openembedded.org,
	Kieran McNulty <Kieran.McNulty@windriver.com>
Subject: Re: [bitbake-devel] [PATCH 0/3] toaster_cummulative_08282023
Message-ID: <20230829143854845af1cb@mail.local>
References: <cover.1693212183.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693212183.git.david.reyna@windriver.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Aug 2023 14:39:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14989

Hello David,

Please set you git configuration so your patches include a From: line,
see https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded#Fixing_your_From_identity

On 28/08/2023 01:45:17-0700, Reyna, David via lists.openembedded.org wrote:
> toaster_cummulative_08282023
> 
> The following changes since commit c8e9590a376c0b63e38167dc522fac4cfbecb5d4:
> 
>   bitbake: Fix disk space monitoring on cephfs (2023-08-25 07:55:34 +0100)
> 
> are available in the Git repository at:
> 
>   ssh://git@push.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_08282023
> 
> David Reyna (3):
>   toaster: Update to Django 4.2
>   toaster: import only used layers
>   toaster: accommodate missing 'Image Name' value in buildinfohelper
> 
>  lib/bb/ui/buildinfohelper.py                  | 13 ++++++++-
>  lib/toaster/bldcollector/urls.py              |  2 +-
>  lib/toaster/bldcontrol/models.py              |  4 +--
>  lib/toaster/orm/models.py                     | 28 +++++++++----------
>  lib/toaster/toastergui/urls.py                |  2 +-
>  lib/toaster/toastergui/views.py               |  6 ++--
>  lib/toaster/toastergui/widgets.py             |  5 ++--
>  .../management/commands/buildimport.py        |  2 +-
>  .../management/commands/checksocket.py        |  4 +--
>  lib/toaster/toastermain/urls.py               |  2 +-
>  toaster-requirements.txt                      |  2 +-
>  11 files changed, 41 insertions(+), 29 deletions(-)
> 
> -- 
> 2.20.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14985): https://lists.openembedded.org/g/bitbake-devel/message/14985
> Mute This Topic: https://lists.openembedded.org/mt/101006437/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

