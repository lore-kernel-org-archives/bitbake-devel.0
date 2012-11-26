Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Td6LB-0003Uz-GR for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 22:35:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAQLLXMf028804;
	Mon, 26 Nov 2012 21:21:33 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28116-06; Mon, 26 Nov 2012 21:21:29 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAQLLOaj028798
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 21:21:25 GMT
Message-ID: <1353964883.21863.66.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Date: Mon, 26 Nov 2012 21:21:23 +0000
In-Reply-To: <ly624ss705.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <ly624ss705.fsf@ensc-virt.intern.sigma-chemnitz.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Broken SRC_URI handling
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
X-List-Received-Date: Mon, 26 Nov 2012 21:35:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-11-26 at 16:45 +0100, Enrico Scholz wrote:
> Hi,
> 
> commit 07b5f84133ac79aac4e939ea5f24390ad7f940a5 introduced a regression
> with
> 
> | +            if not newpath or not os.path.exists(newpath) and path.find("*") != -1:
> 
> 
> When an SRC_URI element is not found, some directory in the search path
> is copied insted.
> 
> There should be probably added some parentheses in the expression above.
> At the moment, the 'A or B and C' above is interpreted as 'A or (B and
> C)' due to operator precedences.

I just pushed a fix for this before I read this email! We reached the
same conclusion so it should be fixed in master now :)

Cheers,

Richard



