Return-Path: <mfumita@electromag.com.au>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8DECED25B
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 03:02:08 +0000 (UTC)
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
 by mx.groups.io with SMTP id smtpd.web10.349.1728356523033037785
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Oct 2024 20:02:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: electromag.com.au, ip: 203.30.46.145, mailfrom: mfumita@electromag.com.au)
Received: (qmail 26473 invoked by uid 5089); 8 Oct 2024 03:02:00 -0000
Received: by simscan 1.2.0 ppid: 26238, pid: 26239, t: 0.8543s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
Received: from unknown (HELO ?192.168.2.146?) (mfumita@electromag.com.au@144.6.137.188)
  by anchovy3.45ru.net.au with ESMTPA; 8 Oct 2024 03:01:59 -0000
Message-ID: <11e9bf7a-1738-473e-ad21-a16ea1b5dd62@electromag.com.au>
Date: Tue, 8 Oct 2024 11:02:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH] fetch2/svn: Support to feed an external
 SSL certificate file and its password
To: bitbake-devel@lists.openembedded.org
References: <20241004030640.10440-1-mfumita@electromag.com.au>
 <46a43e5aa802fcb59dc2dd1fc832e4fd787939b9.camel@linuxfoundation.org>
 <9aa944db-e60d-4b19-9865-afea669e8f5d@electromag.com.au>
 <CANNYZj9YZ3ryc7fOFqs250Yt9UM4fxOG2yCcLx=JoYC98v=s1Q@mail.gmail.com>
Content-Language: en-AU
From: Morikazu Fumita <mfumita@electromag.com.au>
In-Reply-To: <CANNYZj9YZ3ryc7fOFqs250Yt9UM4fxOG2yCcLx=JoYC98v=s1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 03:02:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16651

On 7/10/2024 6:20 pm, Alexander Kanavin wrote:
> On Mon, 7 Oct 2024 at 04:52, Mori Fumita via lists.openembedded.org
> <mfumita=electromag.com.au@lists.openembedded.org> wrote:
>
>> Since Jenkins temporarily installs the certificate at a dynamically generated obfuscated path,
>> it isn't straightforward to configure it in the SVN configuration file in the home directory.
>> Additionally, we want to avoid storing the password on the build machine.
>>
>> So, the "SRC_URI" in the recipe would look something like this, using "ENV_VAR_CERT" and "ENV_VAR_PASS",
>> which Jenkins supplies dynamically.
>> SRC_URI = "svn://[repository];protocol=https;cert_file=${ENV_VAR_CERT};cert_pass=${ENV_VAR_PASS}
> This is still unsafe and can be easily misused. You need to write the
> needed items into a temporary file(s), and configure svn to pick them
> up (perhaps with a temporary configuration file that is formed just
> before the build starts).
>
> Alex
Jenkins already handles most of what you mentioned automatically.
It copies the necessary items to a temporary location just before the 
build and cleans them up once it's complete.

The difference is whether these are configured through the SVN config 
file or
via the chain of Jenkins -> environment variables -> SRC_URI -> runtime 
SVN command line options.

As you suggested, these could be saved in a temporary configuration file 
instead of using environment variables.
In that case, the fetcher would need an interface to forward its path to 
the SVN "--config-dir" command line option anyway.
Also the password would need to be saved in the SVN key store, since it 
can't be saved in the config file.
I'm not sure if this key store can be temporary.

Since Jenkins already has the capability to provide the certificate via 
environment variables, I'd like to use that in bitBake.

Mori
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16648): https://lists.openembedded.org/g/bitbake-devel/message/16648
> Mute This Topic: https://lists.openembedded.org/mt/108811827/7022486
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mfumita@electromag.com.au]
> -=-=-=-=-=-=-=-=-=-=-=-
>


