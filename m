Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 41E506E5FB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 13:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v06D8oNI012370; Fri, 6 Jan 2017 13:08:50 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pvLrNNie8QiI; Fri,  6 Jan 2017 13:08:50 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	v06D8nSP012367
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 6 Jan 2017 13:08:50 GMT
Message-ID: <1483708129.4367.124.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Michael Halstead <mhalstead@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org,
	Scott Rifenbark <srifenbark@gmail.com>
Date: Fri, 06 Jan 2017 13:08:49 +0000
In-Reply-To: <b28aa897-1b0b-766e-3364-dacc1dfc9c56@linuxfoundation.org>
References: <F2A09E750CD22D4C9B40D06C92C54E525F48C10C@inc-mbx-prd02.arthrex.local>
	<b28aa897-1b0b-766e-3364-dacc1dfc9c56@linuxfoundation.org>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Subject: Re: Corrupted Link in BitBake User manual
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
X-List-Received-Date: Fri, 06 Jan 2017 13:08:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2017-01-05 at 17:03 -0800, Michael Halstead wrote:
> I have replaced all the links to hambedded with links to
> archive.org's copies from March 19th when the site was still up. The
> change is complete in all the HTML versions of the Bitbake manual.
> The PDF versions aren't as simple to change. 
> This should mitigate the issue until a permanent solution can be
> decided on.
> Scott, if you push new versions of the docs it will overwrite my
> changes so check in with me before you do.

If you let me know the change, I could push that onto all the docs
branches so that if new manual versions are ever pushed, we'd have the
updated url, at least from the branch heads? (Or Scott could do that)

Cheers,

Richard

