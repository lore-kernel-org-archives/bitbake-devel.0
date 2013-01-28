Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1Tzpom-0003wW-Th
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 Jan 2013 15:36:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 90CF019DEF;
	Mon, 28 Jan 2013 15:20:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yDTH4BRHTY76; Mon, 28 Jan 2013 15:20:38 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id A58C419DDA;
	Mon, 28 Jan 2013 15:20:37 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id A3B1E3415C;
	Mon, 28 Jan 2013 15:20:37 +0100 (CET)
Received: from axis.com (10.92.17.1) by xmail2.se.axis.com (10.0.5.74) with
	Microsoft SMTP Server (TLS) id 8.2.176.0;
	Mon, 28 Jan 2013 15:20:37 +0100
Date: Mon, 28 Jan 2013 15:20:36 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Martin Jansa <martin.jansa@gmail.com>
Message-ID: <20130128142035.GY28382@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
	<1358759883-7566-7-git-send-email-olof.johansson@axis.com>
	<20130128141329.GA16904@jama.palm1.palmone.com>
MIME-Version: 1.0
In-Reply-To: <20130128141329.GA16904@jama.palm1.palmone.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 6/6] fetch2: Add SFTP fetcher
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
X-List-Received-Date: Mon, 28 Jan 2013 14:36:31 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On 2013-01-28 15:13, Martin Jansa wrote:
> On Mon, Jan 21, 2013 at 10:18:03AM +0100, Olof Johansson wrote:
> > +            raise bb.fetch2.ParameterError(
> > +                "Invalid protocol - if you wish to fetch from a git " +
> > +                "repository using ssh, you need to instead use the " +
> 
> extra 'instead' ^ ?
> 
> But I like this error, will add the same to ssh.py fetcher (which I'm
> now trying to fix).

That is shamelessly stolen from the wget fetcher :-). The
"instead" may be redundant, can remove it.

-- 
Olof Johansson


