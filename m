Return-Path: <otavio.salvador@ossystems.com.br>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
	[209.85.223.181])
	by mail.openembedded.org (Postfix) with ESMTP id 6117776E70
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 17:53:15 +0000 (UTC)
Received: by iofb144 with SMTP id b144so22258692iof.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 10:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:mime-version:in-reply-to:references:date
	:message-id:subject:to:cc:content-type;
	bh=6tYg3cFBabCoaEV1f+aPaJsHJWFuUdvc1SvnLLnQYxk=;
	b=REedQHGw5GFdsasbhmdQo77svbJGBFOLweU1iVanKb+5rboVa1iVSeSJEr7GDgmDae
	cizjOxm18FuI6adIzPIk2ALiSU/I2CabYMQY00M6uVZS8BwWV6oNXM7wBZIikA7uIG5/
	+q71ARyNBsrm1hsQnL8K+//4Be6lFG6E4Ps/swDloL2RYYHdnZdbt1ho2BradQ18zAfz
	FTNbHvFxYmuvd9VWpbUZ0+60ALn8ZGuC0+OyX5Zb0KqS5CkEGbpBaaivd10Cg3xG0SMm
	KIBkuXvgh3PV5PTEZJOaSETACMdT1F/Q0Z2EfgxocfGA3H9u6AhSuGUfk9pHozs5ZE2L
	Rmow==
X-Gm-Message-State: ALoCoQnLx9VjETPLu77E+LxlewN75M7AgrZQHcnnKT14z+52yR7h33cbFSuLoLW+k7tdrCxWANCH
X-Received: by 10.107.10.11 with SMTP id u11mr36232014ioi.36.1442944395758;
	Tue, 22 Sep 2015 10:53:15 -0700 (PDT)
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com.
	[209.85.213.169]) by smtp.gmail.com with ESMTPSA id
	189sm1647411ioe.40.2015.09.22.10.53.14
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 22 Sep 2015 10:53:14 -0700 (PDT)
From: Otavio Salvador <otavio.salvador@ossystems.com.br>
X-Google-Original-From: Otavio Salvador <otavio@ossystems.com.br>
Received: by igcpb10 with SMTP id pb10so104447101igc.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 10:53:14 -0700 (PDT)
MIME-Version: 1.0
X-Received: by 10.50.77.15 with SMTP id o15mr19758457igw.5.1442944394038; Tue,
	22 Sep 2015 10:53:14 -0700 (PDT)
Received: by 10.36.218.7 with HTTP; Tue, 22 Sep 2015 10:53:13 -0700 (PDT)
In-Reply-To: <3187731.pmWd6aiVkT@peggleto-mobl.ger.corp.intel.com>
References: <32EA6B79577EEF4C84CB32305D45A059289DF453@SRV24.hamburg.garz-fricke.de>
	<3187731.pmWd6aiVkT@peggleto-mobl.ger.corp.intel.com>
Date: Tue, 22 Sep 2015 14:53:13 -0300
Message-ID: <CAP9ODKo4yZJ8mqoZJX9pAcja=Cy6YPZo87V=hzhuwm+Xpc0Jyw@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
X-Mailman-Approved-At: Wed, 23 Sep 2015 21:40:32 +0000
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Override a "_remove" operator in bbappend file
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
X-List-Received-Date: Tue, 22 Sep 2015 17:53:18 -0000
Content-Type: text/plain; charset=UTF-8

Hello Tim,

On Tue, Sep 22, 2015 at 1:12 PM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> On Tuesday 22 September 2015 14:35:39 Tim Jaacks wrote:
>> https://github.com/Freescale/meta-fsl-arm/blob/3336ef362109eef14f9e73cdededb
>> 43caefedb2f/recipes-graphics/mesa/mesa_%25.bbappend
>>
>> I would like to undo the first two lines.
>
> Adding Otavio (the committer & maintainer of meta-fsl-arm) to CC - Tim perhaps
> you can explain what you're attempting to do here in concrete terms?

It seems you are intending to use mesa for i.MX5 SoC, the way I would
do it would be removing the mx5 from the overrides completely.

If you move to master, the mx5, now uses Linux FSLC which is based on
mainline and got those bits removed[1]. This might be a good trick
since it gives you more Freedom to handle whatever setting is need.

1. https://github.com/Freescale/meta-fsl-arm/commit/3b698004698742130f87dd4d9edaabdf58c4e079

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750

