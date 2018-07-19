Return-Path: <ross.burton@intel.com>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
	[209.85.218.52])
	by mail.openembedded.org (Postfix) with ESMTP id 1035271B99
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jul 2018 22:24:48 +0000 (UTC)
Received: by mail-oi0-f52.google.com with SMTP id n21-v6so2423451oig.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Jul 2018 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=B1+dQCaValw1ozS6OLNjNULCbuqK0wnVHaXql7++1jU=;
	b=uyvyydXijRTk3XwCtBA/F2V7+LQW7NWfBLodC2T+tvCSIAj/OVg4nNFKsQhOh/APSY
	b1i4aGMtkBERfULn4EekW9s0PbTkYYTAjYSMcvwaplCUevmSNOi+9pZ/iwGqDZY3KE3z
	I75oNU0v2pmGaECCh0ntMhfB6AfLbM06x+FJfk340G6zyIx53fnap1ml/dzdfZmopssM
	q3yRcPF8i5nSS7UoxVCvTzLRgCkksLwAZUl+Q04BCF4ZzbNq6cf2Tw+TZroo+NcW7EPP
	x6BRSBE0kmT/s75LzD9n6vWMHxcRvTIHAT+6/nDLyTr/sdiTF02NcRAr+3qiF8J4co0z
	pkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=B1+dQCaValw1ozS6OLNjNULCbuqK0wnVHaXql7++1jU=;
	b=ms/WeitIVjRTRrZmTrSBwET30cjyZfcvVLyifHZBd1/t3hAHg11JUlnJ0QZW4/9/Cp
	yUGBWP/xguoaqgyNJGubmHI3b0aQnP8Wrq8pBW3r/wLd7Q624mYdcRfms/m0oTT5Tei9
	OpfKindndDMx/nyxyFwFm7c8XZKhUrvTvZmin8zpqWob3T+XaS1PCSC+HMX112NrJkfU
	3/uYUQ+uRuOs8vxUlocTJaAqJ6C4UGUlS5/lpdWUmubbfcNNR8fgx1mCBFNtgIp/9mav
	NrGHw/23+IxU/3XKw8y+u0lhbvMGCx/tF3zWheZKL3fD6/pbjjVycXpD9faCAJms+XF/
	tafA==
X-Gm-Message-State: AOUpUlHJvpnM3OdiM87orsIt0ZV+5aUI3L1inE9z1XfHRPlr+D55WZ2H
	TTLzjtFD5frspCWwSEEznp2fEZ1UkrP5kr0Fd9ovtw==
X-Google-Smtp-Source: AAOMgpcWqo3YFT0PqnJTyPT6R+44o1EHTM+dYoShbDRgjusniPRAo5sCLx6liBfemPfKTdWVSQdSimjvzmfrHcoScO8=
X-Received: by 2002:aca:5f56:: with SMTP id
	t83-v6mr13513946oib.115.1532039090038; 
	Thu, 19 Jul 2018 15:24:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6845:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 15:24:29
	-0700 (PDT)
In-Reply-To: <CAMqo94KK+Rjr-2O03PPPw0gWm1suj5JFYHW9xbguYfo9H16Ahg@mail.gmail.com>
References: <CAMqo94KK+Rjr-2O03PPPw0gWm1suj5JFYHW9xbguYfo9H16Ahg@mail.gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 19 Jul 2018 23:24:29 +0100
Message-ID: <CAJTo0LZTbKqmyJuMQOmyJgkGhysdq_7efHNxqm=OxVf-OnnmOQ@mail.gmail.com>
To: Sherif Mousa <sherif.e.mousa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Implement function to be executed before ending each bitbake session
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
X-List-Received-Date: Thu, 19 Jul 2018 22:24:49 -0000
Content-Type: text/plain; charset="UTF-8"

Wasn't this discussed on IRC last week?

Yes, the BuildComplete event.
https://github.com/rossburton/meta-ross/blob/master/classes/timer.bbclass
is a small example.

Ross

On 17 July 2018 at 14:56, Sherif Mousa <sherif.e.mousa@gmail.com> wrote:
> Hi,
>
> Is it possible to setup a function to be executed at the end of each
> bitbake-session execution, just before calling sys.exit(ret) , but without
> patching the original bitbake script "poky/bitbake/bin/bitbake" ?
> Is there a way to do this from a recipe (event handler, ....) ?
>
> Regards,
> Sherif
>
> --
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

