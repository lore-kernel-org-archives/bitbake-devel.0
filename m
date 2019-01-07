Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
	[209.85.221.41])
	by mail.openembedded.org (Postfix) with ESMTP id 2ED1A7BDF5
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 14:56:51 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id v13so725219wrw.5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=bFpjosn8Z3wkk904u2CcTVaTiJuttHcmgwjAm/cpW/k=;
	b=bDsoNMO1bsr6Ab4r65Uq4f0HP0T6H07UFFPa+TVyROdQ8r62wWW4Jgz97TPyHXeCNk
	wyYlW8CM28L0JafKI80yZ5TYm+Rj1oCp4e0ojtjmnTWiMvqm/6H27hboZd5L/iLAmdXM
	fqVuqL0zOgrlmiBiO8Tpk+1wkf2mb7l9Psu7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=bFpjosn8Z3wkk904u2CcTVaTiJuttHcmgwjAm/cpW/k=;
	b=cp7yQ1DMyVDlM8HUl/toFZkoszSj5xY/FtYbIjIcWwHAAl/z6XpIrn/v8eXGRafdJw
	cmi3g/hJHQo7CoRHaXWKXpjcjB8NFqWAA3Imv7AfrXhczE4a4wwFcUcj7uxMz+Y+Z0Ay
	yDCQTk/VZKplfTC9jpWJ0Ewk54HqoT0cjW/Q+9326KpefjzS0DR9Lw9M8NEKEO61GeXU
	UGaDjjYAHH+yzEaSo70aO3R2OcrkTSFIBkFZVOdGbHMV+noLq2eTr/cieaNy6UG8vvwv
	3ZYVoDv4O6kPgUo/wZew0WJYaAmoxTS98YfQfT8KNTmnAGN+ZIHwish1Cf7NqH1pAI7x
	X4Fw==
X-Gm-Message-State: AJcUukeU8FpsS92Nj2wgT5gVN/i6oyqmBlfKL0neLhbTFhnfDytBKPJZ
	nTNLHqBqhYmEkkuJDCFG+3B9ag==
X-Google-Smtp-Source: ALg8bN5S8Xi6MlOT9UKHPx0hqw7lpvH4KCMUcKj4Bwp5KNtsy7RlCwPUspcA4N/aBcgYUQXyPLY/Cg==
X-Received: by 2002:adf:e383:: with SMTP id e3mr28911009wrm.31.1546873012693; 
	Mon, 07 Jan 2019 06:56:52 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o16sm63721075wrn.11.2019.01.07.06.56.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 07 Jan 2019 06:56:52 -0800 (PST)
Message-ID: <49a16b88d162e9d3aa3db88deaed47147d914429.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Slater, Joseph" <joe.slater@windriver.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Mon, 07 Jan 2019 14:56:51 +0000
In-Reply-To: <007BD92917A2324FA403BCF9A464CF84F3723F13@ALA-MBD.corp.ad.wrs.com>
References: <007BD92917A2324FA403BCF9A464CF84F3723F13@ALA-MBD.corp.ad.wrs.com>
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
X-List-Received-Date: Mon, 07 Jan 2019 14:56:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-01-03 at 23:57 +0000, Slater, Joseph wrote:
> TMPDIR is useful, but named sockets need a "short" pathname, so it it
> might be nice to have a RUNDIR, or something similar, under
> /run/user/<id>/bb.  Could this be added?  I would do it if the
> concept is accepted.

What problem are we solving with this?

I'm guessing problems with memory resident bitbake in envvars but I am
having to guess! :)

Cheers,

Richard


