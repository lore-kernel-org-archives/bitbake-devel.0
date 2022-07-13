Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6589BC43334
	for <webhook@archiver.kernel.org>; Wed, 13 Jul 2022 12:28:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.21295.1657715284725142139
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Jul 2022 05:28:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HfXyjryl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id
 p27-20020a05600c1d9b00b003a2f36054d0so1080798wms.4
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Jul 2022 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=c2/TixGjzIkSERGoFSEHDbZtUdOJPkpLeYAcwSAoelc=;
        b=HfXyjrylBB9x+ouxDxft6BiwvC0PcKk3eEJhZIzDmNjLG/bsXkp9s932qR5yCtsPE+
         EdOC0O6ehrwRfqU6Le3U7fwkZ+KMkQiN6bvVkFFRUpPNs7puydpYyscu6SxCkrZfIu+p
         yvWfWmyXv8O05EkLBA3gxGaz/IsjYRf50fqD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=c2/TixGjzIkSERGoFSEHDbZtUdOJPkpLeYAcwSAoelc=;
        b=LRgYXDK9XW9WewwnVpCFBbexdYIzH3EXOAkTWH5auL8d5pGrA12fik0M5YU837LNQW
         2xM7igJwjO1b/x67OVyBdnCbUY74khSpY/2ws3l2PHgjgm6gmAFO9j4Ud1fhNz2jGqHT
         1aX2s6FYTNPNV2DX9BIOkfdtHU404ooY1wNmKULOWaIbwhy4rjD9KhCkpF8NeFK7mXip
         ypX1y6TeKwvJ4OMB8NowR5Bmh61XRE8YTYLLUDA7b+BYkqbyl/02XaGK1A4KKa3hqAFO
         ARKgs2tV+7N8aHi+te6Z90IVMJQFE3MuMLwClhj1gp4a9Pp1p7CP3vjub5xb3ZnGqo3F
         DtSw==
X-Gm-Message-State: AJIora9AmI6x/1Am9xtdSXys41NpnGB936G5dys2mxZQjCAyXL+MZ1Dz
	/jm3ofNsDbT/AM26YkJKqzBP/A==
X-Google-Smtp-Source: 
 AGRyM1v15GgG+V2i2auJ3w2/IejqoW/VNJTwtvaxGTw2YTvMIaLXvGRBA00ZEwihUfw2v/IvqR+u/w==
X-Received: by 2002:a7b:c2b1:0:b0:3a2:e07b:827f with SMTP id
 c17-20020a7bc2b1000000b003a2e07b827fmr9831052wmk.44.1657715282948;
        Wed, 13 Jul 2022 05:28:02 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:5d1c:2bb3:e975:b527?
 ([2001:8b0:aba:5f3c:5d1c:2bb3:e975:b527])
        by smtp.gmail.com with ESMTPSA id
 f2-20020a1cc902000000b003a2e655f2e6sm2021861wmb.21.2022.07.13.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 05:28:02 -0700 (PDT)
Message-ID: 
 <dadf2f1f1d4af8d5a700a34998d20ac212e6f317.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] fetch: bb.fatal when trying to
 checksum non-existing files.
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <ptsneves@gmail.com>, Alexandre Belloni
	 <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Jul 2022 13:28:01 +0100
In-Reply-To: <4c6a0dd9-641d-9331-ff3a-1ca6d02f4dd8@gmail.com>
References: <20220708205407.1680137-1-ptsneves@gmail.com>
	 <20220708205407.1680137-2-ptsneves@gmail.com> <Ys6U7V+xOe7/2Pso@mail.local>
	 <4c6a0dd9-641d-9331-ff3a-1ca6d02f4dd8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Jul 2022 12:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13824

On Wed, 2022-07-13 at 12:10 +0200, Paulo Neves wrote:
> Hello,
>=20
> Well this illustrates the kind of issue I wanted to catch, but this=20
> test's condition will now not be reachable at all.
> Previously, the checksum failed with only a warning, while the failure=
=20
> occurred in the download stage of the local fetcher.
> Now as the checksum fails and it is immediately fatal there is no way to=
=20
> reach a download state at all.
>=20
> Should this test be removed, then? In my patch i added the appropriate=
=20
> test and it is in the bitbake self test which does not depend on poky or=
=20
> openembedded core. Let me know what you think.

The test makes sense, we probably just need to remove the       =20
bitbake('-ccleanall man-db') lines since the issue changed from runtime
to parsing.

Cheers,

Richard

