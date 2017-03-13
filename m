Return-Path: <ulfalizer@gmail.com>
Received: from mail-ua0-f178.google.com (mail-ua0-f178.google.com
	[209.85.217.178])
	by mail.openembedded.org (Postfix) with ESMTP id 4AD1F72F45
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Mar 2017 08:49:32 +0000 (UTC)
Received: by mail-ua0-f178.google.com with SMTP id f54so143537088uaa.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Mar 2017 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=VA44bDAo5SJ/i0RRE4WqSQaVNZenDWpj6RvCY/Mzx+Q=;
	b=Jzc6WyCUCIECjTT/B0PQLK8FRhBnFE3afjAnTpM4DlEAIPXFTp6IFONb+wxREMhInj
	bgFuqb4jCRT462B0Tvg2OYFkfitSwDUiA2ZgfhOh30E8nszA4kHUPxq6xI8dW7FcAKwt
	/JDtIrqfBfxUurxOiEO0cESI8VEOwabu8cfRn81DRzepSEo6xAetcX6DEzBzqOkn8xbH
	WydF4xEf3bgCsnwksl+IgiPquaevVCD6NPpR4o+21f43czNEJJyKji+yMIpLrrcb9leI
	NTXc1yW/LuBe9MymiFM8euuFhUoKuygY4XU1fnUTJ+A4y4rojLQ1cNIr2t09ORI4XmIx
	tXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=VA44bDAo5SJ/i0RRE4WqSQaVNZenDWpj6RvCY/Mzx+Q=;
	b=uPE1sMRofB+TVCLPf5DonLr5yEFfm1WabdeRn9bmi/nDVb6jS2rz+hSpF13xaPMmDG
	Z0dSb2DBTRrh08jJRb0+jvZg9234OSux4nkahHzFNkdvgNsbG+UmtJuod9bzyBB5xDUX
	eRsV7OQZqfSlCn/L8clEOsSsGx9VF0j8locgrrp3Rybm9Z8QU/ANGUZ7iWivAnvRB8ya
	Po0deGQx349iFCWeQukP4Kcap3Ex46IzLvBEa92cpGIWwLZuPKUilLiXEsfALgkZ29Os
	agKXb2DLmuEmwBIOgUHs6qLqZXbeDOs/65y9i5GpSDNv97CIuYceIl0N+qnLGWxAp9po
	8Jsg==
X-Gm-Message-State: AFeK/H2oTyID2m4PQxNawFZUkhmhN+KlR/6rDjkO4+JrOJQR9s4hpIPJ38aRpECi0BRu9alFOZIBJPjriSgMFg==
X-Received: by 10.176.7.211 with SMTP id d19mr68917uaf.19.1489394973847; Mon,
	13 Mar 2017 01:49:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.136.3 with HTTP; Mon, 13 Mar 2017 01:49:33 -0700 (PDT)
In-Reply-To: <2127452.SPVY650BJx@peggleto-mobl.ger.corp.intel.com>
References: <CAKHP1dvO0V3+d5jbAXx6-3t+TxnjZzh210voMqrbxZKGmrai1A@mail.gmail.com>
	<2127452.SPVY650BJx@peggleto-mobl.ger.corp.intel.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Mon, 13 Mar 2017 09:49:33 +0100
Message-ID: <CAFkk2KQDHbjS774vRywGUZ4GYbzzZ2QJ_bqZywv0_X5bGpjtmQ@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: kk <pinganddu90@gmail.com>, bitbake-devel@lists.openembedded.org
Subject: Re: What does the "fn" represent for in "<fn>:<taskname>"?
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
X-List-Received-Date: Mon, 13 Mar 2017 08:49:34 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Mar 13, 2017 at 12:18 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> Hi there,
>
> On Monday, 13 March 2017 2:24:32 AM NZDT kk wrote:
>> In commit:
>>     2c88afb60da54e58f555411a7bd7b006b0c29306
>> uses "<fn>:<taskname>" as the ID for tasks rather than a number, I know
>> taskname represent for, but the <fn> I don't understand, does it means file
>> name or function name?
>
> File name.
>
> Cheers,
> Paul

For some related whining, this really tripped me up when reading
BitBake sources. I suspect most people would immediately think
'function' rather than 'filename' when they see a variable called
'fn'. 'f' or 'fname' would've been clearer.

Cheers,
Ulf

