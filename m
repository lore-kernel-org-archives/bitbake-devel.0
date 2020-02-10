Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id E99606022D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 14:17:41 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a6so522337wme.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Feb 2020 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=FxS3KaLDROgdGNSxBoo8FRWCyblSR+rp0Gqu0UTu6EA=;
	b=GmNI9OTwGihYQ2rh8Snu0+H89ZCskohSEInWbc6qmJudzLGAmsXlbfQEQVAJTPaYmd
	64/L9Z/byn72CejK21gae7h3YVr+P8j6CNJsE5eHIiSf11NF1yt2D06JygLbIP4HGgmC
	OdSXMslOJ5haBsdSlqa+iPUL3V3ASLRrTapIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=FxS3KaLDROgdGNSxBoo8FRWCyblSR+rp0Gqu0UTu6EA=;
	b=ASRSUOM09gsL7Gk/fIRHRFfHNE24w8EMlrLwJgH90LENVjNcBUtvgQJZQqcfmSTyod
	VlnAkmCX9EC7s8Qhf4rkhHDRJ76i3Mjzye1C0NW41jwY9fqynlbSpIl318opP9uOP2N+
	iaukjGY0UanJDTx1ln2qs2OnoyrYI3fxaoV7w3NgjIQabLjsdQnB9M0VKfV5JNO0mXTX
	Tu+l91qKGPmo6RjbsmZ6mRCUoFgTAJokLrvPWW5lY3L+lkuKWmv4Hj8+KhlzKGOfwMZ7
	WYPTppGcGsY0PCSctRWbKOK3um9WllYIg5UzzYh+5gUSaNjnpamsgVe6T9xiyKqPUjZS
	yelQ==
X-Gm-Message-State: APjAAAVJGtj4NAuhOZ9b0pBr+co/UgctEjTy4hdof8LlQYEC4m5CwaNP
	QlZxdCCe1KAyEJJ5u4r8w7Rt2w==
X-Google-Smtp-Source: APXvYqyRxP22NdUKLuroa29ik61k6u4dt0n5RtdsSC3i2EBv3O2Ec1+ZtPxxU6ixIWUhVUhEaCKrGQ==
X-Received: by 2002:a1c:9dce:: with SMTP id g197mr15052410wme.23.1581344261821;
	Mon, 10 Feb 2020 06:17:41 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id w7sm773891wmi.9.2020.02.10.06.17.39
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 10 Feb 2020 06:17:41 -0800 (PST)
Message-ID: <29677f1ba34d00b61ad1375b38f56b20c3e98d50.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <pkj@axis.com>, bitbake-devel@lists.openembedded.org
Date: Mon, 10 Feb 2020 14:17:35 +0000
In-Reply-To: <20200209085034.16349-1-pkj@axis.com>
References: <20200209085034.16349-1-pkj@axis.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [master][zeus][PATCH] uihelper: Track scene tasks again
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
X-List-Received-Date: Mon, 10 Feb 2020 14:17:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-02-09 at 09:50 +0100, Peter Kjellerstedt wrote:
> Track both scene tasks and run tasks to provide a complete progress
> information for all tasks. This avoids the progress bar from stating
> "Currently XX running tasks (0 of 0)" while progressing through
> thousands of setscene tasks, obviously confusing the user.

There was a reason this was removed, this can't work unfortunately. 

The code was changed such that setscene tasks can potentially be rerun
so we have no idea what "complete" looks like or how many will actually
run. I'm not happy about that but there wasn't an alternative.

Cheers,

Richard


