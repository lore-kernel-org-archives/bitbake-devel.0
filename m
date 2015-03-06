Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7AF396017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Mar 2015 13:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t26Dh1cs007820; Fri, 6 Mar 2015 13:43:01 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Q9UcepH3QED0; Fri,  6 Mar 2015 13:43:01 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t26Dgj0e007810
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Mar 2015 13:42:56 GMT
Message-ID: <1425649365.26813.123.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 06 Mar 2015 13:42:45 +0000
In-Reply-To: <20150306132917.GG2337@jama>
References: <20150227120026.GA13973@ulm-bmuc496424.bmw-carit.de>
	<20150306114328.GN5023@ulm-bmuc496424.bmw-carit.de>
	<20150306122238.GF2337@jama>
	<20150306130320.GO5023@ulm-bmuc496424.bmw-carit.de>
	<20150306132917.GG2337@jama>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571
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
X-List-Received-Date: Fri, 06 Mar 2015 13:43:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2015-03-06 at 14:29 +0100, Martin Jansa wrote:
> On Fri, Mar 06, 2015 at 02:03:20PM +0100, Clemens Lang wrote:
> > Hi Martin,
> > 
> > On Fri, Mar 06, 2015 at 01:22:38PM +0100, Martin Jansa wrote:
> > > Using pickle is much better than counting the checksums on every
> > > do_fetch.. we have GBs of sources and we don't want to spend extra
> > > minutes on the build to re-check them if they are identical.
> > 
> > That's what I thought as well. The pickle method should scale a lot
> > better than re-running the hash calculation, especially in terms of I/O
> > ops.
> > 
> > > Maybe add the file time stamp as well, if the file was modified then
> > > .done could be invalidated and checksums re-verified.
> > 
> > I could modify the code to avoid reading the precomputed checksums if
> > the .done file is older than the downloaded file, which should cover
> > this case. Of course, the modification date will not be of much use if
> > the download is not a file, but a directory.
> > 
> > Does this sound good to you?
> 
> yes :)

Firstly, the delay in getting to reviewing this is mainly that we're
having issues in OE-Core which are causing me a lot of headaches so
sorry about that. We've long held the belief we needed to improve this
mechanism.

I am nervous about the amount and kind of code changes this is
involving. Having "binary" data format files in pickle format is
suboptimal in that the user can't easily inspect or change them and its
not clear what the contents means. Using pickle doesn't give a
dependency issue since we use it elsewhere in bitbake as you mentioned.

I was wondering about whether we should just drop to one checksum format
and simplify the problem somewhat. I understand the reasons for
supporting multiple checksum types though and if we add in a requirement
to track timestamps too, the single format doesn't buy us anything.

I guess above all, I've just been trying to push consolidation in the
fetcher, it has at various points been an unmaintainable nightmare. This
is a worthwhile improvement though.

Cheers,

Richard




