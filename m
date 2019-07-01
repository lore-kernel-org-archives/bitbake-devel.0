Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by mail.openembedded.org (Postfix) with ESMTP id 176547BE3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Jul 2019 18:27:34 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id s7so30948071iob.11
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 01 Jul 2019 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=kWTkZPIjaluLwPEpYSbv2juN1EMCC5/TEtHQd+o/U/w=;
	b=PVVTW/Y1v9DNGoQ7Ou/smsmZUExQht1xP6TvmH9w+gVmuF/oCrPC8gLv0mYEx0b97e
	qHzTCvThiep9A7Jt7DH5/b50sgRfz9cDbpSg+DKPMEPkqTQrgYAMwd73xwrwlJorqSL2
	6VLt3mP5FzoP7t8voF28jRepy5IZy9dFF5R+61w32Szb1FxoGCzWlM+mrkafkuNCY5z5
	JEYj9pOM/V/jy3XBjmGyvIK7caQbNRQXfTlJZG6WVXPcNhfSNCreVrmiAkqpBCqj5FB+
	uRCT3xSy+nhT9GhDhOIPtks+GUc+oyO3JCVU9/fhtWtSOwgjHoGYTlyjU5wgAGctRrKk
	4OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=kWTkZPIjaluLwPEpYSbv2juN1EMCC5/TEtHQd+o/U/w=;
	b=YNj0vxcresUVLE88rZzmI7Qt9KFGvi8+D0vFG+OhVaD33ReI/9cIIfXEqa7WCjg/Ap
	CDshyJtfX40ZkP/G/uusiOaaoQ63BxC3Djn0QO6/SnXCEFlCAn92i849NVY046YBvPBz
	5AL8AJYU7pl+EwQpN0pNSFNKEYrY1TVgzoZaD2dKuDwZzKAR4V1d/ZiVMtJrODfoI1P/
	ynmAYBmizvd5u/hBfRgo8JWvolTHu3julXi6GB4i8kQma/nh7IbizIazzPIIRT3hjW8R
	UIRWXD8LsjHDoSup+DIncPt7yX79B8OwH+OENa1Z7JymytY2bSaT6ngoyKXnKNHvISW+
	8VtQ==
X-Gm-Message-State: APjAAAWv0Vr8f8c2EJ4Yge92u+kiXxoon62e2AKplqSr3WSWJnDhj6Mn
	iownHEVteAB1pg9vd7RlVwB8Hin8
X-Google-Smtp-Source: APXvYqxmQKevwcEFIiAdfKl35kQ60yxpiLc6Ww7Mn6d1jNbl3mzkbxZB56X+cGH4Eo/b3oMlz2QlQA==
X-Received: by 2002:a6b:c9d8:: with SMTP id z207mr949650iof.184.1562005655796; 
	Mon, 01 Jul 2019 11:27:35 -0700 (PDT)
Received: from [10.30.197.57] ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	c2sm10674322iok.53.2019.07.01.11.27.34
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Jul 2019 11:27:35 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
References: <CAJdd5GbvT5NaKsn0MvLLKWaHuo2izHCLxGPW0oN88+EKxO-G2A@mail.gmail.com>
	<CA+chaQc_b5qNAeSCd=sK6z=x4d70RPsuNPm-LQ0W5tSgoVjUZg@mail.gmail.com>
Message-ID: <68f290d9-a035-f6fc-11ee-7a70743ed2b9@gmail.com>
Date: Mon, 1 Jul 2019 13:27:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CA+chaQc_b5qNAeSCd=sK6z=x4d70RPsuNPm-LQ0W5tSgoVjUZg@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: setscene fetch failures are fatal
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
X-List-Received-Date: Mon, 01 Jul 2019 18:27:35 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US


On 6/28/19 5:43 PM, Martin Jansa wrote:
> There are patches for this on the ML from long time ago. They were 
> rejected that it's just hiding the real infrastructure issue which 
> should be fixed, but I keep them in my builds as well because as you 
> say, errors like this triggering the CI build failures of unrelated 
> changes is quite annoying.
>
> https://github.com/shr-distribution/bitbake/commit/75858b7f4f03137646cb934b8e3cde0807493eed
> +
> http://git.openembedded.org/openembedded-core-contrib/commit/?h=jansa/master&id=dec7674a1cb501ee8e4f864dcb4adc307c10c159

Thanks. I found those original patches on the mailing list to review the 
arguments. I've proposed a different solution here:

http://lists.openembedded.org/pipermail/bitbake-devel/2019-July/020105.html

with test cases here:

http://lists.openembedded.org/pipermail/openembedded-core/2019-July/284285.html

We'll see if that is a more palatable alternative.

>
> On Sat, Jun 29, 2019 at 12:23 AM Joshua Watt <jpewhacker@gmail.com 
> <mailto:jpewhacker@gmail.com>> wrote:
>
>     I'm having an issue with the _setscene tasks failing to fetch causing
>     our builds to fail. For example: we see the following in our CI build
>     logs:
>
>      WARNING: flac-1.3.1-r0 do_package_write_ipk_setscene: Failed to fetch
>     URL
>     file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo;downloadfilename=07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo,
>     attempting MIRRORS if available
>      ERROR: flac-1.3.1-r0 do_package_write_ipk_setscene: Fetcher failure:
>     Unable to find file
>     file://07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo;downloadfilename=07/sstate:flac:cortexa15hf-neon-poky-linux-gnueabi:1.3.1:r0:cortexa15hf-neon:3:07fe4a22caf5e326a98e397f7923060a_package_write_ipk.tgz.siginfo
>     anywhere. The paths that were searched were:
>       /tmp/tmp.S3vCIuI7SE/sstate
>
>     The build carries on as normal and even builds everything
>     successfully, but the final error code returned from bitbake is '1'.
>     This is particularly annoying because A) this happens a lot and B) the
>     build did actually produce usable outputs so failing isn't really
>     accurate.
>
>     Near as I can tell, this is caused because the knotty UI treats any
>     logging.error() message as fatal and will have a non-zero return code
>     if one occurs.
>
>     I also realize this is probably mostly caused by an infrastructure
>     problem on our end, but I don't seem to be able to get anyone to
>     magically make that better so that this failure stops happening :(
>
>     Does anyone have any ideas for things that could be done to mitigate
>     this? So far, the only thing I've come up with is to modify the
>     bitbake Fetch.download() so that an argument can be passed that says
>     whether to use logger.error() or logger.warning() when reporting an
>     error, but that feels really ugly.
>
>     Thanks,
>     Joshua Watt
>     -- 
>     _______________________________________________
>     bitbake-devel mailing list
>     bitbake-devel@lists.openembedded.org
>     <mailto:bitbake-devel@lists.openembedded.org>
>     http://lists.openembedded.org/mailman/listinfo/bitbake-devel
>

