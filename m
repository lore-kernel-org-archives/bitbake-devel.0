Received: from gandharva.secretlabs.de ([78.46.147.237])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <holger+bitbake@freyther.de>) id 1QundR-0008ET-5c
	for bitbake-devel@lists.openembedded.org;
	Sat, 20 Aug 2011 17:38:57 +0200
Received: from [192.168.0.101] (91-64-80-26-dynip.superkabel.de [91.64.80.26])
	by gandharva.secretlabs.de (Postfix) with ESMTPSA id DB1331B10C11
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 20 Aug 2011 15:25:55 +0000 (UTC)
Message-ID: <4E4FD267.6050304@freyther.de>
Date: Sat, 20 Aug 2011 17:27:35 +0200
From: Holger Freyther <holger+bitbake@freyther.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <alpine.DEB.2.02.1108191305430.5421@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1108191305430.5421@localhost6.localdomain6>
Subject: Re: docs on git fetcher don't match actual code
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
X-List-Received-Date: Sat, 20 Aug 2011 15:38:57 -0000
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 7bit

On 08/19/2011 07:11 PM, Robert P. J. Day wrote:
> 

> 
> which says nothing about "rsync" but lists "https" as a valid protocol
> that's not mentioned higher up.  someone way higher up the food chain
> is welcome to decide what should be clarified here.

Hi Robert,

I would update the manual to mention that 'git' is the default and remove
rsync from it. The reasoning is that rsync is mostly historic and there is no
good reason to use it.

holger


