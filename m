Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 9B2917C346
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jun 2019 08:51:50 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id n4so12061408wrs.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jun 2019 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=iVm8C7Vi24DRTXBhn9nfEqquN7r4WCrr2e7jGXUxdJg=;
	b=V5WupWxzCLyPlDYFKZfRlrkwIREr1R5WeGIdTJ2SdZmcg7Q0XqS18Q/yVdEpHiFwJB
	X6weZFEBtaG0mdWnIdesIwmNg4JdslT16lepjm26FUN+4Qrl+U7kgOYLHBcS8ZSlenSM
	yz9j9k5xmJ6LsmwZ+gzzti2dIHq0VwWszqXA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=iVm8C7Vi24DRTXBhn9nfEqquN7r4WCrr2e7jGXUxdJg=;
	b=FONGrL+X/GflLYW4Iv9gWpDULwp43Sk5nH3pFWF+ugd16z5olEfS+w4UASVTdCPz3V
	pORA6lDUeNwlFRObHQ2NfNBgNv4q/0bB2OxgD4wDN6WLFwxYVAlPD2FEXdhkvb7dMNl3
	PS+Y2d3Pezmm+t7nFmZTBnuhy3AaOb8AnVoS0IBrG7NxzeeQT7WNNOaUV/VcoGUNYWwK
	kBKCpS1uxZGLbu2WbbFucckV3CZZnysfL7uA+Ba96+4ySsFE2rJ/GntsECFNaQi0W/qm
	SaxmZZK1rNM5GpnS61aojoqxUQ1z2mQNuKJ2Wqgw1/JPNMAlm2HfLU+h14rCFkMCSQNj
	eYSw==
X-Gm-Message-State: APjAAAW7HcVwUnwDgV6lDltxnlc0e+jwW0fXnxzHmrbWZjEIO92cENF3
	UOAKhg13HZnL+mAaY9CLNsR+ig==
X-Google-Smtp-Source: APXvYqyWHWXuOcRluIBAFwN4/h/czEo/UNGnNDC6YfjCL+wI6fnvMt4AuI3PLF3XyvXKSCLkdQqqcw==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr12020428wrl.27.1560243111404; 
	Tue, 11 Jun 2019 01:51:51 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id r6sm6781133wrp.85.2019.06.11.01.51.50
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Tue, 11 Jun 2019 01:51:50 -0700 (PDT)
Message-ID: <ad354220c10b316720cb74003b830f0f8bac35e6.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: "Reyna, David" <david.reyna@windriver.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jun 2019 09:51:49 +0100
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0F3CA1F08@ALA-MBD.corp.ad.wrs.com>
References: <cover.1560127238.git.David.Reyna@windriver.com>
	<2784075cbd0cc105c8c6ecdced2226de94d4b343.1560127238.git.David.Reyna@windriver.com>
	<8b6337f60aa01cc8e4c940f6fb20f4d8207d2b5c.camel@linuxfoundation.org>
	<5E53D14CE4667A45B9A06760DE5D13D0F3CA1F08@ALA-MBD.corp.ad.wrs.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [THUD] toaster: Fix Thud Bitbake release for YP-2.6
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
X-List-Received-Date: Tue, 11 Jun 2019 08:51:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2019-06-11 at 08:24 +0000, Reyna, David wrote:
> Hi Richard,
> 
> > When we fix an issue like this we really need to fix it on master
> > first...
> 
> I was actually not going to fix master because "Thud" disappears from
> these files and gets replaced by "Zeus" when master finally becomes
> "Zeus", but I understand your point.

That won't happen for another few months so I wanted to ensure anyone
using master sees the bug fix and doesn't run into the problem.

> > ... then backported it to the 1.42 and 1.40 branches with a
> > straightforward cherry-pick.
> 
> That should work. The affected files are slightly different nearby,
> but since the cherry pick worked those differences are fortunately
> outside the fuzz zone, so all is good.
> 
> > Can you check I've got the right changes in please?
> 
> Yes they are!

Great, thanks!

Richard


