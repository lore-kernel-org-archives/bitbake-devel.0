Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 471256007C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Jan 2014 12:35:03 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0HCYolh016670; Fri, 17 Jan 2014 12:34:50 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KqppGMNEXMaN; Fri, 17 Jan 2014 12:34:50 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0HCXnbc016587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 Jan 2014 12:33:52 GMT
Message-ID: <1389962023.14987.119.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Fri, 17 Jan 2014 12:33:43 +0000
In-Reply-To: <20140116144514.GE1459@axis.com>
References: <1389371323.9182.169.camel@phil-desktop.brightsign>
	<20140116144514.GE1459@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Phil Blundell <pb@pbcl.net>
Subject: Re: [RFC PATCH] bitbake: Rewrite fetch2.decodeurl() to use urlparse.urlsplit()
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
X-List-Received-Date: Fri, 17 Jan 2014 12:35:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-01-16 at 15:45 +0100, Olof Johansson wrote:
> On 14-01-10 17:28 +0100, Phil Blundell wrote:
> > This means that it now understands "standard" URI syntax as well as
> > the slightly odd legacy bitbake variant.
> > 
> > There are other places in bitbake (e.g. Local.urldata_init) that also 
> > need fixing, but this is a start.
> 
> I wrote a URI class last year that got integrated to bitbake's
> fetch2, but the commit that actually made decode/encodeurl a
> wrapper around it was reverted because I missed adding support
> for query params (oops :-)). The class itself is still intact
> though (it's just above decodeurl).
> 
> I did send fixes for that (adding support for query params), but
> they haven't been merged. Perhaps I should resend?

Please do, they've fallen off the radar...

Cheers,

Richard



