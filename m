Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QbCej-000544-By
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Jun 2011 16:19:18 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Jun 2011 07:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,432,1304319600"; d="scan'208";a="18818968"
Received: from unknown (HELO helios.localnet) ([10.255.17.113])
	by orsmga002.jf.intel.com with ESMTP; 27 Jun 2011 07:15:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Chris Larson <clarson@kergoth.com>
Date: Mon, 27 Jun 2011 15:15:18 +0100
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic-pae; KDE/4.6.2; i686; ; )
References: <cover.1308749155.git.paul.eggleton@linux.intel.com>
	<f7f26e0dff68d4c3146caeccc653fb3c020e662a.1308749155.git.paul.eggleton@linux.intel.com>
	<BANLkTin1XfH_vNQwTfab4B6THm0PRSXAkg@mail.gmail.com>
In-Reply-To: <BANLkTin1XfH_vNQwTfab4B6THm0PRSXAkg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201106271515.18128.paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/3] bitbake: track 'overlayed' recipes
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
X-List-Received-Date: Mon, 27 Jun 2011 14:19:18 -0000
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Friday 24 June 2011 19:15:21 Chris Larson wrote:
> Seems sane conceptually, but can we name this something else?
> overlayedlist is pretty weak, particularly being it's not a list at
> all :) I'd say just overlayed, or overlayed_recipes, or similar.

I've changed it to "overlayed" in the poky contrib branch. I can post v2 
patches if desired.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


