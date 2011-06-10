Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1QVAnH-0002Cp-N6
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Jun 2011 01:07:11 +0200
Received: by pzk36 with SMTP id 36so1528768pzk.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2011 16:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:date:from:to:subject:message-id:mime-version
	:content-type:content-disposition:user-agent;
	bh=vmaJrMHrZ7MDxEixrlCZhx7v3YKlK543iigcacPYnCw=;
	b=hp+UcRnO5j1AUeIct4bMCINfZGPsZKm6+jTYipYdICSIb9SVAA6HvxiQ0Uy3y1osKL
	3pWoE4pRTNpGFpuG+S+OFIT9VJMC1bTfSqsaO7HQjJ8kLnvty+NgNtEg7+Tp5JFYU3Pt
	QIv/nbpGEpLytWJkR3vUIfmvEASarkSWAVyL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=date:from:to:subject:message-id:mime-version:content-type
	:content-disposition:user-agent;
	b=Clj56xAzlxd6FhyR17gMuJXfdK2b3TLZtgcHt9vpjuRqeqvqRq1iZBilQLgUk5HwdL
	nWMhtvYJKdS7ZVMdGy3XlAKbuGg4FtV4iBXHJapwdSMU5kEP61RBfqMd0VywWk3eGSgW
	We8jsmDERR7JR34om3n4vtpsbWNrlS92yJv4U=
Received: by 10.142.63.25 with SMTP id l25mr37678wfa.276.1307747029674;
	Fri, 10 Jun 2011 16:03:49 -0700 (PDT)
Received: from sakrah.homelinux.org
	(99-57-141-118.lightspeed.sntcca.sbcglobal.net [99.57.141.118])
	by mx.google.com with ESMTPS id f3sm2667597pbj.32.2011.06.10.16.03.48
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 10 Jun 2011 16:03:48 -0700 (PDT)
Date: Fri, 10 Jun 2011 16:03:26 -0700
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20110610230326.GA20047@sakrah.homelinux.org>
MIME-Version: 1.0
User-Agent: Mutt/1.5.20 (2009-06-14)
Subject: bitbake quitting without parsing or doing anything
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
X-List-Received-Date: Fri, 10 Jun 2011 23:07:11 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I started to experience this error on my machine when I updated bitbake
in my setup today. bitbake console-image simply quits without doing anything
and it dies pretty early. Same setup worked fine last week I did not change
anything

I could trace it go until

bb.event.fire(bb.event.ConfigParsed(), data) line 693 in lib/bb/cooker.py
and silently quit after that

Bisecting resulting in this commit being bad for me.

Let me know if I more information is needed


d21d5954d0c08b1c80b72c5f37becc2e58ec916a is the first bad commit
commit d21d5954d0c08b1c80b72c5f37becc2e58ec916a
Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Wed Jun 8 13:08:52 2011 +0100

    bitbake/server: Move server specific code into the server backend and create a server API
    
    Move the server implementation specific code into the server backend where
    it belongs and replace this with a set of object method calls which
    establish the server, detach it and then connect to it using appropriate
    IPC.
    
    Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

-- 
-Khem


