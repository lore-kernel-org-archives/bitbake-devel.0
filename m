Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qssq6-0007eQ-EW for bitbake-devel@lists.openembedded.org;
	Mon, 15 Aug 2011 10:48:06 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8hPLp015173;
	Mon, 15 Aug 2011 09:43:25 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14922-04; Mon, 15 Aug 2011 09:43:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p7F8hJGL015167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Aug 2011 09:43:19 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: James Limbouris <james.limbouris@gmail.com>
In-Reply-To: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
References: <CAJzOQw3V_tsUh1CW7JDTswYkcvrUPGHfd6vhHQnd3Lrp1enJOw@mail.gmail.com>
Date: Mon, 15 Aug 2011 09:43:16 +0100
Message-ID: <1313397796.14274.546.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Conditional assignment broken
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
X-List-Received-Date: Mon, 15 Aug 2011 08:48:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi James,

On Sat, 2011-08-13 at 06:50 +0800, James Limbouris wrote:
>  Commit 21c21fcc5871e81d8d497b6baed605cdd74c4571 breaks conditional assignment
>  in all conf files. Previously, the environment was copied from a
> cleaned up os environment.
>  After the commit, a pristine environment is available in
> data['_data'], and will be copied to
>  data[] on conditional assignment, defying BB_ENV_EXTRAWHITE.
> Variables not conditionally
>  assigned will still be available from data['_data'], also in defiance
> of BB_ENV_EXTRAWHITE.
> 
>  To verify, simply:
> 
>  export RANDOMENV=42
>  bitbake -e | grep RANDOMENV

Thanks for finding this. Is this related to the pseudo issue you
mentioned on the OE-Core list? I'm guessing this would explain that.

I've merged Joshua's fix into master so hopefully we've got the
environment issues fixed at least.

Cheers,

Richard



