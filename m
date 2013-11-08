Return-Path: <ross.burton@intel.com>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
	[209.85.220.175])
	by mail.openembedded.org (Postfix) with ESMTP id CA1556D663
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2013 13:33:54 +0000 (UTC)
Received: by mail-vc0-f175.google.com with SMTP id ht10so1362314vcb.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Nov 2013 05:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=8r3w30Mj/QPFGQYc6a//M2WOunYykS13gJUwj86V3pY=;
	b=jClCjeeYwu88NGfWVdpQs0FmpHfszfwhOV5WsA+rq8bHdm1ITkkCaMdd33Zca4/+zO
	dGdl00JatWhJSZosjxGuWAvZz3PeAxBQxM/T9EzlJYxTjwRt297sZTl4zS42WV2gNZkK
	tdyjoF+nvBzJQYxGd+4+2bWN6ZmYxYuqFy4jbWWG3nQLECvbyY4cQ/PQHEnqAsrqD3X2
	N3qzI5hjyTVfA5wCW6hwd0G71iZ6s5eUg4cFgewUYxRfwbziLCnSnP+GyAph89Bhaa6v
	yuTMqpiiWrjA6x2dpmKvIprQ3H4OMU59Qb0ANr8RH90K+miFiotDYMBN7L/Ptp1kX4go
	/Mrw==
X-Gm-Message-State: ALoCoQkpT2ufIcWoDghIE1lEa+0n1OR4r2V9IlMr4U4BucZXYT6VgbrgDgEK9s9IWxlfvCb8tX1m
X-Received: by 10.52.187.138 with SMTP id fs10mr9802494vdc.10.1383917636153;
	Fri, 08 Nov 2013 05:33:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.220.71.201 with HTTP; Fri, 8 Nov 2013 05:33:35 -0800 (PST)
In-Reply-To: <527CE508.404@mlbassoc.com>
References: <527BAC0F.3090901@mlbassoc.com> <7286154.LbYKCCWHqH@helios>
	<527BC186.5040406@mlbassoc.com>
	<CABcZANkDuRL2bMgoy=zNbguwT6xWXw0ktDhy0KPOMZwAiS4kfg@mail.gmail.com>
	<527CD8E4.4000202@mlbassoc.com>
	<CAJTo0LbPatd4dHmL5SF4x5ERZwq+A3-UKo7AT-SBNvfBrNpt5w@mail.gmail.com>
	<527CE508.404@mlbassoc.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Fri, 8 Nov 2013 13:33:35 +0000
Message-ID: <CAJTo0LZeK7Y0MGpKUZiAZdocRQuA5KynGh_0F=U2jH1KxHiuyQ@mail.gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	Chris Larson <clarson@kergoth.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Some 'depexp' nits
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
X-List-Received-Date: Fri, 08 Nov 2013 13:33:55 -0000
Content-Type: text/plain; charset=UTF-8

On 8 November 2013 13:20, Gary Thomas <gary@mlbassoc.com> wrote:
> So, did you see the patch (by email, not archives)?

Personally, I'm not on bitbake-list (yet).

Ross

