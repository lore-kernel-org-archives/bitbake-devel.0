Return-Path: <akuster808@gmail.com>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
	[209.85.218.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9EEDE747E9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Sep 2018 14:35:05 +0000 (UTC)
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so27635208oic.4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Sep 2018 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=WB5i2Rpe7SiUg97Eq3ADWSDm7oPuEp4EKMOvfibz5Yo=;
	b=gzqEMLclPUFUNa3A/6CMIQokqfS+zMfVy3tZS/CnzaSk+ef5HZWCOm3sixgh0D4BIL
	rwC67Sv2KRmvWHfZNoX+kLaD3oLB1vre1kFHhRO1h0iL4YI0xt0LtSphyHVr2jYzQ4j2
	ITaUAkw9vFNtS/q+8hYUY7cQ68ZrXKVsjiY4R1ZTvUBTZID0BhbUfdRkiKseZvxoE+KS
	d3pUbU7g096OIKROcDuOaRsYafWUEWMzvqdH3Csu7VTk5cvn/Ty4XMYIldDVQNlvFVCc
	YKeARwmv6FdJRn5g9ClXnE1Gdmm0AULJuYySx2itk2j6TsVhZEf64AYzwNcHSCMfDj+d
	N5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding:content-language;
	bh=WB5i2Rpe7SiUg97Eq3ADWSDm7oPuEp4EKMOvfibz5Yo=;
	b=EmYofs6liLCUOr0vZ7tijwjUVki9uFcF1yaqC7Gi595za3JLj6fh2xb1ZMVLGeCeRj
	uh+GIdKnO6wrP4Ahb2AszN+T62U8NHNXxUQr1qIyNHCl8kg+xk0Jc7woE/dRdRzT0F6k
	UaYBIqoAI9lE8I3KmzMjGLR2NaVZ4Nqgc0AUZq7kBEnFRxCyU6aBkkp324iD2n1ijjDL
	5S4qxVtN5Ap44Lp+TC8LEcuGuJ71lrdvhJ9wOxCyIWwXWK2b5ADJSe8EKBBYv/rGs+hE
	TIQTzQAiAvtAoCKvZF3F3nN/dSb59hdx2gjyNKLa7IfCRWliPiJ1rOFqx5F8oLitkP07
	Q2mw==
X-Gm-Message-State: APzg51C5SDMpyj5FMBDnGiPTVmsspPo13e9uwikPgrfTQSF5kl/YSc4S
	y+nnwqb4KkUUQpJmAd1uTK4=
X-Google-Smtp-Source: ANB0VdaFbTdI+WHdzCEd8l0N2wrB1mmI8qYfaXUuR8HI/fxoNq2NtDGjtXKIAr1mhtqgozFpp7/qBQ==
X-Received: by 2002:aca:e80c:: with SMTP id
	f12-v6mr7679546oih.38.1536330906538; 
	Fri, 07 Sep 2018 07:35:06 -0700 (PDT)
Received: from ?IPv6:2601:202:4180:c33:7da7:aee9:aa08:ff3c?
	([2601:202:4180:c33:7da7:aee9:aa08:ff3c])
	by smtp.gmail.com with ESMTPSA id
	r187-v6sm6080720oie.43.2018.09.07.07.35.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Sep 2018 07:35:06 -0700 (PDT)
To: David Reyna <david.reyna@windriver.com>,
	bitbake-devel@lists.openembedded.org
References: <cover.1536210899.git.David.Reyna@windriver.com>
From: akuster808 <akuster808@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=akuster808@gmail.com; prefer-encrypt=mutual; keydata=
	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
	8CS2NxU=
Message-ID: <673ab6a3-d995-c611-6c99-d7d555e54aec@gmail.com>
Date: Fri, 7 Sep 2018 07:35:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <cover.1536210899.git.David.Reyna@windriver.com>
Cc: Awais Belal <awais.belal@mentor.com>
Subject: Re: [SUMO][PATCH 0/9] toaster: SUMO cummulative patch Aug 28 2018
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
X-List-Received-Date: Fri, 07 Sep 2018 14:35:05 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 09/05/2018 10:26 PM, David Reyna wrote:
> From: David Reyna <David.Reyna@windriver.com>
>
>
> This cumulative enhancement patch includes the following, to support
> flexibility and usability for Toaster.
>
> * 12891 - "Allow flexible value for TOASTERDIR plus custom fixture support"
>
>   This supports the flexibility of having the Toaster base directory (used
>   got the database and project build directories) to be specified by the user.
>   It also allows for flexibility in the location of bitbake to be within one
>   the specified local layers instead of being in the default fixed location.
>
> * bitbake: toaster: Fix comparison in recipe template
>
>   This helps prevent a page failure for certain circumstances, and is well
>   worth porting back to Sumo.
>
> - David
>
>
> The following changes since commit 45ef387cc54a0584807e05a952e1e4681ec4c664:
>
>   bitbake: checksum: sanity check path when recursively checksumming (2018-08-29 15:23:51 +0100)
>
> are available in the git repository at:
>
>   git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/sumo_cummulative_082618
>   http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/sumo_cummulative_082618

Series in sumo nmut.

thanks,
Armin
>
> Awais Belal (8):
>   toaster: allow pokydirname to be evaluated when all layers are local
>   toaster: use a more flexible way to find bitbake
>   bitbake: toaster: allow TOASTER_DIR to be overridden from cmdline
>   toaster/widgets.py: avoid divide by zero issues
>   toastergui/newproject.html: fix release divs
>   toaster/checksettings: allow CUSTOM_XML_ONLY setting through env
>   toaster/models.py: allow local paths for custom recipe's base
>   toaster/layerdetails.js: don't hide local layer info
>
> Karsten Strand (1):
>   bitbake: toaster: Fix comparison in recipe template
>
>  bin/toaster                                        |  9 +++++--
>  lib/toaster/bldcontrol/localhostbecontroller.py    | 31 +++++++++++++++++++---
>  .../management/commands/checksettings.py           |  3 ++-
>  lib/toaster/orm/models.py                          |  7 +++++
>  lib/toaster/toastergui/static/js/layerdetails.js   |  3 ++-
>  lib/toaster/toastergui/templates/newproject.html   |  4 +--
>  lib/toaster/toastergui/templates/recipe.html       |  2 +-
>  lib/toaster/toastergui/widgets.py                  | 19 ++++++++-----
>  8 files changed, 61 insertions(+), 17 deletions(-)
>


