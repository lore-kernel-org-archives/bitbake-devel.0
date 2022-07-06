Return-Path: <t-maiaxiao@linux.microsoft.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0561C433EF
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 20:14:13 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web12.1999.1657138447360153060
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 13:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=f/DUtaPd;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182,
 mailfrom: t-maiaxiao@linux.microsoft.com)
Received: by linux.microsoft.com (Postfix, from userid 1143)
	id A1FAF20DDCB4; Wed,  6 Jul 2022 13:14:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1FAF20DDCB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1657138446;
	bh=YJQ7CcVhrB12zxRpjkgoWhYonhM0W7SbvwiAaFfL2BA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=f/DUtaPdWvDchw3n3SaWMfSE0n1+cZv9LqUeUZjoCq7gN0p3L9gKUtkqo8yvUmIeB
	 x7AYmPCcZRX3w/yBnchRU4ThxXOZawZPFqax6GQmwVbI+jSppROWIJ7Gvq6TSuf3cA
	 TO9K3CvuPUWgSmlhy+Zob3536foOkqe5xSx2vWXM=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id A02053070335;
	Wed,  6 Jul 2022 13:14:06 -0700 (PDT)
Date: Wed, 6 Jul 2022 13:14:06 -0700 (PDT)
From: Maia Xiao <t-maiaxiao@linux.microsoft.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
In-Reply-To: 
 <970e2ed4c836e291aa9845849c0d3d86b57f849c.camel@linuxfoundation.org>
Message-ID: <d6f373c-eb88-e765-7973-9d4af6de40ee@linux.microsoft.com>
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
  <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
  <CADkTA4P_9hfBFO1Pbj+cMpiaBQPL3xaCOPgnRYnO=tyKVS0n-g@mail.gmail.com>
 <970e2ed4c836e291aa9845849c0d3d86b57f849c.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 20:14:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13806

>> Actually never mind on this first point, assuming that this isn't run on
>> all fetch paths (I didn't check that).
>>
>> But my second comment about the depth is something to consider.
>
> Yes, I'm also remembering comments someone made to me recently that
> many git servers don't support limited depth clones because of the load
> they put on the server.
>
> I appreciate this was moved to a newcomer bug as I think we assumed
> there was a straightforward way to remotely ask "is revision X in the
> repo" but it is looking like that might not be that easy :(

Going off what Bruce said, a potentially "softer" way to do this is to
keep self._lsremote(..) as the True condition, but we additionally try
to fetch the specified srcrev and just log a warning if that didn't
work.

If we feel reluctant about the additional fetch, another thing that we
could still do is to log a warning if the srcrev isn't a tag / at the
top of some branch (i.e., not in the ls-remote). I'm not sure if it is
(un)common enough for that check to make sense, though.

Happy to offer a v2 patch if there is interest in either. Thanks for the
discussion, folks!

~maia


