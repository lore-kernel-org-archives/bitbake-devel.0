Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5C09C7E8F5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 10:05:55 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x15so4694714wmj.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 15 Jun 2019 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=rT9hC4VwQe49JCofZrw7Mytr91XAsMWwyPtCbik6Yco=;
	b=d7Co6xk3o6SG6/aGjTJzxZlanNN+qElm5kwsFjXts9L2hF+UoX0Y7mZnU0wrXXtrsI
	5rruBoTksaSFYsRczi5aYgNhNeTi4RfICPkQY5HLvvj2wg/iagijvPbLIAQt4nhn9mQE
	es9ao1x9WgKkAZivWviF4atCCs5iTYxuWhL2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=rT9hC4VwQe49JCofZrw7Mytr91XAsMWwyPtCbik6Yco=;
	b=eYOrioGmzIlnVFNINQuxXfMCf+rpbOPrVIthT11Eo7ycw9P/PaATh1+6bO0BZa1htE
	aEHdaL5Inp+JZI+ZEYXT9bzxBDU2sma0uMYN5XDvcIqzsf3iBfZHUTaapAJ5323EhFmP
	xyE9+WELfpwxEE5JzYZztKSkykOMlimzswtVoyrUgkTqpI5zNMGHpMBy4bOCp4U+4CZl
	g9XlFPygEcHEl5O0sys0Vy0v06FkgwHAcfLV1nLXCcJvSMdJMfs4oyevrSuwFT0etkae
	Obah0dkxVigHctM1Jh/RancFEWM6XYr5G5aYAmb9mdDJjX2FklFFI5DVLS5zthamCwgq
	aDiw==
X-Gm-Message-State: APjAAAWGu7FFSSAhxeDt/+lYIAk76FAtn8OczFuTMY5K9/Vti0KdnjUk
	iPa2ztJHop3Ebk1U3uO1pmX0UQ==
X-Google-Smtp-Source: APXvYqwirOvcExHBl99LnR1WTgBiQPuDRE5t6MCRpZO0Y1z+0kY7ev2xgHkfJJP9DtBad3ST8zeG/w==
X-Received: by 2002:a05:600c:118a:: with SMTP id
	i10mr5731120wmf.162.1560593155942; 
	Sat, 15 Jun 2019 03:05:55 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id u5sm6912655wmc.32.2019.06.15.03.05.54
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sat, 15 Jun 2019 03:05:55 -0700 (PDT)
Message-ID: <afda1b3651286141fa61d53afd0a38ec24ee84ef.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Martin Jansa <martin.jansa@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Sat, 15 Jun 2019 11:05:53 +0100
In-Reply-To: <20190615072409.GA1486@jama>
References: <20190615071743.9494-1-Martin.Jansa@gmail.com>
	<20190615072409.GA1486@jama>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [1.40][PATCH] bitbake: fix version comparison when one of the versions ends in .
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
X-List-Received-Date: Sat, 15 Jun 2019 10:05:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2019-06-15 at 09:24 +0200, Martin Jansa wrote:
> I was seeing the same error on versions not ending with '.', in my
> case:
> bb.utils.vercmp((0,1.0.2r,r0.0webos22),
> (0,1.0.2r0webos19,r0.0webos21)
> 
> Which lead to do_packagedata failure through
> buildhistory_emit_pkghistory shown bellow.
> 
> Alex's fix works for the above versions as well, should I extend
> the bb.utils.vercmp selftest with even weirder versions like we're
> using
> or leave it as is?

Adding such examples would be good please!

Cheers,

Richard


