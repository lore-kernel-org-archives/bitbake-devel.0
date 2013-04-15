Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1URjwG-0006RC-GW; Mon, 15 Apr 2013 15:59:21 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3FDg5EA012707; Mon, 15 Apr 2013 14:42:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VD2146BqF1_W; Mon, 15 Apr 2013 14:42:05 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3FDfxWw012702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 15 Apr 2013 14:42:00 +0100
Message-ID: <1366033296.8670.44.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 15 Apr 2013 14:41:36 +0100
In-Reply-To: <20130412203746.GW2477@jama>
References: <20130411133031.GF2477@jama>
	<CAHUNapRzKJrofFbKX2=5rJZJxSdo+S+5c38GHkp0J8Mhz=C+sw@mail.gmail.com>
	<20130412203746.GW2477@jama>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: oe-core layer <openembedded-core@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Patches
Subject: Re: Checksum failure encountered with download
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
X-List-Received-Date: Mon, 15 Apr 2013 13:59:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-04-12 at 22:37 +0200, Martin Jansa wrote:
> On Fri, Apr 12, 2013 at 03:44:41PM -0400, Trevor Woerner wrote:
> > Sorry for not noticing this sooner.
> > 
> > On Thu, Apr 11, 2013 at 9:30 AM, Martin Jansa <martin.jansa@gmail.com> wrote:
> > > My proposal is to add md5sum of downloaded file to ChecksumError and
> > > rename it to <file>.<md5sum> in "if isinstance(e, ChecksumError):"
> > 
> > Would it be possible to make this behaviour configurable for those who
> > might be concerned about disk space? Or perhaps while renaming and
> > saving it, also move it into the $TMPDIR directory and/or tie this
> > feature in with rm_work?
> > 
> > I'm just thinking that over time one's DL_DIR could potentially become
> > rather cluttered with lots of failed downloads. Only some people would
> > be interested in seeing the failures and the rest would have to remove
> > them manually. I'm also thinking of the scenario where the DL_DIR is
> > shared/sync'ed among a group of people/computers; that could add up to
> > quite a bit of data to share.
> 
> I can make it configurable, but I think that bad-checksums should be
> only in few exceptional cases, while package upgrades are common.
> 
> That said 90% of my downloads directory are old versions I keep just to
> be able to recreate old builds with upstream sources already gone and
> now I've one renamed bad-checksum tarball from evas-1.7.6.1...

Agreed, I'd hope this isn't something which happens that often.

Cheers,

Richard



