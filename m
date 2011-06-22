Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1QZPSa-0003Ba-GH for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 17:35:21 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5MFVkRN005272;
	Wed, 22 Jun 2011 16:31:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 04944-07; Wed, 22 Jun 2011 16:31:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p5MFVedG005266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jun 2011 16:31:40 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Brandon Stafford <brandon@pingswept.org>
In-Reply-To: <BANLkTi=1FjHX=Hmm3Opxo2hY7U+dN=9wnw@mail.gmail.com>
References: <AANLkTikY20mQoKfNaY6xsokcVabDnnaQKrvAmumBvv77@mail.gmail.com>
	<BANLkTi=RWRFGQ1ujgCY8Gk8jhr62HMo_vw@mail.gmail.com>
	<1307483745.15712.80.camel@rex>
	<BANLkTi=1FjHX=Hmm3Opxo2hY7U+dN=9wnw@mail.gmail.com>
Date: Wed, 22 Jun 2011 16:31:23 +0100
Message-ID: <1308756683.20015.68.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] Fix some punctuation, wording, and caps in manual
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
X-List-Received-Date: Wed, 22 Jun 2011 15:35:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-06-07 at 19:07 -0400, Brandon Stafford wrote:
> On Tue, Jun 7, 2011 at 5:55 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> >
> > Hi Brandon,
> >
> > On Fri, 2011-06-03 at 12:14 -0400, Brandon Stafford wrote:
> > > This patch contains what I hope are non-controversial improvements to
> > > the manual. Most of the changes are single characters, but the
> > > line-by-line diff makes the patch look large.
> > >
> > > This is my first patch to Bitbake, so please don't kill me
> > > immediately. (I originally sent this message, minus this sentence,
> > > around 2011-03-10, but the bitbake-dev list appeared to be silently
> > > dropping messages from 2011-03-07 until 2011-03-24. I resent it again
> > > on 2011-03-27. I'm now sending it to the post-migration bitbake-devel
> > > list on 2011-06-03.)
> > >
> > > Signed-off-by: Brandon Stafford <brandon@pingswept.org>
> >
> > I tried to get this to apply but the patch appears corrupt and I can't
> > convince the patch tools to accept it. It looks like you sent html email
> > and that your mailer line wrapped the text in some way too.
> >
> 
> Revised patch and retested against current HEAD (commit
> 077657e50ad032c0fa876bf54e9802af2686e0fb).
> 
> Now works for me with: patch -p1 <
> Revised-fixes-to-punctuation-wording-and-caps-in-manual.patch
> 
> I'm sending the patch as an attachment; we'll see if that produces more success.

It did and I've applied it to master, thanks.

Richard



