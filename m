Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id 477467C2DF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 11:18:13 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id r24so4559683wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 03:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=Ry6WHXGy88EEEOlZ46XDW1MUCf8vax7ajkxk8oJ6cTw=;
	b=KuxIenOilsNE1HUNO1X8f1CCfwcxmPnWkt5W51nsmdcxyRaUC2uygK8QKbF5mwAZbm
	zUokTF8j4QPmqnbTRi5jM44p6K2Zf+eGauHQo5RJZE+ejr7/N7N5U9fiwStIaZl2TCYs
	MF7NFr4fe1T4JcwpO9q9EqKLid9kNVXqol2Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=Ry6WHXGy88EEEOlZ46XDW1MUCf8vax7ajkxk8oJ6cTw=;
	b=idhqv3b2GU2MXFlskr6yXnbpi2d2FNFdjhC8FqMhD38Gxt08pFpYilXtQTSGPlHMJ9
	EquTEMPNxmuN47NiLEVfbKjjhWGp1bj6GZCwoNZRWtIVsL1Z9SN2WgIyY9ygCbdLTNRB
	5S0PxYmmNy1SD/s1BVQsoP8OwV+XDluX607G24qPJTUXpPGwyVlPgOILuJKLF8zbcOaV
	bkBuewJT3WFNkKDl90gpK2Fk4SSblLXdVkfSOfF/PYITp7HQ15r0EZFbHWoHDZyBvazL
	pufgxgkx58BVXU5ABHMuFKimRUAQDlHa8psU2N9fxtBogKBCXIInNMj1dk9MYZkvfIdC
	zP2g==
X-Gm-Message-State: AJcUukdiLUQLRNXS1J2gySnReOGRvggpkwLvs0/H03nG6EMBoiCgauGI
	IM4rRqcCSUweOn+WID6b+kaDoQ==
X-Google-Smtp-Source: ALg8bN62MBA9bVeBqT5FxraExt02/+TqhGVJiM5T//EnLjnYUnLA5S6NhqN0Z6lhfJg/Cc4vA+7+TA==
X-Received: by 2002:a1c:9183:: with SMTP id t125mr6342914wmd.79.1548415094618; 
	Fri, 25 Jan 2019 03:18:14 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	133sm66626951wme.9.2019.01.25.03.18.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 25 Jan 2019 03:18:13 -0800 (PST)
Message-ID: <18561a9b63079e5dc2d4b4a8b6b12728475b0402.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: liu.ming50@gmail.com, bitbake-devel@lists.openembedded.org
Date: Fri, 25 Jan 2019 11:18:12 +0000
In-Reply-To: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
References: <1548413847-32550-1-git-send-email-liu.ming50@gmail.com>
User-Agent: Evolution 3.30.4-1 
Mime-Version: 1.0
Cc: stefan.agner@toradex.com, luka.pivk@toradex.com
Subject: Re: [PATCH] fetch2/gitsm: fix config file concurrent update race
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
X-List-Received-Date: Fri, 25 Jan 2019 11:18:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-01-25 at 11:57 +0100, liu.ming50@gmail.com wrote:
> From: Ming Liu <liu.ming50@gmail.com>
> 
> A following issue was observed with gitsm:
> > git -c core.fsyncobjectfiles=0 config submodule... failed with exit code 255, output:
> > error: could not lock config file config: File exists
> 
> Since all git submodules share a config file and Git creates a lock
> file (.git/config.lock) to synchronize access to it, but Git only tries
> exactly once and returns a error if it's already locked. This leads to
> a race condition if there are many 'git config submodule' run in
> different processes.
> 
> It could be fixed by introducing a bitbake file lock to protect config
> file from concurrent update from submodules.
> 
> Reported-by: Stefan Agner <stefan.agner@toradex.com>
> Signed-off-by: Ming Liu <liu.ming50@gmail.com>
> ---
>  lib/bb/fetch2/gitsm.py | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

This issue should already have been fixed with recent changes to the
gitsm fetcher. Could you confirm which version of the code you were
seeing this problem with?

Cheers,

Richard


