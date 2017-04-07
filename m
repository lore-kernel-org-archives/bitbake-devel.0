Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
	[209.85.214.50])
	by mail.openembedded.org (Postfix) with ESMTP id CD65D77D0C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 08:54:40 +0000 (UTC)
Received: by mail-it0-f50.google.com with SMTP id 19so19635594itj.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 07 Apr 2017 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=zsgN+Sq6JxroQZp2TniacdkSbDwhGfsSg6Yhq8ADf8w=;
	b=xWxNPeI0PMsGHNjLIzEM8jzTipWIIIXzUVBoV7jaaqE7mD+xC3PwQW2PVwBcISv1F6
	ub8lv3EHbSJ1+FBQyUQAXZ8iSAFpPhJaz9zg4DKDHMaM74zMTsbHot4+ZzMGrOvD/YAo
	wy7VyVwtCmT6EeRVjq7TcT/C0/r3ame5/Xm3yd89hC4Ayntme9xV4K7Iv5A99RTKgEVK
	cEWZ5mSdy9JYVbjm3PD9kwSSZmMSBS+/+RWi18fd5yVv4RCUX0y3H7c4M8YgCx/6TbaL
	uCJH2Yt3pzynhoVu9+9fnuEkkdoJQecZv4aAaDjwNrldmfo87UEAFUnO7hIAwf4MqPPq
	S67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=zsgN+Sq6JxroQZp2TniacdkSbDwhGfsSg6Yhq8ADf8w=;
	b=Q72Brkj/nAF2Fm90Ol3nA5K99xeTPJ9WFPNsWfFykfRUWDOPcbweZTqAeqNxk1iQlC
	wVC2bhiGs2bna8btfq2ADr/OOq9/GFybb2pNvgDKxJdO7SBB07mOEwXkRtmYowkWsjqZ
	YBF7pK0CUzDhJQEFiaxGHzrbIWagT+cxM0seSG6jr40hmji5b5mbAwKp+ikU14w5M/qD
	CqMb0cZELWROK0XLCYuPJS+aLg8xx35Z6D6P2Xpsop7jHdtqzMFCpJemgOYoHtdvInDc
	GvN0utNnGkSYfeuXd5TIASZwP09awBiyPFV7WZMkO/HGOXZuRIP53BSyF7XBCl6VXEQz
	wTYg==
X-Gm-Message-State: AFeK/H0V24m2eYrLkHfxDtZ2sLfxn7pm0xQYOMhRL0OqicQlK3Y8M113
	2vNX+XczFVtaQM2D
X-Received: by 10.36.252.65 with SMTP id b62mr30091227ith.38.1491555281817;
	Fri, 07 Apr 2017 01:54:41 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8EAD9.dip0.t-ipconnect.de. [93.232.234.217])
	by smtp.gmail.com with ESMTPSA id
	a68sm9015305itd.30.2017.04.07.01.54.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Apr 2017 01:54:40 -0700 (PDT)
Message-ID: <1491555278.10884.71.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Fri, 07 Apr 2017 10:54:38 +0200
In-Reply-To: <51436031.kQGnlfrvNB@peggleto-mobl.ger.corp.intel.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<1491551779.10884.69.camel@intel.com>
	<16393836.ok1xE2uA39@peggleto-mobl.ger.corp.intel.com>
	<51436031.kQGnlfrvNB@peggleto-mobl.ger.corp.intel.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Fri, 07 Apr 2017 08:54:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-04-07 at 20:32 +1200, Paul Eggleton wrote:
> On Friday, 7 April 2017 8:29:18 PM NZST Paul Eggleton wrote:
> > On Friday, 7 April 2017 7:56:19 PM NZST Patrick Ohly wrote:
> > > Am I using the tool incorrectly or are my expectations wrong?
> > > 
> > > My expectation was that "bitbake-diffsigs -t m4 do_build" would tell me
> > > that m4 was rebuilt because some tasks that it depends on changed, and
> > > then I would drill down to those tasks, eventually arriving at
> > > do_install.
> > 
> > Hmm, something has gone wrong here because this is the exact scenario it's
> > supposed to handle. In my similar tests it did work, so I'm not sure why it
> > didn't work in this case - I'll have to give it a try here.
> 
> I send and then I immediately realised what might be wrong - you said you're 
> using poky master which implies that you haven't also applied the patches for 
> lib/oe/sstatesig.py that I sent to the OE-Core list today. If you haven't, try 
> doing that, it should fix the problem.

Indeed, I had missed that part. It's working now for do_install.

What about do_build? Should bitbake-diffsigs be usable with that?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




