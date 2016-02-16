Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 47B976FFA4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Feb 2016 11:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1GBF2X9001933; Tue, 16 Feb 2016 11:15:02 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sQuJOhx9f3Vm; Tue, 16 Feb 2016 11:15:02 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1GBEvUU001928
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 Feb 2016 11:14:58 GMT
Message-ID: <1455621297.16142.430.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 16 Feb 2016 11:14:57 +0000
In-Reply-To: <1455463095.16142.412.camel@linuxfoundation.org>
References: <cover.1455235907.git.chris_larson@mentor.com>
	<bfefd7e111665ad68f9c30a115cf307921561f7d.1455235907.git.chris_larson@mentor.com>
	<CABcZANkGAQohdYSYsotAyTShaCqDWz441WPUHHf6jF+5J8bP=Q@mail.gmail.com>
	<1455463095.16142.412.camel@linuxfoundation.org>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [RFC PATCH 1/1] bb.ui.knotty: prefix task messages with recipe/task
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
X-List-Received-Date: Tue, 16 Feb 2016 11:15:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2016-02-14 at 15:18 +0000, Richard Purdie wrote:
> On Fri, 2016-02-12 at 00:15 +0000, Christopher Larson wrote:
> > On Thu, Feb 11, 2016 at 5:13 PM Christopher Larson <
> > kergoth@gmail.com
> > > wrote:
> > > From: Christopher Larson <chris_larson@mentor.com>
> > > 
> > > An example prefix: `perl-5.22.1-r0 do_compile:`
> > > 
> > > Signed-off-by: Christopher Larson <chris_larson@mentor.com>
> > I realize this may well be something to do for 2.2 rather than 2.1,
> > but I wanted to throw it out and get thoughts on it, as I'm sick of
> > manually prefixing our log messages in tasks :)
> 
> I like the idea and actually wondered why this was an RFC, shouldn't
> we
> just do it?
> 
> Having watched oe-selftest having a problems with this, I can see why
> we may need to be more cautious :/.
> 
> Still trying to assess how bad the issues there are.

Fixed the issues in selftest so decided to merge this as it is an issue
we've needed to address for a while.

Thanks!

Richard

