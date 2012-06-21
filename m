Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rep.dot.nop@gmail.com>) id 1Shi32-0002H7-8I
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jun 2012 16:07:48 +0200
Received: by werg55 with SMTP id g55so411022wer.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Jun 2012 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=nknR8fZMgAGEagWGrWS/gzEfK4JKcIRy56ZUZHj8FKY=;
	b=AOTmbnqiKmpvh5uO4pf4gKYbieErUKLpkAgcyr6aWSFcNXluFGpGbh2rWx3/ydNplP
	7jpYaHRrE+HvtuMwXV4mKAmvhy6QRJtpDf6hMBOyT9FxGw+3tT0aTESKvUnbRPSDAsDP
	tTr6JYB6R90GoFJu3cWfYO+lJsu9z1ENDgm5kpn9zSXFw7IwP72o0PM2hE0XNGHqjbb/
	1Gi8Am0CSsNzciXIgumH2AQXSiGeZAmKmajWrZYLV8k2DW4PbnpbiZHBkAW4Mb80iRSq
	YKqEuDwZA2osBeZ7cDVMPOcU7hmcx41jef2tku9ZRWoCAn8Q+dAPZz2Apiq/kkN/AeaH
	H5zQ==
MIME-Version: 1.0
Received: by 10.216.228.224 with SMTP id f74mr14837385weq.217.1340287022506;
	Thu, 21 Jun 2012 06:57:02 -0700 (PDT)
Received: by 10.216.234.92 with HTTP; Thu, 21 Jun 2012 06:57:02 -0700 (PDT)
In-Reply-To: <1340285156.1640.114.camel@ted>
References: <1340018907-8814-1-git-send-email-rep.dot.nop@gmail.com>
	<1340280968.1640.96.camel@ted>
	<CAC1BbcSr8K79m6idqVvDDrYG1KxgrMEVwmDVb2KWZ8xrUC0Z9Q@mail.gmail.com>
	<1340285156.1640.114.camel@ted>
Date: Thu, 21 Jun 2012 15:57:02 +0200
Message-ID: <CAC1BbcQgOqcPTnRZksao5yFVH1k8UzcJOCGGO6gzBUWTiPUp7g@mail.gmail.com>
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: do not try to checksum a socket
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 21 Jun 2012 14:07:48 -0000
Content-Type: text/plain; charset=ISO-8859-1

>> SRC_URI = "file:///scratch/src/uClibc/;branch=master;protocol=rsync;rebaseable=1

> Ah, this makes more sense now. For what its worth, the "file://" url
> handler will simply strip off everything including and after the ";" so
> all it really sees is "file:///scratch/src/uClibc/" but this works since
> it will just copy that directory whole.
>
> It will then attempt to checksum everything in a file:// url which is
> why it finds the socket and then fails. So your change does point at a
> potentially valid issue. Paul might have a better idea on which level we
> might want to fix this at?
>
>> > What is worrying me a bit is that we shouldn't be calling the checksum
>> > code for git repositories at all. Whilst this fix no doubt avoids the
>> > problem, I'm worried there might be something deeper going on...
>>
>> Could it be that the logic to deduce the fetcher is somehow broken?
>>
>> Indeed, this was failing for me a couple of weeks ago with a similar SRC_URI.
>> Back then i could not use file:///mydir;protocol=git (i.e. create a
>> clone from a clone living on the local filesystem) so had to resort
>> back to protocol=rsync.
>> There was a socket lying around in that directory, a leftover from
>> some testsuite run.
>
> FWIW, the url you want is git:///mydir;protocol=file which should work.

Oh, that's rather surprising!
The format suggested to me that, iff specified, with "protocol=" i can
select the fetcher, regardless of the actual path-spec.
Shouldn't protocol have precedence over any eventual path-implied fetcher?
file:///mydir;protocol=rsync
  rsync -a /mydir S
file:///mydir;protocol=git
  git clone -s file:///mydir S

> As of the patches today, this also works as mirror syntax so you could
> even add this in local.conf as a PREMIRROR and leave the recipe
> pristine.

thanks for the hint, yes, i know. Changing the recipe reminds me that
i have local changes and i can paste it to khem easily.
cheers,


