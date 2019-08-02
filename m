Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 42AEB7F214
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:58:18 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id h19so1765752wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=message-id:subject:from:to:date:in-reply-to:references:user-agent
	:mime-version:content-transfer-encoding;
	bh=SwngliQzKjJQyxigOYo8/LT8FBtcO3L8v7u7kP8hKJk=;
	b=hZ77v4Ad4U9QDZXZLCxDQl4bQZ4vIIvQdKMFWJ9oyTPfr5WxUHAzCzN/nj1eyf+/83
	OzwbaC58wJBunaC/uaCDCgbC9QtD3HzsYqz6lef8S3PmYYwWqhb6R/+qcRrqnVBZBA9n
	fbXyyUvzTBrPl9k/bz9p6ZdffwwwhhgN8mk6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
	:references:user-agent:mime-version:content-transfer-encoding;
	bh=SwngliQzKjJQyxigOYo8/LT8FBtcO3L8v7u7kP8hKJk=;
	b=fmBBJQOS9FfBi753J72d6DJxVQNmp1bx0cFy3FiB+nIcjQsBtfmoBL5E5wqjz6KxTB
	lJKoIkQFJd84aTfWoKrQcXgeDmMd6+Ob0j/m0HkhDDp4SgH88r+1PQ7zExLT4aQZ86iB
	GenrCQF5L0p2ekUL5co1p3NfQEoDSKctTkCdsvh3rjhw+vH2vXZ20DoiKxpvXsTIhng8
	O/wKiLcaFF/3P4pWuKB7MgMwpWFHfwN4SD1XUyGqcAfJS3Zn8m+hryxmBZJH/H5D/gOX
	h+5xYLL3Z9WE4g/O6ShY7U+jVLnew3nFiJcaT3RRQoZrjTxPynWNywKRKBXoWCRuwsaO
	4S/A==
X-Gm-Message-State: APjAAAXd8mDvOCi1vYVc2qZXmu6rfIVJcMextDU+dRxAjrr6Va3gOGrU
	b2/jBsWblven7S2hRyy4KDknBR0Np28=
X-Google-Smtp-Source: APXvYqx9/840BHvZrDvb8iOiv1AeKxyhiTgK1UkdBoh4FHbrVHz5VyFGjmDxEXY+PyabuebBy25sqQ==
X-Received: by 2002:a1c:99ca:: with SMTP id b193mr4925212wme.31.1564761499020; 
	Fri, 02 Aug 2019 08:58:19 -0700 (PDT)
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	x20sm169674108wrg.10.2019.08.02.08.58.18
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:58:18 -0700 (PDT)
Message-ID: <31173ac285f0fcd0924a8b68138bfd157c1c63e6.camel@linuxfoundation.org>
From: richard.purdie@linuxfoundation.org
To: Mark Hatle <mark.hatle@windriver.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 02 Aug 2019 16:58:17 +0100
In-Reply-To: <c560520f-2f2f-c178-dc3d-cbfed4df673b@windriver.com>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
	<20190802152049.16529-13-richard.purdie@linuxfoundation.org>
	<c560520f-2f2f-c178-dc3d-cbfed4df673b@windriver.com>
User-Agent: Evolution 3.32.2-1 
MIME-Version: 1.0
Subject: Re: [PATCH 13/16] siggen: Clean up task reference formats
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
X-List-Received-Date: Fri, 02 Aug 2019 15:58:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2019-08-02 at 10:50 -0500, Mark Hatle wrote:
> There are filesystems (MacOS primarily) where ':' is the
> separator.  So it would
> be better to continue using '.'..

The ship has sailed on that, ":" is used throughout runqueue already.
This patch just brings pieces of external API into line with that.
Using "." is even worse as its in every filename.

Cheers,

Richard


