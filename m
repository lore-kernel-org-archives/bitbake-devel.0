Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
	[209.85.221.66])
	by mail.openembedded.org (Postfix) with ESMTP id 0AC097BD97
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Oct 2019 12:40:29 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id v8so7716468wrt.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Oct 2019 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=dcAsBjh1lYjHJF4zflW7SlXWA0IXYG5hctOoH4L2lAM=;
	b=E8vj0ywCdXO5ij4fizTH1353XYZNn77R42+x1xKJwsbypyLouv6hWmz5yvF6FbEeOZ
	nJimv1W9mFb1ikbhgNiJFsEL7E4LehooMJ74aaNF3JGlhlLIJhNnM6cRpLy/0f/y0tBS
	RMaYaZ3gfckKZPW4Q8uab5P3J85QQu+DmicCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=dcAsBjh1lYjHJF4zflW7SlXWA0IXYG5hctOoH4L2lAM=;
	b=XCc1ChOOS0lDuzS3Sae0O5SyZZfCPSXphCrESrOe13DVSeuton0OJ6dmCXeqRdyi0T
	EBsqTkTeJDufl+CZF0c1bgacBADWyGH117zVkWCBxpfrZdBCUnkA8L/WHkwXFrFbLRKf
	IeiDv+euaFU23/gf1R8AJk2ukTwES83Fwdej0PlHJzMXNquOa789d9gKvpB7elqql5Jh
	IEM4kTp6Zr9yjHSmafeHI31+R/VZX59IU0LAdfZDKuyK6tsArbaSlEJdXwFtb2pk7EiK
	l+xmMIsWzy4g3A/FWA9Tm9JQkCrar+aP0aIDsdgSNUokq2eqDaD/+urzzkyEopJT/UKI
	B3Mw==
X-Gm-Message-State: APjAAAW1rHcibzHdNeOUY2vQsOKmmnKPBU6+c+Fe/J+Ck9kD5eXK/omo
	r4ACDozOLQ3/qlw92D9/6BbZRQ==
X-Google-Smtp-Source: APXvYqzAef8gaxKpqSIiy9hmQJmw6HbZ8ZD+eSoc2a7/1yMfbkdiN76j1kUR/IysQjsoeaaeShD6kA==
X-Received: by 2002:adf:ff87:: with SMTP id j7mr8281689wrr.360.1570711230766; 
	Thu, 10 Oct 2019 05:40:30 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id b5sm4492350wmj.18.2019.10.10.05.40.29
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Thu, 10 Oct 2019 05:40:30 -0700 (PDT)
Message-ID: <e5d1ae1121599ba195203285b2745dc9396024ea.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Thu, 10 Oct 2019 13:40:29 +0100
In-Reply-To: <20191009132226.1808-1-JPEWhacker@gmail.com>
References: <20191009132226.1808-1-JPEWhacker@gmail.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Subject: Re: [PATCH] siggen: Include unihash and taskhash in sigdata
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
X-List-Received-Date: Thu, 10 Oct 2019 12:40:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2019-10-09 at 08:22 -0500, Joshua Watt wrote:
> Captures the unihash and the taskhash when generating the signature
> data. The taskhash doesn't actually factor into the signature
> calculation, but it is very useful to know what it was for debugging
> purposes.
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/bb/siggen.py | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)

Unfortunately this will break anything using existing sigdata files
from disk (e.g. in sstate mirrors) so we'll have to think a bit more
about how to add this without changing the data format in a backwards
incompatible way.

Cheers,

Richard


