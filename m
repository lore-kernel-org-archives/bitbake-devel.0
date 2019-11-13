Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 576AD7F36B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 23:27:06 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id n1so4333776wra.10
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:user-agent:mime-version:content-transfer-encoding;
	bh=6k/ijBe8MyEuUeHcPvkJSvV18l/EVb0VBXyC+ph1+A8=;
	b=cF5SCfrjyUBu5GHL4Zg1ttquPEBCW/KQbM7kjm+6fDjjGyn0Trpwm3WYUrg0dZSN7z
	gVxdTTSgEt8DXGq1XeAnBNtlum34DPvngXtdxwwQC/tUfJm1GKrJRX9UY6IajHbCPuq7
	Plw+pF7/S/EcHUjNRAgJkfowORoRXctpmuy7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=6k/ijBe8MyEuUeHcPvkJSvV18l/EVb0VBXyC+ph1+A8=;
	b=HJRfq3hbU4k10vJ8kzzqYW5x6dGjtzofSKosDe9RuQO8fQoC7vDQeVXlCOcUSjQjlt
	Ai7X+ptva9+6RuyEzKg7lxkYZDWUjQI5xRKFMVX0LZYIzhQE/+jnf0ITHmEMJoTpnCqF
	6H581Nn73wkrplIX9+MnEEJa9i9qGvfVu6h4t/Guua2yBxDEE5ACXq2aag0f8efSbVLd
	Skvt0s5oiQQZv2UQ+Akz9jG0MkZrKT3nF8SgBdqsf28npFZQOGFRi6LWCcOYvzMK6lhm
	wplQUTMZdV6xq98wP3Wc268La682mJOycNg2TU3V/bbfZuzQvOG2hP3F0piEddFC/Cnn
	nYZQ==
X-Gm-Message-State: APjAAAWNG84+x8XLIAHQy78XVqTxwnudLe2Tj1gYTy4ikfYHUwRSzh1F
	yZx+UL4rdN5Z+h5NRAPCSfC0NQ==
X-Google-Smtp-Source: APXvYqzr+O4WpWzWyBab9WIRzb9x0vnuHLqXaHqESO8+X0nKwRtrmA0z2S/HnVFBld2OBKXlf/qNGg==
X-Received: by 2002:adf:f5c6:: with SMTP id k6mr5003704wrp.245.1573687626912; 
	Wed, 13 Nov 2019 15:27:06 -0800 (PST)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id t5sm4515688wro.76.2019.11.13.15.27.05
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 13 Nov 2019 15:27:06 -0800 (PST)
Message-ID: <8ca66dfc3c6ed6f930bd121f1c3d48c2c51d9a1d.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: =?ISO-8859-1?Q?An=EDbal_Lim=F3n?= <anibal.limon@linaro.org>, 
	bitbake-devel@lists.openembedded.org
Date: Wed, 13 Nov 2019 23:27:04 +0000
In-Reply-To: <20191113232303.29047-1-anibal.limon@linaro.org>
References: <20191113232303.29047-1-anibal.limon@linaro.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on directories
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
X-List-Received-Date: Wed, 13 Nov 2019 23:27:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2019-11-13 at 17:23 -0600, Aníbal Limón wrote:
> The new BB_SIGNATURE_LOCAL_DIRS_EXCLUDE allows you to specify a list
> of directories to exclude when making taskhash, our specific case
> is using SRC_URI that points local VCS directory.
> 
> In OE-Core this variable could be set by default to:
> 
> BB_SIGNATURE_LOCAL_DIRS_EXCLUDE = ".cvs .git .svn"

I'm wondering if we should be adventurous and make this the default
value? :)

Cheers,

Richard



