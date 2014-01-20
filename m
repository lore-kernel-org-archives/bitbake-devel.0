Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 5AF156B678
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 16:29:11 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0KGSvUn012330; Mon, 20 Jan 2014 16:28:57 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NnxYi9jBgt9h; Mon, 20 Jan 2014 16:28:57 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0KGSNKO012297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 20 Jan 2014 16:28:25 GMT
Message-ID: <1390235296.874.39.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 20 Jan 2014 16:28:16 +0000
In-Reply-To: <20140120161805.GG5565@jama>
References: <1390231311.874.37.camel@ted> <20140120155734.GI6520@axis.com>
	<20140120161805.GG5565@jama>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2/git: Anchor names when using ls-remote
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
X-List-Received-Date: Mon, 20 Jan 2014 16:29:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-01-20 at 17:18 +0100, Martin Jansa wrote:
> On Mon, Jan 20, 2014 at 04:57:34PM +0100, Olof Johansson wrote:
> > On 14-01-20 16:21 +0100, Richard Purdie wrote:
> > > When specifying tags, they're searched for unanchored so foo/bar could
> > > match:
> > > 
> > > refs/heads/abc/foo/bar
> > > refs/heads/xyz/foo/bar
> > > refs/heads/foo/bar
> > > 
> > > This change anchors the expressions so they are based against heads
> > > or tags (or any other base level tree that has been created).
> > 
> > Afaict, ls-remote matches the wildcard character against any
> > character, including /.
> > 
> > $ git ls-remote gittest refs/*/foo/bar
> > 69ab4bdbb5f3725ca594a2abdb636ee8fc25e1c4        refs/tags/abc/foo/bar
> > c8647b027d88af180e90d842577518b73ef6a167        refs/tags/foo/bar
> > 149c3c329515086af1ae4e24b12b17100ae16256        refs/tags/xyz/foo/bar
> 
> Yes, I've seen the same behavior:
> 
> http://lists.openembedded.org/pipermail/bitbake-devel/2013-August/003724.html
> 

Hmm, ok, we can explicitly do:

git ls-remote xxx refs/heads/X refs/tags/X

which should resolve this...

Cheers,

Richard



