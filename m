Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id 2A1B17F278
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 21:08:53 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id w12so344993wro.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Sep 2019 14:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=AKtXwugHh6fMH6DXNv62ksOLS6BwKuFgjh3v3BRF3S8=;
	b=Mnu/QPZU1MnJOZTUNET8TLV7S5mxTTjwUxgQXyJXQaFiXB4+YXlPQRCVlwN9HHj6Bg
	10BWEZcwyG6z+ARDdA5FSNxdLYlLhLP93xsREA8oWUrFGR8TTsm+m3DD4/5+ad9iJ6px
	2s0zUDJqouKTcbwZx33U5bMGCE07On6TecxOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=AKtXwugHh6fMH6DXNv62ksOLS6BwKuFgjh3v3BRF3S8=;
	b=Gm/6RIDBTMh+JRCewFvKUe5R/OVnakPPXJhyI/rK/NHhcu5Md+l68MMjERg5SjTmss
	SRoBZL4nImtRZDIMmP/IL9yl3+XHSKoe8aaR1Z8SxmQpwOfthje8H1FmuxCS46wKetWc
	xS8wlGsigk11nXIUWjRBo1C70yR1Ei8M3Ezpz8taTLn3aEWuqcCf3ui1bOe1KSy/FOQQ
	opWaw9l6kLPh0Y8ZWVGIOPeK+TnbRh6eKrQGehGpr3AhYv1RmxTnh/3bC34eQOogDGeQ
	G6IerMQFW/kJeYD08NcA/cTYQFWhQjRLZ1ByfQSiKWhvs0s52M1NHM0Z5bgPpjAxkPQ5
	8XIQ==
X-Gm-Message-State: APjAAAVeUkkyMAhWnqZpqMUplKbARhnjiWlx9YrxZzbEhuueePXt8xqc
	oTMv+d9XPqfF3ROhzkXOibUcyfkzg2w=
X-Google-Smtp-Source: APXvYqziNXi/WZ2/7ZyfYOX3vjJXZCug6MusVIlvrcByhyqDXZgZVd/xHaC1fisoY8w/++tOhx2l3w==
X-Received: by 2002:adf:e607:: with SMTP id p7mr320402wrm.230.1569532134707;
	Thu, 26 Sep 2019 14:08:54 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id v8sm331747wra.79.2019.09.26.14.08.53
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 26 Sep 2019 14:08:53 -0700 (PDT)
Message-ID: <63e618d3ffaf83959d6a0f62ae1a6b17d556d480.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: SHOAIB MUHAMMAD <19558058@students.latrobe.edu.au>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Sep 2019 22:08:52 +0100
In-Reply-To: <MEAPR01MB419977871A4644D3FA437302C0860@MEAPR01MB4199.ausprd01.prod.outlook.com>
References: <MEAPR01MB419977871A4644D3FA437302C0860@MEAPR01MB4199.ausprd01.prod.outlook.com>
User-Agent: Evolution 3.34.0-1 
MIME-Version: 1.0
Cc: ADARSH KUMAR <19844172@students.latrobe.edu.au>
Subject: Re: Bitbake Error
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
X-List-Received-Date: Thu, 26 Sep 2019 21:08:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-09-26 at 04:47 +0000, SHOAIB MUHAMMAD wrote:
> It seems that a command is outdated with the current system I am
> using. I am running a Linux 18.04 LTS on the host PC.
> Is there any way to fix this?

You're using krogoth and that is an old release (and now unsupported).
You'd need to use an older operating system to build it, either
directly or in a container/VM.

Cheers,

Richard


