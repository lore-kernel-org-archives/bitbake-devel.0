Return-Path: <twoerner@gmail.com>
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com
	[209.85.223.170])
	by mail.openembedded.org (Postfix) with ESMTP id 8599C609B2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 20:11:43 +0000 (UTC)
Received: by iesa3 with SMTP id a3so71406927ies.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 29 May 2015 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=Q9wIptNAqhH2/uoxaijEUXCYdSQJwKF8P9LXErubKEg=;
	b=HBqzoIN2sc7lpSIzRgiTs8VFyo2Ie5e2/IJqRfNnl5+U+qJPmXgCkpczEYQ6YGR8Se
	oV+cjNlRZNtB+2QFOm/ufWzSkXje4zCkPWkSq7ro0mzHPw1NzErcDqvPJ2jCSDINdH+N
	7nxWJMHxoiv5eBDnIQy0GvwUNLeCE/NOqGl7kz+HLzolzQFXotV4Wks3JsOU2vkvuls5
	9Hd9NWaXUaJ+/3IXSv0NGe0HW2OYTAVrbgDidIUN6NBlbOGl0daEt84OoGFVYoHn/FvS
	2b4Ay3BWc+o5I6UvtgmkTyMo8IkhEQg2lo8lkye6Bz/iectDXPKINFNpoygdp1IAjylb
	aY3g==
X-Received: by 10.43.40.130 with SMTP id tq2mr17113429icb.46.1432930305000;
	Fri, 29 May 2015 13:11:45 -0700 (PDT)
Received: from [192.168.141.85] (dsl-67-55-28-109.acanac.net. [67.55.28.109])
	by mx.google.com with ESMTPSA id
	m84sm1990624ioi.27.2015.05.29.13.11.44
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 29 May 2015 13:11:44 -0700 (PDT)
Message-ID: <5568C7FD.8070903@gmail.com>
Date: Fri, 29 May 2015 16:11:41 -0400
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <555FA65A.1020505@gmail.com>
	<7025804.ZvuMXxFa1D@peggleto-mobl.ger.corp.intel.com>
In-Reply-To: <7025804.ZvuMXxFa1D@peggleto-mobl.ger.corp.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake-layers layerindex-fetch
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
X-List-Received-Date: Fri, 29 May 2015 20:11:46 -0000
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 05/26/15 09:51, Paul Eggleton wrote:
> This is controlled by BBLAYERS_FETCH_DIR; by default this is set to 
> "${COREBASE}" with ??= so you can set it to your preferred value in local.conf 
> as desired. (We should definitely document this, I acknowledge at the moment it 
> isn't documented anywhere.)

It'd be nice if "bitbake-layers remove-layer" had the same mechanism.
Some way (preferably using the same BBLAYERS_FETCH_DIR variable,
possibly renamed so it made sense in both cases) to specify the base of
where my layers are stored:

    $ bitbake-layers remove-layer meta-realtime
    No layers matching /z/master/rpi-poky-linaro-rt/meta-realtime found
in BBLAYERS

But my layers are stored in /z/master/layers.




Of course I can get around this by using:

    $ bitbake-layers remove-layer *meta-realtime

