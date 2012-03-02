Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S3VbO-0000nF-CY for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 17:45:07 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q22GaYhG003184;
	Fri, 2 Mar 2012 16:36:34 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02151-10; Fri,  2 Mar 2012 16:36:30 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q22GaOm6003177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Mar 2012 16:36:25 GMT
Message-ID: <1330706188.309.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Fri, 02 Mar 2012 16:36:28 +0000
In-Reply-To: <CABcZANmgbf_fDAxsqOkzzNX2t81u2tkeGsgibgo3nDyQzA1vng@mail.gmail.com>
References: <cover.1330674604.git.kai.kang@windriver.com>
	<bbac4fa41e627a8673202459461c10e0c1426b61.1330674604.git.kai.kang@windriver.com>
	<CABcZANmgbf_fDAxsqOkzzNX2t81u2tkeGsgibgo3nDyQzA1vng@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: enable cleanup of WORKDIR
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
X-List-Received-Date: Fri, 02 Mar 2012 16:45:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-02 at 08:33 -0700, Chris Larson wrote:
> On Fri, Mar 2, 2012 at 12:54 AM, Kang Kai <kai.kang@windriver.com> wrote:
> > [Yocto 1561]
> > Add a command line option for bitbake to enable cleanup of WORKDIR.
> > It checks every package build directories under WORKDIR then parse
> > the directory name to get package name and version. If the version
> > is not the package prefer version then delete the directory.
> >
> > Signed-off-by: Kang Kai <kai.kang@windriver.com>
> > ---
> >  bitbake/bin/bitbake       |    4 +++
> >  bitbake/lib/bb/command.py |    5 +++
> >  bitbake/lib/bb/cooker.py  |   63 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 72 insertions(+), 0 deletions(-)
> 
> This is wrong on multiple levels. bitbake (other than some hacky stuff
> in the fetcher that needs to die) has *zero* knowledge of the use of
> WORKDIR today, that's entirely metadata implementation.

Totally agreed. I saw a comment earlier today in the bugzilla about this
and made the same comment even before I saw this patch...

Cheers,

Richard



