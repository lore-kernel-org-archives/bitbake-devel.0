Return-Path: <twoerner@gmail.com>
Received: from mail-it0-f44.google.com (mail-it0-f44.google.com
	[209.85.214.44])
	by mail.openembedded.org (Postfix) with ESMTP id 3CB6562132;
	Fri, 10 Jun 2016 16:07:09 +0000 (UTC)
Received: by mail-it0-f44.google.com with SMTP id e5so13838715ith.0;
	Fri, 10 Jun 2016 09:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=0NkOpmpARgaSxWXYjpxE4MaROCzHsHQ11LjFvssuvN8=;
	b=iCEoz/fwxTDx7EdQRNpDquL+MQUbkAjbZkOhrCTCGJrpJzXroTd00ZGAi7Gqq8LJg3
	U/Db7WEA+taBdAy9b5kD1Hdvmk6wAPwcdgaSyO2URCeQ9SbhEwbR3g5byYqaiilS60Y3
	x+FGmwowVFEMBmYk/J1aEcppbSopN4fp2kUHl3pksSWFJQ9c65u4OUxgUBcNH5vcSxN7
	P5zPqlVFlhoxhOFuN3HeXAWWNJKZzK2eNveOey2dQ2+ix1ko6uyldH2lyYCZQyaZQlZg
	AY+1HPHv8NIB9V7GbP+4M4n7jxKswTPEr1OB3xbQipzTaEgZlyy2K9zaxg5A5V5e82ql
	iSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=0NkOpmpARgaSxWXYjpxE4MaROCzHsHQ11LjFvssuvN8=;
	b=WIT0JZBed97nJMPdseOU7BACypOnoLZ5BDkqizlopOPudTD/sfc9eHczy/Ovxq1alF
	v+ARSTkQTEvbPJfWM3Oi1UxDql9/uS6yhsoEpV1kCrpHMZQPU8/jybFaqyPotN/l+iR7
	aFA+Cj+mMuijIr8CrKwP7SGWn6dLrzvv+6VBARCI9x2rBxqeWdT6SIXLpHQZhEe9T4M1
	1xzO8zB0B3ULvtPKB9rJnhGB12k9Fy3cuGD7qoyWwgGmoMQqf4vFtwdJviEnnaiOQ99q
	47ds9SOZX9lN6CWLoMQiZgnt0Gl8PF8XKkfBpGC2Bl+/Osc/I3NLIxK128CjYn65fDd5
	InWQ==
X-Gm-Message-State: ALyK8tJ76L4VQVRZyx1H0euxzPqEs46E0dg/R+cBS/fh5AFGZHODYTxHyIfnlBNcG5kujg==
X-Received: by 10.36.144.198 with SMTP id x189mr31251788itd.69.1465574829819; 
	Fri, 10 Jun 2016 09:07:09 -0700 (PDT)
Received: from openSUSE-i7.site (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by smtp.gmail.com with ESMTPSA id
	m86sm2166202iod.36.2016.06.10.09.07.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Jun 2016 09:07:09 -0700 (PDT)
Date: Fri, 10 Jun 2016 12:07:10 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20160610160710.GA18625@openSUSE-i7.site>
References: <1465572809.13979.185.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1465572809.13979.185.camel@linuxfoundation.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Multi-configuration builds
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
X-List-Received-Date: Fri, 10 Jun 2016 16:07:10 -0000
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri 2016-06-10 @ 04:33:29 PM, Richard Purdie wrote:
> A few people have asked about multi-machine builds.

Do you envision each config also pointing to individual bblayer configurations
too? I.e. if I'm building for 3 different MACHINEs, with 3 different configs
(local.conf?), then there would also be 3 different bblayers.conf's?

