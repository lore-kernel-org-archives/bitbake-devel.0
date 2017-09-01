Return-Path: <akuster808@gmail.com>
Received: from mail-pg0-f45.google.com (mail-pg0-f45.google.com [74.125.83.45])
	by mail.openembedded.org (Postfix) with ESMTP id EB25C783BB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Sep 2017 22:03:12 +0000 (UTC)
Received: by mail-pg0-f45.google.com with SMTP id r133so3915340pgr.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 01 Sep 2017 15:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=SECmUvrUQkmDL1IwLkfNQLiF4nzccL7ugoMmwNnA3fE=;
	b=R39b7izgxf2SEiXGZ0TwgSruqSRSICEIjgdFdA8mW1V3yp6FBMSJRcc81lOxufye3h
	v9oZeN9JJ8g9PT18vtSOPd7DoLmrbkHgWRrK6sfhzgwSzS4YPxo4e1HHR1wdqfJDAxEa
	wcrR+/1A4bb6TypaeTIBRxdnN0WXZjbt7XjOtZQSiVrBUpTub39/FxqE8lFzagldDChO
	nMdZoYR992U2Vt6xZBu9C8W3o4Xf1x7M1pW6c7WRwG4JEWYcY+qDxvfS10OD1Y3T6w61
	aqH2f9vOjYJnbUoChoIB46XTUb2uclKKUJkGG7gz1h/ITx7Bpp9Qe0IXA/Q5B8mh/X6M
	uvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=SECmUvrUQkmDL1IwLkfNQLiF4nzccL7ugoMmwNnA3fE=;
	b=cu8+uDcYS/EE8BmnSYoKllQop6hFy7+Z7D3KaQDh+TPFpMR4+IVTuObF0gGpc7g1G7
	lfA5BB9W/gqn+pGS0qbg5rqqAw5EmL26sJ/h+1vBoqAJEPzQopO2ECgeMuWv1ilBAfU1
	Px+0x1VEKr5XgKeiOFcEYKTM3pamNmbyNWtDUKLmJ2vhlxaLq+7nEaPMXmju0j3tsMuN
	uDM9/37zf+aepa1/gmoIQdPYxLdiSfQt/2JS+eNNXhfVQtcutZny1kl4ICM73+dFWLOJ
	cvIG2HsSn9a20K6dUWUkWFItxXQ3F+3TPovfH2DBRrDM42UCufworqTt29mXydmTuUiY
	Ljxg==
X-Gm-Message-State: AHPjjUi/Bm4vzbj7ExSBV7o0icXKRCOZnBmnEeszglQDxIDPPBmN6FHb
	PX4JERzTIpUcWg==
X-Google-Smtp-Source: ADKCNb576ZnXG0uy146DX/J2OT0uktNxWdeNh6O4PxoYMrmMMBh9BDI79B7NLIlqVa/b2PAjpnMN1A==
X-Received: by 10.99.120.137 with SMTP id t131mr4033935pgc.147.1504303394192; 
	Fri, 01 Sep 2017 15:03:14 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:c400:6ad5:9d97:9621?
	([2601:202:4001:9ea0:c400:6ad5:9d97:9621])
	by smtp.gmail.com with ESMTPSA id j7sm1437541pfb.30.2017.09.01.15.03.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Sep 2017 15:03:13 -0700 (PDT)
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Fred Lamer <fred@rogue-research.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"poky@yoctoproject.org" <poky@yoctoproject.org>
References: <e380fe57-2ad0-787d-1ea0-b02411480121@rogue-research.com>
	<4ef85854c4b44bc48a381838801fd2c2@XBOX02.axis.com>
From: akuster808 <akuster808@gmail.com>
Message-ID: <1c531eb1-e787-74a3-2020-f487ddd95a57@gmail.com>
Date: Fri, 1 Sep 2017 15:03:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <4ef85854c4b44bc48a381838801fd2c2@XBOX02.axis.com>
Subject: Re: [poky] CVS support on Yocto 2.3 (Pyro) and bitbake 1.34
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
X-List-Received-Date: Fri, 01 Sep 2017 22:03:13 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US



On 09/01/2017 08:44 AM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
>> devel-bounces@lists.openembedded.org] On Behalf Of Fred Lamer
>> Sent: den 4 augusti 2017 16:00
>> To: bitbake-devel@lists.openembedded.org; poky@yoctoproject.org
>> Subject: [bitbake-devel] CVS support on Yocto 2.3 (Pyro) and bitbake
>> 1.34
>>
>> Hi,
>>
>> I'm trying to bring a project from Yocto 2.1 (Krogoth) to 2.3 (Pyro). I
>> have a problem with one of my recipe that tries to fetch from a cvs
>> repository. The recipe work perfectly on Yocto 2.1 (using bitbake
>> 1.30),
>> but not on Yocto 2.3 (using bitbake 1.34).
>>
>> It seems like 'cvs' is not installed on the host system? I get the
>> following error:
>>
>> ***********************************************************************
>>
>> Fetcher failure: Fetch command export
>> PATH="/media/yocto/yocto-vetrobot-next.git/build/tmp/sysroots-
>> uninative/x86_64-linux/usr/bin:/media/yocto/yocto-vetrobot-
>> next.git/poky/scripts:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-
>> sysroot-native/usr/bin/x86_64-poky-linux:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-
>> sysroot/usr/bin/crossscripts:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-
>> sysroot-native/usr/sbin:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-
>> sysroot-native/usr/bin:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-
>> sysroot-native/sbin:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/work/corei7-64-poky-linux/libev/4.15-r0/recipe-
>> sysroot-native/bin:/media/yocto/yocto-vetrobot-
>> next.git/poky/bitbake/bin:/media/yocto/yocto-vetrobot-
>> next.git/build/tmp/hosttools";
>> export HOME="/home/fred"; /usr/bin/env cvs
>> '-d:pserver:anonymous@cvs.schmorp.de:/schmorpforge' co -r rel-4_15
>> libev
>> failed with exit code 127, output:
>>
>> /usr/bin/env: ‘cvs’: No such file or directory
>>
>> ***********************************************************************
>>
>> So, it seems like cvs is either not installed or not in the PATH.
>> Anyone ever had this problem?
>>
>> Note that this if I copy/paste this command outside of the bitbake
>> environnement:
>>
>> ***********************************************************************
>>
>> /usr/bin/env cvs '-d:pserver:anonymous@cvs.schmorp.de:/schmorpforge' co -r rel-4_15 libev
>>
>> ***********************************************************************
>>
>> it works perfectly (so it's not a fetch error from the repo).
>>
>> Thanks
>>
>> Fred
> This is due to the introduction of the HOSTTOOLS and HOSTTOOLS_NONFATAL
> variables in Pyro. Only executables included in these variables will be
> available from the host environment when bitbake is running. The
> executables in HOSTTOOLS must exist or bitbake will abort. The executables
> in HOSTTOOLS_NONFATAL will be available if they exist.
Is this supported in Master? I could not find it for a backport 
consideration.
- armin
>
> So if you add cvs to HOSTTOOLS_NONFATAL, using cvs to fetch a repository
> should start to work again.
>
> //Peter
>


