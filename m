Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by mail.openembedded.org (Postfix) with ESMTP id ED7967BEE4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 17:25:46 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id r24so6599118wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 09:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=bRccvz7UQenTnnl5CGToVgxV+YF4XRYyCKTG4FWVhpg=;
	b=HkzwjJTjA5zma/KaPhe5tMvqdwnIE8m/UhR9FL5G3DnbAbrDc8uPkzXTS0avdGJEwp
	IwpmpectT9b0KSeciElgmdW4Bqkh4SLPvy8wbtdlApSe2J5gGFlNhMIDj5HvWmT19W4t
	ZAfFFx91cNfkSsQf7sVggebHga+cEXu5SgxpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=bRccvz7UQenTnnl5CGToVgxV+YF4XRYyCKTG4FWVhpg=;
	b=XL/uu/tCBDdPwKmjc/S+3tCJXjp1W5QmM0CKSh2SLveTNpIQERpY8k7xwU3yln/SO6
	wNM1XYEJDIfwixLHT5uF2bRJkyL24jKKn2aF3rvMjRw6vgEIixHOSP0EwB/PDQWTWJK7
	lcIAairVns73xawKVpD8iDcZEwFnmQaJ9HVgQ4uaC0h7U7l0YieLfsEUCq2D8d9czQm8
	kG5UR1wiG7fPh2vU132UPDnAbbDffRG2ZPOAbYYNSb+BgWFhRC59S+qlNBBJGvIHmDNM
	74hHgIKqIMHgnrVHeGHnMebJBmmLt0TTx3uMXVUMK9nlWalcg3LBibfgA4Qx9q6ritkR
	b1Ag==
X-Gm-Message-State: AJcUukdRx6NdzZd9g4b56Rp4BRc1WofYuX1KdXvBn+PBF9Lz9TainL6A
	wR20yHYFsCFyzacNaNEi6xUmOg==
X-Google-Smtp-Source: ALg8bN4CCAaOJPFwYXmUvpUVhDKQbfCbPuTC1rxEF0o6wG+s1Tdsk2b/HSaSrS9GltoEibsXUI3ncw==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr9526147wmc.25.1546881947501; 
	Mon, 07 Jan 2019 09:25:47 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o5sm14064099wmg.25.2019.01.07.09.25.46
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 07 Jan 2019 09:25:46 -0800 (PST)
Message-ID: <dcb48164018d247d47ccd5400d47347dfd6bb428.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Christopher Larson <kergoth@gmail.com>
Date: Mon, 07 Jan 2019 17:25:45 +0000
In-Reply-To: <CABcZANkY0HGOzB2JKZC08=QzRzM_BoVJf0PZ-MrRFcD1XZTMRQ@mail.gmail.com>
References: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
	<20190107155536.6062-3-richard.purdie@linuxfoundation.org>
	<CABcZANkY0HGOzB2JKZC08=QzRzM_BoVJf0PZ-MrRFcD1XZTMRQ@mail.gmail.com>
User-Agent: Evolution 3.30.2-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/4] cooker: Allow faster exitting from parser threads
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
X-List-Received-Date: Mon, 07 Jan 2019 17:25:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2019-01-07 at 09:02 -0700, Christopher Larson wrote:
> Empty is raised when it times out, not just when it’s actually empty,
> though.

Good point, thanks. I was about to rework it but my next patch removes
it entirely so I guess I can just drop this intermediate one...

Cheers,

Richard


