Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <joshua.lock@intel.com>)
	id 1R9fFK-0003pW-QD; Fri, 30 Sep 2011 17:43:31 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 30 Sep 2011 08:36:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,468,1312182000"; d="scan'208";a="22177455"
Received: from unknown (HELO [10.255.15.62]) ([10.255.15.62])
	by AZSMGA002.ch.intel.com with ESMTP; 30 Sep 2011 08:36:54 -0700
From: Joshua Lock <joshua.lock@intel.com>
To: "Yu, Ke" <ke.yu@intel.com>
Date: Fri, 30 Sep 2011 08:36:49 -0700
In-Reply-To: <4E85D3E0.7070807@intel.com>
References: <4E85D3E0.7070807@intel.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1317397015.11645.6.camel@scimitar>
Mime-Version: 1.0
X-Mailman-Approved-At: Fri, 30 Sep 2011 23:43:24 +0200
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Fri, 30 Sep 2011 15:43:31 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-30 at 08:36 -0600, Yu, Ke wrote:
> Hi,
> 
> As you may already know, a new GUI has been added to bitbake recently, 
> i.e. HOB (Human Oriented Builder). 

It's not an acronym, it's just a name - Hob.

> It is a graphical image creator that 
> allows user to freely choose which packages to be built in the image. 
> The wiki https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more 
> detail.

I'll be changing this page and adding more user-centric info in the
coming weeks.

> 
> This email is to collect your feedback on the HOB. Current HOB is our 
> first version, and it surely has many place to improve. We has the plan 
> to enhance it in Yocto 1.2. So we really hope that you can use it and 
> provide your valuable feedback . We do think user's feedback/requirement 
> is the right way to go. Looking forward your valuable input.
> 
> Best Regards
> Ke
> 
> Ps. The simple way to run hob is:
> # touch conf/hob-pre.conf conf/hob-post.conf
> # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf

In oe-core (and therefore Poky) we have a wrapper script so from an
oe-init-build-env'd build directory you can just call hob.

The script will create the required configuration files with some
required values.

Regards,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



