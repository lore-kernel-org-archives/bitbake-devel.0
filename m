Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f52.google.com (mail-it0-f52.google.com
	[209.85.214.52])
	by mail.openembedded.org (Postfix) with ESMTP id 56695782A9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 May 2017 13:56:39 +0000 (UTC)
Received: by mail-it0-f52.google.com with SMTP id g126so9282418ith.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 May 2017 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=9VuAzdMgq5z+tAveWbEMo/NqsepI/DPUFLvHB9d0L2k=;
	b=hxznBXTGg+ZWoAu6m03lscci/vx1sg8njHzZROkZgXvPID5jofbyTavkwNzrEFwNxY
	/HUtJL6/C58DTF39dKxVLcFiXPv1Vj0B9ekuAfvWqu8MzVcefVrGGKQxWZov3+Po2Z6o
	/k8gC/fHMyIE44T/nNBfsPURZf/HYnsxlWsU5iAE9VAh9hA2sFAo5qkY/BpL9DyeOl6z
	mrfifUovW9lqvOry1CRXX535c1wrhu+EsVyWvln6yUn18aRNA+q9gnD7uRAi6pSTX1uk
	3zzE5nRgiV8HnDMZDvcvQAyprZckOfl3QwaJTSMt5FDIwKR/NS84Y2Ckt2DMP67i8+Is
	058w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=9VuAzdMgq5z+tAveWbEMo/NqsepI/DPUFLvHB9d0L2k=;
	b=ilNhAo1X60Vh4ifWQz1B2LFfJvaXXtiz75QeVa0798ZUC2XQNWsH0r/jxM2Koz7skr
	7PetZ1/FfgQEuZffVKV1iFMX80Zeg6z/xBXU35Sad/ZO7ASbU6wF/pfdUESyN95kLh1U
	RhxZR/a/sIE7Ll2UgOKtAibNxuzOBxxf5dNbDm7vpojauDdJyBNmF+2Gqul7YIg6Dydt
	p0phGQJPjeoUzpGXwPG/nPI4GaD2ZNAwbkI1OwiiIwb0SjMC1ULkSm+rg1ZrBLYFhXEF
	ZVLonv1tBjmTUQQM4X6gRymPuMDarwHFX/f6mBN49xo4WnYixcvUq0V66XJDARr8jlEc
	qb7Q==
X-Gm-Message-State: AODbwcAdfdEeNC4ydIP0tPgHxedDhXRKxk3E+bPMayGGNGFItunyi/Ye
	I4n15dNXMhkYIM5u
X-Received: by 10.36.23.22 with SMTP id 22mr19698492ith.78.1495807000960;
	Fri, 26 May 2017 06:56:40 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8F704.dip0.t-ipconnect.de. [93.232.247.4])
	by smtp.gmail.com with ESMTPSA id
	k79sm4425030itk.26.2017.05.26.06.56.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 May 2017 06:56:39 -0700 (PDT)
Message-ID: <1495806997.16923.124.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Christopher Larson <kergoth@gmail.com>
Date: Fri, 26 May 2017 15:56:37 +0200
In-Reply-To: <1495742514.16923.97.camel@intel.com>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<CABcZAN=d7BHGOM9602pfbA4N6chDB8b8RDKB4xo6fhCChDx0Rg@mail.gmail.com>
	<1495742514.16923.97.camel@intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Fri, 26 May 2017 13:56:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-05-25 at 22:01 +0200, Patrick Ohly wrote:
> On Thu, 2017-05-25 at 08:50 -0700, Christopher Larson wrote:
> > 
> > On Mon, May 22, 2017 at 3:50 AM, Patrick Ohly <patrick.ohly@intel.com>
> > wrote:
> >         Having a .bbappend without corresponding .bb file triggers an
> >         error or
> >         at least warning, depending on the global
> >         BB_DANGLINGAPPENDS_WARNONLY.
> >         
> >         Some layers (for example, meta-freescale) avoid that message
> >         by only
> >         adding .bbappends to the BBFILES when the layers they apply to
> >         are
> >         present. Others (like intel-iot-refkit) avoid such .bbappends
> >         by
> >         falling back to global assignments with _pn-<recipe> as
> >         override. Both
> >         is complicated.
> >         
> >         Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and
> >         ignores
> >         all bbappends which match a file pattern in that list. This is
> >         an
> >         easier way to have bbappends which may or may not apply to an
> >         existing recipe.
> > 
> > IMHO this makes it too easy to miss legitimate problems. By adding
> > them only when the layers are present, you ensure that if that layer
> > removes the recipe you’re appending, you’ll immediately know it. This
> > hides such actual problems by suppressing for all optional appends
> > across the board.
> 
> I understand that it is a double-edged sword. It's meant for layer
> maintainers who know what they are doing. If a layer maintainer prefers
> to be warned about missing recipes, they can simply ignore the whitelist
> feature. Layer maintainers who use it need to ensure that they have
> tests in place which will fail when the bbappend is no longer used.

Also note that the alternative solution currently used by layers like
meta-freescale is brittle (depends on ordering of entries in
bblayers.conf). This is not just a theoretic problem; there's currently
a mail thread on the Yocto mailing list ("dynamic-layers") where someone
had the order wrong and had to spend time on debugging the problem.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




