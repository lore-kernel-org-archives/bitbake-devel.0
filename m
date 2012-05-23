Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SX8F4-0001r0-9D for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 11:52:30 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4N9gIs0010868;
	Wed, 23 May 2012 10:42:18 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 10805-01; Wed, 23 May 2012 10:42:14 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4N9g73I010857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 May 2012 10:42:08 +0100
Message-ID: <1337766127.8248.43.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Wed, 23 May 2012 10:42:07 +0100
In-Reply-To: <5052782.3c2ltfUpqO@helios>
References: <cover.1337728949.git.paul.eggleton@linux.intel.com>
	<4FBC2513.4090607@windriver.com> <1486170.3Ec8bBqrfQ@helios>
	<5052782.3c2ltfUpqO@helios>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] bitbake: implement checksums for local files in SRC_URI
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
X-List-Received-Date: Wed, 23 May 2012 09:52:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-05-23 at 00:55 +0100, Paul Eggleton wrote:
> On Wednesday 23 May 2012 00:50:48 Paul Eggleton wrote:
> > On Tuesday 22 May 2012 18:45:23 you wrote:
> > > On 5/22/12 6:23 PM, Paul Eggleton wrote:
> > > > Gathers a list of paths to have checksums calculated at parse time, and
> > > > processes these when calculating task hashes. Checksums are cached with
> > > > the file's current mtime. Thus, changing any local file in SRC_URI will
> > > > now cause the do_fetch taskhash to change, thus forcing a rebuild.
> > > 
> > > Does the mtime change invalidate the checksum, or just cause the checksum
> > > to be re-interpreted?
> > 
> > The latter.
> 
> Er, I think I may have misread your question. To be totally clear - the mtime 
> is not a component of the checksum; we merely store it next to the checksum in 
> a cache so that we don't have to re-compute the checksum if the file hasn't 
> been modified. If mtime changes but the file content does not, the checksum will 
> be re-computed but will not change.

Just to be completely clear, this is purely a performance issue, we
don't want to recompute the checksums for all the files at each bitbake
invocation as his would be slow. We therefore just recompute the
checksum when mtime changes.

You can therefore happily touch a file and it won't trigger a rebuild.
Any change to the contents will rebuild the recipe though through the
changed sstate checksum.

Cheers,

Richard



