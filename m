Return-Path: <alberto@pianon.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE0FC77B61
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 05:19:10 +0000 (UTC)
Received: from server3.justice4all.it (server3.justice4all.it [95.217.19.36])
 by mx.groups.io with SMTP id smtpd.web11.13532.1682572742951530306
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Apr 2023 22:19:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@pianon.eu header.s=mail20151219 header.b=qjQGW8Kz;
 spf=pass (domain: pianon.eu, ip: 95.217.19.36, mailfrom: alberto@pianon.eu)
Received: from localhost (localhost [127.0.0.1])
	by server3.justice4all.it (Postfix) with ESMTP id 914585C0096;
	Thu, 27 Apr 2023 07:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pianon.eu; h=
	message-id:references:in-reply-to:subject:subject:from:from:date
	:date:content-transfer-encoding:content-type:content-type
	:mime-version; s=mail20151219; t=1682572740; x=1684387141; bh=dZ
	JGLtW7Dhd5AlcjAq+OM53U3vXBfUQvS//wbUG89Uc=; b=qjQGW8Kze2iM35ITVy
	TtwBSLaFv5e8vDZdeX/ew1XDCn8xIBNzlFqTz17WugAajbvTaKU0d205ZRee9953
	TPidkaMuMIRhiVHUf4rxLl9ZT7TucGjVTVe39OViTPpqGJIwfXL9a6Dt4sPwkNzS
	zCworC6jFxzi2XIg9jX4E7OPM=
X-Virus-Scanned: Debian amavisd-new at server3.justice4all.it
Received: from server3.justice4all.it ([127.0.0.1])
	by localhost (server3.justice4all.it [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id InkKOrkcGrGk; Thu, 27 Apr 2023 07:19:00 +0200 (CEST)
Received: from pianon.eu (localhost [127.0.0.1])
	(Authenticated sender: alberto@pianon.eu)
	by server3.justice4all.it (Postfix) with ESMTPA id 1556A5C0095;
	Thu, 27 Apr 2023 07:19:00 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Apr 2023 07:18:59 +0200
From: Alberto Pianon <alberto@pianon.eu>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel@lists.openembedded.org,
 richard.purdie@linuxfoundation.org, jpewhacker@gmail.com, carlo@piana.eu
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
In-Reply-To: <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu>
References: <20230420062113.134546-1-alberto@pianon.eu>
 <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu>
Message-ID: <afcd01000f265238360efcdaecd16a4e@pianon.eu>
X-Sender: alberto@pianon.eu
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 05:19:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14749

Il 2023-04-27 07:14 Alberto Pianon ha scritto:
> Could you please check if this is really the case in your case?
> You'd need to go to meta/recipes-sato/matchbox-panel-2/files
> (check where the layer is located in your filesystem) and do

Of course it is located at 
/mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.patch

:)

Please check also the other two files for which you get the warnings

thanks!

Alberto

