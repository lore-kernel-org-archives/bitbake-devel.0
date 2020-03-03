Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
	[209.85.221.68])
	by mail.openembedded.org (Postfix) with ESMTP id 204DA6025D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Mar 2020 08:24:00 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id h9so2191156wrr.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Mar 2020 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=2YdWRRl2hj//o6sGgc+0WCjz/4p321Z6PQX6Ui0Ukr0=;
	b=On4ha0dY3dskHYeJs+sBfZVfdp0X9/oEFuDHn36Ndol3lPJfNz+NnFH6sCH4ybuu3R
	sWAGgGfN1xE1iIDQZ5/rR2EIIdYK4lnVtvgF464Y0vRxQKme1ggprsId3XhFsvB2H1Z6
	VENU82pJnrPcAKtBNxgwAFHjquvkrHD3UXr0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=2YdWRRl2hj//o6sGgc+0WCjz/4p321Z6PQX6Ui0Ukr0=;
	b=C4Q9uL2P+NY3U/iUOg551ZziXskyxLakqR1ID1bGQ9b+kCt7grxBxLCk84StrbBm3V
	GjUAtVNyDaV4f7gJG/ZVzF2zeC8qqR3ZLtFfu226hrWzGqi/8eRS+ILZQRoYlW9K0blK
	TqCzwB346xUu3s/8iV6MAV5lrlztQtfKWviuxKBWpWGMzRkA1b2jOoxeyBQ5GNyiUDZ0
	mjv5/9GeRsWMcR2qEEcp01y6ApnYn0Y/b+pAuEI21GWiQTw3Wfxl5Wwiqgp2khrday1X
	4RONeWUtSwelENiKTinjq2cCkxHotwcpTG8kISjQtYu5xvK53jWh5lSUmHm+djp6s2gg
	QCag==
X-Gm-Message-State: ANhLgQ01cQlHYyo2Oh1bP5Q/CgyOK5V3I7pllHiXZzfIZ1N8CnmFPlYs
	6vwCbQ3Z/xfeowsRdDDfJj6qtA==
X-Google-Smtp-Source: ADFU+vvXVS3awerMN591YPYF2Xujmryi3JWHsI71CeQ0E4IxVezv2uTFTjWY/ozZga0dIYza3jTO8A==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr4322707wrr.352.1583223841463; 
	Tue, 03 Mar 2020 00:24:01 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p17sm29899260wre.89.2020.03.03.00.24.00
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 03 Mar 2020 00:24:00 -0800 (PST)
Message-ID: <777e3d343a1a29738dec59a3984ae63d6f7b296b.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Tanu Kaskinen <tanuk@iki.fi>, bitbake-devel@lists.openembedded.org
Date: Tue, 03 Mar 2020 08:23:59 +0000
In-Reply-To: <736799570e22f93fdea25f2fb0ecb129dacd5760.camel@iki.fi>
References: <20200229161633.496077-1-richard.purdie@linuxfoundation.org>
	<736799570e22f93fdea25f2fb0ecb129dacd5760.camel@iki.fi>
User-Agent: Evolution 3.35.91-1 
MIME-Version: 1.0
Subject: Re: [PATCH] fetch2: Limit shown checksums to sha256
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 03 Mar 2020 08:24:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-03-03 at 09:56 +0200, Tanu Kaskinen wrote:
> On Sat, 2020-02-29 at 16:16 +0000, Richard Purdie wrote:
> > Currently bitbake will list many checksums for a recipe when none
> > are
> > present, encouraging users to add them all to a recipe. We don't
> > need/want them all.
> > 
> > We used to show md5 and sha256 but given the concerns about md5,
> > switch to showing just sha256 going forward which seems like the
> > sensible one to standardise upon.
> 
> Should this be interpreted so that going forward, it's recommended to
> drop the md5 checksums from recipes when doing version upgrades?

Yes, that is the intent/plan. We don't really need both and this
usability fix is a good opportunity to rationalise what we're doing.

Cheers,

Richard


