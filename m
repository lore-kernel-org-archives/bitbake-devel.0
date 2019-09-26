Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail.openembedded.org (Postfix) with ESMTP id E09887EE4F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 20:50:22 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id w12so301045wro.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 13:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=6SrPx122afrQaO0tfkdW7l/xBVB4Gng4kjwnrMSPG8w=;
	b=ZQc52lCFZYcWvqFNVNcFrGbqzFvZExM5HW5ISJQa39y3uhCo8+Af9lBzA1ioomL00Z
	GTy2n9QYs2aYf3acs4HTL/p33IapybPntKw4KWvbU5YTtdL5K30KSQYzwtKvBfdvL98N
	tZtEeHw8ZMeXPS/B9w9XFZxZt2/3NrCgpRplE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=6SrPx122afrQaO0tfkdW7l/xBVB4Gng4kjwnrMSPG8w=;
	b=oZODag4JN1yjETFmukglLfbZxMazO6GiLdDBNDSoVMQeQnCb/7u/NE4v/FO9/Wfsnw
	6T8GH8o16tgTlGxxOSeVLWHiGk7q8t+K9cHEsHUZp4/XW558nvn9z/E3OoKVMnFuqkqa
	pjlWL2XsRXlk4wCOVdJbr2aPnwmqB/egFml4DZa4mLI8K6PmgQDO0ROkD6MvwCB4TIKY
	lQgT8GFIyl3eGfsxEGjI+YU24QJ+Tv3o9mJH/ZY+fP/K+h4nqB2bgs6xE7K6SIs4Ww/E
	43btEFyOWIEf6w2JpXWPfqHfQBpc0NA/QNNPaY+daeajaZ8rA/buI+qpEPVYoGrMiy4R
	OYNQ==
X-Gm-Message-State: APjAAAW3HDAOZchKZrg/QO3PNnOTmjLwAbPODIHocOx+1ljaw8a1os5Q
	pnPnMclCA2+Nb54ZaDbZ4nlVdA==
X-Google-Smtp-Source: APXvYqwrLYyvh1kXF1XvArwocKdBMXoVq6QFo8qC/DqRkTjsAMC8YEg1g4T35lQ1wJvEVEDAQm25vQ==
X-Received: by 2002:adf:e546:: with SMTP id z6mr255199wrm.113.1569531023287;
	Thu, 26 Sep 2019 13:50:23 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id a13sm250763wrf.73.2019.09.26.13.50.21
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 13:50:22 -0700 (PDT)
Message-ID: <c31b6cbb514d4d1bc30fd0d7b6c6b4e124086a75.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Grzegorz Heldt <grzegorz.heldt@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Thu, 26 Sep 2019 21:50:21 +0100
In-Reply-To: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
References: <CAK5ws+EfD=A3ROQmZe9A0Enb-83NcrW_9er2BB7-e9N1H=xmEQ@mail.gmail.com>
User-Agent: Evolution 3.34.0-1 
MIME-Version: 1.0
Subject: Re: bitbake-layers add-layer issue
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
X-List-Received-Date: Thu, 26 Sep 2019 20:50:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-09-25 at 22:38 +0200, Grzegorz Heldt wrote:
> Hello.
> 
> To setup my projects im usually using bash scripts like that performs
> following steps:
> 
> -------------------------------
> wiesniak@desk:~/projects/yocto-rasp/poky/build/conf$ cat
> ../../../setup 
> #!/bin/bash
> 
> BRANCH=warrior
> git clone git://git.yoctoproject.org/meta-raspberrypi -b $BRANCH
> git clone git://git.yoctoproject.org/poky -b $BRANCH
> git clone git://git.openembedded.org/meta-openembedded -b $BRANCH
> 
> cd poky
> . oe-init-build-env
> bitbake-layers add-layer ../../meta-raspberrypi/
> bitbake-layers add-layer ../../meta-openembedded/meta-python/
> bitbake-layers add-layer ../../meta-openembedded/meta-oe/
> bitbake-layers add-layer ../../meta-openembedded/meta-multimedia/
> bitbake-layers add-layer ../../meta-openembedded/meta-networking/
> 
> echo INHERIT += \"rm_work\" >> conf/local.conf
> echo DL_DIR = \"/home/yocto-downloads\" >> conf/local.conf
> 
> -----------------------------
> 
> The problem is that at one of steps that invokes bitbake-layers add-
> layer, issue is reported and script fails.

What is the issue that is reported? Telling us that might help us
understand what is happening...

Cheers,

Richard


