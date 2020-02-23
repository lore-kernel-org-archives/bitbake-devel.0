Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 4748661825
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Feb 2020 23:53:59 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id n10so8318833wrm.1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 23 Feb 2020 15:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=8pe9HFWQf3hadZAuK7vToXYADg5etAK4/8EnTC6MjPM=;
	b=bUJoQWLB/F0m4dsGd1a0t1aWmDkw6kTeX9xg/fW9yEZXAhaZdvgIC1mwJ4JNeqNnRT
	aaUnYldYkixo1QRQo1vmY9bminiOiWiGv7ixK40vkOUWAorf/DZRyMmSy/CJZhxCeTbT
	vOW+q2WPJmGjmMF/kqBzv8yOIKntqkWPtR5Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=8pe9HFWQf3hadZAuK7vToXYADg5etAK4/8EnTC6MjPM=;
	b=RRBIxnMx3oUD7JCW3oFf1J8KHPDIc58UzG3/w+YOFeOH6ZFxwJWhxrVYkQckJ1i0MH
	sUH13CGCoLIAi5Zt1ow4KcFQ+Bce5xg8Ys0u7u7ofesuoyEON3dhnxFfoP2+VR3ElJh1
	SzcBxdxhRWG0LDCiMYR+Pk7JAIy04tEEkUIGTMPmzKFtnYV7q8BHs7QI/MLMHR+MI6kr
	Mic+D7ArqWIk8hGoATA37ASNi45+87AbUugqNzwvG+3vAqvxIz+472RUubDCo5pJhHAP
	yrw9DhVLZesDUHBfaaHvsbIRJ9ONw/FJaQ/WzOUmdaJhc9olGHEtKlm5fMebuMpQDdqB
	Ucvw==
X-Gm-Message-State: APjAAAVr40dxcSSyZtE3RbGiH5agXEaSUfQnuHgczzM1w6SZ9CwtoU/S
	R2nYxURi58yNu7Ye4q27INr/WOpVbuM=
X-Google-Smtp-Source: APXvYqzc4ZXD1Xz6cgPw8IYURjBE+UzPUJnuC6SX+A7FYdush0nJGsUviQwnmQXujZ5bFMYfkDwU9g==
X-Received: by 2002:adf:aadb:: with SMTP id i27mr66072484wrc.105.1582502039823;
	Sun, 23 Feb 2020 15:53:59 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x6sm15081300wmi.44.2020.02.23.15.53.58
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 23 Feb 2020 15:53:59 -0800 (PST)
Message-ID: <49d09c50265086a49798d59c8569323c37bba430.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Adrian Bunk <bunk@stusta.de>
Date: Sun, 23 Feb 2020 23:53:57 +0000
In-Reply-To: <20200223195148.GB3444@localhost>
References: <20200221205213.16130-1-bunk@stusta.de>
	<e349f1cc1d3b36fdff330dc7eab1f213a67d32b1.camel@linuxfoundation.org>
	<20200223195148.GB3444@localhost>
User-Agent: Evolution 3.34.1-4 
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
X-List-Received-Date: Sun, 23 Feb 2020 23:53:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2020-02-23 at 21:51 +0200, Adrian Bunk wrote:
> On Sat, Feb 22, 2020 at 03:54:54PM +0000, Richard Purdie wrote:
> > ...
> > b) We actually fix/improve the way logging works.
> > 
> > I'd prefer b).
> 
> Makes sense, I've submitted this as bug #13813.

I note you believe this has to be fixed before we reach M3. I guess I'd
agree, I just don't know who is going to do it.

Bitbake bugs get auto assigned to me. I physically cannot actually keep
up with the incoming bugs despite working more than I should.

I was actually trying to do something about my bug count as its
seriously depressing me. For each one I try and fix I seem to find
three more intermittent issues on the autobuilder :(.

I know you didn't mean it this way and we need to track the issues, I
just don't know how we're going to handle it.

Cheers,

Richard








