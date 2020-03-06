Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
	[209.85.128.67])
	by mail.openembedded.org (Postfix) with ESMTP id B602F61B36
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2020 10:47:50 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id a25so9128008wmm.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Mar 2020 02:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=wKwKIiOLyJmB0o1Y4KTeb8j/ghk8yA4L3k9W7hmU47M=;
	b=L16YI2Vu4vz2nPKrJ1XJwhUO6pCBO+fWNHdzfaDGwmA1kMY/hfXjLCqxpFJu1d9UoM
	fo9KF5wOpbhRErWwRbsG6cULjetc142L35xSiNd/CnVSP2w5uPtzlDm+LUMhdK20jLxL
	YjutedfBGQMQuqIjS9WwrmFAiTY1v/72ij78I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=wKwKIiOLyJmB0o1Y4KTeb8j/ghk8yA4L3k9W7hmU47M=;
	b=MMfHAsZ9UhOWFx8dCByIJhfA05QLjl0lYb4tUlHK9lp5A+j1R6M1jLdabuDE/hefew
	wblAeuz3RjTUGBgXbY+PdZ3e+5FufmqncVzFLUqJlod8DWHvNLbZZEQqlZd7T/rn4UqL
	OaXfCGovcjLXqNy9+1ztTisnHGgQI/FwUEEjkVaAkuPpo8ryArIh7t10fG1DrEPh1y/i
	YTOT49HozRk4QSHz+fW1UEKgFgXU3y5Rqr6K1ehlyUSY5KDFkunAO91UuAPlF7G/OrPj
	iL2lsVgSc79X/RLCjNdRvT0XgELkCWJH/p4onFuTdM1sXvZnM1kbANYsXejY8FxHqBjX
	iBHQ==
X-Gm-Message-State: ANhLgQ0takPKgrXy20JotchGqmGOZRfZt73EqQoTiLQKD9wW/CrhqzGj
	0FqG0B96qSwwpOT17fI8Cw6Q7LaTtz0=
X-Google-Smtp-Source: ADFU+vsyMytW+b7Qq2ey2meisnJG1WZvCXetPH27jFWluXwCnyPQncJOnGFp9KZrFyNq7OIgCCHW4g==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr3329477wmj.176.1583491671220; 
	Fri, 06 Mar 2020 02:47:51 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id u11sm441875wrb.10.2020.03.06.02.47.49
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 06 Mar 2020 02:47:50 -0800 (PST)
Message-ID: <c6f30f1b074af551a0b46837237c21e44e699c19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Adrian Bunk <bunk@stusta.de>
Date: Fri, 06 Mar 2020 10:47:49 +0000
In-Reply-To: <20200306102420.GB17785@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
	<20200223195148.GB3444@localhost>
	<49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
	<20200224054945.GB6683@localhost>
	<f5a7208c16b4df00445cb280b3a556923c07db97.camel@linuxfoundation.org>
	<20200306102420.GB17785@localhost>
User-Agent: Evolution 3.35.91-1 
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Lower priority of debug messages that should not be shown on the console
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
X-List-Received-Date: Fri, 06 Mar 2020 10:47:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2020-03-06 at 12:24 +0200, Adrian Bunk wrote:
> On Mon, Feb 24, 2020 at 09:12:06AM +0000, Richard Purdie wrote:
> > On Mon, 2020-02-24 at 07:49 +0200, Adrian Bunk wrote:
> > > On Sun, Feb 23, 2020 at 11:53:57PM +0000, Richard Purdie wrote:
> > ...
> > > > I know you didn't mean it this way and we need to track the
> > > > issues,
> > > > I
> > > > just don't know how we're going to handle it.
> > > 
> > > From my side the problem is that my initial patch is what I can
> > > do
> > > with reasonable effort.
> > 
> > Part of the reason I'm highlighting this is that I have a lot of
> > feedback that says people don't believe there is any problem with
> > our
> > resourcing. Unless I can show where there are issues, its not going
> > to
> > change :/.
> 
> Why does YP give users false/misleading information regarding
> security support of stable and LTS releases despite lack of resources
> to provide security support?

See my other longer reply to you on oe-arch.

I think the project is trying to improve the security support we can
offer on stable releases as they become an LTS. No its not perfect and
we're not offering guarantees but is is an improvement.

The project got to pick where it allocated funding and it chose to
improve LTS and security over for example helping me with day to day
patch review/testing and build failure work. I don't mind, we have to
start somewhere to improve things and LTS/security is important.

The project does already fund some "day to day" running by funding me
to work on bitbake/OE-Core. Yes, it would be helpful if it wasn't just
me, maybe in the future if we can show success of the LTS we may
attract more members and I can get some help and stop burning out, time
will tell.

> There is no reason to believe claims that there would be any problem 
> with resourcing when the public announcements from YP give the
> opposite impression.

As I've said in a few places now, there will be some comments from the
project about this. I have already drafted something about resourcing
but there were concerns it would cause panic and I've agreed to reword
it to try not to do that. There isn't reason to panic, we do need more
help and we will communicate that when its ready. You'd be amazed at
the work in writing public statements and your reaction to the LTS
announcement will sadly be held as an example of why I shouldn't talk
about resourcing.

Cheers,

Richard




