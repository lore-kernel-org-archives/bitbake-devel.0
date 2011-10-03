Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <joshua.lock@intel.com>)
	id 1RAqrj-0003B0-V6; Tue, 04 Oct 2011 00:20:05 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 03 Oct 2011 15:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="58622113"
Received: from scimitar.jf.intel.com (HELO [10.7.199.170]) ([10.7.199.170])
	by orsmga001.jf.intel.com with ESMTP; 03 Oct 2011 15:13:23 -0700
From: Joshua Lock <joshua.lock@intel.com>
To: Koen Kooi <koen@dominion.thruhere.net>
Date: Mon, 03 Oct 2011 15:13:22 -0700
In-Reply-To: <EE88C9B7-2646-4305-A8A8-4BD2BA031C27@dominion.thruhere.net>
References: <4E85D3E0.7070807@intel.com> <4E863AE8.7020901@mlbassoc.com>
	<33AB447FBD802F4E932063B962385B3512DAF448FB@shsmsx501.ccr.corp.intel.com>
	<CAP9ODKpnvcCJWCYDMbyL5n_HDjxb+6cwy54BWTaXqM2eH5=G_w@mail.gmail.com>
	<EE88C9B7-2646-4305-A8A8-4BD2BA031C27@dominion.thruhere.net>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1317680002.14372.15.camel@scimitar>
Mime-Version: 1.0
X-Mailman-Approved-At: Wed, 05 Oct 2011 15:27:42 +0200
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Mon, 03 Oct 2011 22:20:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2011-10-01 at 11:51 -0600, Koen Kooi wrote:
> 
> Op 1 okt. 2011 om 12:46 heeft Otavio Salvador <otavio@ossystems.com.br> het volgende geschreven:
> 
> > On Fri, Sep 30, 2011 at 21:23, Yu, Ke <ke.yu@intel.com> wrote:
> > ...
> >> So currently, if you name your own image with XXX-image, HOB should be able to automatically add it in the drop-down list.
> >> 
> >> And yes, it is helpful to allow user adding item into base image list. it can be done by adding one item in "Edit"->"Preference". I will add this requirement to my plan. For base image filtering, I am not sure if it is necessary, since base image list is not that long. How do you think?
> > ...
> > 
> > It would be nice to have a way to filter out images too. In case we're
> > customizing oe-core to a customer we might want to reduce the options
> > to avoid unsupported images to be built.
> 
> Like a whitelist regexp on hob.conf

Filed as Yocto #1581

http://bugzilla.pokylinux.org/show_bug.cgi?id=1581

Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



