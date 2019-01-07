Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail.openembedded.org (Postfix) with ESMTP id 34C0D7BEE4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 17:31:28 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id b11so1644800wmj.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 09:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=PLXO6T1B9E21ymjuG71liPWGFi+nK2DEGPRCAQru7vc=;
	b=XH0uYXPa3Rq9bx4H76xNJVhwOzJgTIe5WBC4w5OBWeipPT+X+cV8o2OQAQWaAbros/
	P6FATepZb6E1rhVRLaSIJWGWcKnOtKE0lbLjel6brLB8XRUDfcQsR+5UIEuBWvK2SQrV
	Z99EiD8W79XUAA2wKma2E9qxQEzYSm9F+7SgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=PLXO6T1B9E21ymjuG71liPWGFi+nK2DEGPRCAQru7vc=;
	b=OtGO/6cDOYDeVjfGrYmCYrd2o3qncI7ybsOMoCldsL0jaQC4eslhQvWefbN8vHoeLf
	LaSur4swSY4V6Nbpdkxuv8jZwX45oEQrkqYZU+ky4HX61dEA4jzuIZK59Ko9H+TtqHjr
	rPrIhNTX+8jOvPpUBL7Kv03cMsf6ZRfhYYfr63f56Z+P9EhNecOXn2MVxvQy6K1x6CaZ
	r7gPPEA+77IUXTthJ5Sq3nnxSklL4AJDvCzP+PoKdPkTg92n5/Ts7wJY/cm/Gfu9XWFQ
	joHbpc+sEqh4ocb0u3nm04C18zH+KNYAr1qSi1j3s2mE0dsDRI0N8fheA1KZwdhbbWSk
	58jQ==
X-Gm-Message-State: AJcUukcMFn6TE0Txep8yA/Sz5F8mkvpi5sp2xUasPlEST+Q6G5leB2vi
	QgLE3r5e+8fKtfP7liJace+kUA==
X-Google-Smtp-Source: ALg8bN5IJekQmrWNpLOjxEsr0Eyd81qH78au43EAFEpkP/5rARbcjCoRJOlw7Z+kCU6yzaA/Z3s6Mw==
X-Received: by 2002:a1c:b14:: with SMTP id 20mr9842048wml.103.1546882288814;
	Mon, 07 Jan 2019 09:31:28 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t4sm18695033wrb.64.2019.01.07.09.31.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 07 Jan 2019 09:31:27 -0800 (PST)
Message-ID: <d87ce682d2a0e2eda230e8b0e7799f2ec68f46db.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Mark Hatle <mark.hatle@windriver.com>, "Slater, Joseph"
	<joe.slater@windriver.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 07 Jan 2019 17:31:22 +0000
In-Reply-To: <d718f0d7-3834-3b42-2fc2-3667ed4e899c@windriver.com>
References: <007BD92917A2324FA403BCF9A464CF84F3723F13@ALA-MBD.corp.ad.wrs.com>
	<49a16b88d162e9d3aa3db88deaed47147d914429.camel@linuxfoundation.org>
	<d718f0d7-3834-3b42-2fc2-3667ed4e899c@windriver.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Subject: Re: /run/user/<id>/bb
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
X-List-Received-Date: Mon, 07 Jan 2019 17:31:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2019-01-07 at 10:07 -0600, Mark Hatle wrote:
> On 1/7/19 8:56 AM, Richard Purdie wrote:
> > On Thu, 2019-01-03 at 23:57 +0000, Slater, Joseph wrote:
> > > TMPDIR is useful, but named sockets need a "short" pathname, so
> > > it it
> > > might be nice to have a RUNDIR, or something similar, under
> > > /run/user/<id>/bb.  Could this be added?  I would do it if the
> > > concept is accepted.
> > 
> > What problem are we solving with this?
> > 
> > I'm guessing problems with memory resident bitbake in envvars but I
> > am
> > having to guess! :)
> 
> I'm assuming it's a combination of memory resident bitbake, and overall path
> length in TMPDIR to the sockets.  Sockets have a maximum filesystem path length
> (107 characters in Linux) that is much shorted then other components in the
> system (4k or less).
> 
> The typical way people work around this is whenever you use a socket
> you cd to the path of the socket and then open it relative to the
> current location.

The code in bitbake already does that as it happens...

> in either the TMPDIR or RUNDIR type configuration, that 'cd ; open'
> type behavior will still likely be needed.  So I'm not sure if RUNDIR
> actually fixes anything when it comes to path length issues.  It just
> moves the socket to a known location, from 'current' path.

I'm hoping Joe can explain the problem rather than us guessing,
particularly as the code for where I thought the problem may be already
does a chdir().

Cheers,

Richard


