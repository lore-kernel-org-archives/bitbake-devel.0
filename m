Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>)
	id 1R9h4n-0007tx-Jw; Fri, 30 Sep 2011 19:40:45 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 30 Sep 2011 10:34:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,468,1312182000"; d="scan'208";a="57475905"
Received: from unknown (HELO [10.255.15.62]) ([10.255.15.62])
	by azsmga001.ch.intel.com with ESMTP; 30 Sep 2011 10:34:59 -0700
From: Joshua Lock <josh@linux.intel.com>
To: McClintock Matthew-B29882 <B29882@freescale.com>
Date: Fri, 30 Sep 2011 10:34:54 -0700
In-Reply-To: <CAEsOVNdwudRO7V2DQhpESC=xCqDtJqxJ72+e_hYDLq7bE=z+cg@mail.gmail.com>
References: <4E85D3E0.7070807@intel.com>
	<CAEsOVNdwudRO7V2DQhpESC=xCqDtJqxJ72+e_hYDLq7bE=z+cg@mail.gmail.com>
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Message-ID: <1317404099.11645.21.camel@scimitar>
Mime-Version: 1.0
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
X-List-Received-Date: Fri, 30 Sep 2011 17:40:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-09-30 at 10:20 -0600, McClintock Matthew-B29882 wrote:
> On Fri, Sep 30, 2011 at 9:36 AM, Yu Ke <ke.yu@intel.com> wrote:
> > Hi,
> >
> > As you may already know, a new GUI has been added to bitbake recently, i.e.
> > HOB (Human Oriented Builder). It is a graphical image creator that allows
> > user to freely choose which packages to be built in the image. The wiki
> > https://wiki.yoctoproject.org/wiki/BitBake/GUI/Hob  has more detail.
> >
> > This email is to collect your feedback on the HOB. Current HOB is our first
> > version, and it surely has many place to improve. We has the plan to enhance
> > it in Yocto 1.2. So we really hope that you can use it and provide your
> > valuable feedback . We do think user's feedback/requirement is the right way
> > to go. Looking forward your valuable input.
> >
> > Best Regards
> > Ke
> >
> > Ps. The simple way to run hob is:
> > # touch conf/hob-pre.conf conf/hob-post.conf
> > # bitbake -u hob -r conf/hob-pre.conf -R conf/hob-post.conf
> >
> > Where conf/hob-pre.conf conf/hob-post.conf is the configuration file, which
> > can be empty in above case.
> 
> Has any discussion gone into making some sort of plugin or extensions?
> I'd like for it to be as easy as possible for someone new to make hob
> be able to some things like: configure runtime services, configure
> networking settings, add users, and I'm sure there are other things.

No such discussion has occurred. These are good feature suggestions,
I'm not sure about a plugin mechanism - are you suggesting that
to enable the features mentioned or in addition to?
At least for enabling runtime services there's likely an issue of the
UI having enough knowledge of the init system to do so.
        
I can certainly see at least the three features proposed here being
desirable and I'll probably file those as feature enhancements in the
bugzilla, unless you'd like to?
        
Any further thoughts on customisations to enable via the GUI?
        
Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre



