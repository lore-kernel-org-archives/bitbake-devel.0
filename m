Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
	by mail.openembedded.org (Postfix) with ESMTP id 730E770057
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Dec 2017 10:29:31 +0000 (UTC)
Received: by mail-wm0-f67.google.com with SMTP id g75so28304479wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Dec 2017 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=6/4+0k5o6HAgXiFgKcGGlYLQMZ/pGHMuRJz+Kq3vF30=;
	b=Edlfm1yRrwjGEN/VAua4W76Uqc/AHRsBnoP8rGmysQVjTwucGB8K2heXRTqV6Q45aJ
	NqfU+32ETyvF7fHxh6f8cVEEO9Ylm8y37ks8OGtJC/+tkji/joicfyQMl25b6ueH5WPE
	M/9hRuCin0nh9Q22nIxobzh3rKTuTfPCXAkCPETNtkRmiFc4WuX7P8xbrvtaGy5goigs
	4Ec/Nx819j6OcX6TdFbTbMviGomk5MItp9ntMaaGoO4lBLqEFkauY5MNt+4fz4/7Am6R
	tcKtDemjD8gggPRMvJOCHi5OkOUWC/QVhpaAf7MnwqVAKBe2FSFU/iV2A3kd3uZ+FyLE
	OEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6/4+0k5o6HAgXiFgKcGGlYLQMZ/pGHMuRJz+Kq3vF30=;
	b=uHeL7DP5ZVXmzpJAljsMFc4T9ft5S46I6njmJ9oLHz92eyjgQSqgkTiukqbJHwxa21
	vR5LRgJKHXLrF2oEsMSmwnYvmPolNb3fzvbLVCGAUgf4xKieWOwRqYVk5fRNEmPJnxp/
	tYbZIYbuP1bTU2bw/r0cB2BK5AF55Plq7PKFjbQcj/iFpZ6XpR+H3XAMkSMol7fZv72D
	YuZ2JgQhGQfHYirFALGs1h9aEGPJAJ+/qmJ805N1XVH6bKyKjJarPlyaKFiJp4virFsb
	eRFVjqLoihx9PQu559r6ap0I06vOg2MmSP1i0oo8yLc3PMhQvLiEghcGFyXSk/8Hx12O
	eMOg==
X-Gm-Message-State: AKGB3mKimJEEs1Odg3QsfyjtG5NSLE/TklPyro2HDbAboms8tliAzk3J
	87jquPOIx20LzYRVl7qCM5pzD/2/
X-Google-Smtp-Source: ACJfBotN0oVb8a6QcsgAAdDrXUYmrdrb9l9Yg5MHnYwAketlm0x6GPokJZAjsrqMQ+PbmbT5Zu/6yw==
X-Received: by 10.28.158.212 with SMTP id h203mr12807223wme.157.1513592972053; 
	Mon, 18 Dec 2017 02:29:32 -0800 (PST)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id i71sm2846716wmd.1.2017.12.18.02.29.31
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 18 Dec 2017 02:29:31 -0800 (PST)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Dec 2017 11:29:29 +0100
Message-ID: <1577998.KcEGUiIB0f@crde-port-20.cahors.local>
In-Reply-To: <20171113152404.21785-1-freesilicon@gmail.com>
References: <20171113151617.20905-1-freesilicon@gmail.com>
	<20171113152404.21785-1-freesilicon@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Mon, 18 Dec 2017 10:29:31 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Ping ?

On lundi 13 novembre 2017 16:24:02 CET David Vincent wrote:
> Create branches for each user-supplied name when running checkout and
> set start point of branch to the resolved revision.
> Also, update documentation to better describe this functionality.
> 
> Changes in v2:
>   - clarify commit message
>   - update documentation
> 
> Changes in v3:
>   - rebase on current master
> 
> David Vincent (2):
>   fetch/git: fix per-branch unpacking
>   bitbake-user-manual: update git fetcher
> 
>  .../bitbake-user-manual-fetching.xml               | 34
> ++++++++++++++++++++-- lib/bb/fetch2/git.py                               |
> 12 ++++----
>  lib/bb/tests/fetch.py                              | 28 ++++++++++++++++++
>  3 files changed, 67 insertions(+), 7 deletions(-)



