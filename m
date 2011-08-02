Received: from mail.pbcl.net ([88.198.119.4] helo=hetzner.pbcl.net)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <philb@gnu.org>) id 1QoFkJ-0002zE-9R
	for bitbake-devel@lists.openembedded.org;
	Tue, 02 Aug 2011 16:14:59 +0200
Received: from cambridge.roku.com ([81.142.160.137] helo=[172.30.1.145])
	by hetzner.pbcl.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72) (envelope-from <philb@gnu.org>)
	id 1QoFOp-0002SM-7U; Tue, 02 Aug 2011 15:52:47 +0200
From: Phil Blundell <philb@gnu.org>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Date: Tue, 02 Aug 2011 14:52:46 +0100
In-Reply-To: <1312292735.2344.597.camel@rex>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<1312292735.2344.597.camel@rex>
X-Mailer: Evolution 3.0.2- 
Message-ID: <1312293167.4325.38.camel@phil-desktop>
Mime-Version: 1.0
X-Mailman-Approved-At: Thu, 04 Aug 2011 09:38:37 +0200
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Tue, 02 Aug 2011 14:14:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-08-02 at 14:45 +0100, Richard Purdie wrote:
> We could do with clearly documenting this in the bitbake manual. I
> suspect users would expect the highest version to win and we probably
> should change the behaviour but I'm open to other opinions.

The original intent with BBFILE_COLLECTIONS was that the recipe from the
highest-priority collection would win even if it was an older version.
(The rationale for this was that the one in the higher priority
collection was the most likely to have local customisations, and you
wouldn't want those to suddenly be negated if a newer version popped up
in some upstream collection.)

I suspect the same logic probably does apply to layers to some extent
for the same reason.  If there is a situation where you are just trying
to aggregate the recipes together from a bunch of layers and you just
want the highest version from that set then my first reaction would be
that the layers should probably all have the same priority.  

Actually, to some extent I consider it a bit of a misfeature that the
layer priority is specified by the layer rather than by the user in
bblayers.conf, since this makes it harder to vary the stack-up order
without local hackery to the layer files.  For example, meta-oe
currently sets itself to a higher priority than oe-core, but I've found
that it generally seems to suit me better if meta-oe is actually the
lower-priority layer.

p.




