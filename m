Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
	[209.85.220.67])
	by mail.openembedded.org (Postfix) with ESMTP id 343E67705F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Aug 2016 14:29:39 +0000 (UTC)
Received: by mail-pa0-f67.google.com with SMTP id ez1so19398805pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 05 Aug 2016 07:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=subject:to:references:from:organization:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=xVyhXEpIg3Y5guvaM5EIW7T/xnaoLfMJPabrSBjYexc=;
	b=M9IHvBX/2USPSyTsKtF6KLoiWBlK5+jpGaqzxkODLorfd4SRXRWWyMXnL2H4LnpgXa
	43wQtiDbiCfrLJmFnDDbS8i/2EPdzFh+Vg+0uvYyUqSzhqybEg8hX49YK3RsSBjHX8kD
	tKq7V/hc53y85FuD4aW1Qifs5hjyq6RK28cqRWg92yhLnRhRonT5CTFZ0B+QNSRaQjYl
	z3IV8BxgrSzB3ehAqHZZ/eLV+x3PWnOgzyIo59DmGEYjA2ZUEmHS5iBL6AWNmtmFSyxO
	ZvXuyp8IlGPvNfmu7TNEpAGpLO+KJb2+Waif51mMEv3ufL1jVhKYLrZL7VraqjUyW6R3
	sOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:subject:to:references:from:organization
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-transfer-encoding;
	bh=xVyhXEpIg3Y5guvaM5EIW7T/xnaoLfMJPabrSBjYexc=;
	b=FtAHzAeEllGe7LCQFN9DnFeRV6vhZ2Z4PkBDvsxIJKzLrBbhOLKBshKbFrpOPwze6q
	oFVgVHm6SdQ7u41EyYBYu/A25cVfyM73hxzGIpGMhC6Fv/lXqtSu0LZ8nYS+Pr1EobLj
	39lpo0PWi7f3Gr7I4t29V2oRxqofUbf9OfLA75XHgRSz32cCRY2Gq/KxjaLQuPxaPNe3
	ldYcMpR+pi2tiRcXNSbzQytf8yoNJSybSKd7Riciuaj+FaXhYU9jlb7iOHvLLppbEKIv
	D8XLrRSOnM4se32vTh8iX+VutOEgh0cAEQmNHpk1jdk+6ItRAcYGFW4D6Ew6eB1BO6H6
	XE6g==
X-Gm-Message-State: AEkooutsnI0/GoFwNyUVE34CrJuH4gZT6ZA/aRVKswoJl5CP/C3UyLIxwSDCDT1KObda/A==
X-Received: by 10.66.235.100 with SMTP id ul4mr31729405pac.50.1470407380670;
	Fri, 05 Aug 2016 07:29:40 -0700 (PDT)
Received: from CACSVMO-14452.local ([2601:646:8882:b8c:41d7:99c1:5cc6:c627])
	by smtp.gmail.com with ESMTPSA id
	r10sm28567291pfk.84.2016.08.05.07.29.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Aug 2016 07:29:39 -0700 (PDT)
To: zzs <zzs213@126.com>, bitbake-devel@lists.openembedded.org
References: <1c7e8f51.d202.1564ba890a5.Coremail.zzs213@126.com>
From: Khem Raj <raj.khem@gmail.com>
Organization: himvis.com
Message-ID: <27cfffee-84cd-6c77-26b7-b9de8c1d0745@gmail.com>
Date: Fri, 5 Aug 2016 07:29:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
	Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1c7e8f51.d202.1564ba890a5.Coremail.zzs213@126.com>
Subject: Re: howto build specific version package
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
X-List-Received-Date: Fri, 05 Aug 2016 14:29:40 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



On 8/2/16 7:29 AM, zzs wrote:
> Hello, everyone
> 
> I have two version .bb recipe, sya test_1.0.bb and test_2.0.bb.
> When build the `test` package  using the flowwing cmd:
>     bitbake test
> Always 2.0 was built.
> My question is: how to let bitbake to build version 1.0 of the test package
> 

You can add PREFERRED_VERSION_pn-test = "1.0" in local.conf
or you can add DEFAULT_PREFERENCE = "-1" to test_2.0.bb


> 
>  
> 
> 
> 

