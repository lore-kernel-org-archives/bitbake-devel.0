Return-Path: <akuster@mvista.com>
Received: from mail-qk0-f171.google.com (mail-qk0-f171.google.com
	[209.85.220.171])
	by mail.openembedded.org (Postfix) with ESMTP id 9E91677ABF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Oct 2017 17:04:12 +0000 (UTC)
Received: by mail-qk0-f171.google.com with SMTP id q8so5827522qkl.12
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Oct 2017 10:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=TlvofvylwoA1MNVh7GnUtDf12+Ij9MVhLu8rNIfVyMo=;
	b=JJFQSIHMGSQNLI689jft7DxpCCwv9WxYlhX7HvIIBrQzoLVFSBzEnhostID+ttwiZ2
	5cIpeOgHqbSkG41MDJeFq3FGgumMReL37lNbZx9kf8HJfyJEG65mPO625X9eks5G/iPW
	CGOD7LLUpdAwND8hJyQA9VAIFY+Gm3JLmqsREJQGWfxP70UvKiSqTMQxtTeJI44aOxKi
	W8hoKr+6QaysdX+jUrzayxCdmxWwEI6PcM9Bhdbs9AiQZUCnSa+psm+8ZJL9+W8m4t0K
	dWSukxjkKmLgWutYx/PxJV6drTEVgL7Y0hr+77YSzPp+6ZxjRtqun+7fRBMR23grXQ/M
	pP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=TlvofvylwoA1MNVh7GnUtDf12+Ij9MVhLu8rNIfVyMo=;
	b=YR1yMdoXb69bRAc2s+1Fd6rFSPtEbQUt7bpq1qhArLBm7HefjeqvSQ8ZVNL2fPyK6C
	TzSyutkdsQVyzbCG2kpcVEcE9CJL0vtiDF0zxhBHhSJ/hrHZoYznl4J5ci9hEDHMzPjk
	W7+ZBtYAlnWGXcr8EPVSD9GzlxBDweGL20L/1PSR8OgDFs+PT1bhKRVTrY5XSlSxbEcm
	WkZ6OZeUBIIshYRUoPzMkYhNRzRpgyA004nY6nPLFPdoZzPxJZLm/0fwUxpKZwowG0Uv
	JF/b+WYmoGZR0MbjbUKc+DpRfNUepibc1bt1mW3MNv17XtlTCbZjmWjZmW2o/W3gGrS4
	8m3A==
X-Gm-Message-State: AMCzsaWcjj2x+sG7Pe92RrY4+LhyaiJLAa2HKZHv559huONGcYNsCsTh
	nfiZYQuW2OPw0ZEFBKTMijaqn54FErw=
X-Google-Smtp-Source: AOwi7QBo988/jjPw2lz/ISkGgCQKzSgQzhfSxNf6H/3B/cgbmzCyYdLZMLS5yYtck7IsmmBDBO6R1g==
X-Received: by 10.55.39.145 with SMTP id n139mr5467346qkn.70.1506963853128;
	Mon, 02 Oct 2017 10:04:13 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:c866:1112:ad7:1236?
	([2601:202:4001:9ea0:c866:1112:ad7:1236])
	by smtp.gmail.com with ESMTPSA id 13sm7433726qtp.74.2017.10.02.10.04.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Oct 2017 10:04:11 -0700 (PDT)
To: Alexander Kanavin <alexander.kanavin@linux.intel.com>,
	leonardo.sandoval.gonzalez@linux.intel.com,
	bitbake-devel@lists.openembedded.org
References: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
	<20171002153849.24922-3-leonardo.sandoval.gonzalez@linux.intel.com>
	<324e7e99-7b13-5e30-36a2-4814be8f7b5b@mvista.com>
	<f755d561-8d66-2918-e218-fee685ba62f6@linux.intel.com>
From: akuster <akuster@mvista.com>
Message-ID: <292663c7-88bf-4b39-7ed4-c98f62e87cb2@mvista.com>
Date: Mon, 2 Oct 2017 10:04:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <f755d561-8d66-2918-e218-fee685ba62f6@linux.intel.com>
Subject: Re: [PATCH 3/3] README: new readme file including main aspects of the project
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
X-List-Received-Date: Mon, 02 Oct 2017 17:04:12 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 10/02/2017 09:06 AM, Alexander Kanavin wrote:
> On 10/02/2017 07:02 PM, akuster wrote:
>>
>
>> Is there any value in providing a sample command:
>>
>> git send-patch -M -1 --subject-prefix=Bitbake][PATCH --to
>> bitbake-devel@lists.openembedded.org
>
> ak@kanavin-desktop:~/development/poky/meta$ git send-patch
> git: 'send-patch' is not a git command. See 'git --help'.
>
>
> Should be 'git send-email'.

correct.

>
> Alex


