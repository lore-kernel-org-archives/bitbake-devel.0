Return-Path: <otavio.salvador@ossystems.com.br>
Received: from mail-pf0-f176.google.com (mail-pf0-f176.google.com
	[209.85.192.176])
	by mail.openembedded.org (Postfix) with ESMTP id BD8D77731E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 10:11:49 +0000 (UTC)
Received: by mail-pf0-f176.google.com with SMTP id o185so11550270pfb.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 03 Feb 2016 02:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ossystems-com-br.20150623.gappssmtp.com; s=20150623;
	h=from:mime-version:in-reply-to:references:date:message-id:subject:to
	:cc:content-type;
	bh=SAHumlWtcVxx1yE41aVBT5HJ/xX4sfNuXwpIueZ+yYA=;
	b=hyQAMleUgCPjcaV7hKJa+OqKGEuJdc7HTKcFYJ+VeuYLtn0aOOsXQ7UQjCEB9zTcvd
	EE2H5KtHtwuPQR1dkKjF8GJVkss55wp28cmPXxcBKW7wUi5AdHL1EGn24EqJK68w00mj
	ehuarHRxtC6bfPOgHvph60ucXm0qTm9MxXj0TarhV/xfXAtfTAzYUQzsXDfzAEUkRFtK
	5OajjBZ1TgwLtiv0Qzh/A10M26lHh3MoAKLe0kgXUfX8p0KFUYAtOhao/mdht19oZkAH
	R+FN67teyGnaxRSfUzlhzP+2AukQOaCGXwKwhD7vE5qu++GAMP1Kq88FnyNNr9MZoDbx
	48Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:mime-version:in-reply-to:references:date
	:message-id:subject:to:cc:content-type;
	bh=SAHumlWtcVxx1yE41aVBT5HJ/xX4sfNuXwpIueZ+yYA=;
	b=FXtJvY443mfKNXh6jflM7pHTKtMMufh0O/tZuFBea8ZOEGmx8cTOyqgJ0P3nltWclB
	IwvqoRYgaTx9eSPPnx7VzC/zH/163mSICmtZ/ED7U3cLyMaOnavcyGwFukqxsbwVwQNV
	N181ZIUWANsxlPhi/vIdLI9WQ5+KPYdRKkN3v8TJKbUELYC5LX8S1lt1nmqf96Fv7bzj
	bTpTbc+8cW5oue5QgTZrwcf36F8Toohp10p+SEHvv3ClNuV/0aKTKDpkwTsssWPvAm8p
	azWv91SqN55D0Xq8WWFNksJCrv06upSVlbFdYvaxTdl/vSyBFlImcZn+5S6cgwhjHVpL
	1dXg==
X-Gm-Message-State: AG10YORH2dER5RjeYGkUpmqfqdYjooC5UdbIpzkKZl/Wd2w6jGMChR9HUCp+2zedq4f3Vg==
X-Received: by 10.98.87.196 with SMTP id i65mr937885pfj.72.1454494310128;
	Wed, 03 Feb 2016 02:11:50 -0800 (PST)
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com.
	[209.85.220.47]) by smtp.gmail.com with ESMTPSA id
	g26sm8677565pfg.35.2016.02.03.02.11.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 03 Feb 2016 02:11:48 -0800 (PST)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by mail-pa0-f47.google.com with SMTP id ho8so11233948pac.2;
	Wed, 03 Feb 2016 02:11:48 -0800 (PST)
MIME-Version: 1.0
X-Received: by 10.66.129.232 with SMTP id nz8mr931970pab.102.1454494307869;
	Wed, 03 Feb 2016 02:11:47 -0800 (PST)
Received: by 10.66.72.229 with HTTP; Wed, 3 Feb 2016 02:11:47 -0800 (PST)
In-Reply-To: <1454457340.27087.143.camel@linuxfoundation.org>
References: <1454457340.27087.143.camel@linuxfoundation.org>
Date: Wed, 3 Feb 2016 08:11:47 -0200
X-Gmail-Original-Message-ID: <CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
Message-ID: <CAP9ODKqGa0Lurxye_+TviFbxBT-d3sf2D3tD_WiR9er_RcFsKg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [Openembedded-architecture] [PATCH] data_smart: Drop default expand=False to getVar [API change]
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
X-List-Received-Date: Wed, 03 Feb 2016 10:11:51 -0000
Content-Type: text/plain; charset=UTF-8

On Tue, Feb 2, 2016 at 9:55 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> At some point in the future, getVar should expand by default. To get
> there from the current position, we need a period of time where the
> expand parameter is mandatory.
>
> This patch starts that process. Clear errors will result from any code
> which doesn't provide this. Layers can be fixed with an expression
> like:
>
> sed -e 's:\(\.getVar([^,()]*, [^,()]*\)):\1, False):g' -i `grep -ril getVar *`
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

I am in favor of making it mandatory but I fail to see what we gain in
making it expand by default in future.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

