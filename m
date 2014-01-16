Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 4C8C16E3AA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Jan 2014 14:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 0C0C51A0D2;
	Thu, 16 Jan 2014 15:50:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id joGAEXNfOOEe; Thu, 16 Jan 2014 15:50:30 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id AC3EB3F8093;
	Thu, 16 Jan 2014 15:45:15 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 93265CC1;
	Thu, 16 Jan 2014 15:45:15 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 82FC89DF;
	Thu, 16 Jan 2014 15:45:15 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 80EE03E06F;
	Thu, 16 Jan 2014 15:45:15 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.255.0;
	Thu, 16 Jan 2014 15:45:15 +0100
Date: Thu, 16 Jan 2014 15:45:14 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Phil Blundell <pb@pbcl.net>
Message-ID: <20140116144514.GE1459@axis.com>
References: <1389371323.9182.169.camel@phil-desktop.brightsign>
MIME-Version: 1.0
In-Reply-To: <1389371323.9182.169.camel@phil-desktop.brightsign>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Thu, 16 Jan 2014 14:50:31 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 14-01-10 17:28 +0100, Phil Blundell wrote:
> This means that it now understands "standard" URI syntax as well as
> the slightly odd legacy bitbake variant.
> 
> There are other places in bitbake (e.g. Local.urldata_init) that also 
> need fixing, but this is a start.

I wrote a URI class last year that got integrated to bitbake's
fetch2, but the commit that actually made decode/encodeurl a
wrapper around it was reverted because I missed adding support
for query params (oops :-)). The class itself is still intact
though (it's just above decodeurl).

I did send fixes for that (adding support for query params), but
they haven't been merged. Perhaps I should resend?

-- 
olofjn

