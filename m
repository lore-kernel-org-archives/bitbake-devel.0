Return-Path: <akuster808@gmail.com>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
	[209.85.192.182])
	by mail.openembedded.org (Postfix) with ESMTP id 0A3C060017
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Apr 2015 02:12:49 +0000 (UTC)
Received: by pdea3 with SMTP id a3so40368511pde.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 19:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=O1H6bAKf66xOH6+0EHWKCTV6BtrMF/dBcBChhyq74+g=;
	b=GheKbVroAPr5bVMOHPMj+jlxNpE6tbmPGJr31PRqeH3tmi9Nvc+YsNcBTU53ltVOHB
	eK1H1pIn0zAdX2tIlBoFWWfw3Pk7P/sZ6xOIWuiKrxW+nhEnFaZtn9oJ/9EeQHx5s9LY
	i0oY7nIeb81x5aynK6VMfzTC7Z70XVPiD6fXqqyQb5+foS4Z2DgYVWO/uTNHPbHyhUIX
	ybrzmpIs0J17q4UGNa5WPcXPXRCaaM6/DgycqhrtQ9AWIAokVL4Cjm0lePFCO8p89R22
	VaLnpwG4ftjCKVcQONCbXdp9tE8KLuv1dusFA/18aVgSDilymF3cXVK/ovgHqSbd24li
	Na6w==
X-Received: by 10.66.120.69 with SMTP id la5mr7643285pab.66.1428718371230;
	Fri, 10 Apr 2015 19:12:51 -0700 (PDT)
Received: from ?IPv6:2601:c:a700:3ba7:586e:6bf6:7756:bf6e?
	([2601:c:a700:3ba7:586e:6bf6:7756:bf6e])
	by mx.google.com with ESMTPSA id x4sm333869pdl.55.2015.04.10.19.12.49
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 19:12:50 -0700 (PDT)
Message-ID: <5528831F.2060908@gmail.com>
Date: Fri, 10 Apr 2015 19:12:47 -0700
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: Re: [dizzy 0/7] inotify patchset back-port
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
X-List-Received-Date: Sat, 11 Apr 2015 02:12:50 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

I found your contrib branch and I will pull the seven changes from there.
- armin

On 04/10/2015 07:57 AM, Alex DAMIAN wrote:
> cooker: read file watches on server idle

