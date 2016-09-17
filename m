Return-Path: <akuster@mvista.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id D9E4965CB5
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Sep 2016 05:54:10 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id cm16so32199520pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 22:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding;
	bh=AzEl0hnTdrADatfNNrcRxGOz0NnYQWsMplLhQTEFjd4=;
	b=TnJDN9nhaw7N/nps2CGSKMNrP3DvfnETdN5pKNtfI6cYvm1+XshcQgqyG91ZQ5Ge7S
	yd5fOrZESXZ7/FRAkt3RitDo/xWb2E8jg/dKIKxcDkAKmT28447ywisESVQ9DayyZH1X
	WnUSR3V1VmzT3eZfaRxguwJ3X8gpj9HT7jC0U0LKr7RyaQpw47nkpI3WO4S9rzd6FyEc
	6aLCVUPeSOGniFaCE53CGwN/CnZfZEAi1eK7VaKpDNkLMtp/4tSkTcq0awCBoAPLV436
	4gVBeczJeJYrO1ylNrEqziXXMX3zqxvb6b/RyxKypWsR2LV18LQOhcLMNaSFpQ3ZFmEW
	Zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding;
	bh=AzEl0hnTdrADatfNNrcRxGOz0NnYQWsMplLhQTEFjd4=;
	b=gnZrkzi7Mxt0BlZX4UFUOPNqP7RBRv2LGaw9yAGXoAa9L116Y6G6iQJCnAwb7jLzcK
	+lL5N+zMJ8Yz/IJ9k3G2wU4c7Qj2/7BINu/bX8dJt1QgJLuVIMd0v9YyzPIizu6+/s8S
	g3xSvxdlA4qr+CqfNwTp9VbC8CqtySaWg/oSD3qutrhd31tNoiSdbFUKRBjq7jMvzi6S
	/i2xt5l5e3Du3i3f9+TWD9P0vOaCzXu3ayTs8SXjkyK+AiI1QS2yVsVlkeNaV0NzdqDa
	jhtvlG6nJHtbgLCBdupVcakUpA5MRULqrNqUKIAxgmUPkd1NycrEjeweE3ulH8SuXukw
	YV5Q==
X-Gm-Message-State: AE9vXwOUoPLIZ1rYud3//fm3WCr/hClPKHV0uOcFy3YwXFwE6SqQ1C5UFgfPAYZIyDLjXLL8
X-Received: by 10.66.160.99 with SMTP id xj3mr28941021pab.73.1474091651267;
	Fri, 16 Sep 2016 22:54:11 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:142f:f172:55ee:c116?
	([2601:202:4001:9ea0:142f:f172:55ee:c116])
	by smtp.gmail.com with ESMTPSA id
	xv9sm15923446pab.36.2016.09.16.22.54.10
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 16 Sep 2016 22:54:10 -0700 (PDT)
To: bitbake-devel@lists.openembedded.org
References: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
From: akuster <akuster@mvista.com>
Message-ID: <ecb2b37b-ce03-34d1-273f-09f799eced54@mvista.com>
Date: Fri, 16 Sep 2016 22:54:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
	Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1474069004-10786-1-git-send-email-akuster808@gmail.com>
Subject: Re: [PATCH 0/3] Bitbake 1.28-next
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
X-List-Received-Date: Sat, 17 Sep 2016 05:54:13 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


sheesh. I thought I was working on bitbake used for jethro, looks like I 
was off. patches are still applicable.


On 09/16/2016 04:36 PM, Armin Kuster wrote:
> Please consider these changes for 1.28
> to fix bitbake-selftest failures.
>
>
> Richard Purdie (1):
>    bb/tests/fetch: Update cups url
>
> Ross Burton (2):
>    lib/bb/tests/fetch: remove URL that doesn't exist anymore
>    fetch2/wget: fallback to GET if HEAD is rejected in checkstatus()
>
>   lib/bb/fetch2/wget.py | 72 +++++++++++++++++++++++++++++++++++----------------
>   lib/bb/tests/fetch.py |  7 ++---
>   2 files changed, 53 insertions(+), 26 deletions(-)
>


