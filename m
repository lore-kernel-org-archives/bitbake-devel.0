Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qe4mI-0002jE-2c for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 14:30:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65CR7YX030993;
	Tue, 5 Jul 2011 13:27:07 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30583-06; Tue,  5 Jul 2011 13:27:03 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65CQxVA030987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jul 2011 13:26:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
Date: Tue, 05 Jul 2011 13:26:27 +0100
Message-ID: <1309868787.20015.693.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 0/5] Layer tooling improvements v2
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
X-List-Received-Date: Tue, 05 Jul 2011 12:30:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-06-29 at 19:37 +0100, Paul Eggleton wrote:
> The following patches add dependencies between layers, and add the ability
> to query "overlayed" recipes.
> 
> Since v1, two more patches were added: the first to add the ability to
> flatten multi-layer configurations into a single layer, and the second is
> a fix for the way that bitbake-layers' show_appends action sorts its
> output. The other patches are unchanged aside from renaming "overlayedlist"
> to "overlayed" within the first two patches.
> 
> The changes are available (against Poky, but apply cleanly against bitbake
> master with -p2) at:
>   git://git.pokylinux.org/poky-contrib paule/layertooling-2
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/layertooling-2
> 
> Paul Eggleton (5):
>   bitbake: track 'overlayed' recipes
>   bitbake-layers: add show_overlayed action
>   bitbake/cooker: implement layer dependencies, make priority optional
>   bitbake-layers: add command to flatten layers into one
>   bitbake-layers: fix sorting of show_appends output

Thanks Paul, I've merged these. Whilst not perfect I think its a good
start at what we need to do and gives us something to work with and
build from :)

Cheers,

Richard



