Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 6A2507D380
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Apr 2019 09:01:25 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id y197so13828609wmd.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 08 Apr 2019 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=eNK6JIe56KAACVC/XHfdFiz94fp0XVtExJF3q5vryYM=;
	b=IC5caiN4HKyo4JJzNUDYv6M8Sm1GUzkTnqc3ix0Fjkzmaq6VyFBY2KE3TOpVcowPyB
	pVlXTAGAs89ZULoEphdagStVF3WZ/oSM/5R8OSJmUsF11mbb7KzT6UdVVwOZlKxrqWkL
	OXBWgj578TuF4SCgHV/6+NKU9BpDYyqo/I+zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=eNK6JIe56KAACVC/XHfdFiz94fp0XVtExJF3q5vryYM=;
	b=aFzljawsY/YS/7aUi00VCWczbqij5L0bYV9WDf9e097lssngoZwycbsu0lF93lm+T3
	Rby84xDzHev6rrGp9SNYl420ZCZ43UMdWkzDBWdiM5h+JvNiZzMKe0k2qwq9yZbsRKOR
	m2AHilDYJBY07HH3TryJxDr0/WrJacxmn+ysIH98be+Q6v6oCq8z/epMYFgYhKOyoqS9
	DZswRHlpWSwnT0HmhmkLBPlMHmBKTk/FDou9N1hzveIhTuw/8sJuir4Bb0CdbPvgQ1yC
	vOt9OSzkXTaHOLH5qyW+OVHUs1WBYaHyLlepNFmMFT/eWnA79XuHwHKWPA/KBNTvuut9
	uDgw==
X-Gm-Message-State: APjAAAW90hIeqgt/iEOtmW9kSrtr9t6OXqHTV1Th4nVu5wSX4gRyacL4
	G9EtKyj6g+5Q0oaSnJM4HcaOKA==
X-Google-Smtp-Source: APXvYqzIs1JNnPmNf5MDbcG7Mfut6FpHgFoxqVK3zvlTHaDjqwmDKrQr/e6CBeqQCUYVZTUJsqVMGg==
X-Received: by 2002:a1c:81c9:: with SMTP id
	c192mr16586399wmd.124.1554714086191; 
	Mon, 08 Apr 2019 02:01:26 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o130sm11674956wmo.43.2019.04.08.02.01.24
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 08 Apr 2019 02:01:25 -0700 (PDT)
Message-ID: <03b6d5b6154f87bafc132a26894d04ca1fc1f16c.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 08 Apr 2019 10:01:18 +0100
In-Reply-To: <52961ec262083777d20e7711fb5b1f2b9d3196ee.1547620210.git.liezhi.yang@windriver.com>
References: <cover.1547620210.git.liezhi.yang@windriver.com>
	<52961ec262083777d20e7711fb5b1f2b9d3196ee.1547620210.git.liezhi.yang@windriver.com>
User-Agent: Evolution 3.32.0-1 
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] bb: siggen: Add a prefix for uuid4
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
X-List-Received-Date: Mon, 08 Apr 2019 09:01:25 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-01-16 at 14:30 +0800, Robert Yang wrote:
> This can make bitbake-diffsigs and dumpsig easier to understand,
> otherwise,
> it's hard to know it is a random uuid unless look into the code.

The correct fix for the problem as stated is to tweak the otuput of
diffsigs/dumpsigs, not change the contents of the file...

Cheers,

Richard


