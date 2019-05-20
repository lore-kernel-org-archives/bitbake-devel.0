Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id 82F697BEEC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2019 11:15:04 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id c66so14039466wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2019 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=EAAeLNrA0EJsq7V4sZ2l7rJLdLRO8pReWE8pvu9jX6E=;
	b=HbET/bxnzeLdBiz2YZnM6OfPzQPjOA6hFSbokf+fJNUP/SHI2plUWYaJvK4zCcg05W
	83VZGb1dY0O1vkD+aYtp6nY3Eb2ofoJYRnppjbKq3FX9mdn9fz1xC0ub3na7LepMe/ad
	eay4edGJ8kRQTW/f375VJ/bnNhocY3YvfVVmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=EAAeLNrA0EJsq7V4sZ2l7rJLdLRO8pReWE8pvu9jX6E=;
	b=sebQUaIIwoLWygTZ5Xa9oWuxfhIXwog4irrF/e21K4BaCjsy59bGIaUYQBg7awHG6V
	UvYaCiRll0KhjwLBycoYW7Wz92uMpbKmW74BOHQ2dqNCxoxQTSCUJyQ0kiK4A/ZH/8U0
	vY3wika7rgRp79w0YmZgU+Osq7YP6cOssrkY7STN0a8BKH5/pmsgrleDsh0iTEPo3Rmd
	Iy1ivr1e6C1xrOD85gxH0xK+G5pqylL88aeDGN9sLo+BpODl/VeuCn3gi3cN4w4GrSaM
	lx9vVwsvgbnEMaFkT45dpHm+aOxxCY4NTwdu6F08L5tG/0fy+Bi59U6wbHufM37qc5/w
	yJ6g==
X-Gm-Message-State: APjAAAXQ+zziQ9J8OkHrIbG8/aASX/QpZkqEUMbigzJbbIkiY+yheatA
	neKomdvz+IwQmJ1lnDWxQsB+1Q==
X-Google-Smtp-Source: APXvYqx+wLZmxkOBoEsNXSQUJUrAM0ebZVBxlis43ORIIQpBBGNY/OeV6WKDgOFGl/mABxYRtv718w==
X-Received: by 2002:a1c:a64e:: with SMTP id p75mr11055737wme.62.1558350905233; 
	Mon, 20 May 2019 04:15:05 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id 16sm9641329wmx.45.2019.05.20.04.15.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 04:15:04 -0700 (PDT)
Message-ID: <56257a01283f667966358808fb5425383d6eea58.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Andrew Featherstone <andrew.featherstone@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 20 May 2019 12:15:02 +0100
In-Reply-To: <CAGW41X6aTxVpjg+Q5twwyHZgVevw03dJNRFgkOzhH4dNJpKEuA@mail.gmail.com>
References: <CAGW41X4-eci5jLF=is4zXyZ_S-09KAm3u6zRY7bZRm5-ZOBoNg@mail.gmail.com>
	<CD049A4B-65EC-4837-AF9B-9664647B6C8B@gmail.com>
	<CAGW41X6aTxVpjg+Q5twwyHZgVevw03dJNRFgkOzhH4dNJpKEuA@mail.gmail.com>
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Subject: Re: BitBake release notes
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
X-List-Received-Date: Mon, 20 May 2019 11:15:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2019-05-19 at 09:41 +0100, Andrew Featherstone wrote:
> Thanks, Alex. Are the Yocto Project release notes the de-facto
> release notes? From version 1.16 onwards it seems that releases go up
> by 2 at a time in the minor version; why is this? The current version
> of the BitBake User Manual [1] offers little insight here.

Odd versions are development versions (in the master branch), even ones
are stable releases.

Bitbake does keep a fairly stable API and should be backwards
compatible but there aren't many people testing that so its possible
you may find issues...

Cheers,

Richard


