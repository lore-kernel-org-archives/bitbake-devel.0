Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S9gqa-000823-Ei for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 18:58:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2JHnOOU032469;
	Mon, 19 Mar 2012 17:49:24 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32155-03; Mon, 19 Mar 2012 17:49:20 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2JHnDo2032463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Mar 2012 17:49:15 GMT
Message-ID: <1332179355.9740.57.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 19 Mar 2012 17:49:15 +0000
In-Reply-To: <alpine.DEB.2.02.1203181332080.21990@oneiric>
References: <alpine.DEB.2.02.1203181332080.21990@oneiric>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: online manual should be updated or removed, no?
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
X-List-Received-Date: Mon, 19 Mar 2012 17:58:20 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-03-18 at 13:33 -0400, Robert P. J. Day wrote:
> given that the historical bitbake manual here:
> 
> http://bitbake.berlios.de/manual/
> 
> is massively out of date, it should probably either be updated, or
> augmented with advice on how to get the current version from the
> bitbake download itself.

I've finally managed to find a way to remove it (ish). I couldn't delete
the files but I could move them out the way.

I've replaced it with a few lines of text which should direct people to
where they need to go. I'd happily see it replaced with something more
elegant.

Cheers,

Richard



