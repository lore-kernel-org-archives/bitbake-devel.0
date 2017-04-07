Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0AD0677DF1
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Apr 2017 16:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v37Gm1oA012104; 
	Fri, 7 Apr 2017 17:48:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id DzgzrAzFg_z2; Fri,  7 Apr 2017 17:48:01 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v37GkpFK011987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 7 Apr 2017 17:46:52 +0100
Message-ID: <1491583611.17200.98.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Paul Eggleton
	<paul.eggleton@linux.intel.com>
Date: Fri, 07 Apr 2017 17:46:51 +0100
In-Reply-To: <d42b10d6959f4e89b77ac926f260d556@XBOX02.axis.com>
References: <cover.1491514854.git.paul.eggleton@linux.intel.com>
	<d42b10d6959f4e89b77ac926f260d556@XBOX02.axis.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 00/11] bitbake-diffsigs fixes/improvements
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
X-List-Received-Date: Fri, 07 Apr 2017 16:48:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2017-04-07 at 12:20 +0000, Peter Kjellerstedt wrote:
> > 
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
> > Sent: den 6 april 2017 23:52
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 00/11] bitbake-diffsigs
> > fixes/improvements
> > 
> > As part of an effort to add task signature recording and comparison
> > to
> > buildhistory in OE, I went digging into bitbake-diffsigs and the
> > code
> > that supports it and discovered that unfortunately it had a number
> > of
> > bugs - in particular the -t option despite being around for a while
> > and
> > having numerous band-aids applied in the past still wasn't really
> > working properly. I have to take a big chunk of the responsibility
> > for
> > this as I wrote the thing in the first place. This patchset
> > corrects
> > most of the issues that I found and also makes a number of
> > improvements
> > to the readability of the output.
> > 
> > NOTE: there are a few corresponding changes required in OE-Core
> > that I
> > am about to send out, these should be applied at the same time.
> Will you do the same for bitbake-dumpsig as I believe it has many 
> problems in common with bitbake-diffsigs?

bitbake-dumpsig is near enough a symlink to diffsigs, its all the same
code.

Cheers,

Richard

