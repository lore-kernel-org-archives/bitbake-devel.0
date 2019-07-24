Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id CF0A17F143
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Jul 2019 14:19:49 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id 31so47252805wrm.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Jul 2019 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=flZNj/e3NkOFz+9E8bIhYvS1za6zaMx1LdSksZKJcLo=;
	b=UhmA68pQD5gtW/zuC96Kx7Bde3dP1c4clRbM8WWq+FSxzHWH/QuqjklaGNSKnKiO7p
	/5Fm+aWm5DgSR1d0jOFidVuv9v8h9VVcvASe9SzS9YAzjICzVkEq+p/DatnJqV4ZV0Xa
	NHZqehWV14ivp/O5QxTzl0hfdd9QUNkB+UUG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=flZNj/e3NkOFz+9E8bIhYvS1za6zaMx1LdSksZKJcLo=;
	b=fdNCDos8mwZQxCwGhNfcskasXj2DDujBN0wdXEF189kczyeZ+BFsu2JLwO0BE3minv
	Y2rHTxRz5m1udOmgSwOmIgjb96gXGTxRgnxv5uW+Mv0wzLsnf3FcrV75AHvrRLaZaXLs
	TYZ6R3Kxon621I/3vw4bbEKGv6jD3nj1++Uyqq/iFdEEqOFiUwu1kO8vop8AhS/zuq7p
	GWuwBvvj0Qq7fL8UB/FXM9mYoK3ET4PuoUhxtvN1RcUHFc/3mgJG/g5r/tmpC78JpS/j
	KF9nxH6kGdhJBt8IU6HFnQWQxl+2mDpAOXdEqOQrhC9ZkSeUMims4YYvZ0UY62PZTB7W
	2Cpw==
X-Gm-Message-State: APjAAAV0hGBNvcR6DLzdw+mfdp/z2RZ8+pK9C/AdiKwBiFtJlQekP6gw
	XvOOjIENB4xG3oFi1WOw4LRtjQ==
X-Google-Smtp-Source: APXvYqyucnGXrVDm08DM+2fp5ZdN7kZz2en/frE+yDR+vWIRFkqK8P3mEoMBAFbq6r/YgjbCagx6KQ==
X-Received: by 2002:a5d:48cf:: with SMTP id p15mr38631387wrs.151.1563977990609;
	Wed, 24 Jul 2019 07:19:50 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x185sm35589011wmg.46.2019.07.24.07.19.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 24 Jul 2019 07:19:50 -0700 (PDT)
Message-ID: <f6f6e58e652516f2402d4c247237c9116054b0a8.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Mike Crowe <mac@mcrowe.com>
Date: Wed, 24 Jul 2019 15:19:48 +0100
In-Reply-To: <20190724091134.kqctx32x3daxiwjq@mcrowe.com>
References: <20181217171645.8145-1-richard.purdie@linuxfoundation.org>
	<20190723160909.wdj7fwboiy65kfet@mcrowe.com>
	<00066477-9727-3081-a300-e030ef733333@windriver.com>
	<1e930c00f2f1ef60bda5c7d25d2850d438f3345a.camel@linuxfoundation.org>
	<20190724091134.kqctx32x3daxiwjq@mcrowe.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] data/siggen: Switch md5 -> sha256
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
X-List-Received-Date: Wed, 24 Jul 2019 14:19:50 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-07-24 at 10:11 +0100, Mike Crowe wrote:
> We make use of the recipe name in our sstate cache pruning script,
> since some recipes have more churn and we expire them more quickly.
> That shouldn't be a problem as long as the recipe name is kept in
> preference to the version.

Lets get the abstraction, then we can discuss which pieces make most
sense and have which priority.

> > > So the same truncation when matching, and it should be safe.  The
> > > recipe,
> > > version ... task bit is nice to have for a human reader, but I
> > > don't
> > > think it's
> > > actually needed by the system itself.
> > > 
> > > This should avoid any collisions and keep the maximum information
> > > that will fit
> > > in the filename(s).
> > 
> > In some ways regardless of what we do, we need to abstract it so
> > that
> > we have one function generating the filenames.
> > 
> > So yes, think we need a patch which abstracts the filename
> > generation.
> > It needs to be able to truncate elements of the constructed name
> > other
> > than the hash. I do prefer truncating the other elements than
> > changing
> > the hash.
> 
> If we're going to keep the 64-character SHA-256 hash and instead
> elide parts of the sstate filenames, then I think only sstate.bbclass
> needs to change, so this isn't a Bitbake issue and we should probably
> move this thread it openembedded-core.
> 
> Or perhaps I'm misunderstanding your suggestion.

No, this probably becomes an OE-Core issue. Keep in mind that some code
does glob on these names though iirc so we'll have to consider those
bits too.

Cheers,

Richard


