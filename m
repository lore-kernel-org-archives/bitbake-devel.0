Return-Path: <twoerner@gmail.com>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
	[209.85.223.195])
	by mail.openembedded.org (Postfix) with ESMTP id C5E8565CC7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Feb 2017 01:14:14 +0000 (UTC)
Received: by mail-io0-f195.google.com with SMTP id 101so756949iom.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Feb 2017 17:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=sMRqjPwfHc4G5GfeqOfhrWdQpPVXEiEqOZckScA1c0A=;
	b=Ze+6smxcBFs1HthtSjr6Lnla4sFyft+8yN22H0MmIP9gGgyhL9FHs0gveEhVFmfjrJ
	xmMHXTSWnnwiaHWVHarRfG+dL/o1RQ5ncMl3tcciyoxCMW6q90do0JUbo+r6QQXthEB4
	elAj/9z2ecaeqDQGL9fAA960uOT0nYKpcNh0HWl03HhsLcDrtuV3YvkTkkqZ4RMoZH6B
	YL1mvrlhoYcIkcGSzvVYh41i+5E1T98wg5tiKJFqyjSJrNTmfKpmYdcl3RA8QjdvUacD
	18zlGnwSeZ9Q1XauX8dar5oIjHmjp91iCRrjS7OfAeS/+q3qbIE1KVKb1RV2mO8vbIOz
	KY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=sMRqjPwfHc4G5GfeqOfhrWdQpPVXEiEqOZckScA1c0A=;
	b=cJHhdZl52mJaRpQhkmE5SsxnGfo0Lf5bhaLPwMYblWgHtprjbuRFIcOA1pQ0pu/zzz
	zM0GA97xK/K+psjuJLVdQM3bSntUmZ4SduiCb/yC+W0a42C2whwHFzI+sPAqWPPQUTGs
	svCnESiaF06E96ypENZfR13BCzJb5rNx/4xaFefXGvfJWch35DdpcIyvBJ/NIV5d3YW8
	sTXS3QmcKZ3RAUAfrKCsmL8ONP/Mz4C1NI1Bq/MBMHDFWLGU9vVIJyDuirVWvVyGhviM
	aJz2qzKSMomKnc7XWExR5oOE67554S+LykzhGnIrtrwjloH8CPZIdEwZ0ohMgHKaaP2u
	IyPA==
X-Gm-Message-State: AMke39mofZCjKalnKaS+tx7isI63EyumqbDstoFP3MLie7cWKKYBLGPqA1kqUrtWSUa5Jg==
X-Received: by 10.107.172.7 with SMTP id v7mr1143555ioe.49.1486602854805;
	Wed, 08 Feb 2017 17:14:14 -0800 (PST)
Received: from linux-uys3 (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by smtp.gmail.com with ESMTPSA id d11sm2048445itg.1.2017.02.08.17.14.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 Feb 2017 17:14:13 -0800 (PST)
Date: Wed, 8 Feb 2017 20:14:11 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Message-ID: <20170209011411.GA26866@linux-uys3>
References: <578DC9D2.1060607@mlbassoc.com>
	<CAJTo0LaXhGF3eFt=tfRBHfU56kf_nheBrV8Sshsxrpq+fGn7cA@mail.gmail.com>
	<f4f9f0d1-9827-b239-5458-328a947af066@windriver.com>
	<2475257.7Bltr6I3so@peggleto-mobl.ger.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <2475257.7Bltr6I3so@peggleto-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: New progress meters
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
X-List-Received-Date: Thu, 09 Feb 2017 01:14:15 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed 2016-07-20 @ 08:29:52 AM, Paul Eggleton wrote:
       ^^^^^^^^^^
... talk about showing up late to the party! ;-)

> We can certainly do something like that - the progress handler sees all output 
> even if it doesn't contain anything interesting to it (e.g. % complete). The 
> trouble comes when the process prints out nothing - such as when linking a 
> very large binary. I'm not sure how you would introspect into that part of the 
> process.

Would it be possible to show progress such that once a recipe started to be
processed, it would remain in view until it was done (preferably in the same
relative location)?

Let's say you have a recipe abc.bb whose tasks are: fetch, unpack, patch,
configure, compile, deploy, package. I think it might be nice if, once bitbake
started processing abc, we saw something like:


	before-4.5.6 ...
	abc-1.2.3 do_fetch ===>
	after-0.9.8 ...

Then when the fetch was done we'd see

	before-4.5.6 ...
	abc-1.2.3 do_unpack ===|==>
	after-0.9.8 ...

then

	before-4.5.6 ...
	abc-1.2.3 do_patch ===|===|=>
	after-0.9.8 ...


Or, maybe:

	before-4.5.6 ...
	abc-1.2.3  =fetch=
	after-0.9.8 ...

	before-4.5.6 ...
	abc-1.2.3  =fetch=|=unpack=
	after-0.9.8 ...

	before-4.5.6 ...
	abc-1.2.3  =fetch=|=unpack=|=patch=
	after-0.9.8 ...

Maybe the different tasks could have their own colours? Perhaps the equals
signs could be used to show progress: as a task progresses more equals signs
would be printed, then the pipe drawn and the new task drawing started when
the next task begins? At the end of processing abc we might see something
like:

	abc-1.2.3 =fetch===========|=unpack=|=patch=|=configure====|=compile===========================================|=deploy===|=package==

which tells us that fetching and compiling were this recipe's largest jobs.

I guess the largest problem would be handling the vertical real-estate. With
hundreds of packages, the output would scroll off rather quickly. Maybe once a
recipe was complete it could drop off?

